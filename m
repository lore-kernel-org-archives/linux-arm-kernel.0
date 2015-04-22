From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 22 Apr 2015 16:14:49 +0200
Subject: [PATCH] ARM: dts: imx25: Add missing '#pwm-cells' property for
 pwm4
In-Reply-To: <1429706430-9495-1-git-send-email-fabio.estevam@freescale.com>
References: <1429706430-9495-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20150422141449.GI21413@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Wed, Apr 22, 2015 at 09:40:30AM -0300, Fabio Estevam wrote:
> All pwm ports pass the '#pwm-cells' property, except pw4.
> 
> Fix it by passing '#pwm-cells' property for pwm4.

I already sent the same patch a month ago [1]. Forgot to resend it.

Thanks,

Markus

[1] http://www.spinics.net/lists/arm-kernel/msg408159.html

> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx25.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
> index e4d3aec..677f81d 100644
> --- a/arch/arm/boot/dts/imx25.dtsi
> +++ b/arch/arm/boot/dts/imx25.dtsi
> @@ -428,6 +428,7 @@
>  
>  			pwm4: pwm at 53fc8000 {
>  				compatible = "fsl,imx25-pwm", "fsl,imx27-pwm";
> +				#pwm-cells = <2>;
>  				reg = <0x53fc8000 0x4000>;
>  				clocks = <&clks 108>, <&clks 52>;
>  				clock-names = "ipg", "per";
> -- 
> 1.9.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150422/0fe5336e/attachment.sig>
