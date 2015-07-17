From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 17 Jul 2015 14:44:46 +0300
Subject: [PATCH 6/7] Documentation: atmel-quadspi: add binding file for
 Atmel QSPI driver
In-Reply-To: <f4bb1c68fcc19b3642110ab0ef9850d6eeca3112.1437059658.git.cyrille.pitchen@atmel.com>
References: <cover.1437059658.git.cyrille.pitchen@atmel.com>
 <f4bb1c68fcc19b3642110ab0ef9850d6eeca3112.1437059658.git.cyrille.pitchen@atmel.com>
Message-ID: <55A8EAAE.6010506@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 7/16/2015 6:27 PM, Cyrille Pitchen wrote:

> This patch documents the DT bindings for the driver of the Atmel QSPI
> controller embedded inside sama5d2x SoCs.

> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> ---
>   .../devicetree/bindings/mtd/atmel-quadspi.txt      | 29 ++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/mtd/atmel-quadspi.txt

> diff --git a/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt b/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
> new file mode 100644
> index 000000000000..a0d60ac7ae10
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
> @@ -0,0 +1,29 @@
> +* Atmel Quad Serial Peripheral Interface (QSPI)
> +
> +Required properties:
> +  - compatible : Should be "atmel,sama5d2-qspi"
> +  - reg : the first contains the register location and length,
> +          the second contains the memory mapping address and length
> +  - interrupts : Should contain the interrupt for the device
> +  - clocks : The clock needed by the QSPI controller
> +  - #address-cells : should be 1
> +  - #size-cells : should be 0
> +
> +Example:
> +
> +qspi0: qspi at f0020000 {

     Once again, the ePAPR standard tells up to call the node just "spi", not 
"qspi".

> +	compatible = "atmel,sama5d2-qspi";
> +	reg = <0xf0020000 0x100>,
> +	      <0xd0000000 0x08000000>;

    Either you use the leading zeroes or you don't. :-)

[...]

MBR, Sergei
