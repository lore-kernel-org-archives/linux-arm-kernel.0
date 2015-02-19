From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Thu, 19 Feb 2015 15:05:14 +0100
Subject: [PATCH 6/6] ARM: dts: Add sound support to exynos5250-spring
In-Reply-To: <1424283959-16289-7-git-send-email-afaerber@suse.de>
References: <1424283959-16289-1-git-send-email-afaerber@suse.de>
 <1424283959-16289-7-git-send-email-afaerber@suse.de>
Message-ID: <54E5ED9A.90802@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andreas,

On 02/18/2015 07:25 PM, Andreas F?rber wrote:
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  arch/arm/boot/dts/exynos5250-spring.dts | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
> index 866beb4e0597..142e0550e223 100644
> --- a/arch/arm/boot/dts/exynos5250-spring.dts
> +++ b/arch/arm/boot/dts/exynos5250-spring.dts
> @@ -49,6 +49,17 @@
>  		};
>  	};
>  
> +	sound {
> +		compatible = "google,snow-audio-max98089";
> +		samsung,model = "Spring-I2S-MAX98089";
> +		samsung,i2s-controller = <&i2s0>;
> +		samsung,audio-codec = <&max98089>;
> +		clocks = <&pmu_system_controller 0>;
> +		clock-names = "mclk";

Related to my comment in patch 1/6, "mclk" should be defined in the codec
device node. I know that you probably used as a reference Tushar's patch
[0] I posted recently but I just figured out that his dependency patch [1]
mentioned in [2] handled the master clock in the ASoC machine driver but
the final version merged handled it in the codec drivers.

I asked Kukjin to drop the patch to Snow and Peach Pit/Pi and will post
a correct version as a part of a series once I've sound working.

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&mic_det_gpio>, <&hp_det_gpio>;
> +	};
> +

The mic and headphone jack detection are still not supported in the Snow
ASoC machine driver so this pinctrl are not needed but I guess it doesn't
hurt to have them mux'ed too.

Best regards,
Javier

[0]: https://lkml.org/lkml/2015/2/6/495
[1]: https://lkml.org/lkml/2014/5/20/4
[2]: https://patches.linaro.org/30406/
