From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 28 Nov 2013 21:33:23 +0100
Subject: [RFC PATCH] Documentation: devicetree: add description for
 generic bus properties
In-Reply-To: <20131127172806.GC2291@e103592.cambridge.arm.com>
References: <20131127172806.GC2291@e103592.cambridge.arm.com>
Message-ID: <20131128203322.GB14689@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 27, 2013 at 05:28:06PM +0000, Dave Martin wrote:
[...]
> From will.deacon at arm.com Wed Nov 20 12:06:22 2013
[...]
> A number of discussion points remain to be resolved:
> 
>   - Use of the ranges property and describing slave vs master bus
>     address ranges. In the latter case, we actually want to describe our
>     address space with respect to the bus on which the bus masters,
>     rather than the parent. This could potentially be achieved by adding
>     properties such as dma-parent and dma-ranges (already used by PPC?)
> 
>   - Describing masters that master through multiple different buses
> 
>   - How on Earth this fits in with the Linux device model (it doesn't)
> 
>   - Interaction with IOMMU bindings (currently under discussion)

This is all very vague. Perhaps everyone else knows what this is all
about, in which case it'd be great if somebody could clue me in.

In particular I'm not sure what exact problem this solves. Perhaps a
somewhat more concrete example would help. Or perhaps pointers to
documentation that can help filling in the gaps.

>  .../devicetree/bindings/arm/coherent-bus.txt       | 110 +++++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/coherent-bus.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/coherent-bus.txt b/Documentation/devicetree/bindings/arm/coherent-bus.txt
> new file mode 100644
> index 000000000000..e3fbc2e491c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/coherent-bus.txt
> @@ -0,0 +1,110 @@
> +* Generic binding to describe a coherent bus
> +
> +In some systems, devices (peripherals and/or CPUs) do not share
> +coherent views of memory, while on other systems sets of devices may
> +share a coherent view of memory depending on the static bus topology
> +and/or dynamic configuration of both the bus and device. Establishing
> +such dynamic configurations requires appropriate topological information
> +to be communicated to the operating system.
> +
> +This binding document attempts to define a set of generic properties
> +which can be used to encode topological information in bus and device
> +nodes.
> +
> +
> +* Terminology
> +
> +  - Port                : An interface over which memory transactions
> +                          can propagate. A port may act as a master,
> +                          slave or both (see below).
> +
> +  - Master port         : A port capable of issuing memory transactions
> +                          to a slave. For example, a port connecting a
> +                          DMA controller to main memory.
> +
> +  - Slave port          : A port capable of responding to memory
> +                          transactions received by a master. For
> +                          example, a port connecting the control
> +                          registers of an MMIO device to a peripheral
> +                          bus.

"Port" sounds awfully generic. Other bindings (such as those for V4L2,
aka media) use ports for something completely different. Perhaps we can
come up with a more specific term that matches the use-case better?

What exactly does this map to in hardware?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131128/d304b471/attachment.sig>
