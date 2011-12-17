From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Sat, 17 Dec 2011 02:15:09 +0100
Subject: [PATCH v2 1/2] [RFC] ARM: IOMMU: Tegra20: iommu_ops for GART
 driver
In-Reply-To: <20111216154331.GD29877@amd.com>
References: <1323954690-7000-1-git-send-email-hdoyu@nvidia.com><1323954690-7000-2-git-send-email-hdoyu@nvidia.com><20111216154331.GD29877@amd.com>
Message-ID: <20111217.031509.550537371548178833.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg, Thank you for your quick review.

From: Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: [PATCH v2 1/2] [RFC] ARM: IOMMU: Tegra20: iommu_ops for GART driver
Date: Fri, 16 Dec 2011 16:43:31 +0100
Message-ID: <20111216154331.GD29877@amd.com>

> On Thu, Dec 15, 2011 at 03:11:29PM +0200, Hiroshi DOYU wrote:
> > Tegra 20 IOMMU H/W, GART (Graphics Address Relocation Table). This
> > patch implements struct iommu_ops for GART for the upper IOMMU API.
> > 
> > This H/W module supports only single virtual address space(domain),
> > and manages a single level 1-to-1 mapping H/W translation page table.
> > 
> > Signed-off-by: Hiroshi DOYU <hdoyu@nvidia.com>
> > ---
> >  drivers/iommu/Kconfig      |   11 +
> >  drivers/iommu/Makefile     |    1 +
> >  drivers/iommu/tegra-gart.c |  451 ++++++++++++++++++++++++++++++++++++++++++++
> 
> The code looks good in general.

Thanks.

> I think we need to extend the IOMMU-API
> a little bit to better support GART IOMMUs. A user of the IOMMU-API
> should be able to get the information about the iova-base and size of
> the aperture for example. These extensions will be beneficial for
> porting other GART-like driver to the IOMMU-API too.

is it similar to how ".pgsize_bitmap" is passed?

> 
> 
> 	Joerg
> 
> -- 
> AMD Operating System Research Center
> 
> Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
> General Managers: Alberto Bozzo, Andrew Bowd
> Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
> 
