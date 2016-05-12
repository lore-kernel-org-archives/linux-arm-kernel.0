From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Thu, 12 May 2016 14:16:46 +0800
Subject: [PATCH 1/2] arm64: dts: NS2: Add all of the UARTs
In-Reply-To: <1463007369-13071-1-git-send-email-jonmason@broadcom.com>
References: <1463007369-13071-1-git-send-email-jonmason@broadcom.com>
Message-ID: <57341FCE.6050403@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/5/12 6:56, Jon Mason wrote:
> Add all of the UARTs present on NS2 and enable them in the SVK device
> tree file.  Also, do some magic to make sure that uart3 is discovered as
> ttyS0 (as that is the console UART).
> 
> Signed-off-by: Jon Mason <jonmason@broadcom.com>
> ---
>  arch/arm64/boot/dts/broadcom/ns2-svk.dts | 16 ++++++++++++++++
>  arch/arm64/boot/dts/broadcom/ns2.dtsi    | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/broadcom/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
> index 7cd3640..b062a44 100644
> --- a/arch/arm64/boot/dts/broadcom/ns2-svk.dts
> +++ b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
> @@ -40,10 +40,14 @@
>  
>  	aliases {
>  		serial0 = &uart3;
> +		serial1 = &uart0;
> +		serial2 = &uart1;
> +		serial3 = &uart2;
>  	};
>  
>  	chosen {
>  		stdout-path = "serial0:115200n8";
> +		bootargs = "earlycon=uart8250,mmio32,0x66130000";

Hi Jon,

I submit a patch[1], with it, we can use earlycon without option to enable early console
for "snps,dw-apb-uart", could you help me to test it, thanks.

BRs,
Kefeng


[1] https://lkml.org/lkml/2016/5/11/34

>  	};
>  
>  	memory {
> @@ -68,6 +72,18 @@
>  	status = "ok";
>  };
>  
> +&uart0 {
> +	status = "ok";
> +};
> +
> +&uart1 {
> +	status = "ok";
> +};
> +
> +&uart2 {
> +	status = "ok";
> +};
> +
>  &uart3 {
>  	status = "ok";
>  };
> diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
> index 788ed8f..c77a9e8 100644
> --- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
> @@ -357,6 +357,36 @@
>  			status = "disabled";
>  		};
>  
> +		uart0: serial at 66100000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x66100000 0x100>;
> +			interrupts = <GIC_SPI 390 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&iprocslow>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		uart1: serial at 66110000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x66110000 0x100>;
> +			interrupts = <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&iprocslow>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		uart2: serial at 66120000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x66120000 0x100>;
> +			interrupts = <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&iprocslow>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
>  		uart3: serial at 66130000 {
>  			compatible = "snps,dw-apb-uart";
>  			reg = <0x66130000 0x100>;
> 
