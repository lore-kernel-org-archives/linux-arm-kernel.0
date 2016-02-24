From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 24 Feb 2016 15:21:20 +0100
Subject: [PATCH] ARM: dts: rockchip: add mipi_dsi to VIO power domain on
 rk3288
In-Reply-To: <1456231181-13989-1-git-send-email-john@metanate.com>
References: <1456231181-13989-1-git-send-email-john@metanate.com>
Message-ID: <1682563.dHMl0I8iqX@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 23. Februar 2016, 12:39:41 schrieb John Keeping:
> The MIPI controllers are part of the VIO power domain so add the
> necessary property to indicate this for the controller we support.
> 
> Signed-off-by: John Keeping <john@metanate.com>
> ---
>  arch/arm/boot/dts/rk3288.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index d879a89..a92a3b5 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -890,6 +890,7 @@
>  		clocks = <&cru SCLK_MIPIDSI_24M>, <&cru PCLK_MIPI_DSI0>;
>  		clock-names = "ref", "pclk";
>  		rockchip,grf = <&grf>;
> +		power-domains = <&power RK3288_PD_VIO>;
>  		status = "disabled";

applied to my dts32 branch after moving power-domains above rockchip,grf and 
adapting to the "#address-cells" and "#size-cells" present in the dtsi.


Thanks
Heiko
