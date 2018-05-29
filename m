From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 29 May 2018 13:48:26 +0200
Subject: [PATCH v2 0/8] Make deferring probe forever optional
In-Reply-To: <20180524175024.19874-1-robh@kernel.org>
References: <20180524175024.19874-1-robh@kernel.org>
Message-ID: <20180529114825.GH18595@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2018 at 12:50:16PM -0500, Rob Herring wrote:
> Rob Herring (8):
>   driver core: make deferring probe after init optional
>   driver core: add a deferred probe timeout
>   dt-bindings: pinctrl: add a 'pinctrl-use-default' property
>   arm: dts: bcm283x: mark the UART pin muxing nodes with
>     pinctrl-use-default
>   pinctrl: optionally stop deferring probe at end of initcalls
>   iommu: Stop deferring probe at end of initcalls
>   iommu: Remove IOMMU_OF_DECLARE
>   PM / Domains: Stop deferring probe at the end of initcall
> 
>  .../admin-guide/kernel-parameters.txt         |  7 +++
>  .../bindings/pinctrl/pinctrl-bindings.txt     |  6 +++
>  arch/arm/boot/dts/bcm283x.dtsi                |  2 +
>  drivers/base/dd.c                             | 43 +++++++++++++++++++
>  drivers/base/power/domain.c                   |  2 +-
>  drivers/iommu/arm-smmu-v3.c                   |  2 -
>  drivers/iommu/arm-smmu.c                      |  7 ---
>  drivers/iommu/exynos-iommu.c                  |  2 -
>  drivers/iommu/ipmmu-vmsa.c                    |  3 --
>  drivers/iommu/msm_iommu.c                     |  2 -
>  drivers/iommu/of_iommu.c                      | 21 +--------
>  drivers/iommu/qcom_iommu.c                    |  2 -
>  drivers/iommu/rockchip-iommu.c                |  2 -
>  drivers/pinctrl/devicetree.c                  | 14 ++++--
>  include/linux/device.h                        |  2 +
>  include/linux/of_iommu.h                      |  4 --
>  16 files changed, 73 insertions(+), 48 deletions(-)

For the IOMMU bits:

Acked-by: Joerg Roedel <jroedel@suse.de>
