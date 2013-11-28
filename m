From: bcousson@baylibre.com (Benoit Cousson)
Date: Thu, 28 Nov 2013 10:35:08 +0100
Subject: [PATCH] ARM: DTS: omap4-sdp: Add regulator for LCD backlight
 (pwm-backlight)
In-Reply-To: <1385630924-16392-1-git-send-email-peter.ujfalusi@ti.com>
References: <1385630924-16392-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <52970E4C.8070502@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 28/11/2013 10:28, Peter Ujfalusi wrote:
> Since in DT booted kernel dummy regulators are no longer supported we need
> to provide valid phandle for the regulator needed by the backlight.
> On the board VBAT is used to power the LCD backlight(s).
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi,
>
> This patch is needed for 3.13 to get the LCD backlight to work again.

OK, so this is a fix for the next -rc?

Regards,
Benoit

>
> Regards,
> Peter
>
>   arch/arm/boot/dts/omap4-sdp.dts | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
> index 5fc3f43..6f86db2 100644
> --- a/arch/arm/boot/dts/omap4-sdp.dts
> +++ b/arch/arm/boot/dts/omap4-sdp.dts
> @@ -104,6 +104,7 @@
>   				100 110 120 127
>   				>;
>   		default-brightness-level = <13>;
> +		power-supply = <&vbat>;
>   	};
>
>   	sound {
>


-- 
Beno?t Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
