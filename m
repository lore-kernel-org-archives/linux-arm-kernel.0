From: mporter@ti.com (Matt Porter)
Date: Wed, 6 Mar 2013 15:31:52 -0500
Subject: [PATCH v9 5/9] dmaengine: edma: Add TI EDMA device tree binding
In-Reply-To: <90c29a73df9e495f907517c49dd45b88@DFLE72.ent.ti.com>
References: <1362586540-10393-1-git-send-email-mporter@ti.com>
 <1362586540-10393-6-git-send-email-mporter@ti.com>
 <90c29a73df9e495f907517c49dd45b88@DFLE72.ent.ti.com>
Message-ID: <20130306203152.GO6209@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 06, 2013 at 08:24:06PM +0000, Peter Korsgaard wrote:
> >>>>> "Matt" == Matt Porter <mporter@ti.com> writes:
> 
>  Matt> The binding definition is based on the generic DMA controller
>  Matt> binding.
> 
>  Matt> Signed-off-by: Matt Porter <mporter@ti.com>
>  Matt> ---
>  Matt>  Documentation/devicetree/bindings/dma/ti-edma.txt |   49 +++++++++++++++++++++
>  Matt>  1 file changed, 49 insertions(+)
>  Matt>  create mode 100644 Documentation/devicetree/bindings/dma/ti-edma.txt
> 
>  Matt> diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
>  Matt> new file mode 100644
>  Matt> index 0000000..075a60e3
>  Matt> --- /dev/null
>  Matt> +++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
>  Matt> @@ -0,0 +1,49 @@
>  Matt> +TI EDMA
>  Matt> +
>  Matt> +Required properties:
>  Matt> +- compatible : "ti,edma3"
>  Matt> +- ti,hwmods: Name of the hwmods associated to the EDMA
>  Matt> +- ti,edma-regions: Number of regions
>  Matt> +- ti,edma-slots: Number of slots
>  Matt> +- ti,edma-queue-tc-map: List of transfer control to queue mappings
>  Matt> +- ti,edma-queue-priority-map: List of queue priority mappings
>  Matt> +- ti,edma-default-queue: Default queue value
>  Matt> +
>  Matt> +Optional properties:
>  Matt> +- ti,edma-reserved-channels: List of reserved channel regions
>  Matt> +- ti,edma-reserved-slots: List of reserved slot regions
>  Matt> +- ti,edma-xbar-event-map: Crossbar event to channel map
>  Matt> +
>  Matt> +Example:
>  Matt> +
>  Matt> +edma: edma at 49000000 {
>  Matt> +	reg = <0x49000000 0x10000>;
>  Matt> +	interrupt-parent = <&intc>;
>  Matt> +	interrupts = <12 13 14>;
> 
> Probably interrupt-parent should be removed from the example as well to
> match am33xx.dtsi

I'm not sure what the DT maintainers want here. Full context within the
example or the actual real usage where it's typically inherited.

Grant or Rob, any thoughts?

-Matt
