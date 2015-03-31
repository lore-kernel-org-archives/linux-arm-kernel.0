From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 31 Mar 2015 15:18:34 +0200
Subject: [PATCH 00/16 v2] iommu: Move domain allocation into drivers
In-Reply-To: <20150330174315.GD15655@arm.com>
References: <1427373799-18662-1-git-send-email-joro@8bytes.org>
 <20150330174315.GD15655@arm.com>
Message-ID: <20150331131834.GE4441@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Mon, Mar 30, 2015 at 06:43:15PM +0100, Will Deacon wrote:
> Whilst I'm still a bit worried about the ability of the IOMMU driver to do
> very much in the ->domain_alloc callback (since we don't know which IOMMU
> instance the domain is for), it doesn't leave us any worse off than we
> currently are.

The IOMMU driver should just allocate the data-structures for a domain
in the domain_alloc call-back. It should not be necessary to care about
any relations of the domain with specific iommu instances.
 
> So, for the arm-smmu patch and the core IOMMU changes:
> 
>   Acked-by: Will Deacon <will.deacon@arm.com>

Thanks a lot!


	Joerg
