From: robh@kernel.org (Rob Herring)
Date: Mon, 21 Sep 2015 08:52:02 -0500
Subject: [PATCH v2 1/3] doc: dt: add documentation for Mediatek spi-nor
 controller
In-Reply-To: <1442559533-17552-2-git-send-email-bayi.cheng@mediatek.com>
References: <1442559533-17552-1-git-send-email-bayi.cheng@mediatek.com>
 <1442559533-17552-2-git-send-email-bayi.cheng@mediatek.com>
Message-ID: <56000B82.9060607@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2015 01:58 AM, Bayi Cheng wrote:
> Add device tree binding documentation for serial flash with
> Mediatek serial flash controller
> 
> Signed-off-by: Bayi Cheng <bayi.cheng@mediatek.com>
> ---
>  .../devicetree/bindings/mtd/mtk_quadspi.txt        | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/mtk_quadspi.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/mtk_quadspi.txt b/Documentation/devicetree/bindings/mtd/mtk_quadspi.txt
> new file mode 100644
> index 0000000..380b907
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/mtk_quadspi.txt
> @@ -0,0 +1,27 @@
> +* MTD SPI nor driver for MTK MT81xx (and similar) serial flash controller
> +
> +Required properties:
> +- compatible: 	  should be "mediatek,mt8173-nor";
> +- reg: 		  physical base address and length of the controller's register
> +- clocks: 	  the phandle of the clock needed by the QuadSPI controller

QuadSPI?

Please document number of clocks and their use/function.

> +- clock-names: 	  the name of the clocks
> +		  See Documentation/devicetree/bindings/clock/clock-bindings.txt for details.
> +- #address-cells: should be <1>
> +- #size-cells:	  should be <0>
> +
> +Example:
> +
> +nor_flash: spi at 1100d000 {
> +	compatible = "mediatek,mt8173-nor";
> +	reg = <0 0x1100d000 0 0xe0>;
> +	clocks = <&pericfg CLK_PERI_SPI>,
> +		 <&topckgen CLK_TOP_SPINFI_IFR_SEL>;
> +	clock-names = "spi", "sf";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	flash at 0 {
> +		....
> +	};
> +};
> +
> 
