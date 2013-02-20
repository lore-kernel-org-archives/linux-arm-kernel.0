From: badarkhe.manish@gmail.com (Manish Badarkhe)
Date: Wed, 20 Feb 2013 17:28:07 +0530
Subject: [PATCH V3] ARM: dts: add minimal DT support for DevKit8000
In-Reply-To: <1360999167-17606-1-git-send-email-anilk4.v@gmail.com>
References: <1360999167-17606-1-git-send-email-anilk4.v@gmail.com>
Message-ID: <CAKDJKT6uMQN_MaPNDt4dDxEKNZHyuupBzD0KrFUQ2fpiUYzk3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 16, 2013 at 12:49 PM, Anil Kumar <anilk4.v@gmail.com> wrote:
> DevKit8000 is a beagle board clone from Timll, sold by
> armkits.com. The DevKit8000 has RS232 serial port, LCD, DVI-D,
> S-Video, Ethernet, SD/MMC, keyboard, camera, SPI, I2C, USB and
> JTAG interface.
>
> This patch adds the basic DT support for devkit8000. At this time,
> Information
> of twl4030 (PMIC), MMC1, I2C1 and leds are added.
>
> Signed-off-by: Anil Kumar <anilk4.v@gmail.com>
> Tested-by: Thomas Weber <thomas@tomweber.eu>
> ---
>  -This patch is based on top of kernel 3.8-rc5.
>
>  -Tested on Devkit8000.
>
> For V3:
>  - Remove pin mux as done at device boot time by default.
>
> For V2:
>  - Change model name as "TimLL OMAP3 Devkit8000"
>  - Change compatible as "timll,omap3-devkit8000"
>  - Doing i2c1 pinmux default with pinctrl-single driver instead of i2c1
>    driver probe time.
>
> :100644 100644 5ebb44f... 22ebc76... M  arch/arm/boot/dts/Makefile
> :000000 100644 0000000... 6338993... A
> arch/arm/boot/dts/omap3-devkit8000.dts
> :100644 100644 53cb380b.. ccecb76... M
> arch/arm/mach-omap2/board-generic.c
>  arch/arm/boot/dts/Makefile             |    1 +
>  arch/arm/boot/dts/omap3-devkit8000.dts |  103
> ++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/board-generic.c    |    1 +
>  3 files changed, 105 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 5ebb44f..22ebc76 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -102,6 +102,7 @@ dtb-$(CONFIG_ARCH_MXS) += imx23-evk.dtb \
>         imx28-tx28.dtb
>  dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
>         omap3-beagle.dtb \
> +       omap3-devkit8000.dtb \
>         omap3-beagle-xm.dtb \
>         omap3-evm.dtb \
>         omap3-tobi.dtb \
> diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts
> b/arch/arm/boot/dts/omap3-devkit8000.dts
> new file mode 100644
> index 0000000..6338993
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap3-devkit8000.dts
> @@ -0,0 +1,103 @@
> +/*
> + * Author: Anil Kumar <anilk4.v@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +/dts-v1/;
> +
> +/include/ "omap3.dtsi"
> +/ {
> +       model = "TimLL OMAP3 Devkit8000";
> +       compatible = "timll,omap3-devkit8000", "ti,omap3";
> +
> +       memory {
> +               device_type = "memory";
> +               reg = <0x80000000 0x10000000>;  /* 256 MB */
> +       };
> +
> +       leds {
> +               compatible = "gpio-leds";
> +
> +               heartbeat {
> +                       label = "devkit8000::led1";
> +                       gpios = <&gpio6 26 0>;  /* 186 -> LED1 */
> +                       default-state = "on";
> +                       linux,default-trigger = "heartbeat";
> +               };
> +
> +               mmc {
> +                       label = "devkit8000::led2";
> +                       gpios = <&gpio6 3 0>;   /* 163 -> LED2 */
> +                       default-state = "on";
> +                       linux,default-trigger = "none";
> +               };
> +
> +               usr {
> +                       label = "devkit8000::led3";
> +                       gpios = <&gpio6 4 0>;   /* 164 -> LED3 */
> +                       default-state = "on";
> +                       linux,default-trigger = "usr";
> +                };
> +

No need of extra line over here.

Thanks
Manish Badarkhe
