From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 31 Aug 2016 18:20:02 +0200
Subject: [PATCH v2 1/4] ARM: dts: sun8i: Add PWM pin in H3
In-Reply-To: <20160831082520.25962-2-woogyom.kim@gmail.com>
References: <20160831082520.25962-1-woogyom.kim@gmail.com>
 <20160831082520.25962-2-woogyom.kim@gmail.com>
Message-ID: <20160831162002.GI14379@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Milo,

On Wed, Aug 31, 2016 at 05:25:17PM +0900, Milo Kim wrote:
> H3 PA5 pin is assigned for single PWM channel.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> index fdf9fdb..05d0c4b 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -360,6 +360,13 @@
>  				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>  			};
>  
> +			pwm0_pin_a: pwm0 at 0 {
> +				allwinner,pins = "PA5";
> +				allwinner,function = "pwm0";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +

Is it used on any boards?

If not, we have the policy of not merging the pinctrl nodes that are
not used by anyone to avoid bloating the DT for no particular reason.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160831/41aaa03c/attachment.sig>
