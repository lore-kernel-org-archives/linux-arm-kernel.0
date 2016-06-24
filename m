From: robh@kernel.org (Rob Herring)
Date: Fri, 24 Jun 2016 10:55:41 -0500
Subject: [PATCH 1/5] dt-bindings: Add binding for brcm,bcm2835-sdhost.
In-Reply-To: <1466595738-2229-2-git-send-email-kraxel@redhat.com>
References: <1466595738-2229-1-git-send-email-kraxel@redhat.com>
 <1466595738-2229-2-git-send-email-kraxel@redhat.com>
Message-ID: <20160624155541.GA12266@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2016 at 01:42:14PM +0200, Gerd Hoffmann wrote:
> From: Eric Anholt <eric@anholt.net>
> 
> This is the other SD controller on the platform, which can be swapped
> to the role of SD card host using pin muxing.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  .../devicetree/bindings/mmc/brcm,bcm2835-sdhci.txt |  3 +++
>  .../bindings/mmc/brcm,bcm2835-sdhost.txt           | 24 ++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhci.txt b/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhci.txt
> index 59476fb..3cc74e2 100644
> --- a/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhci.txt
> @@ -15,4 +15,7 @@ sdhci: sdhci {
>  	interrupts = <2 30>;
>  	clocks = <&clk_mmc>;
>  	bus-width = <4>;
> +	dmas = <&dma 13>,
> +	       <&dma 13>;
> +	dma-names = "tx", "rx";

This looks like it should be separate patch.

>  };
> diff --git a/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt b/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt
> new file mode 100644
> index 0000000..074992c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt
> @@ -0,0 +1,24 @@
> +Broadcom BCM2835 SDHOST controller
> +
> +This file documents differences between the core properties described
> +by mmc.txt and the properties that represent the BCM2835 controller.
> +
> +Required properties:
> +- compatible: Should be "brcm,bcm2835-sdhci".

Doesn't match the example.

> +- clocks: The clock feeding the SDHOST controller.

reg?

interrupts?

> +
> +Optional properties:
> +- dmas: DMA channels for read and write.
> +          See Documentation/devicetree/bindings/dma/dma.txt for details

dma-names?

> +
> +Example:
> +
> +sdhost: sdhost at 7e202000 {
> +	compatible = "brcm,bcm2835-sdhost";
> +	reg = <0x7e202000 0x100>;
> +	interrupts = <2 24>;
> +	clocks = <&clocks BCM2835_CLOCK_VPU>;
> +	dmas = <&dma 13>,
> +	       <&dma 13>;
> +	dma-names = "tx", "rx";
> +};
> -- 
> 1.8.3.1
> 
