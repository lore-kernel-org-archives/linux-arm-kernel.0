From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 3 Sep 2018 10:31:22 +0800
Subject: [PATCH] arm64: dts: ls208xa: add second duart
In-Reply-To: <20180830090038.6956-1-kurt@linutronix.de>
References: <20180830090038.6956-1-kurt@linutronix.de>
Message-ID: <20180903023120.GG3850@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It looks good to me.  @Leo, are you okay with it?

Shawn

On Thu, Aug 30, 2018 at 11:00:38AM +0200, Kurt Kanzenbach wrote:
> The NXP LS208xA SoCs have two dual uarts. Thus, add the second one.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> index 8cb78dd99672..547a86ec7cd2 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> @@ -22,6 +22,8 @@
>  		crypto = &crypto;
>  		serial0 = &serial0;
>  		serial1 = &serial1;
> +		serial2 = &serial2;
> +		serial3 = &serial3;
>  	};
>  
>  	cpu: cpus {
> @@ -221,6 +223,20 @@
>  			interrupts = <0 32 0x4>; /* Level high type */
>  		};
>  
> +		serial2: serial at 21d0500 {
> +			compatible = "fsl,ns16550", "ns16550a";
> +			reg = <0x0 0x21d0500 0x0 0x100>;
> +			clocks = <&clockgen 4 3>;
> +			interrupts = <0 33 0x4>; /* Level high type */
> +		};
> +
> +		serial3: serial at 21d0600 {
> +			compatible = "fsl,ns16550", "ns16550a";
> +			reg = <0x0 0x21d0600 0x0 0x100>;
> +			clocks = <&clockgen 4 3>;
> +			interrupts = <0 33 0x4>; /* Level high type */
> +		};
> +
>  		cluster1_core0_watchdog: wdt at c000000 {
>  			compatible = "arm,sp805-wdt", "arm,primecell";
>  			reg = <0x0 0xc000000 0x0 0x1000>;
> -- 
> 2.11.0
> 
