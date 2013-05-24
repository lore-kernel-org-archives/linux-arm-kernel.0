From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Fri, 24 May 2013 09:53:07 -0300
Subject: [PATCHv3 5/6] ARM: cubieboard: Enable ethernet (EMAC) support
 in dts
In-Reply-To: <1369387394-9453-6-git-send-email-maxime.ripard@free-electrons.com>
References: <1369387394-9453-1-git-send-email-maxime.ripard@free-electrons.com>
 <1369387394-9453-6-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <519F62B3.8090302@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

El 24/05/13 06:23, Maxime Ripard escribi?:
> From: Stefan Roese <sr@denx.de>
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> ---
>  arch/arm/boot/dts/sun4i-a10-cubieboard.dts | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> index b70fe0d..32d9b18 100644
> --- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> @@ -27,6 +27,21 @@
>  	};
>  
>  	soc at 01c20000 {
> +		emac: ethernet at 01c0b000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&emac_pins_a>;
> +			phy = <&phy0>;
> +			status = "okay";
> +		};
> +
> +		mdio at 01c0b080 {
> +			status = "okay";
> +
> +			phy0: ethernet-phy at 0 {
> +				reg = <0>;
> +			};

During my testing I found out that I needed to use 1 as reg for the
driver to work. You can find a fixup patch enclosed that changes this;
it's possible that some extra changes may also be needed (s/phy0/phy1/
on the node?)

Cheers,

Emilio
-------------- next part --------------
A non-text attachment was scrubbed...
Name: fixup-reg.patch
Type: text/x-diff
Size: 711 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130524/8a9338c8/attachment-0001.bin>
