From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue, 26 Jun 2018 13:14:35 +0800
Subject: [PATCH 0/5] arm64: allwinner: h6: Enable AXP805 PMIC on Pine H64
In-Reply-To: <20180620051540.25617-1-wens@csie.org>
References: <20180620051540.25617-1-wens@csie.org>
Message-ID: <7397ce33b3b5f1a6743ce8d527807efdb7f73caa.camel@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2018-06-20?? 13:15 +0800?Chen-Yu Tsai???
> Hi everyone,
> 
> This series enables the AXP805 PMIC found on the Pine64 Pine H64
> board.
> The AXP805 seems to be identical to the AXP806 when comparing
> datasheets.
> The Pine H64 uses the PMIC in stand-alone or "self-working" mode,
> using
> the I2C interface. Neither features are currently supported. This
> series
> adds support for them, and then adds the PMIC to the device tree.
> 
> Patch 1 adds a new device tree property to describe the self-working
> mode
> for the AXP806.
> 
> Patch 2 adds support for the newly added property to the driver.
> 
> Patch 3 adds support for the using AXP806 with I2C.
> 
> Patch 4 converts raw clock/reset indices for the H6 R_CCU currently
> found
> in the device tree to macros defined as part of the device tree
> bindings.
> 
> Patch 5 adds the PMIC and its regulators to the Pine H64 device tree.
> 
> Please have a look.
> 
> Regards
> ChenYu

For the whole series:

Tested-by: Icenowy Zheng <icenowy@aosc.io>

And, except two small inline comments,

Reviewed-by: Icenowy Zheng <icenowy@aosc.io>

> 
> 
> Chen-Yu Tsai (4):
>   dt-bindings: mfd: axp20x: Add "self-working" mode for AXP806
>   mfd: axp20x: Add self-working mode support for AXP806
>   mfd: axp20x: Support AXP806 in I2C mode
>   arm64: dts: allwinner: h6: Use macros for R_CCU clock and reset
>     indices
> 
> Icenowy Zheng (1):
>   arm64: dts: allwinner: h6: enable AXP805 PMIC on Pine H64
> 
>  .../devicetree/bindings/mfd/axp20x.txt        |   7 +-
>  .../boot/dts/allwinner/sun50i-h6-pine-h64.dts | 109
> ++++++++++++++++++
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |   9 +-
>  drivers/mfd/axp20x-i2c.c                      |   2 +
>  drivers/mfd/axp20x.c                          |  30 ++++-
>  5 files changed, 149 insertions(+), 8 deletions(-)
> 
