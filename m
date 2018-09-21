From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Fri, 21 Sep 2018 15:42:09 +0200
Subject: [PATCH] ARM: dts: clearfog: fix sdhci supply property name
In-Reply-To: <606cef37c2776bdc7dfa3ef578a18c40004e17af.1534878753.git.baruch@tkos.co.il>
 (Baruch Siach's message of "Tue, 21 Aug 2018 22:12:33 +0300")
References: <606cef37c2776bdc7dfa3ef578a18c40004e17af.1534878753.git.baruch@tkos.co.il>
Message-ID: <871s9nhsr2.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,
 
 On mar., ao?t 21 2018, Baruch Siach <baruch@tkos.co.il> wrote:

> The vmmc phandle, like all power supply property names, must have the
> '-supply' suffix.
>

I also noticed it a few months ago and then I forgot. However, does it
add any value to have this regulator?

Now that I found my note, I considered to just remove this line as well
as the regulator node.

What do you think ?

Gregory

> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  arch/arm/boot/dts/armada-388-clearfog.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/armada-388-clearfog.dtsi b/arch/arm/boot/dts/armada-388-clearfog.dtsi
> index 7c6ad2afb094..1b0d0680c8b6 100644
> --- a/arch/arm/boot/dts/armada-388-clearfog.dtsi
> +++ b/arch/arm/boot/dts/armada-388-clearfog.dtsi
> @@ -48,7 +48,7 @@
>  					     &clearfog_sdhci_cd_pins>;
>  				pinctrl-names = "default";
>  				status = "okay";
> -				vmmc = <&reg_3p3v>;
> +				vmmc-supply = <&reg_3p3v>;
>  				wp-inverted;
>  			};
>  
> -- 
> 2.18.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
