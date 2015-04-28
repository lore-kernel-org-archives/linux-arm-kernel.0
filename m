From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Apr 2015 19:13:00 +0100
Subject: ARM errata 430973 on multi platform kernels
In-Reply-To: <20150423141727.GQ18048@atomide.com>
References: <20150407135713.GL4027@n2100.arm.linux.org.uk>
 <20150407152207.GM18048@atomide.com>
 <20150408230658.GO4027@n2100.arm.linux.org.uk>
 <20150409134843.GQ4027@n2100.arm.linux.org.uk>
 <20150415163108.GB2033@earth> <20150416160858.GH18048@atomide.com>
 <20150417184156.GA3326@earth> <20150420234032.GM18048@atomide.com>
 <20150423102542.GZ4027@n2100.arm.linux.org.uk>
 <20150423141727.GQ18048@atomide.com>
Message-ID: <20150428181300.GB4027@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 23, 2015 at 07:17:28AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [150423 03:26]:
> > However, I don't think anyone is willing to say that they have a
> > solution to this problem - obviously, you can't build OMAP as a
> > non-multiplatform kernel anymore, so in effect you can never have
> > the kernel enable this errata.  And you can't detect whether you're
> > running in secure mode or not.
> > 
> > We could do the "only write the bit if it was originally clear" but
> > we still have the problem that doing so may cause other people
> > regressions.
> 
> How about we keep the bit writing part !multiplatform conditional
> (or even remove it) but always do the flush for ca-8?
> 
> Then we could also do a warning for a misconfigured ca-8 later on.

Yes, we could do this - we'll have to rely on the boot loader doing
the right thing and setting this bit appropriately.  For those
platforms where this doesn't apply, I don't see any solution as (iirc)
OMAP now requires MULTIPLATFORM to be enabled.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
