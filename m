From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 26 Jul 2013 13:34:43 -0600
Subject: [PATCH 3/9] spi: tegra114: move to generic dma DT binding
In-Reply-To: <1374639002-16753-4-git-send-email-rizhao@nvidia.com>
References: <1374639002-16753-1-git-send-email-rizhao@nvidia.com>
 <1374639002-16753-4-git-send-email-rizhao@nvidia.com>
Message-ID: <51F2CF53.30002@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Stripping CC list a bit)

On 07/23/2013 10:09 PM, Richard Zhao wrote:
> - driver: remove use of nvidia,dma-request-selector
> 	  use dma_request_slave_channel to request channel
> - if dmas/dma-names are missing, it still supports cpu based transfer
> - update binding doc and specify dmas/dma-names properties as optional

I'll simply repeat the comments I already made downstream:

Most commit messages aren't written as bullet points. This might be
better written as:

----------
Convert the Tegra114 SPI driver to support the standard DMA device-tree
bindings.

Note that DMA mode is optional; if the DT properties required to support
DMA are missing, then the driver will fall back to pure CPU operation.
----------

> diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt

> +Optional properties:
> +- dmas : The Tegra DMA controller's phandle and request selector for
> +  this SPI controller.
> +- dma-names : Should be "rx-tx".

This should reference dma.txt which defines the DMA DT bindings. How about:

----------
Optional properties:
- dmas, dma-names : The DMA channel to use for DMA-mode operation. See
  dma.txt for the definition of these properties. A single entry named
  "rx-tx" must be specified.
----------
