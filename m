From: will.deacon@arm.com (Will Deacon)
Date: Mon, 30 Jun 2014 18:02:21 +0100
Subject: [RFC/PATCH 4/7] iommu: msm: Add MSM IOMMUv1 driver
In-Reply-To: <1404147116-4598-5-git-send-email-ohaugan@codeaurora.org>
References: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org>
 <1404147116-4598-5-git-send-email-ohaugan@codeaurora.org>
Message-ID: <20140630170221.GA30740@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olav,

On Mon, Jun 30, 2014 at 05:51:53PM +0100, Olav Haugan wrote:
> MSM IOMMUv1 driver supports Qualcomm SoC MSM8974 and
> MSM8084.
> 
> The IOMMU driver supports the following features:
> 
>     - ARM V7S page table format independent of ARM CPU page table format
>     - 4K/64K/1M/16M mappings (V7S)
>     - ATOS used for unit testing of driver
>     - Sharing of page tables among SMMUs
>     - Verbose context bank fault reporting
>     - Verbose global fault reporting
>     - Support for clocks and GDSC
>     - map/unmap range
>     - Domain specific enabling of coherent Hardware Table Walk (HTW)
> 
> Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
> ---
>  .../devicetree/bindings/iommu/msm,iommu_v1.txt     |   56 +
>  drivers/iommu/Kconfig                              |   36 +
>  drivers/iommu/Makefile                             |    2 +
>  drivers/iommu/msm_iommu-v1.c                       | 1448 +++++++++++++
>  drivers/iommu/msm_iommu.c                          |  149 ++
>  drivers/iommu/msm_iommu_dev-v1.c                   |  340 +++
>  drivers/iommu/msm_iommu_hw-v1.h                    | 2236 ++++++++++++++++++++
>  drivers/iommu/msm_iommu_pagetable.c                |  600 ++++++
>  drivers/iommu/msm_iommu_pagetable.h                |   33 +
>  drivers/iommu/msm_iommu_priv.h                     |   55 +
>  include/linux/qcom_iommu.h                         |  221 ++
>  11 files changed, 5176 insertions(+)

This patch is *huge*! It may get bounced from some lists (I think the
linux-arm-kernel lists has a ~100k limit), so it might be worth trying to do
this incrementally.

That said, a quick glance at your code indicates that this IOMMU is
compliant with the ARM SMMU architecture, and we already have a driver for
that. Please can you rework this series to build on top of the code in
mainline already, rather than simply duplicating it? We need fewer IOMMU
drivers, not more!

It's also worth talking to Varun Sethi, as he was already looking at
implementing block mappings in the existing driver.

Thanks,

Will
