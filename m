From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 30 Sep 2015 17:03:40 +0200
Subject: [RFC/PATCH 00/11] arm: omap: counter32k rework
In-Reply-To: <6944324.e1oo8C9xbx@wuerfel>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
 <20150930141338.GC31865@saruman.tx.rr.com>
 <3705422.OMk7ysE7Jn@wuerfel> <6944324.e1oo8C9xbx@wuerfel>
Message-ID: <20150930150340.GA19079@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 04:49:53PM +0200, Arnd Bergmann wrote:
> On Wednesday 30 September 2015 16:42:21 Arnd Bergmann wrote:
> > 
> > TEGRA folks: the tegra_read_persistent_clock() implementation apparently
> > predates the Tegra RTC driver and I wonder if they actually do the
> > right thing in combination. Could it be that the wall time forwards
> > twice as fast as it should during resume when the RTC driver is loaded?
> > Could it be that we can simply remove  tegra_read_persistent_clock()
> > and the register_persistent_clock() infrastructure?
> > 
> 
> I found the 'sleeptime_injected' variable now, which takes care of
> forwarding the clock by the correct amount.
> 
> I also found the CLOCK_SOURCE_SUSPEND_NONSTOP flag next to it, which
> should let us use the counter32k driver to provide the correct
> time during suspend without the omap_read_persistent_clock() function.
> We should be able to just delete that code.
> 
> If we decide to also delete the tegra_read_persistent_clock()
> function, we can remove the registration too.

This was discussed a very long time ago, but I can't remember most of
the context. I found this in my inbox:

	https://lkml.org/lkml/2014/11/7/605

But I don't remember if there was an outcome or if anything came of
that. I'm currently busy with some other work, but thought I'd drop
this reference here in case somebody wants to dig into it before I
get around to it.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150930/e12518b4/attachment.sig>
