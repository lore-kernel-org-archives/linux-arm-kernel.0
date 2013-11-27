From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 27 Nov 2013 15:06:50 -0800
Subject: [RFC PATCH] Documentation: devicetree: add description for
 generic bus properties
In-Reply-To: <20131127172806.GC2291@e103592.cambridge.arm.com>
References: <20131127172806.GC2291@e103592.cambridge.arm.com>
Message-ID: <20131127230650.GA6162@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 27, 2013 at 05:28:06PM +0000, Dave Martin wrote:
> Hi all,
> 
> SoC architectures are getting increasingly complex in ways that are not
> transparent to software.
> 
> A particular emerging issue is that of multi-master SoCs, which may have
> different address views, IOMMUs, and coherency behaviour from one master
> to the next.
> 
> DT can't describe multi-master systems today except for PCI DMA and
> similar.  This comes with constraints and assumptions that won't work
> for emerging SoC bus architectures.  On-SoC, a device's interface to the
> system can't be described in terms of a single interface to a single
> "bus".
> 
> Different masters may have different views of the system too.  Software
> needs to understand the true topology in order to do address mapping,
> coherency management etc., in any generic way.
> 
> One piece of the puzzle is to define how to describe these topologies in
> DT.
> 
> The other is how to get the right abstractions in the kernel to drive
> these systems in a generic way.
> 
> The following proposal (originally from Will) begins to address the DT
> part.
> 
> Comments encouraged -- I anticipate it may take some discussion to
> reach a consensus here.
> 
> Cheers
> ---Dave
> 
> 
> >From will.deacon at arm.com Wed Nov 20 12:06:22 2013
> Date: Wed, 20 Nov 2013 12:06:13 +0000
> Subject: [PATCH RFC v2] Documentation: devicetree: add description for generic bus properties
> 
> This patch documents properties that can be used as part of bus and
> device bindings in order to describe their linkages within the system
> topology.
> 
> Use of these properties allows topological parsing to occur in generic
> library code, making it easier for bus drivers to parse information
> regarding their upstream masters and potentially allows us to treat
> the slave and master interfaces separately for a given device.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> 
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

How does this _not_ fit into the Linux device model?  What am I missing
here that precludes the use of the "driver/device/bus" model we have
today?

>   - Interaction with IOMMU bindings (currently under discussion)
> 
> Cheers,
> 
> Will
> 
>  .../devicetree/bindings/arm/coherent-bus.txt       | 110 +++++++++++++++++++++

Why "arm"?

What makes it ARM specific?

thanks,

greg k-h
