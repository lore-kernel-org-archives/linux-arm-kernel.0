From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 27 Jun 2014 07:57:42 -0400
Subject: [PATCH V4 15/16] documentation: dt: omap: crossbar: Add
 description for interrupt consumer
In-Reply-To: <1403766634-18543-16-git-send-email-r.sricharan@ti.com>
References: <1403766634-18543-1-git-send-email-r.sricharan@ti.com>
 <1403766634-18543-16-git-send-email-r.sricharan@ti.com>
Message-ID: <20140627115742.GA23978@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 12:40:33PM +0530, Sricharan R wrote:
> From: Nishanth Menon <nm@ti.com>
> 
> The current crossbar description does not include the description
> required for the consumer of the crossbar, a.k.a devices whoes events
> pass through the crossbar into the GIC interrupt controller.
> 
> So, provide documentation for the same.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Sricharan R <r.sricharan@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  .../devicetree/bindings/arm/omap/crossbar.txt      |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/crossbar.txt b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
> index 6923531..35356b6 100644
> --- a/Documentation/devicetree/bindings/arm/omap/crossbar.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
> @@ -36,3 +36,20 @@ Examples:
>  			ti,irqs-reserved = <0 1 2 3 5 6 131 132 139 140>;
>  			ti,irqs-skip = <10 133 139 140>;
>  		};
> +
> +Consumer:
> +========
> +See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt and
> +Documentation/devicetree/bindings/arm/gic.txt for further details.
> +
> +An interrupt consumer on an SoC using crossbar will use:
> +	interrupts = <GIC_SPI request_number interrupt_level>
> +request number shall be between 0 to that described by
> +"ti,max-crossbar-sources"
> +
> +Example:
> +	device_x at 0x4a023000 {
> +		/* Crossbar 8 used */
> +		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;

If you are going to reference MAX_SOURCES in the previous patch to the
docs, then you should use the macro here as well and explain both.  Or,
just use numbers in the docs, and macros in the dtsi files.

If you prefer the latter, just let me know and I'll fixup the other
patch when applying these.  Otherwise, you can just send a v5 of the two
patches affected.

thx,

Jason.
