From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 09 Apr 2015 17:01:24 +0200
Subject: [PATCH 2/2] arm/dts: Add nodes for flexcan devices
 present on LS1021A SoC
In-Reply-To: <1428591087-12831-2-git-send-email-bhupesh.sharma@freescale.com>
References: <1428591087-12831-1-git-send-email-bhupesh.sharma@freescale.com>
 <1428591087-12831-2-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <55269444.7050707@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/2015 04:51 PM, Bhupesh Sharma wrote:
> From: Sakar Arora <Sakar.Arora@freescale.com>
> 
> This patch adds the device nodes for flexcan controller(s) present
> on LS1021A SoC.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> Signed-off-by: Sakar Arora <Sakar.Arora@freescale.com>
> ---
>  arch/arm/boot/dts/ls1021a-qds.dts |    8 ++++++++
>  arch/arm/boot/dts/ls1021a.dtsi    |   20 ++++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
> index 9c5e16b..1641a04 100644
> --- a/arch/arm/boot/dts/ls1021a-qds.dts
> +++ b/arch/arm/boot/dts/ls1021a-qds.dts
> @@ -238,3 +238,11 @@
>  &uart1 {
>  	status = "okay";
>  };
> +
> +&can0 {
> +	status = "okay";
> +};
> +
> +&can1 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index c70bb27..c44661b 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -332,6 +332,26 @@
>  			status = "disabled";
>  		};
>  
> +		can0: can at 2a70000 {
> +			compatible = "fsl,ls1021a-flexcan";
> +			reg = <0x0 0x2a70000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&platform_clk 1>;
> +			clock-frequency = <150000000>;

Please don't use clock-frequency, it's only needed for powerpcs without
proper clock support.

> +			clock-names = "per";

Please provide a per and ipg clock, otherwise the driver will not work
properly.

> +			little-endian;
> +		};

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150409/ad99c47c/attachment.sig>
