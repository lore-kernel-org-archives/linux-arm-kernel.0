From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 27 Sep 2011 11:56:13 +0300
Subject: [PATCH v3 0/6] iommu: split mapping to page sizes as supported by
	the hardware
In-Reply-To: <1316195506-9777-1-git-send-email-ohad@wizery.com>
References: <1316195506-9777-1-git-send-email-ohad@wizery.com>
Message-ID: <CAK=WgbYkG7s+aLW2icm0iHbiX1YRSZ1JSr=jPDv=3Dd+Fg1wgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ping

On Fri, Sep 16, 2011 at 8:51 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> v2->v3:
>
> - s/KB/KiB/ (David W)
>
> v1->v2:
>
> - split to patches (by keeping the old code around until all drivers are converted) (Joerg)
>
>
> Ohad Ben-Cohen (6):
> ?iommu/core: split mapping to page sizes as supported by the hardware
> ?iommu/omap: announce supported page sizes
> ?iommu/msm: announce supported page sizes
> ?iommu/amd: announce supported page sizes
> ?iommu/intel: announce supported page sizes
> ?iommu/core: remove the temporary register_iommu_pgsize API
>
> ?drivers/iommu/amd_iommu.c ? | ? 20 ++++++-
> ?drivers/iommu/intel-iommu.c | ? 20 ++++++-
> ?drivers/iommu/iommu.c ? ? ? | ?130 +++++++++++++++++++++++++++++++++++++++----
> ?drivers/iommu/msm_iommu.c ? | ? ?8 ++-
> ?drivers/iommu/omap-iommu.c ?| ? ?6 ++-
> ?drivers/iommu/omap-iovmm.c ?| ? 12 +---
> ?include/linux/iommu.h ? ? ? | ? ?7 +-
> ?virt/kvm/iommu.c ? ? ? ? ? ?| ? ?4 +-
> ?8 files changed, 177 insertions(+), 30 deletions(-)
>
> --
> 1.7.4.1
>
>
