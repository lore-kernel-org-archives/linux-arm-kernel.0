From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 May 2015 00:14:43 +0100
Subject: schedule_timeout sleeps too long after dividing CPU frequency
In-Reply-To: <555D030F.8030100@free.fr>
References: <20150514144239.GZ2067@n2100.arm.linux.org.uk>
 <20150520201438.GW2067@n2100.arm.linux.org.uk>
 <555CF17D.4060500@free.fr> <76003699.Oyq777txnm@wuerfel>
 <555D030F.8030100@free.fr>
Message-ID: <20150520231443.GB2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 11:56:31PM +0200, Mason wrote:
> Russell, when you added the FEAT_C3STOP flag unconditionally in
> commit 5388a6b266, didn't that potentially break platforms that
> didn't expect the flag to be set?

Why would it break any platforms at the time it was merged?

You're only having problems because you don't provide a global timer
to the kernel, which the C3STOP feature does require - and that's
because your platform appears to be very limited in what it can
provide.  All other platforms at the time provided a global timer,
so the scenario you're facing never existed.

Maybe you also should read the discussion around this which is over 5
years old.  You can find some initial discussion via these message IDs:

alpine.LFD.2.00.1004171152080.3625 at localhost.localdomain

And the thread "SMP Local timer and power management" from May 2010.

Yes, making it conditional depending on the platform was mooted, but
it seemed unnecessary.  The fact that no one until now has had a
problem with it is testament to the approach being correct for the
hardware that was in use over the last five years.  No bug reports
means no problem.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
