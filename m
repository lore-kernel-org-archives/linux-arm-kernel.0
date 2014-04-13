From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 13 Apr 2014 16:22:38 +0800
Subject: [PATCH 09/10] ARM: dts: imx51-babbage: Add "clock-frequency"
 property for I2C2
In-Reply-To: <1397366353-29395-9-git-send-email-shc_work@mail.ru>
References: <1397366353-29395-1-git-send-email-shc_work@mail.ru>
 <1397366353-29395-9-git-send-email-shc_work@mail.ru>
Message-ID: <20140413082237.GI24180@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 13, 2014 at 09:19:12AM +0400, Alexander Shiyan wrote:
> This patch adds missing "clock-frequency" property for I2C2.
> Value was be taken from old non-DT board file.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/boot/dts/imx51-babbage.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
> index ff7d2fa..cdcdd87 100644
> --- a/arch/arm/boot/dts/imx51-babbage.dts
> +++ b/arch/arm/boot/dts/imx51-babbage.dts
> @@ -340,6 +340,7 @@
>  &i2c2 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_i2c2>;
> +	clock-frequency = <100000>;

This is unnecessary.  Documentation/devicetree/bindings/i2c/i2c-imx.txt:

Optional properties:
- clock-frequency : Constains desired I2C/HS-I2C bus clock frequency in Hz.
  The absence of the propoerty indicates the default frequency 100 kHz.

Shawn

>  	status = "okay";
>  
>  	sgtl5000: codec at 0a {
> -- 
> 1.8.3.2
> 
> 
> 
