From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 11 Dec 2017 08:18:01 +0100
Subject: [PATCH 3/5] arm: dts: sun8i: a83t: a711: Enable I2C0
In-Reply-To: <20171208215419.30396-4-mylene.josserand@free-electrons.com>
References: <20171208215419.30396-1-mylene.josserand@free-electrons.com>
 <20171208215419.30396-4-mylene.josserand@free-electrons.com>
Message-ID: <20171211071801.ekdzbimk5nvlvekr@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 08, 2017 at 10:54:17PM +0100, Myl?ne Josserand wrote:
> The A711 has a touchscreen connected by I2C0.
> Enable only I2C0 node for the moment.
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> index a021ee6da396..84cca1a48cea 100644
> --- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> +++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> @@ -105,6 +105,13 @@
>  	status = "okay";
>  };
>  
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_pins>;

If there's only one set of pins, maybe we should force that muxing in
the DTSI?

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171211/3d651804/attachment.sig>
