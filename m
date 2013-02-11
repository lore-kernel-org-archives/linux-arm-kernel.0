From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 11 Feb 2013 11:52:19 +0000
Subject: [PATCH v2 08/14] USB: ehci-omap: Add device tree support and
 binding information
In-Reply-To: <1360252974-7912-9-git-send-email-rogerq@ti.com>
References: <1360252974-7912-1-git-send-email-rogerq@ti.com>
 <1360252974-7912-9-git-send-email-rogerq@ti.com>
Message-ID: <20130211115219.GC2726@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 07, 2013 at 04:02:48PM +0000, Roger Quadros wrote:
> Allows the OMAP EHCI controller to be specified via device tree.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> ---
>  .../devicetree/bindings/usb/omap-ehci.txt          |   34 ++++++++++++++++++
>  drivers/usb/host/ehci-omap.c                       |   36 +++++++++++++++++++-
>  2 files changed, 69 insertions(+), 1 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/omap-ehci.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/omap-ehci.txt b/Documentation/devicetree/bindings/usb/omap-ehci.txt
> new file mode 100644
> index 0000000..b00a654
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/omap-ehci.txt
> @@ -0,0 +1,34 @@
> +OMAP HS USB EHCI controller
> +
> +This device is usually the child of the omap-usb-host
> +Documentation/devicetree/bindings/mfd/omap-usb-host.txt
> +
> +Required properties:
> +
> +- compatible: should be "ti,ehci-omap"
> +- reg: should contain one register range i.e. start and length
> +- interrupt-parent: phandle to the interrupt controller

Same comment as for ohci-omap3 here; I don't think it's necessary to document
this as a required property.

Otherwise, looks good.

Thanks,
Mark.
