From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 12 Feb 2016 09:01:39 +0000
Subject: [PATCH v8 00/10] mfd: axp20x: Add support for RSB based AXP223
In-Reply-To: <1455242567-17880-1-git-send-email-wens@csie.org>
References: <1455242567-17880-1-git-send-email-wens@csie.org>
Message-ID: <20160212090139.GO20693@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 12 Feb 2016, Chen-Yu Tsai wrote:

[...]

> Chen-Yu Tsai (10):
>   mfd: axp20x: Add AXP223 to list of supported PMICs in DT bindings
>   mfd: axp20x: Remove second struct device * parameter for
>     axp20x_match_device()
>   mfd: axp20x: use dev->driver->of_match_table in axp20x_match_device()
>   mfd: axp20x: Add missing copyright notice
>   mfd: axp20x: Split the driver into core and i2c bits
>   mfd: axp20x: Whitespace, open parenthesis alignment code style fixes
>   mfd: axp20x: Add support for RSB based AXP223 PMIC
>   regulator: axp20x: Support new AXP223 PMIC
>   ARM: dts: sun8i: sinlinx-sina33: Add AXP223 PMIC device and regulator
>     nodes
>   ARM: dts: sun8i: q8-common: Add AXP223 PMIC device and regulator nodes
> 
>  Documentation/devicetree/bindings/mfd/axp20x.txt |   7 +-
>  arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts   |  76 +++++++++++++++-
>  arch/arm/boot/dts/sun8i-q8-common.dtsi           |  83 +++++++++++++++++-
>  drivers/mfd/Kconfig                              |  25 ++++--
>  drivers/mfd/Makefile                             |   2 +
>  drivers/mfd/axp20x-i2c.c                         | 104 ++++++++++++++++++++++
>  drivers/mfd/axp20x-rsb.c                         |  80 +++++++++++++++++
>  drivers/mfd/axp20x.c                             | 105 ++++++-----------------
>  drivers/regulator/axp20x-regulator.c             |   3 +
>  include/linux/mfd/axp20x.h                       |  34 +++++++-
>  10 files changed, 425 insertions(+), 94 deletions(-)
>  create mode 100644 drivers/mfd/axp20x-i2c.c
>  create mode 100644 drivers/mfd/axp20x-rsb.c

Right, I've applied the MFD and Regulator patches and sent out the
required pull-request.  You just need to have the arch/arm/ patches
taken care off and you're all set.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
