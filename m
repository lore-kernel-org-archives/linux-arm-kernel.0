From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 15 Feb 2017 09:36:03 +0000
Subject: [PATCH v3 00/18] add support for AXP20X and AXP22X power supply
 drivers
In-Reply-To: <20170214094112.27426-1-quentin.schulz@free-electrons.com>
References: <20170214094112.27426-1-quentin.schulz@free-electrons.com>
Message-ID: <20170215093603.5bk5hqq6p3istxdi@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


[...]

> Quentin Schulz (18):
>   dt-bindings: power: battery: add constant-charge-current property
>   power: supply: power_supply_core: add constant-current-charge optional
>     property
>   mfd: axp20x: correct name of temperature data ADC registers
>   iio: adc: add support for X-Powers AXP20X and AXP22X PMICs ADCs
>   mfd: axp20x: add ADC cells for AXP20X and AXP22X PMICs
>   mfd: axp20x: add AC power supply cells for AXP22X PMICs
>   ARM: dtsi: axp209: add AC power supply subnode
>   ARM: dtsi: axp22x: add AC power supply subnode
>   ARM: dts: sun8i: sina33: enable ACIN power supply subnode
>   ARM: sun5i: chip: enable ACIN power supply subnode
>   dt-bindings: power: supply: add AXP20X/AXP22X battery DT binding
>   mfd: axp20x: add CHRG_CTRL1/2/3 to writeable regs for AXP20X/AXP22X
>   power: supply: add battery driver for AXP20X and AXP22X PMICs
>   mfd: axp20x: add MFD cells for AXP20X and AXP22X battery driver
>   ARM: dtsi: axp209: add battery power supply subnode
>   ARM: dtsi: axp22x: add battery power supply subnode
>   ARM: dts: sun8i: sina33: enable battery power supply subnode
>   ARM: sun5i: chip: enable battery power supply subnode

This set is still missing a bunch of Acks.

>  .../bindings/power/supply/axp20x_battery.txt       |  20 +
>  .../devicetree/bindings/power/supply/battery.txt   |   2 +
>  arch/arm/boot/dts/axp209.dtsi                      |  10 +
>  arch/arm/boot/dts/axp22x.dtsi                      |  10 +
>  arch/arm/boot/dts/sun5i-r8-chip.dts                |   8 +
>  arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |   8 +
>  drivers/iio/adc/Kconfig                            |  10 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/axp20x_adc.c                       | 606 +++++++++++++++++++++
>  drivers/mfd/axp20x.c                               |  29 +-
>  drivers/power/supply/Kconfig                       |  12 +
>  drivers/power/supply/Makefile                      |   1 +
>  drivers/power/supply/axp20x_battery.c              | 492 +++++++++++++++++
>  drivers/power/supply/power_supply_core.c           |   3 +
>  include/linux/mfd/axp20x.h                         |   4 +-
>  include/linux/power_supply.h                       |   1 +
>  16 files changed, 1214 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
>  create mode 100644 drivers/iio/adc/axp20x_adc.c
>  create mode 100644 drivers/power/supply/axp20x_battery.c
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
