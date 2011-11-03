From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Thu, 3 Nov 2011 13:48:20 +0000
Subject: [PATCH-V3 2/4] arm:omap:am33xx: Update common OMAP machine
	specific sources
In-Reply-To: <20111006230308.GX6324@atomide.com>
References: <hvaibhav@ti.com>
	<1316529142-27564-3-git-send-email-hvaibhav@ti.com>
	<87fwjjcfbt.fsf@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930257840691@dbde02.ent.ti.com>
	<87ehyyj6ts.fsf@ti.com> <20111006230308.GX6324@atomide.com>
Message-ID: <79CD15C6BA57404B839C016229A409A801E53A@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Tony Lindgren [mailto:tony at atomide.com]
> Sent: Friday, October 07, 2011 4:33 AM
> To: Hilman, Kevin
> Cc: Premi, Sanjeev; Hiremath, Vaibhav; linux-omap at vger.kernel.org;
> paul at pwsan.com; linux-arm-kernel at lists.infradead.org; Mohammed, Afzal
> Subject: Re: [PATCH-V3 2/4] arm:omap:am33xx: Update common OMAP machine
> specific sources
> 
> * Kevin Hilman <khilman@ti.com> [110930 09:35]:
> > "Premi, Sanjeev" <premi@ti.com> writes:
> >
> > Actually, looking at this closer, I think the infrastructure is already
> > there to handle this cleanly.
> >
> > Basically, dpll5 should not even be registered for SoCs where it doesn't
> > exist.  Then, any attempts to use DPLL5 would know it doesn't exist
> > because the call to clk_get() in omap3_clk_lock_dpll5() would fail.
> 
> Yes please use the SoC specific lists, see what we have now queued
> up in sram-map-io branch. So using SoC specific map_io + init_early +
> set_globals should do the trick.
> 
Sorry for delayed response, was on festival vacation...

> > I think the clock3xxx_data.c needs a bit more cleanup so that only
> > clocks that exist for a given SoC are registered.
> >
> > Paul already did a similar cleanup for the powerdomain data files by
> > creating separate lists for common ones and unique ones.  Looks like we
> > need the same for the clock data.
> 
> Right.
> 
I agree that we need to clean clock data, but with the current discussion,
feel it may not be so useful, since the clock tree of the AM335x device is
different than OMAP3 family of devices -

http://www.ti.com/product/am3359

Public TRM -
http://www.ti.com/lit/ug/spruh73/spruh73.pdf


While porting Linux kernel to AM335x EVM, I had created separate clock data
file for AM33xx -
	- arch/arm/mach-omap2/clock33xx_data.c

Similar for clock domain data -
	- arch/arm/mach-omap2/clockdomains33xx_data.c

So we don't need any of the changes which we are discussing about, since execution doesn't reach there.


Currently looking at clock data, to see how this cleanup can be achieved,
any suggestions/comments/pointers would be helpful.


Thanks,
Vaibhav

> Regards,
> 
> Tony
