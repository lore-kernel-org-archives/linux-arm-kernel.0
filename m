From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 27 Oct 2017 17:12:20 +0200
Subject: [PATCH v9 04/10] arm: dts: sunxi: h3/h5: represent the mdio
 switch used by sun8i-h3-emac
In-Reply-To: <20171024175714.15840-5-clabbe.montjoie@gmail.com>
References: <20171024175714.15840-1-clabbe.montjoie@gmail.com>
 <20171024175714.15840-5-clabbe.montjoie@gmail.com>
Message-ID: <20171027151220.m3vbtqd22bbupvpe@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The prefix should be ARM, uppercase.

On Tue, Oct 24, 2017 at 07:57:08PM +0200, Corentin Labbe wrote:
> Since dwmac-sun8i could use either an integrated PHY or an external PHY
> (which could be at same MDIO address), we need to represent this selection
> by a MDIO switch.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> index d762098fc589..0e97df490aba 100644
> --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> @@ -422,14 +422,36 @@
>  			#size-cells = <0>;
>  			status = "disabled";
>  
> -			mdio: mdio {
> +			mdio0: mdio {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> -				int_mii_phy: ethernet-phy at 1 {
> -					compatible = "ethernet-phy-ieee802.3-c22";
> +				compatible = "snps,dwmac-mdio";
> +			};
> +
> +			mdio-mux {
> +				compatible = "allwinner,sun8i-h3-mdio-mux";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				mdio-parent-bus = <&mdio0>;

And you should have a line here.

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
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171027/94855150/attachment.sig>
