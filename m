From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 26 Sep 2018 14:18:20 +0200
Subject: [PATCH 1/3] arm64: dts: rockchip: add missing address and size
 cells for rk3399 mipi dsi
In-Reply-To: <20180822120214.11848-1-heiko@sntech.de>
References: <20180822120214.11848-1-heiko@sntech.de>
Message-ID: <5343343.YmWWhNScNg@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 22. August 2018, 14:02:12 CEST schrieb Heiko Stuebner:
> DSI controllers are also the hosts of their dsi bus and therefore contain
> nodes describing the attached panels with their reg properties containing
> the virtual ids.
> 
> The dsi controller nodes on rk3399 lacked the #address-cells and #size-cells
> for these subnodes, so add them.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

applied the easy one for 4.20

> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index c88e603396f6..4ac7bf547916 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -1720,6 +1720,8 @@
>  		resets = <&cru SRST_P_MIPI_DSI0>;
>  		reset-names = "apb";
>  		rockchip,grf = <&grf>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
>  		status = "disabled";
>  
>  		ports {
> @@ -1754,6 +1756,8 @@
>  		resets = <&cru SRST_P_MIPI_DSI1>;
>  		reset-names = "apb";
>  		rockchip,grf = <&grf>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
>  		status = "disabled";
>  
>  		ports {
> 
