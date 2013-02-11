From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 11 Feb 2013 11:46:11 +0000
Subject: [PATCH v2 07/14] USB: ohci-omap3: Add device tree support and
 binding information
In-Reply-To: <1360252974-7912-8-git-send-email-rogerq@ti.com>
References: <1360252974-7912-1-git-send-email-rogerq@ti.com>
 <1360252974-7912-8-git-send-email-rogerq@ti.com>
Message-ID: <20130211114611.GB2726@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 07, 2013 at 04:02:47PM +0000, Roger Quadros wrote:
> Allows the OHCI controller found in OMAP3 and later chips to
> be specified via device tree.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> ---
>  .../devicetree/bindings/usb/omap3-ohci.txt         |   17 +++++++++++++++++
>  drivers/usb/host/ohci-omap3.c                      |   19 +++++++++++++++++++
>  2 files changed, 36 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/omap3-ohci.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/omap3-ohci.txt b/Documentation/devicetree/bindings/usb/omap3-ohci.txt
> new file mode 100644
> index 0000000..ad2ace0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/omap3-ohci.txt
> @@ -0,0 +1,17 @@
> +OMAP HS USB OHCI controller (OMAP3 and later)
> +
> +Required properties:
> +
> +- compatible: should be "ti,ohci-omap3"
> +- reg: should contain one register range i.e. start and length
> +- interrupt-parent: phandle to the interrupt controller

I'm not sure that needs to be documented as a required property. It's a
standard property, and if it's defined for the parent node, you won't need it
here.

Otherwise, this looks fine to me.

Thanks,
Mark.
