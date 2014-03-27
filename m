From: b.brezillon.dev@gmail.com (Boris BREZILLON)
Date: Thu, 27 Mar 2014 09:39:04 +0100
Subject: [PATCH] ARM: imx6/dt: add ccm dependency upon ckil, ckih1 and
 osc clocks
In-Reply-To: <1395907913-23808-1-git-send-email-b.brezillon.dev@gmail.com>
References: <5333DA13.2080505@gmail.com>
 <1395907913-23808-1-git-send-email-b.brezillon.dev@gmail.com>
Message-ID: <5333E3A8.3050405@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 27/03/2014 09:11, Boris BREZILLON a ?crit :
> Signed-off-by: Boris BREZILLON <b.brezillon.dev@gmail.com>
> ---
>   arch/arm/boot/dts/imx6qdl.dtsi |    4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index cfc85be..060e94c 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -62,16 +62,19 @@
>   
>   		ckil {
Oops.
You'll have to change this line into the line below in order to be able 
to reference this clk.

                           ckil: ckil {
>   			compatible = "fsl,imx-ckil", "fixed-clock";
> +			#clock-cells = <0>;
>   			clock-frequency = <32768>;
>   		};
>   
>   		ckih1 {
ditto
>   			compatible = "fsl,imx-ckih1", "fixed-clock";
> +			#clock-cells = <0>;
>   			clock-frequency = <0>;
>   		};
>   
>   		osc {
ditto
>   			compatible = "fsl,imx-osc", "fixed-clock";
> +			#clock-cells = <0>;
>   			clock-frequency = <24000000>;
>   		};
>   	};
> @@ -489,6 +492,7 @@
>   				interrupts = <0 87 IRQ_TYPE_LEVEL_HIGH>,
>   					     <0 88 IRQ_TYPE_LEVEL_HIGH>;
>   				#clock-cells = <1>;
> +				clocks = <&ckil &ckih1 &osc>;
>   			};
>   
>   			anatop: anatop at 020c8000 {
