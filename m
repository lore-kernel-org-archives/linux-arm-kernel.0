From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 8 Feb 2017 11:17:06 +0100
Subject: [PATCH 6/8] arm64: dts: allwinner: add device node for R_PWM
In-Reply-To: <20170208100009.29362-6-icenowy@aosc.xyz>
References: <20170208100009.29362-1-icenowy@aosc.xyz>
 <20170208100009.29362-6-icenowy@aosc.xyz>
Message-ID: <20170208101706.332djd3fw6tbenqx@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2017 at 06:00:07PM +0800, Icenowy Zheng wrote:
> Allwinner A64 SoC has two PWM controller, both are similar to the
> controller in H3 SoC.
> 
> Add one of the controllers which lies in the "CPUs" part of the SoC.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 4b0baa79554c..6204aee5c6f4 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -432,5 +432,13 @@
>  			#size-cells = <0>;
>  			#gpio-cells = <3>;
>  		};
> +
> +		r_pwm: pwm at 01f03800 {
> +			compatible = "allwinner,sun8i-h3-pwm";

Please add an a64 compatible there too.

> +			reg = <0x01f03800 0x8>;

The size is 0x400

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170208/581a971c/attachment.sig>
