From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 31 Mar 2015 16:24:40 +0200
Subject: [GIT PULL] iommu: Kill off pgsize_bitmap field from struct
 iommu_ops
In-Reply-To: <20150327171946.GL1562@arm.com>
References: <20150327171946.GL1562@arm.com>
Message-ID: <20150331142440.GD22683@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Fri, Mar 27, 2015 at 05:19:46PM +0000, Will Deacon wrote:
> Please can you pull the following IOMMU changes for 4.1? They move the
> per-iommu_ops pgsize_bitmap field into the iommu_domain, which allows
> IOMMUs such as the ARM SMMU to support different page sizes within a
> given SoC.

I have some concerns about the direction taken with this patch-set. The
goal for the IOMMU-API is still to have domains that can be attached to
arbitrary devices (even when mappings already exist). But with this
patch-set we move into a direction where a domain can only be used on
IOMMUs that support the page-sizes required by the domain. In the end
this would be visible to the user of the IOMMU-API, which is not what we
want.

I can understand the motivation behind these patches, but we need to
think about how this could work with the desired semantics of the
IOMMU-API.


	Joerg
