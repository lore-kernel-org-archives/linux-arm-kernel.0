From: tony@atomide.com (Tony Lindgren)
Date: Thu, 14 Jun 2012 04:52:08 -0700
Subject: [PATCH 3/3] ARM: OMAP2+: gpmc: handle additional timings
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E99994C@DBDE01.ent.ti.com>
References: <4FD63DBF.9000200@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997D9E@DBDE01.ent.ti.com>
 <4FD77E35.3050703@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998767@DBDE01.ent.ti.com>
 <20120613113217.GK12766@atomide.com>
 <20120613115445.GM12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998C80@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999849@DBDE01.ent.ti.com>
 <20120614101901.GI12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99994C@DBDE01.ent.ti.com>
Message-ID: <20120614115207.GL12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mohammed, Afzal <afzal@ti.com> [120614 03:43]:
> Hi Tony,
> 
> On Thu, Jun 14, 2012 at 15:49:02, Tony Lindgren wrote:
> 
> > Well I took a look at the values, and it seems the only difference is the
> > static GPMC_CONFIG1_CLKACTIVATIONTIME(1) that your patch now overwrites 0.
> 
> It seems change below should be part of $subject.
> 
> Please let me know your comments
> 
> Regards
> Afzal
> 
> diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
> index fd4c48d..938896c 100644
> --- a/arch/arm/mach-omap2/gpmc-onenand.c
> +++ b/arch/arm/mach-omap2/gpmc-onenand.c
> @@ -321,6 +321,8 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
>         t.rd_cycle = gpmc_ticks_to_ns(fclk_offset + (latency + 1) * div +
>                      ticks_cez);
> 
> +       t.clk_activation = fclk_offset_ns;
> +

This too should be fclk_offset, not fclk_offset_ns.

Tony
