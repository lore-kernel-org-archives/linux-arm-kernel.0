From: stefan@agner.ch (Stefan Agner)
Date: Thu, 17 Dec 2015 12:45:07 -0800
Subject: [PATCH 1/3] ARM: dts: imx7d: add arch timer
In-Reply-To: <1449789132-18976-1-git-send-email-Frank.Li@freescale.com>
References: <1449789132-18976-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <024b6540b3ebd5f132d171ba40c6e727@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-12-10 15:12, Frank.Li at freescale.com wrote:
> From: Frank Li <Frank.Li@freescale.com>
> 
> add cortex a7 arch timer.
> uboot v2016.01-rc2 supported psci basic support.
> smp can be supported by psci

This sounds a bit overly simplified log message. I am not very into this
PSCI topic, is this a prerequisit for the ARM arch timers? Maybe you
could elaborate that a bit more.

Also, I would prefer full sentences and commonly used spellings such as
Cortex-A7, U-Boot etc...

--
Stefan

> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
> ---
>  arch/arm/boot/dts/imx7d.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
> index 489604a..a621af6 100644
> --- a/arch/arm/boot/dts/imx7d.dtsi
> +++ b/arch/arm/boot/dts/imx7d.dtsi
> @@ -119,6 +119,15 @@
>  		clock-output-names = "osc";
>  	};
>  
> +	timer {
> +		compatible = "arm,armv7-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +		interrupt-parent = <&intc>;
> +	};
> +
>  	etr at 30086000 {
>  		compatible = "arm,coresight-tmc", "arm,primecell";
>  		reg = <0x30086000 0x1000>;
