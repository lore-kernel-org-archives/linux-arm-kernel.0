From: robh@kernel.org (Rob Herring)
Date: Tue, 24 Apr 2018 09:39:07 -0500
Subject: [PATCH v1 2/4] dt-bindings: clock: mediatek: add g3dsys bindings
In-Reply-To: <4b5d243d33433f83874359794b796d4228574714.1524044917.git.sean.wang@mediatek.com>
References: <cover.1524044917.git.sean.wang@mediatek.com>
 <4b5d243d33433f83874359794b796d4228574714.1524044917.git.sean.wang@mediatek.com>
Message-ID: <20180424143907.eewrpzdmkhhux3lb@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2018 at 06:24:54PM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add bindings to g3dsys providing necessary clock and reset control to
> Mali-450.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../bindings/arm/mediatek/mediatek,g3dsys.txt      | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,g3dsys.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,g3dsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,g3dsys.txt
> new file mode 100644
> index 0000000..ff2d70c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,g3dsys.txt
> @@ -0,0 +1,30 @@
> +MediaTek g3dsys controller
> +============================
> +
> +The MediaTek g3dsys controller provides various clocks and reset controller to
> +the GPU.
> +
> +Required Properties:
> +
> +- compatible: Should be:
> +	- "mediatek,mt2701-g3dsys", "syscon":
> +		for MT2701 SoC
> +	- "mediatek,mt7623-ethsys", "mediatek,mt2701-g3dsys", "syscon":
> +		for MT7623 SoC

ethsys?

> +- #clock-cells: Must be 1
> +- #reset-cells: Must be 1
> +
> +The ethsys controller uses the common clk binding from
> +Documentation/devicetree/bindings/clock/clock-bindings.txt
> +The available clocks are defined in dt-bindings/clock/mt*-clk.h.
> +
> +Example:
> +
> +g3dsys: clock-controller at 13000000 {
> +	compatible = "mediatek,mt7623-g3dsys",
> +		     "mediatek,mt2701-g3dsys",
> +		     "syscon";
> +	reg = <0 0x13000000 0 0x200>;
> +	#clock-cells = <1>;
> +	#reset-cells = <1>;
> +};
> -- 
> 2.7.4
> 
