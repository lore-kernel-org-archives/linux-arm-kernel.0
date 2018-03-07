From: robh@kernel.org (Rob Herring)
Date: Wed, 7 Mar 2018 13:28:49 -0600
Subject: [PATCH v6 1/3] dt-bindings: dmaengine: Add MediaTek High-Speed
 DMA controller bindings
In-Reply-To: <1ae80ef14cac41dea35dca49e8071d67c955f5e7.1520407882.git.sean.wang@mediatek.com>
References: <cover.1520407882.git.sean.wang@mediatek.com>
 <1ae80ef14cac41dea35dca49e8071d67c955f5e7.1520407882.git.sean.wang@mediatek.com>
Message-ID: <20180307192849.bdedrzqmpmwprpc2@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2018 at 04:16:26PM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Document the devicetree bindings for MediaTek High-Speed DMA controller
> which could be found on MT7623 SoC or other similar Mediatek SoCs.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../devicetree/bindings/dma/mtk-hsdma.txt          | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/mtk-hsdma.txt

Please add reviewed-by's when posting new versions.

> 
> diff --git a/Documentation/devicetree/bindings/dma/mtk-hsdma.txt b/Documentation/devicetree/bindings/dma/mtk-hsdma.txt
> new file mode 100644
> index 0000000..4bb31735
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/mtk-hsdma.txt
> @@ -0,0 +1,33 @@
> +MediaTek High-Speed DMA Controller
> +==================================
> +
> +This device follows the generic DMA bindings defined in dma/dma.txt.
> +
> +Required properties:
> +
> +- compatible:	Must be one of
> +		  "mediatek,mt7622-hsdma": for MT7622 SoC
> +		  "mediatek,mt7623-hsdma": for MT7623 SoC
> +- reg:		Should contain the register's base address and length.
> +- interrupts:	Should contain a reference to the interrupt used by this
> +		device.
> +- clocks:	Should be the clock specifiers corresponding to the entry in
> +		clock-names property.
> +- clock-names:	Should contain "hsdma" entries.
> +- power-domains: Phandle to the power domain that the device is part of
> +- #dma-cells: 	The length of the DMA specifier, must be <1>. This one cell
> +		in dmas property of a client device represents the channel
> +		number.
> +Example:
> +
> +        hsdma: dma-controller at 1b007000 {
> +		compatible = "mediatek,mt7623-hsdma";
> +		reg = <0 0x1b007000 0 0x1000>;
> +		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&ethsys CLK_ETHSYS_HSDMA>;
> +		clock-names = "hsdma";
> +		power-domains = <&scpsys MT2701_POWER_DOMAIN_ETH>;
> +		#dma-cells = <1>;
> +	};
> +
> +DMA clients must use the format described in dma/dma.txt file.
> -- 
> 2.7.4
> 
