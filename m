From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 8 Sep 2017 09:19:54 +0200
Subject: [PATCH v5 01/10] arm64: dts: allwinner: Restore EMAC changes
In-Reply-To: <20170908071156.5115-2-clabbe.montjoie@gmail.com>
References: <20170908071156.5115-1-clabbe.montjoie@gmail.com>
 <20170908071156.5115-2-clabbe.montjoie@gmail.com>
Message-ID: <20170908071954.j2bhtw4wqa27fald@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 08, 2017 at 09:11:47AM +0200, Corentin Labbe wrote:
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
> index 1c2387bd5df6..968908761194 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
> @@ -50,6 +50,7 @@
>  	compatible = "friendlyarm,nanopi-neo2", "allwinner,sun50i-h5";
>  
>  	aliases {
> +		ethernet0 = &emac;
>  		serial0 = &uart0;
>  	};
>  
> @@ -108,6 +109,22 @@
>  	status = "okay";
>  };
>  
> +&emac {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&emac_rgmii_pins>;
> +	phy-supply = <&reg_gmac_3v3>;
> +	phy-handle = <&ext_rgmii_phy>;
> +	phy-mode = "rgmii";
> +	status = "okay";
> +};
> +
> +&mdio {
> +	ext_rgmii_phy: ethernet-phy at 7 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <7>;
> +	};
> +};
> +

This won't compile, you don't have that node in the H5 DTSI.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170908/d7832ef0/attachment.sig>
