From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Thu, 17 Jul 2014 13:19:34 -0300
Subject: [PATCH 03/14] ARM: sunxi: sun5i: Enforce max frequency on PLL6
In-Reply-To: <1405588134-2396-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com>
 <1405588134-2396-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <53C7F796.2050303@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

El 17/07/14 06:08, Maxime Ripard escribi?:
> PLL6 out of reset is running at 2.4GHz, which is outside of its operating
> boundaries.
>
> Enforce its maximum frequency as set in the datasheet to make sure we stays
> within these bounds.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>   arch/arm/boot/dts/sun5i-a13.dtsi | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
> index bf86e65dd167..de89edc5e5b3 100644
> --- a/arch/arm/boot/dts/sun5i-a13.dtsi
> +++ b/arch/arm/boot/dts/sun5i-a13.dtsi
> @@ -97,6 +97,7 @@
>   			reg = <0x01c20028 0x4>;
>   			clocks = <&osc24M>;
>   			clock-output-names = "pll6_sata", "pll6_other", "pll6";
> +			clock-max-frequency = <1200000000>;
>   		};
>
>   		/* dummy is 200M */
>

This patch itself is ok, but I'm not seeing so far where is 
"clock-max-frequency" read from the DT and passed to the clock for later 
verification. Did you leave that out by mistake when shuffling patches?

Cheers!

Emilio
