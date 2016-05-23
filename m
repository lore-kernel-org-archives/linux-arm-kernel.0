From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 23 May 2016 09:10:40 +0100
Subject: [PATCH V5 0/7] iommu/msm: Add DT adaptation and generic bindings
 support
In-Reply-To: <1463741694-1735-1-git-send-email-sricharan@codeaurora.org>
References: <1463741694-1735-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <5742BB00.3040504@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sricharan,

Thanks for the patchset,

On 20/05/16 11:54, Sricharan R wrote:
> The msm_iommu.c driver currently works based on platform data.
> A single master device can be connected to more than one iommu and multiple
> contexts in each of the iommu. This association between master and iommus was
> represented from platform data using parent/child devices. The master drivers
> were responsible for attaching all of the iommus/context to a domain. Now the
> platform data support is removed and DT support is added. The master/iommus are
> added through generic iommu bindings.
...
> [V1]
>     https://lists.linuxfoundation.org/pipermail/iommu/2015-August/014074.html
>
> Sricharan R (7):
>    iommu/msm: Add DT adaptation
>    documentation: iommu: Add bindings for msm,iommu-v0 ip
>    iommu/msm: Move the contents from msm_iommu_dev.c to msm_iommu.c
>    iommu/msm: Add support for generic master bindings
>    iommu/msm: use generic ARMV7S short descriptor pagetable ops
>    iommu/msm: Use writel_relaxed and add a barrier
>    iommu/msm: Remove driver BROKEN
>
>   .../devicetree/bindings/iommu/msm,iommu-v0.txt     |  64 ++
>   drivers/iommu/Kconfig                              |   2 +-
>   drivers/iommu/Makefile                             |   2 +-
>   drivers/iommu/msm_iommu.c                          | 885 +++++++++++----------
>   drivers/iommu/msm_iommu.h                          |  73 +-
>   drivers/iommu/msm_iommu_dev.c                      | 381 ---------
>   drivers/iommu/msm_iommu_hw-8xxx.h                  | 109 +--
>   7 files changed, 636 insertions(+), 880 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
>   delete mode 100644 drivers/iommu/msm_iommu_dev.c


Tested It on IFC6410 and DB600c.

Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


--srini
