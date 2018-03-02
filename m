From: will.deacon@arm.com (Will Deacon)
Date: Fri, 2 Mar 2018 18:02:20 +0000
Subject: RFC on Kdump and PCIe on ARM64
In-Reply-To: <84121a8d-5294-0567-6c6b-f57e85dc4961@codeaurora.org>
References: <c5c2d8d2-0384-442a-7bc6-8929457b8447@codeaurora.org>
 <20180301190552.GK13722@bhelgaas-glaptop.roam.corp.google.com>
 <2b2de17c-8527-e49b-2ef2-2a3d1801e4f9@codeaurora.org>
 <20180302000303.GD74737@bhelgaas-glaptop.roam.corp.google.com>
 <20180302103032.GB19323@arm.com>
 <84121a8d-5294-0567-6c6b-f57e85dc4961@codeaurora.org>
Message-ID: <20180302180219.GB20579@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2018 at 09:12:29AM -0500, Sinan Kaya wrote:
> On 3/2/2018 5:30 AM, Will Deacon wrote:
> >> Do you really have to reset the IOMMU?  Can you just give it new page
> >> tables that start out with all IOVAs from all devices being invalid,
> >> then add valid mappings as drivers need them (presumably after the
> >> driver has done whatever it needs to so the device stops using the old
> >> DMA addresses)?
> > We already have the option to do that via the command line using the
> > disable_bypass option, so it just sounds like we need to take this into
> > account when resetting the SMMU to take care that GBPA is configured so
> > that transactions are terminated when SMMUEN=0.
> 
> How about the points that Baoquan highlighted in his email regarding the
> solution from AMD and X86?

Which specific points do you think this proposal doesn't address?

> I have not read the entire thread but, is this just a matter of following
> what Bjorn recommended or there is more to it?

I'm trying to say how I think Bjorn's idea can be implemented for SMMUv3.
I basically want to avoid a situation where the SMMU driver tries to walk
the in-memory data structures left by a previous kernel and infer the
setup from that.

Will
