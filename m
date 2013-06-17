From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Jun 2013 13:12:32 +0200
Subject: [PATCH v10 5/8] dmaengine: edma: Add TI EDMA device tree binding
In-Reply-To: <1371263570-9323-5-git-send-email-joelagnel@ti.com>
References: <1371263570-9323-1-git-send-email-joelagnel@ti.com>
 <1371263570-9323-5-git-send-email-joelagnel@ti.com>
Message-ID: <3940138.jZFEtfGGLz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 June 2013 21:32:47 Joel A Fernandes wrote:
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
> new file mode 100644
> index 0000000..ada0018
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
> @@ -0,0 +1,26 @@
> +TI EDMA
> +
> +Required properties:
> +- compatible : "ti,edma3"
> +- ti,hwmods: Name of the hwmods associated to the EDMA
> +- ti,edma-regions: Number of regions
> +- ti,edma-slots: Number of slots
> +
> +Optional properties:
> +- ti,edma-xbar-event-map: Crossbar event to channel map

You need to list #dma-cells as required here, and which values are accepted by
the driver (I suppose only <1>). You should also explain the format of the
dma-specifier for a slave here for each possible value of #dma-cells.

For each of the standard properties (reg, interrupts, dma-channels), list
whether they are optional or required. Since the example has three interrupts,
you should probably list how many interrupts need to be specified (minimum
and maximum if the number is variable) and in what order to expect them.

	Arnd
