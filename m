From: max.schwarz@online.de (Max Schwarz)
Date: Wed, 07 May 2014 12:04:36 +0200
Subject: [PATCH v2 0/8] pinctrl-rockchip: Change wrong initial assumptions
In-Reply-To: <11862890.WUjscWaP3U@diego>
References: <11862890.WUjscWaP3U@diego>
Message-ID: <4611044.dLc2GHPYxV@xq-nb>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 5. Mai 2014, 13:57:31 schrieb Heiko St?bner:
> Initially due to lack of documentation and (personal) understanding
> I assumed that the area holding the iomux settings would be separate
> from everything else, while in fact the grf registers contain not only
> pinctrl stuff but also dma, usb-phy and general soc-status settings.
> Also things like drive-strength we do not support currently are intermixed.
> 
> The same is true for the pmu, which does not only contain power domains
> but also the system reset as well as well as general registers surviving
> system-resets. Additionally the rk3188 moved parts of the pull-setting
> registers into the pmu space.
> 
> While this wasn't a problem until now, the upcoming rk3288 introduces
> additional changes to both the grf and pmu areas. On it even part of
> the pinmux registers move into the pmu space.
> 
> The code in it's current form supports both the old as well as the
> changed bindings.
> 
> As stated in the v1 thread, this is also a first step to deprecate the
> wrongly included gpio-controllers which now duplicate the recently added
> gpio-dwapb, that should be used instead.
> 
> 
> changes since v1:
> - add select MFD_SYSCON as suggested by Max
> 
> Heiko Stuebner (8):
>   pinctrl: rockchip: do not require 2nd register area
>   pinctrl: rockchip: use regmaps instead of raw mappings
>   pinctrl: rockchip: rockchip_pinctrl in rockchip_get_bank_data
>   pinctrl: rockchip: let pmu registers be supplied by a syscon
>   pinctrl: rockchip: only map bank0-pull-region when pmu regmap missing
>   pinctrl: rockchip: base regmap supplied by a syscon
>   dt-bindings: adapt rockchip-pinctrl doc to changed bindings
>   ARM: dts: rockchip: convert pinctrl nodes to new bindings
> 
>  .../bindings/pinctrl/rockchip,pinctrl.txt          |  28 +++-
>  arch/arm/boot/dts/rk3066a.dtsi                     |   2 +-
>  arch/arm/boot/dts/rk3188.dtsi                      |   9 +-
>  arch/arm/boot/dts/rk3xxx.dtsi                      |   9 +-
>  drivers/pinctrl/Kconfig                            |   1 +
>  drivers/pinctrl/pinctrl-rockchip.c                 | 178
> +++++++++++++++------ 6 files changed, 165 insertions(+), 62 deletions(-)

This series
Acked-by: Max Schwarz <max.schwarz@online.de>

Cheers,
  Max
