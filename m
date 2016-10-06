From: l.majewski@majess.pl (Lukasz Majewski)
Date: Thu, 6 Oct 2016 08:40:07 +0200
Subject: [PATCH v2 5/6] arm: dts: imx7-colibri: Use pwm polarity control
In-Reply-To: <20161001101235.24598-6-bhuvanchandra.dv@toradex.com>
References: <20161001101235.24598-1-bhuvanchandra.dv@toradex.com>
 <20161001101235.24598-6-bhuvanchandra.dv@toradex.com>
Message-ID: <20161006084007.44c5cbae@jawa>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 1 Oct 2016 15:42:34 +0530
Bhuvanchandra DV <bhuvanchandra.dv@toradex.com> wrote:

> Configure PWM polarity control.
> 
> Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
> ---
>  arch/arm/boot/dts/imx7-colibri.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi
> b/arch/arm/boot/dts/imx7-colibri.dtsi index a9cc657..2af5e3e 100644
> --- a/arch/arm/boot/dts/imx7-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx7-colibri.dtsi
> @@ -43,7 +43,7 @@
>  / {
>  	bl: backlight {
>  		compatible = "pwm-backlight";
> -		pwms = <&pwm1 0 5000000>;
> +		pwms = <&pwm1 0 5000000 0>;

My recommendation would be to add:
#include <dt-bindings/pwm/pwm.h>

and then define pwms as:

pwms = <&pwm1 0 5000000 PWM_POLARITY_NORMAL>;

It would be more readable

Best regards,
?ukasz Majewski

>  	};
>  
>  	reg_module_3v3: regulator-module-3v3 {

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161006/124c447f/attachment.sig>
