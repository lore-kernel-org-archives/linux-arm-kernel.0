From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 2 Feb 2011 11:35:41 +0530
Subject: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP (Re: 4430SDP boot
	failure)
In-Reply-To: <20110202011006.GP3358@atomide.com>
References: <20110106170805.GE1198@n2100.arm.linux.org.uk>
	<20110106180030.GA8249@n2100.arm.linux.org.uk>
	<20110106182023.GV7771@atomide.com>
	<20110106203238.GH1198@n2100.arm.linux.org.uk>
	<20110106204053.GA7771@atomide.com>
	<20110107161230.GR1198@n2100.arm.linux.org.uk>
	<20110110185209.GC4957@atomide.com> <20110111231611.GX4957@atomide.com>
	<3c13ae6d9e13b94548bfcaaced7681e8@mail.gmail.com>
	<20110202011006.GP3358@atomide.com>
Message-ID: <81ed58d7158cfa16007e141d0ac1f74c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Tony Lindgren [mailto:tony at atomide.com]
> Sent: Wednesday, February 02, 2011 6:40 AM
> To: Anand Gadiyar
> Cc: Russell King - ARM Linux; linux-arm-kernel at lists.infradead.org;
> linux-omap at vger.kernel.org; Keshava Munegowda; Santosh Shilimkar;
> Felipe Balbi
> Subject: Re: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP (Re:
> 4430SDP boot failure)
>
> * Anand Gadiyar <gadiyar@ti.com> [110201 04:54]:
> >
> > I believe this fix is fixing your reboot issue, but it's breaking
> > EHCI support on the SDP.
> >
> > The MODE4 above should really be MODE3 - all GPIOs are on MODE3.
> > By changing
> >
> > The patch snippet below fixes EHCI on the SDP, but I believe that
> > making this change will reintroduce the "board reboots" issue
> > you originally reported. Could you check and tell me if this
> > is the case?
>
> Hmm sorry looks like I made a typo there. That should be fixed.
>
> > Just curious - is your board a Blaze, or an SDP?
>
> It's a ES1.0 blaze, with the patch below it reboots early
> during the boot. I also have to disable omap_l2_cache_init
> on this board to get it to boot.
>
Do you still get this problem with 'omap_l2_cache_init' ?
As reported earlier, we don't see this issue on ES1.0
SDP.
