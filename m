From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 08 Oct 2016 11:23:52 +0200
Subject: [PATCH] Specify all interrupts for the GPIO controller.
In-Reply-To: <1475489412-9758-1-git-send-email-vijaykumar@zilogic.com> (Vijay
 Kumar B.'s message of "Mon, 3 Oct 2016 15:40:12 +0530")
References: <1475489412-9758-1-git-send-email-vijaykumar@zilogic.com>
Message-ID: <87h98n8a8n.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vijay Kumar B <vijaykumar@zilogic.com> writes:

> The PXA GPIO controller has 3 interrupt outputs, this needs to be
> indicated in the DTS file. Without this mainstone's CPLD interrupt 0
> will not be raised to the processor.
>
> Signed-off-by: Vijay Kumar B. <vijaykumar@zilogic.com>
> Reviewed-by: Deepak S. <deepak@zilogic.com>
> ---
>  arch/arm/boot/dts/pxa2xx.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/pxa2xx.dtsi b/arch/arm/boot/dts/pxa2xx.dtsi
> index 5e5af07..9ca2e5b 100644
> --- a/arch/arm/boot/dts/pxa2xx.dtsi
> +++ b/arch/arm/boot/dts/pxa2xx.dtsi
> @@ -54,8 +54,8 @@
>  			reg = <0x40e00000 0x10000>;
>  			gpio-controller;
>  			#gpio-cells = <0x2>;
> -			interrupts = <10>;
> -			interrupt-names = "gpio_mux";
> +			interrupts = <8 9 10>;
> +			interrupt-names = "gpio0", "gpio1", "gpio_mux";
>  			interrupt-controller;
>  			#interrupt-cells = <0x2>;
>  			ranges;

Hi Vijay,

A patch was already submitted in september for this in there :
https://mail-archive.com/linux-kernel at vger.kernel.org/msg1239445.html

Cheers.

-- 
Robert
