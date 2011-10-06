From: tony@atomide.com (Tony Lindgren)
Date: Thu, 6 Oct 2011 16:03:08 -0700
Subject: [PATCH-V3 2/4] arm:omap:am33xx: Update common OMAP machine
	specific sources
In-Reply-To: <87ehyyj6ts.fsf@ti.com>
References: <hvaibhav@ti.com>
	<1316529142-27564-3-git-send-email-hvaibhav@ti.com>
	<87fwjjcfbt.fsf@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930257840691@dbde02.ent.ti.com>
	<87ehyyj6ts.fsf@ti.com>
Message-ID: <20111006230308.GX6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [110930 09:35]:
> "Premi, Sanjeev" <premi@ti.com> writes:
> 
> Actually, looking at this closer, I think the infrastructure is already
> there to handle this cleanly.
> 
> Basically, dpll5 should not even be registered for SoCs where it doesn't
> exist.  Then, any attempts to use DPLL5 would know it doesn't exist
> because the call to clk_get() in omap3_clk_lock_dpll5() would fail.

Yes please use the SoC specific lists, see what we have now queued
up in sram-map-io branch. So using SoC specific map_io + init_early +
set_globals should do the trick.
 
> I think the clock3xxx_data.c needs a bit more cleanup so that only
> clocks that exist for a given SoC are registered.
> 
> Paul already did a similar cleanup for the powerdomain data files by
> creating separate lists for common ones and unique ones.  Looks like we
> need the same for the clock data.

Right.

Regards,

Tony
