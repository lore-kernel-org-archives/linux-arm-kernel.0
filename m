From: madalin.bucur@nxp.com (Madalin-Cristian Bucur)
Date: Fri, 26 May 2017 12:31:15 +0000
Subject: [pull request][v3] soc/fsl/qbman: Enable QBMan on ARM Platforms
In-Reply-To: <1495462842-14402-1-git-send-email-madalin.bucur@nxp.com>
References: <1495462842-14402-1-git-send-email-madalin.bucur@nxp.com>
Message-ID: <AM5PR0402MB2691C73822FA33F05AF9C678ECFC0@AM5PR0402MB2691.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding linux-arm-kernel at lists.infradead.org

> -----Original Message-----
> From: Madalin Bucur [mailto:madalin.bucur at nxp.com]
> Sent: Monday, May 22, 2017 5:21 PM
> To: arm at kernel.org
> Cc: Roy Pledge <roy.pledge@nxp.com>; oss at buserror.net;
> catalin.marinas at arm.com; Madalin-Cristian Bucur <madalin.bucur@nxp.com>
> Subject: [pull request][v3] soc/fsl/qbman: Enable QBMan on ARM Platforms
> 
> Hi,
> 
> This patch series enables DPAA1 QBMan devices for ARM and
> ARM64 architectures. This allows the LS1043A and LS1046A to use
> QBMan functionality.
> 
> Changes since v2:
> Fixed some misspellings
> Added 'no-map' constraint to device tree bindings
> Described ordering contraint on regions in the device tree
> Removed confusing comment regarding non-shareable mappings
> Added warning if old reserved-memory technique is used on ARM
> 
> Changes since v1:
> Reworked private memory allocations to use shared-dma-pool on ARM
> platforms
> 
> Thanks,
> Madalin
> 
> The following changes since commit
> 08332893e37af6ae779367e78e444f8f9571511d:
> 
>   Linux 4.12-rc2 (2017-05-21 19:30:23 -0700)
> 
> are available in the git repository at:
> 
> 
> https://github.com/qoriq-open-source/linux qbman-next
> 
> for you to fetch changes up to 71e875c2a4e431ef6200090c71f7600be7821e9b:
> 
>   soc/fsl/qbman: Add missing headers on ARM (2017-05-22 16:59:55 +0300)
> 
> ----------------------------------------------------------------
> Claudiu Manoil (2):
>       soc/fsl/qbman: Drop L1_CACHE_BYTES compile time check
>       soc/fsl/qbman: Add missing headers on ARM
> 
> Madalin Bucur (4):
>       dts: arm64: add LS1046A DPAA FMan nodes
>       soc/fsl/qbman: Drop set/clear_bits usage
>       soc/fsl/qbman: add QMAN_REV32
>       soc/fsl/qbman: different register offsets on ARM
> 
> Roy Pledge (4):
>       soc/fsl/qbman: Use shared-dma-pool for BMan private memory
> allocations
>       soc/fsl/qbman: Use shared-dma-pool for QMan private memory
> allocations
>       dt-bindings: soc/fsl: Update reserved memory binding for QBMan
>       soc/fsl/qbman: Rework ioremap() calls for ARM/PPC
> 
> Valentin Rothberg (1):
>       soc/fsl/qbman: Fix ARM32 typo
> 
>  Documentation/devicetree/bindings/soc/fsl/bman.txt |  12 +-
>  Documentation/devicetree/bindings/soc/fsl/qman.txt |  26 ++--
>  arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi |  48 +++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts  |   2 +
>  arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts  |  60 +++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |  11 +-
>  drivers/soc/fsl/qbman/bman.c                       |  24 +++-
>  drivers/soc/fsl/qbman/bman_ccsr.c                  |  35 +++++-
>  drivers/soc/fsl/qbman/bman_portal.c                |  12 +-
>  drivers/soc/fsl/qbman/bman_priv.h                  |   3 +
>  drivers/soc/fsl/qbman/dpaa_sys.h                   |   8 +-
>  drivers/soc/fsl/qbman/qman.c                       |  46 ++++++-
>  drivers/soc/fsl/qbman/qman_ccsr.c                  | 140
> ++++++++++++++++-----
>  drivers/soc/fsl/qbman/qman_portal.c                |  12 +-
>  drivers/soc/fsl/qbman/qman_priv.h                  |   5 +-
>  drivers/soc/fsl/qbman/qman_test.h                  |   2 -
>  16 files changed, 381 insertions(+), 65 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi
