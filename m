From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Jul 2018 10:19:16 +0800
Subject: [PATCH v3 0/5] arm64: allwinner: h6: Enable AXP805 PMIC on Pine
 H64
In-Reply-To: <20180712160452.5516-1-wens@csie.org>
References: <20180712160452.5516-1-wens@csie.org>
Message-ID: <CAGb2v66bGNbcnHBd2pQ64EC1G62uCGhmwGjBrJ_st88y83dAWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2018 at 12:04 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> Hi everyone,
>
> This series enables the AXP805 PMIC found on the Pine64 Pine H64 board.
> The AXP805 seems to be identical to the AXP806 when comparing datasheets.
> The Pine H64 uses the PMIC in stand-alone or "self-working" mode, using
> the I2C interface. Neither features are currently supported. This series
> adds support for them, and then adds the PMIC to the device tree.
>
> Unfortunately, v2 was actually an accidental resend of v1. Apologies to
> Lee having to review the same stuff twice.
>
> Changes since v1:
>
>   - Mentioned "self-working mode" in device tree commit message
>   - Shortened one line mfd cell into just one line
>   - Dropped unrelated pinctrl change
>   - Collected tags from Rob, Icenowy, Lee, and Maxime
>
> Patch 1 adds a new device tree property to describe the self-working mode
> for the AXP806.
>
> Patch 2 adds support for the newly added property to the driver.
>
> Patch 3 adds support for the using AXP806 with I2C.
>
> Patch 4 converts raw clock/reset indices for the H6 R_CCU currently found
> in the device tree to macros defined as part of the device tree bindings.
>
> Patch 5 adds the PMIC and its regulators to the Pine H64 device tree.
>
> First three patches should go in through Lee's mfd tree. We'll take the
> other two through the sunxi tree.

Merged the device tree patches.

> Please have a look.
>
> Regards
> ChenYu
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
>  .../boot/dts/allwinner/sun50i-h6-pine-h64.dts | 109 ++++++++++++++++++
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |   8 +-
>  drivers/mfd/axp20x-i2c.c                      |   2 +
>  drivers/mfd/axp20x.c                          |  28 ++++-
>  5 files changed, 146 insertions(+), 8 deletions(-)
>
> --
> 2.18.0
>
