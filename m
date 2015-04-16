From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Apr 2015 17:05:07 +0100
Subject: [PATCH 2/2] arch: arm: Show the serial number from devicetree in
 cpuinfo
In-Reply-To: <1429179791.2483.13.camel@collins>
References: <1427564371-26039-1-git-send-email-contact@paulk.fr>
 <1427564371-26039-2-git-send-email-contact@paulk.fr>
 <20150416094623.GX12732@n2100.arm.linux.org.uk>
 <1429179791.2483.13.camel@collins>
Message-ID: <20150416160506.GA12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 16, 2015 at 12:23:11PM +0200, Paul Kocialkowski wrote:
> We could simply check whether the serial-number property is there (when
> DT is enabled at all) and fallback to using serial_low/high when it's
> not the case (which would perhaps be 0), at a later point in
> initialization. If you think init_machine_late is a good fit, then I'll
> go for it.

I do.  The only user of the string right now is userspace.  We don't
expect the serial number to change over the lifetime of the kernel,
and we expect that it's initialised by the time userspace gets to run.

So, doing this at late_initcall() time seems completely sensible to me.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
