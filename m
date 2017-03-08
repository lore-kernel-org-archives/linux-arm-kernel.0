From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 08 Mar 2017 10:21:20 +0100
Subject: [PATCH 2/3] ARM64: dts: marvell: armada-3720-db: add gpio expander
In-Reply-To: <20170222173146.30993-3-gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Wed, 22 Feb 2017 18:31:45 +0100")
References: <20170222173146.30993-1-gregory.clement@free-electrons.com>
 <20170222173146.30993-3-gregory.clement@free-electrons.com>
Message-ID: <87pohsm8dr.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On mer., f?vr. 22 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> A gpio expander is present on the i2c bus on the Armada 3720 DB board. This
> patch add it to the device tree.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied on mvebu/dt64

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-3720-db.dts | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> index 86602c907a61..864936acc316 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> @@ -64,6 +64,24 @@
>  
>  &i2c0 {
>  	status = "okay";
> +
> +	gpio_exp: pca9555 at 22 {
> +		compatible = "nxp,pca9555";
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		reg = <0x22>;
> +		/*
> +		 * IO0_0: PWR_EN_USB2	IO1_0: PWR_EN_VTT
> +		 * IO0_1: PWR_EN_USB23	IO1_1: MPCIE_WDISABLE
> +		 * IO0_2: PWR_EN_SATA	IO1_2: RGMII_DEV_RSTN
> +		 * IO0_3: PWR_EN_PCIE	IO1_3: SGMII_DEV_RSTN
> +		 * IO0_4: PWR_EN_SD
> +		 * IO0_5: PWR_EN_EMMC
> +		 * IO0_6: PWR_EN_RGMII	IO1_6: SATA_USB3.0_SEL
> +		 * IO0_7: PWR_EN_SGMII	IO1_7: PWR_MCI_PS
> +		 */
> +	};
>  };
>  
>  /* CON3 */
> -- 
> 2.11.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
