From: robh@kernel.org (Rob Herring)
Date: Sun, 21 Feb 2016 20:53:49 -0600
Subject: [PATCH] dma: mv_xor_v2: new driver
In-Reply-To: <1455523083-25506-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1455523083-25506-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160222025349.GC15973@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 08:58:03AM +0100, Thomas Petazzoni wrote:
> The new mv_xor_v2 driver supports the XOR engines found in the 64-bits
> ARM from Marvell of the Armada 7K and Armada 8K family. This XOR
> engine is a completely new hardware block, entirely different from the
> one used on previous Marvell Armada platforms, which use the existing
> mv_xor driver.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  .../devicetree/bindings/dma/mv-xor-v2.txt          |  19 +
>  drivers/dma/Kconfig                                |  13 +
>  drivers/dma/Makefile                               |   1 +
>  drivers/dma/mv_xor_v2.c                            | 880 +++++++++++++++++++++
>  4 files changed, 913 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/mv-xor-v2.txt
>  create mode 100644 drivers/dma/mv_xor_v2.c
> 
> diff --git a/Documentation/devicetree/bindings/dma/mv-xor-v2.txt b/Documentation/devicetree/bindings/dma/mv-xor-v2.txt
> new file mode 100644
> index 0000000..0a03dcf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/mv-xor-v2.txt
> @@ -0,0 +1,19 @@
> +* Marvell XOR v2 engines
> +
> +Required properties:
> +- compatible: Should be "marvell,mv-xor-v2"

and an SoC specific compatible please.

"marvell,mv" is a bit redundant.

> +- reg: Should contain registers location and length (two sets)
> +    the first set is the DMA registers
> +    the second set is the global registers
> +- msi-parent: Phandle to the MSI-capable interrupt controller used for
> +  interrupts.
> +
> +Example:
> +
> +	xor0 at 400000 {
> +		compatible = "marvell,mv-xor-v2";
> +		reg = <0x400000 0x1000>,
> +		      <0x410000 0x1000>;
> +		msi-parent = <&gic_v2m0>;
> +		dma-coherent;
> +	};
