From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Fri, 14 Sep 2012 09:01:51 -0400
Subject: [PATCH v4 06/24] docs: Xen ARM DT bindings
In-Reply-To: <1347621207-11294-6-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1209141145150.29232@kaball.uk.xensource.com>
 <1347621207-11294-6-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20120914130151.GH25249@phenom.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 12:13:08PM +0100, Stefano Stabellini wrote:
> Add a doc to describe the Xen ARM device tree bindings
> 
> 
> Changes in v4:
> 
> - "xen,xen" should be last as it is less specific;
> - update reg property using 2 address-cells and 2 size-cells.
> 
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> CC: devicetree-discuss at lists.ozlabs.org
> CC: David Vrabel <david.vrabel@citrix.com>
> CC: Rob Herring <robherring2@gmail.com>
> CC: Dave Martin <dave.martin@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/xen.txt |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/xen.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/xen.txt b/Documentation/devicetree/bindings/arm/xen.txt
> new file mode 100644
> index 0000000..1f8f7d4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/xen.txt
> @@ -0,0 +1,22 @@
> +* Xen hypervisor device tree bindings
> +
> +Xen ARM virtual platforms shall have the following properties:
> +
> +- compatible:
> +	compatible = "xen,xen-<version>", "xen,xen";
> +  where <version> is the version of the Xen ABI of the platform.
> +
> +- reg: specifies the base physical address and size of a region in
> +  memory where the grant table should be mapped to, using an
> +  HYPERVISOR_memory_op hypercall. 
> +
> +- interrupts: the interrupt used by Xen to inject event notifications.

Its singular here.. but in the example its plurar. What if you use
multiple of the same number ("16 0xf")?

> +
> +
> +Example:
> +
> +hypervisor {
> +	compatible = "xen,xen-4.3", "xen,xen";
> +	reg = <0 0xb0000000 0 0x20000>;

So two grant tables?

Hm, physical address is zero, and the size is 0xbignumber?
Or is the '0' denotating a seperator of arguments, so it is
0xb000.. for physical address and 0x20000 for size?


> +	interrupts = <1 15 0xf08>;
> +};
> -- 
> 1.7.2.5
