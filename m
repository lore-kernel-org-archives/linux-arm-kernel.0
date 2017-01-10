From: will.deacon@arm.com (Will Deacon)
Date: Tue, 10 Jan 2017 14:16:52 +0000
Subject: [PATCH v7 11/19] iommu/arm-smmu: Implement reserved region
 get/put callbacks
In-Reply-To: <1483969570-3154-12-git-send-email-eric.auger@redhat.com>
References: <1483969570-3154-1-git-send-email-eric.auger@redhat.com>
 <1483969570-3154-12-git-send-email-eric.auger@redhat.com>
Message-ID: <20170110141651.GB27365@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 01:46:02PM +0000, Eric Auger wrote:
> The get() populates the list with the MSI IOVA reserved window.
> 
> At the moment an arbitray MSI IOVA window is set at 0x8000000
> of size 1MB. This will allow to report those info in iommu-group
> sysfs.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v3 -> v4:
> - do not handle PCI host bridge windows anymore
> - encode prot
> 
> RFC v2 -> v3:
> - use existing get/put_resv_regions
> 
> RFC v1 -> v2:
> - use defines for MSI IOVA base and length
> ---
>  drivers/iommu/arm-smmu.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
