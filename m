From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 31 May 2016 21:01:13 +0200
Subject: [PATCH resend v2 5/6] ARM: dts: sun9i: a80-optimus: Disable
 dummy regulators vcc3v0, vcc3v3, vcc5v0
In-Reply-To: <1464711804-19256-6-git-send-email-wens@csie.org>
References: <1464711804-19256-1-git-send-email-wens@csie.org>
 <1464711804-19256-6-git-send-email-wens@csie.org>
Message-ID: <20160531190113.GO4908@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 01, 2016 at 12:23:23AM +0800, Chen-Yu Tsai wrote:
> These 3 regulators are provided in sunxi-common-regulators.dtsi.
> 3.0V/3.3V and 5.0V are commonly used voltages in Allwinner devices.
> These dummy regulators provide a stand-in when bindings that require
> one, but the real regulator is not supported yet.
> 
> Since these are no longer needed, we can disable them.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun9i-a80-optimus.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
> index 6cfc02194035..991337d1d6f1 100644
> --- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
> +++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
> @@ -322,6 +322,18 @@
>  
>  #include "axp809.dtsi"
>  
> +&reg_vcc3v0 {
> +	status = "disabled";
> +};
> +
> +&reg_vcc3v3 {
> +	status = "disabled";
> +};
> +
> +&reg_vcc5v0 {
> +	status = "disabled";
> +};
> +

Why not remove the include entirely?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160531/ea5464ad/attachment.sig>
