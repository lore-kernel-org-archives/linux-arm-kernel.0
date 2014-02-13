From: marek.belisko@gmail.com (Belisko Marek)
Date: Thu, 13 Feb 2014 14:07:52 +0100
Subject: [PATCH 0/8] OMAP: OMAP3 DSS related clock patches
In-Reply-To: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com>
References: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <CAAfyv34RNULeCpp8LV1LudJt7+Xs+wbKp+Zm4SSrH1GJPxGkLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 13, 2014 at 11:03 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> Hi,
>
> I've been debugging OMAP3 related issues with DSS clocks, and I hopefully have
> them all fixed with this series. This fixes the problems for both non-DT boot,
> but also for DT boot with DSS DT support (which is not merged yet).
>
> The non-DT boot related fixes should be merged for 3.14, but I'd like the DT
> boot related fixes to be merged for 3.14 also, as that'll make handling the DSS
> DT support easier.
>
> This is based on v3.14-rc2.
Tested on gta04 board with DSS DT patches v3 (rebased on 3.14-rc2).
Panel is finally working fine.
Thanks.

Tested-by: Marek Belisko <marek@goldelico.com>

>
>  Tomi
>
> Tomi Valkeinen (8):
>   clk: divider: fix rate calculation for fractional rates
>   clk: ti/divider: fix rate calculation for fractional rates
>   ARM: OMAP2+: clock: fix clkoutx2 with CLK_SET_RATE_PARENT
>   ARM: dts: fix omap3 dss clock handle names
>   ARM: dts: fix DPLL4 x2 clkouts on 3630
>   ARM: dts: use ti,fixed-factor-clock for dpll4_m4x2_mul_ck
>   ARM: dts: set 'ti,set-rate-parent' for dpll4_m4 path
>   OMAPDSS: fix rounding when calculating fclk rate
>
>  arch/arm/boot/dts/omap3430es1-clocks.dtsi          |  6 +--
>  .../omap36xx-am35xx-omap3430es2plus-clocks.dtsi    |  6 +--
>  arch/arm/boot/dts/omap36xx-clocks.dtsi             | 20 +++++++
>  arch/arm/boot/dts/omap36xx.dtsi                    |  2 +-
>  arch/arm/boot/dts/omap3xxx-clocks.dtsi             |  8 +--
>  arch/arm/mach-omap2/cclock3xxx_data.c              |  2 +
>  arch/arm/mach-omap2/dpll3xxx.c                     | 62 ++++++++++++++++++++++
>  drivers/clk/clk-divider.c                          | 10 ++--
>  drivers/clk/ti/divider.c                           |  8 +--
>  drivers/video/omap2/dss/dss.c                      |  4 +-
>  include/linux/clk/ti.h                             |  4 ++
>  11 files changed, 111 insertions(+), 21 deletions(-)
>
> --
> 1.8.3.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

BR,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
