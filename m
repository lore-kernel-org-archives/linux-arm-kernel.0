From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 30 Jul 2013 09:59:02 +0100
Subject: [PATCH 05/10] ARM: sunxi: Add Allwinner A31 DTSI
In-Reply-To: <1374618312-19001-6-git-send-email-maxime.ripard@free-electrons.com>
References: <1374618312-19001-1-git-send-email-maxime.ripard@free-electrons.com>
 <1374618312-19001-6-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <51F78056.6000104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 23/07/13 23:25, Maxime Ripard wrote:
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/Makefile       |   3 +-
>  arch/arm/boot/dts/sun6i-a31.dtsi | 155 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 157 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/sun6i-a31.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 641b3c9..1482533 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -210,7 +210,8 @@ dtb-$(CONFIG_ARCH_SUNXI) += \
>  	sun4i-a10-mini-xplus.dtb \
>  	sun4i-a10-hackberry.dtb \
>  	sun5i-a10s-olinuxino-micro.dtb \
> -	sun5i-a13-olinuxino.dtb
> +	sun5i-a13-olinuxino.dtb \
> +	sun6i-a31-colombus.dtb
>  dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb \
>  	tegra20-iris-512.dtb \
>  	tegra20-medcom-wide.dtb \
> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> new file mode 100644
> index 0000000..c6c19a9
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> @@ -0,0 +1,155 @@
> +/*
> + * Copyright 2013 Maxime Ripard
> + *
> + * Maxime Ripard <maxime.ripard@free-electrons.com>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/include/ "skeleton.dtsi"
> +

[...]

> +		gic: interrupt-controller at 01c81000 {
> +			compatible = "arm,cortex-a7-gic";
> +			reg = <0x01c81000 0x1000>, <0x01c82000 0x100>;

Th Cortex A7 TRM indicates that its GIC has the virtualization
extensions. You should reflect this in the binding (wider GICC range,
GICH and GICV ranges, maintenance interrupt).

See
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0464d/BGBJFJJA.html
for details.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
