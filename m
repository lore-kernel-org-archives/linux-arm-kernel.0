From: robherring2@gmail.com (Rob Herring)
Date: Mon, 27 Aug 2012 18:03:52 -0500
Subject: [PATCH v3 06/25] docs: Xen ARM DT bindings
In-Reply-To: <1345131377-14713-6-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1208161618550.4850@kaball.uk.xensource.com>
 <1345131377-14713-6-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <503BFCD8.5090804@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/16/2012 10:35 AM, Stefano Stabellini wrote:
> Add a doc to describe the Xen ARM device tree bindings
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> CC: devicetree-discuss at lists.ozlabs.org
> CC: David Vrabel <david.vrabel@citrix.com>
> ---
>  Documentation/devicetree/bindings/arm/xen.txt |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/xen.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/xen.txt b/Documentation/devicetree/bindings/arm/xen.txt
> new file mode 100644
> index 0000000..ec6d884
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/xen.txt
> @@ -0,0 +1,22 @@
> +* Xen hypervisor device tree bindings
> +
> +Xen ARM virtual platforms shall have the following properties:
> +
> +- compatible:
> +	compatible = "xen,xen", "xen,xen-<version>";
> +  where <version> is the version of the Xen ABI of the platform.
> +
> +- reg: specifies the base physical address and size of a region in
> +  memory where the grant table should be mapped to, using an
> +  HYPERVISOR_memory_op hypercall. 
> +
> +- interrupts: the interrupt used by Xen to inject event notifications.

You should look at ePAPR 1.1 which defines hypervisor related bindings.
While it is a PPC doc, we should reuse or extend what makes sense.

See section 7.5:

https://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.1.pdf

Rob

> +
> +
> +Example:
> +
> +hypervisor {
> +	compatible = "xen,xen", "xen,xen-4.3";
> +	reg = <0xb0000000 0x20000>;
> +	interrupts = <1 15 0xf08>;
> +};
> 
