From: robh@kernel.org (Rob Herring)
Date: Tue, 8 Dec 2015 09:06:32 -0600
Subject: [PATCH v10 10/17] dt-bindings: add document for rockchip dp phy
In-Reply-To: <1449470390-31285-1-git-send-email-ykk@rock-chips.com>
References: <1449470239-30667-1-git-send-email-ykk@rock-chips.com>
 <1449470390-31285-1-git-send-email-ykk@rock-chips.com>
Message-ID: <20151208150632.GA16308@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2015 at 02:39:50PM +0800, Yakir Yang wrote:
> Add dt binding documentation for rockchip display port PHY.
> 
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

One possible typo below, otherwise:

Acked-by: Rob Herring <robh@kernel.org>

> ---
> Changes in v10: None
> Changes in v9: None
> Changes in v8:
> - Remove the specific address in the example node name. (Heiko)
> 
> Changes in v7:
> - Simplify the commit message. (Kishon)
> 
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
> index 0000000..00902cb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt
> @@ -0,0 +1,22 @@
> +Rockchip Soc Seroes Display Port PHY
                   ^
Is this supposed to be SerDes?

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
> +edp_phy: edp-phy {
> +	compatible = "rockchip,rk3288-dp-phy";
> +	rockchip,grf = <&grf>;
> +	clocks = <&cru SCLK_EDP_24M>;
> +	clock-names = "24m";
> +	#phy-cells = <0>;
> +};
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
