From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 17 Dec 2014 18:54:03 +0800
Subject: [PATCH v2 0/4] clk: sunxi: mmc: Last bits of phase handling
In-Reply-To: <1418765936-12542-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1418765936-12542-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v672ozg8BREGY9Fyxs9QrkM8ksVpwK7EdC0WK8X2GfBx8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 17, 2014 at 5:38 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> These are the last patches of the serie converting the custom phase
> API to the proper common clock framework API.
>
> These patches have already been discussed in length, only the patch 1
> is new and should ease the handling of our MMC clocks.
>
> Thanks,
> Maxime
>
> Changes from v1:
>   - Fixed memory leak when a phase clock registration fails
>   - Moved the spinlock declaration
>   - Updated the DT bindings docs
>
> Maxime Ripard (4):
>   clk: sunxi: Rework MMC phase clocks
>   ARM: sunxi: dt: Add sample and output mmc clocks
>   mmc: sunxi: Convert MMC driver to the standard clock phase API
>   clk: sunxi: Remove custom phase function

Apart from the minor comments, whole series is

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Also tested on my Cubieboard, Cubieboard2, Hummingbird A31,
and HSG H702 (A13 tablet).


ChenYu

>
>  Documentation/devicetree/bindings/clock/sunxi.txt  |   7 +-
>  .../devicetree/bindings/mmc/sunxi-mmc.txt          |   8 +-
>  arch/arm/boot/dts/sun4i-a10.dtsi                   |  72 +++++++----
>  arch/arm/boot/dts/sun5i-a10s.dtsi                  |  54 ++++++---
>  arch/arm/boot/dts/sun5i-a13.dtsi                   |  44 +++++--
>  arch/arm/boot/dts/sun6i-a31.dtsi                   |  72 +++++++----
>  arch/arm/boot/dts/sun7i-a20.dtsi                   |  72 +++++++----
>  arch/arm/boot/dts/sun8i-a23.dtsi                   |  54 ++++++---
>  drivers/clk/sunxi/clk-mod0.c                       | 131 +++++++++++----------
>  drivers/clk/sunxi/clk-sunxi.c                      |  37 ------
>  drivers/mmc/host/sunxi-mmc.c                       |  72 +++++++----
>  include/linux/clk/sunxi.h                          |  22 ----
>  12 files changed, 392 insertions(+), 253 deletions(-)
>  delete mode 100644 include/linux/clk/sunxi.h
>
> --
> 2.2.0
>
