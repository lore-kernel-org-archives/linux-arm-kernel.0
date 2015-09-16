From: horia.geanta@freescale.com (=?UTF-8?Q?Horia_Geant=c4=83?=)
Date: Wed, 16 Sep 2015 18:28:41 +0300
Subject: [PATCH] ARM: dts: ls1021a: add crypto node
In-Reply-To: <1439365361-24129-1-git-send-email-horia.geanta@freescale.com>
References: <1439365361-24129-1-git-send-email-horia.geanta@freescale.com>
Message-ID: <55F98AA9.1030607@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ping

On 8/12/2015 10:42 AM, Horia Geant? wrote:
> Signed-off-by: Horia Geant? <horia.geanta@freescale.com>
> ---
>  arch/arm/boot/dts/ls1021a.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index 973a496207fc..5bd64a4df4d3 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -63,6 +63,7 @@
>  		serial4 = &lpuart4;
>  		serial5 = &lpuart5;
>  		sysclk = &sysclk;
> +		crypto = &crypto;
>  	};
>  
>  	cpus {
> @@ -148,6 +149,45 @@
>  			big-endian;
>  		};
>  
> +		crypto: crypto at 1700000 {
> +			compatible = "fsl,sec-v5.0", "fsl,sec-v4.0";
> +			fsl,sec-era = <7>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg		 = <0x0 0x1700000 0x0 0x100000>;
> +			ranges		 = <0x0 0x0 0x1700000 0x100000>;
> +			interrupts	 = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			sec_jr0: jr at 10000 {
> +				compatible = "fsl,sec-v5.0-job-ring",
> +				     "fsl,sec-v4.0-job-ring";
> +				reg = <0x10000 0x10000>;
> +				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
> +			sec_jr1: jr at 20000 {
> +				compatible = "fsl,sec-v5.0-job-ring",
> +				     "fsl,sec-v4.0-job-ring";
> +				reg = <0x20000 0x10000>;
> +				interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
> +			sec_jr2: jr at 30000 {
> +				compatible = "fsl,sec-v5.0-job-ring",
> +				     "fsl,sec-v4.0-job-ring";
> +				reg = <0x30000 0x10000>;
> +				interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
> +			sec_jr3: jr at 40000 {
> +				compatible = "fsl,sec-v5.0-job-ring",
> +				     "fsl,sec-v4.0-job-ring";
> +				reg = <0x40000 0x10000>;
> +				interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
> +		};
> +
>  		clockgen: clocking at 1ee1000 {
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> 
