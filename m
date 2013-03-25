From: monstr@monstr.eu (Michal Simek)
Date: Mon, 25 Mar 2013 15:28:43 +0100
Subject: [PATCH] ARM: zynq: add support for ZedBoard
In-Reply-To: <1364043863-20669-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1364043863-20669-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <CAHTX3dJK4r6w1GFp7x=KYvK65XwM366+=BD-B8dH5pGtDBm=Tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/23 Steffen Trumtrar <s.trumtrar@pengutronix.de>:
> Support the Avnet ZedBoard.
>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  arch/arm/boot/dts/Makefile          |  3 ++-
>  arch/arm/boot/dts/zynq-zedboard.dts | 45 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/zynq-zedboard.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 9c62558..1d36a4c 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -174,7 +174,8 @@ dtb-$(CONFIG_ARCH_VT8500) += vt8500-bv07.dtb \
>         wm8505-ref.dtb \
>         wm8650-mid.dtb \
>         wm8850-w70v2.dtb
> -dtb-$(CONFIG_ARCH_ZYNQ) += zynq-zc702.dtb
> +dtb-$(CONFIG_ARCH_ZYNQ) += zynq-zc702.dtb \
> +       zynq-zedboard.dtb
>
>  targets += dtbs
>  targets += $(dtb-y)
> diff --git a/arch/arm/boot/dts/zynq-zedboard.dts b/arch/arm/boot/dts/zynq-zedboard.dts
> new file mode 100644
> index 0000000..1b024c7
> --- /dev/null
> +++ b/arch/arm/boot/dts/zynq-zedboard.dts
> @@ -0,0 +1,45 @@
> +/*
> + *  Copyright (C) 2013 Steffen Trumrar <s.trumtrar@pengutronix.de>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +/dts-v1/;
> +/include/ "zynq-7000.dtsi"
> +
> +/ {
> +       model = "Zynq ZedBoard";
> +       compatible = "xlnx,zynq-zed", "xlnx,zynq-7000";
> +
> +       memory {
> +               device_type = "memory";
> +               reg = <0x0 0x20000000>;
> +       };
> +};
> +
> +&gem0 {
> +       status = "okay";
> +};
> +
> +&uart0 {
> +       status = "okay";
> +};
> +
> +&uart1 {
> +       status = "okay";
> +};
> +
> +&ps_clk {
> +       clock-frequency = <33333330>;
> +};
> +
> +&ttc0_0 {
> +       status = "okay";
> +       compatible = "xlnx,ttc-counter-clockevent";
> +};

Look at my timer patches for it.
I have discussed this with Josh and this is not needed anymore.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
