From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 09 Sep 2016 15:35:53 +0200
Subject: [PATCH 3/3] dt-bindings: reset: oxnas: Update for OX820
In-Reply-To: <20160909131955.27334-4-narmstrong@baylibre.com>
References: <20160909131955.27334-1-narmstrong@baylibre.com>
 <20160909131955.27334-4-narmstrong@baylibre.com>
Message-ID: <1473428153.3023.34.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

Am Freitag, den 09.09.2016, 15:19 +0200 schrieb Neil Armstrong:
> Add new compatible string for reset and sys-ctrl for the Oxford
> Semiconductor OX820 Support.
> Drop the OX810SE indices since they moved in a dedicated include file.

Not sure if the OX820 reset controller should be considered "compatible"
to OX810SE. The register layout and usage is the same, but the reset
indices are different. Does this warrant a new compatible string, or
should this be
	compatible = "oxsemi,ox820-reset", "oxsemi,ox810se-reset"?

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/reset/oxnas,reset.txt      | 39 ++--------------------
>  1 file changed, 3 insertions(+), 36 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/reset/oxnas,reset.txt b/Documentation/devicetree/bindings/reset/oxnas,reset.txt
> index 6f06db9..df0488e 100644
> --- a/Documentation/devicetree/bindings/reset/oxnas,reset.txt
> +++ b/Documentation/devicetree/bindings/reset/oxnas,reset.txt
> @@ -5,45 +5,12 @@ Please also refer to reset.txt in this directory for common reset
>  controller binding usage.
>  
>  Required properties:
> -- compatible: Should be "oxsemi,ox810se-reset"
> +- compatible: Should be "oxsemi,ox810se-reset" or "oxsemi,ox820-reset"
>  - #reset-cells: 1, see below
>  
>  Parent node should have the following properties :
> -- compatible: Should be "oxsemi,ox810se-sys-ctrl", "syscon", "simple-mfd"
> -
> -For OX810SE, the indices are :
> - - 0 : ARM
> - - 1 : COPRO
> - - 2 : Reserved
> - - 3 : Reserved
> - - 4 : USBHS
> - - 5 : USBHSPHY
> - - 6 : MAC
> - - 7 : PCI
> - - 8 : DMA
> - - 9 : DPE
> - - 10 : DDR
> - - 11 : SATA
> - - 12 : SATA_LINK
> - - 13 : SATA_PHY
> - - 14 : Reserved
> - - 15 : NAND
> - - 16 : GPIO
> - - 17 : UART1
> - - 18 : UART2
> - - 19 : MISC
> - - 20 : I2S
> - - 21 : AHB_MON
> - - 22 : UART3
> - - 23 : UART4
> - - 24 : SGDMA
> - - 25 : Reserved
> - - 26 : Reserved
> - - 27 : Reserved
> - - 28 : Reserved
> - - 29 : Reserved
> - - 30 : Reserved
> - - 31 : BUS
> +- compatible: Should be "oxsemi,ox810se-sys-ctrl", "syscon", "simple-mfd" or
> +	"oxsemi,ox820-sys-ctrl", "syscon", "simple-mfd"

Please add a pointer to include/dt-bindings/reset/oxsemi,ox8{10se,20}.h

Otherwise I'm fine with the series, pending DT maintainer approval.

regards
Philipp
