From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 13 Dec 2016 20:14:59 +0100
Subject: [PATCH 6/6] ARM: dts: sun8i: raise the max voltage of DCDC2 in
 sun8i reference tablets
In-Reply-To: <20161213152252.53749-7-icenowy@aosc.xyz>
References: <20161213152252.53749-1-icenowy@aosc.xyz>
 <20161213152252.53749-7-icenowy@aosc.xyz>
Message-ID: <20161213191459.mmoejcmf26qqtyze@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2016 at 11:22:52PM +0800, Icenowy Zheng wrote:
> The "extremity_freq" frequency described in the original FEX files uses
> a voltage of 1.46v, which is beyond the current maximum voltage value of
> DCDC2 (Cortex-A7 supply) in the sun8i reference tablet DTSI file.
> 
> Raise the maximum value to 1.46v.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
>  arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
> index 7ac8bb4bc95a..325ca5bd67a5 100644
> --- a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
> +++ b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
> @@ -180,7 +180,7 @@
>  &reg_dcdc2 {
>  	regulator-always-on;
>  	regulator-min-microvolt = <900000>;
> -	regulator-max-microvolt = <1400000>;
> +	regulator-max-microvolt = <1460000>;

This is outside of the voltage range tolerated by the CPU. NAK.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161213/b9ea0961/attachment.sig>
