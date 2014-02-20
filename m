From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Thu, 20 Feb 2014 17:13:21 +0000
Subject: [PATCH 2/2] arm/xen: Don't use xen DMA ops when the device is
 protected by an IOMMU
In-Reply-To: <1392913301-25524-1-git-send-email-julien.grall@linaro.org>
References: <1392913301-25524-1-git-send-email-julien.grall@linaro.org>
Message-ID: <1392916401.32657.31.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding the -spec list for the generic IOMMU binding question.

On Thu, 2014-02-20 at 16:21 +0000, Julien Grall wrote:
> diff --git a/Documentation/devicetree/bindings/arm/xen.txt b/Documentation/devicetree/bindings/arm/xen.txt
> index 0f7b9c2..ee25a57 100644
> --- a/Documentation/devicetree/bindings/arm/xen.txt
> +++ b/Documentation/devicetree/bindings/arm/xen.txt
> @@ -15,6 +15,8 @@ the following properties:
>  - interrupts: the interrupt used by Xen to inject event notifications.
>    A GIC node is also required.
>  
> +- protected-devices: (optional) List of phandles to device node where the
> +IOMMU has been programmed by Xen. 

Is there some common/generic IOMMU binding which we can reuse here?
Although this isn't exactly an IOMMU it certainly has some similarities
-- it is providing IOMMU like functionality (albeit a very inflexible
IOMMU which you don't need to/can't actually program).

I'd far rather we followed existing patterns rather than invent our own
things.

I'm wondering if perhaps we didn't ought to integrate this as an actual
IOMMU driver, although I'm not convinced this would make sense.

I'm also not sure about shovelling everything as properties under a
single Xen node, should this not be its own node with compatible =
"xen,(pv)iommu"?

Ian.
