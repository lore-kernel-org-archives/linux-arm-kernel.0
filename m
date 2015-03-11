From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 11 Mar 2015 09:38:47 +0100
Subject: [PATCH 1/2] iommu: move pgsize_bitmap from struct iommu_ops to
 struct iommu_domain
In-Reply-To: <1425641688-26438-2-git-send-email-will.deacon@arm.com>
References: <1425641688-26438-1-git-send-email-will.deacon@arm.com>
 <1425641688-26438-2-git-send-email-will.deacon@arm.com>
Message-ID: <20150311083846.GB19391@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 06, 2015 at 11:34:47AM +0000, Will Deacon wrote:
> struct iommu_ops contains function pointers for IOMMU driver callbacks
> in order to implement the core IOMMU API. Amongst these pointers is
> an unsigned long pgsize_bitmap field, which is problematic because the
> set of supported page sizes is not necessarily the same across all
> instances of a given IOMMU type in the system. Furthermore, the set of
> supported page sizes may be restricted following domain initialisation
> when a particular page table format is chosen for the domain.
> 
> This patch moves the field from iommu_ops into the iommu_domain and
> updates all users accordingly.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
[...]
>  drivers/iommu/tegra-gart.c      |  2 +-
>  drivers/iommu/tegra-smmu.c      |  3 +--

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150311/55d9df1f/attachment.sig>
