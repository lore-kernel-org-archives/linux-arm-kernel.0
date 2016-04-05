From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 5 Apr 2016 13:27:58 +0200
Subject: [v7, 0/5] Fix eSDHC host version register bug
In-Reply-To: <1459480051-3701-1-git-send-email-yangbo.lu@nxp.com>
References: <1459480051-3701-1-git-send-email-yangbo.lu@nxp.com>
Message-ID: <CAPDyKFqgMCvbqMYZ-uM-rTnVvfJkCYbhv2kucCRyNyc9FWoR=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 April 2016 at 05:07, Yangbo Lu <yangbo.lu@nxp.com> wrote:
> This patchset is used to fix a host version register bug in the T4240-R1.0-R2.0
> eSDHC controller. To get the SoC version and revision, it's needed to add the
> GUTS driver to access the global utilities registers.
>
> So, the first three patches are to add the GUTS driver.
> The following two patches are to enable GUTS driver support to get SVR in eSDHC
> driver and fix host version for T4240.
>
> Yangbo Lu (5):
>   ARM64: dts: ls2080a: add device configuration node
>   soc: fsl: add GUTS driver for QorIQ platforms
>   dt: move guts devicetree doc out of powerpc directory
>   powerpc/fsl: move mpc85xx.h to include/linux/fsl
>   mmc: sdhci-of-esdhc: fix host version for T4240-R1.0-R2.0
>
>  .../bindings/{powerpc => soc}/fsl/guts.txt         |   3 +
>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |   6 ++
>  arch/powerpc/kernel/cpu_setup_fsl_booke.S          |   2 +-
>  drivers/clk/clk-qoriq.c                            |   3 +-
>  drivers/i2c/busses/i2c-mpc.c                       |   2 +-
>  drivers/iommu/fsl_pamu.c                           |   3 +-
>  drivers/mmc/host/Kconfig                           |   1 +
>  drivers/mmc/host/sdhci-of-esdhc.c                  |  23 ++++
>  drivers/net/ethernet/freescale/gianfar.c           |   2 +-
>  drivers/soc/Kconfig                                |   2 +-
>  drivers/soc/fsl/Kconfig                            |   8 ++
>  drivers/soc/fsl/Makefile                           |   1 +
>  drivers/soc/fsl/guts.c                             | 119 +++++++++++++++++++++
>  include/linux/fsl/guts.h                           |  98 ++++++++---------
>  .../asm/mpc85xx.h => include/linux/fsl/svr.h       |   4 +-
>  15 files changed, 219 insertions(+), 58 deletions(-)
>  rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/guts.txt (91%)
>  create mode 100644 drivers/soc/fsl/Kconfig
>  create mode 100644 drivers/soc/fsl/guts.c
>  rename arch/powerpc/include/asm/mpc85xx.h => include/linux/fsl/svr.h (97%)
>
> --
> 2.1.0.27.g96db324
>

I was about to queue this for next, when I noticed that checkpatch is
complaining/warning lots about these patches. Can you please a round
of checkpatch and fix what makes sense.

Kind regards
Uffe
