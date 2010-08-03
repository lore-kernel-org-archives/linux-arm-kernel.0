From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Tue, 3 Aug 2010 11:23:25 +0200
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <20100802202935.GA26214@codeaurora.org>
References: <20100729123512Y.fujita.tomonori@lab.ntt.co.jp>
	<201007291026.55928.arnd@arndb.de> <20100729084018.GM26098@amd.com>
	<20100729174621W.fujita.tomonori@lab.ntt.co.jp>
	<20100729090607.GN26098@amd.com>
	<d493494df33aaf65e526181b1dbafce3.squirrel@www.codeaurora.org>
	<20100802075802.GN24084@amd.com>
	<20100802202935.GA26214@codeaurora.org>
Message-ID: <20100803092325.GD18307@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 02, 2010 at 04:29:38PM -0400, Zach Pfeffer wrote:
> On Mon, Aug 02, 2010 at 09:58:02AM +0200, Roedel, Joerg wrote:

> > In the means of the IOMMU-API the domain is the abstraction of an
> > address space (in other words a page table). The IOMMU(s) which this domain
> > is later assigned to are determined by the iommu_attach_device calls.
> > I think the right way to go here is to create the concept of a
> > device-context in the IOMMU-API and add functions like
> > 
> > 	iommu_attach_context(struct iommu_domain *domain,
> > 			     struct iommu_context *ctxt);
> > 	iommu_detach_context(struct iommu_context *ctxt);
> > 
> > This would work if you can determine in your iommu-driver which iommu
> > you need to program for which device. What do you think?
> > 
> 
> Joerg, I'd like to make sure I understand this. A domain is an address
> space separate from the actual page-tables that may be part of an
> iommu_context, correct? After I iommu_attach_context the ctxt will
> reflect the address space of the domain, correct?

A domain is defined by a single page-table which can be modified using
the iommu_map/iommu_unmap function calls. I am not completly sure what
you mean by an iommu_context. Can you describe what it means in your
context?

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
