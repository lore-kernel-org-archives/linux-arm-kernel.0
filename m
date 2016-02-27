From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 27 Feb 2016 10:54:47 -0800
Subject: [PATCH v2 00/10] mfd: axp20x: Add support for AXP809 PMIC
In-Reply-To: <1455532288-30870-1-git-send-email-wens@csie.org>
References: <1455532288-30870-1-git-send-email-wens@csie.org>
Message-ID: <CAGb2v667XLSNQQf9kfYf1fV3Q0J1ktfVe+QFfxmZYCXQHnf=7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Mon, Feb 15, 2016 at 2:31 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> Hi everyone,
>
> This is v2 of the AXP809 PMIC support series. This adds support for
> X-Powers' AXP809 PMIC. This is the primary PMIC accompanying Allwinner's
> A80 SoC. For now, only the power button (PEK) and regulators are
> supported. These are supported using existing axp20x drivers. This is
> based on the AXP223 series v8, as well as 2 patches from v1 that are
> already in regulator/topic/axp20x.

Any updates on this series?

Thanks.
ChenYu

> Changes since v1:
>
>   - Added patch 4, changing default regulator names to lowercase.
>   - Dropped regulator nodes from axp809.dtsi.
>
> Patch 1 adds a MAINTAINERS entry for the X-Powers AXP PMICs. I list
> myself as the maintainer.
>
> Patch 2 adds AXP809 to the axp20x bindings.
>
> Patch 3 adds AXP809 support to the axp20x mfd driver.
>
> Patch 4 changes the in-kernel default regulator names from uppercase to
> lowercase, making it easier on the eye.
>
> Patch 5 adds AXP809 support to the axp20x regulator driver. This patch
> depends on patch 3, and patches already in regulator/topic/axp20x.
>
> Patch 6 adds a dtsi file for AXP809.
>
> Patch 7 enables AXP809 support on the A80 Optimus board.
>
> Patch 8 enables AXP809 support on the Cubieboard 4.
>
> Patch 9 disables the dummy regulators from sunxi-common-regulators.dtsi
> on the A80 Optimus board. These aren't used in the board DTS anymore.
>
> Patch 10 disables the dummy regulators from sunxi-common-regulators.dtsi,
> on the Cubieboard4. These aren't used in the board DTS anymore.
>
>
> Regards
> ChenYu
>
> Chen-Yu Tsai (10):
>   MAINTAINERS: Add entry for X-Powers AXP family PMIC drivers
>   mfd: axp20x: Add bindings for AXP809 PMIC
>   mfd: axp20x: Add support for AXP809 PMIC
>   regulator: axp20x: Use of_match name as default regulator name
>   regulator: axp20x: support AXP809 variant
>   ARM: dts: sunxi: Add dtsi file for AXP809 PMIC
>   ARM: dts: sun9i: a80-optimus: Add AXP809 PMIC device node and
>     regulators
>   ARM: dts: sun9i: cubieboard4: Add AXP809 PMIC device node and
>     regulators
>   ARM: dts: sun9i: a80-optimus: Disable dummy regulators vcc3v0, vcc3v3,
>     vcc5v0
>   ARM: dts: sun9i: cubieboard4: Disable dummy regulators vcc3v0, vcc3v3,
>     vcc5v0
>
>  Documentation/devicetree/bindings/mfd/axp20x.txt   |  31 ++++-
>  MAINTAINERS                                        |   6 +
>  .../dts/{sun9i-a80-cubieboard4.dts => axp809.dtsi} |  98 ++------------
>  arch/arm/boot/dts/sun9i-a80-cubieboard4.dts        | 143 ++++++++++++++++++++-
>  arch/arm/boot/dts/sun9i-a80-optimus.dts            | 143 ++++++++++++++++++++-
>  drivers/mfd/axp20x-rsb.c                           |   1 +
>  drivers/mfd/axp20x.c                               |  79 ++++++++++++
>  drivers/regulator/axp20x-regulator.c               | 129 ++++++++++++++-----
>  include/linux/mfd/axp20x.h                         |  59 +++++++++
>  9 files changed, 559 insertions(+), 130 deletions(-)
>  copy arch/arm/boot/dts/{sun9i-a80-cubieboard4.dts => axp809.dtsi} (52%)
>
> --
> 2.7.0
>
