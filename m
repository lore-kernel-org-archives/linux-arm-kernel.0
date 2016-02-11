From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 11 Feb 2016 13:32:08 +0000
Subject: [PATCH v2 3/7] Documentation: bindings: document the Alpine MSIX
 driver
In-Reply-To: <1455110583-19515-4-git-send-email-antoine.tenart@free-electrons.com>
References: <1455110583-19515-1-git-send-email-antoine.tenart@free-electrons.com>
 <1455110583-19515-4-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <56BC8D58.8050005@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/16 13:22, Antoine Tenart wrote:
> Following the addition of the Alpine MSIX driver, this patch adds the
> corresponding bindings documentation.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> Signed-off-by: Tsahee Zidenberg <tsahee@annapurnalabs.com>
> ---
>  .../interrupt-controller/al,alpine-msix.txt        | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/al,alpine-msix.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/al,alpine-msix.txt b/Documentation/devicetree/bindings/interrupt-controller/al,alpine-msix.txt
> new file mode 100644
> index 000000000000..c7d3d0192f5d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/al,alpine-msix.txt
> @@ -0,0 +1,24 @@
> +Alpine MSIX controller
> +
> +Required properties:
> +
> +- compatible: should be "al,alpine-msix"
> +- reg: physical base address and size of the registers
> +- interrupt-parent: specifies the parent interrupt controller.
> +- interrupt-controller: identifies the node as an interrupt controller
> +- msi-controller: identifies the node as an PCI Message Signaled Interrupt
> +		  controller
> +- al,msi-base-spi: SPI base of the MSI frame
> +- al,msi-num-spis: number of SPIs assigned to the MSI frame

It would probably be good to reference the GIC bindings so that the
"SPI" acronym makes actual sense. It will also disambiguate the "base"
aspect (is this number relative to IRQ0? or SPI0? - I assume the latter,
but that's by looking at the code).

> +
> +Example:
> +
> +msix: msix {
> +	compatible = "al,alpine-msix";
> +	reg = <0x0 0xfbe00000 0x0 0x100000>;
> +	interrupt-parent = <&gic>;
> +	interrupt-controller;
> +	msi-controller;
> +	al,msi-base-spi = <160>;
> +	al,msi-num-spis = <160>;
> +};
> 

Otherwise looks good to me.

	M.
-- 
Jazz is not dead. It just smells funny...
