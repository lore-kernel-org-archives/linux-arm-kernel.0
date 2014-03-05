From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 5 Mar 2014 10:35:02 +0200
Subject: [PATCH 0/8] OMAP: OMAP3 DSS related clock patches
In-Reply-To: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com>
References: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <5316E1B6.4060007@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tero,

What about the dts fixes in this series? DSS DT depends on those fixes.
I'd like the dts fixes to be either merged for v3.14, or I can add them
to my DSS DT series (with acks).

 Tomi

On 13/02/14 12:03, Tomi Valkeinen wrote:
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


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140305/c929fbc3/attachment.sig>
