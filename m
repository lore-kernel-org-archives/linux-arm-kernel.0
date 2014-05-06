From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 6 May 2014 20:58:04 +0800
Subject: [PATCH] ARM: dts: i.MX53: Fix ipu register space size
In-Reply-To: <1399374094-32451-1-git-send-email-s.hauer@pengutronix.de>
References: <1399374094-32451-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20140506125802.GB2870@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 06, 2014 at 01:01:34PM +0200, Sascha Hauer wrote:
> The IPU register space is 128MB, not 2GB.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Shawn Guo <shawn.guo@freescale.com>

Arnd, Olof,

Please apply this fix for 3.15, and copy stable.  Thanks.

Cc: <stable@vger.kernel.org>

Shawn

> ---
>  arch/arm/boot/dts/imx53.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index 9c2bff2..6a1bf4f 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -115,7 +115,7 @@
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			compatible = "fsl,imx53-ipu";
> -			reg = <0x18000000 0x080000000>;
> +			reg = <0x18000000 0x08000000>;
>  			interrupts = <11 10>;
>  			clocks = <&clks IMX5_CLK_IPU_GATE>,
>  			         <&clks IMX5_CLK_IPU_DI0_GATE>,
> -- 
> 2.0.0.rc0
> 
