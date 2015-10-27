From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 28 Oct 2015 00:08:44 +0100
Subject: [PATCH v7 11/17] Documentation: phy: add document for rockchip dp
 phy
In-Reply-To: <1445656003-15300-1-git-send-email-ykk@rock-chips.com>
References: <1445599415-30856-1-git-send-email-ykk@rock-chips.com>
 <1445656003-15300-1-git-send-email-ykk@rock-chips.com>
Message-ID: <5298205.Ylro4gBPnU@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, 24. Oktober 2015, 11:06:37 schrieb Yakir Yang:
> Add dt binding documentation for rockchip display port PHY.
> 
> Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> ---
> Changes in v7: None
> Changes in v6: None
> Changes in v5:
> - Split binding doc's from driver changes. (Rob)
> - Update the rockchip,grf explain in document, and correct the clock required
>   elemets in document. (Rob & Heiko)
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  .../devicetree/bindings/phy/rockchip-dp-phy.txt    | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt b/Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt
> new file mode 100644
> index 0000000..505194e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt
> @@ -0,0 +1,22 @@
> +Rockchip Soc Seroes Display Port PHY
> +------------------------------------
> +
> +Required properties:
> +- compatible : should be one of the following supported values:
> +	 - "rockchip.rk3288-dp-phy"
> +- clocks: from common clock binding: handle to dp clock.
> +	of memory mapped region.
> +- clock-names: from common clock binding:
> +	Required elements: "24m"
> +- rockchip,grf: phandle to the syscon managing the "general register files"
> +- #phy-cells : from the generic PHY bindings, must be 0;
> +
> +Example:
> +
> +edp_phy: edp-phy at ff770274 {

one small thing, I found while playing more ... the node should not have
an address, as it also does not have register property. So just name it
	edp_phy: edp-phy {
		...
	};

There is only one anyway on the rk3288.

With that change the Reviewed-by still applies :-)

> +	compatible = "rockchip,rk3288-dp-phy";
> +	rockchip,grf = <&grf>;
> +	clocks = <&cru SCLK_EDP_24M>;
> +	clock-names = "24m";
> +	#phy-cells = <0>;
> +};
> 
