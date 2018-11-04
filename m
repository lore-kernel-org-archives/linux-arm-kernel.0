From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 4 Nov 2018 16:34:37 +0800
Subject: [PATCH] arm64: dts: Add flexcan nodes in LX2160A
In-Reply-To: <20181024161509.14200-1-pankaj.bansal@nxp.com>
References: <20181024161509.14200-1-pankaj.bansal@nxp.com>
Message-ID: <20181104083435.GE26016@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2018 at 10:49:20AM +0000, Pankaj Bansal wrote:
> The FlexCAN module in LX2160A is a communication controller implementing
> the CAN protocol according to the ISO 11898-1 standard and CAN 2.0 B
> protocol specifications.
> 
> -Flexible mailboxes configurable to store 0 to 8, 16, 32 or 64 bytes
> data length
> -Each mailbox configurable as receive or transmit, all supporting
> standard and extended messages
> 
> Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> ---
> 
> Notes:
>     This patch depends on below patches:
>     [1] https://lore.kernel.org/patchwork/project/lkml/list/?series=369563
>     [2] https://patchwork.kernel.org/patch/10645287/
>     
>     This patch is used by below patches:
>     [1] https://www.spinics.net/lists/linux-can/msg00348.html
> 
>  .../boot/dts/freescale/fsl-lx2160a-qds.dts   |  8 ++++++++
>  .../boot/dts/freescale/fsl-lx2160a-rdb.dts   |  8 ++++++++
>  .../boot/dts/freescale/fsl-lx2160a.dtsi      | 18 ++++++++++++++++++
>  3 files changed, 34 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> index 99a22abbe725..8a0305a2b778 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> @@ -31,6 +31,14 @@
>  	};
>  };
>  
> +&can0 {
> +	status = "okay";
> +};
> +
> +&can1 {
> +	status = "okay";
> +};
> +
>  &crypto {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> index 6481e5f20e69..f8c95fc6de27 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> @@ -31,6 +31,14 @@
>  	};
>  };
>  
> +&can0 {
> +	status = "okay";
> +};
> +
> +&can1 {
> +	status = "okay";
> +};
> +
>  &crypto {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index 56f846c55812..23ea8776b55a 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -566,6 +566,24 @@
>  			status = "disabled";
>  		};
>  
> +		can0: can at 2180000 {
> +			compatible = "fsl,lx2160ar1-flexcan";

Is the compatible documented somewhere?

Shawn

> +			reg = <0x0 0x2180000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clockgen 4 7>, <&clockgen 4 7>;
> +			clock-names = "ipg", "per";
> +			status = "disabled";
> +		};
> +
> +		can1: can at 2190000 {
> +			compatible = "fsl,lx2160ar1-flexcan";
> +			reg = <0x0 0x2190000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clockgen 4 7>, <&clockgen 4 7>;
> +			clock-names = "ipg", "per";
> +			status = "disabled";
> +		};
> +
>  		uart0: serial at 21c0000 {
>  			compatible = "arm,sbsa-uart","arm,pl011";
>  			reg = <0x0 0x21c0000 0x0 0x1000>;
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
