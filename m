From: B16395@freescale.com (Sethi Varun-B16395)
Date: Tue, 8 Oct 2013 18:18:45 +0000
Subject: [PATCH 3/5] iommu/arm-smmu: Introduce stream ID masking
In-Reply-To: <20131008165920.GG21189@mudshark.cambridge.arm.com>
References: <1381224444-27303-1-git-send-email-andreas.herrmann@calxeda.com>
 <1381224444-27303-4-git-send-email-andreas.herrmann@calxeda.com>
 <20131008151007.GD21189@mudshark.cambridge.arm.com>
 <20131008152008.GE2935@alberich> <20131008164021.GH2935@alberich>
 <20131008165920.GG21189@mudshark.cambridge.arm.com>
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D0A516014@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: iommu-bounces at lists.linux-foundation.org [mailto:iommu-
> bounces at lists.linux-foundation.org] On Behalf Of Will Deacon
> Sent: Tuesday, October 08, 2013 10:29 PM
> To: Andreas Herrmann
> Cc: iommu at lists.linux-foundation.org; Rob Herring; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH 3/5] iommu/arm-smmu: Introduce stream ID masking
> 
> On Tue, Oct 08, 2013 at 05:40:21PM +0100, Andreas Herrmann wrote:
> > On Tue, Oct 08, 2013 at 05:20:08PM +0200, Andreas Herrmann wrote:
> > To be more specific: For SATA I'd need to specify 10 StreamIds. This
> > would
> >
> > (1) exceed MAX_MASTER_STREAMIDS (currently it's 8)
> >
> >    (Can easily be fixed by adapting a macro.)
> >
> > (2) exceed number of available SMR groups to map the IDs to a context.
> >
> >    This can be solved by caclulating an appropriate mask for the
> >    mapping (but with a non-power-of-two number of StreamIds that's
> >    already non-trivial -- for the trivial case I have some code to do
> >    this).
> >
> > Both problems are avoided by introducing this patch -- use
> > smr_mask_bits to map all StreamIDs to the same context and be done
> > with it. (for the "single-master-SMMU" case)
> 
> The problem is, this information *really* doesn't belong in the device
> tree, but I think computing the general case dynamically is incredibly
> difficult too (and requires *complete* topological information in the
> device-tree, so you don't accidentally pull in other devices).
> 
[Sethi Varun-B16395] I don't quiet follow the point about topological information. How do you determine from the topology if the stream ids should share the iommu domain?
Another question, how would iommu group creation work for dma masters with multiple stream ids?

-Varun
