From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 18 Aug 2014 14:38:06 +0200
Subject: [PATCH 0/5] MMC cleanup of dev_pm_ops and .owner
In-Reply-To: <1407860069-12706-1-git-send-email-peter.griffin@linaro.org>
References: <1407860069-12706-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <CAPDyKFr5ESzjEd3DUO7aMKN9K_Ytuw8GY-fgEyCM4sCGJAX3NQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 August 2014 18:14, Peter Griffin <peter.griffin@linaro.org> wrote:
> This series cleans up a few platform drivers in how they are declaring there
> dev_pm_ops structs, and gets rid of a few now redundant #else conditions.
>
> Also it removes the .owner field of drivers which use module_platform_driver
> api to register themselves, as this field gets overwritten.
>
> Peter Griffin (5):
>   mmc: remove .owner field for drivers using module_platform_driver
>   mmc: dw_mmc-pci: Remove superflous #else condition on CONFIG_PM_SLEEP
>   mmc: dw_mmc-pltfm: Remove superflous #else condition on
>     CONFIG_PM_SLEEP
>   mmc: sdhci-pci: Use SET_RUNTIME_PM_OPS macro to set runtime pm
>     callbacks
>   mmc: sdhci-acpi.c: Use SET_RUNTIME_PM_OPS macro to set runtime pm
>     callbacks

Thanks! Applied for next!

Kind regards
Uffe

>
>  drivers/mmc/host/dw_mmc-pci.c      |  3 ---
>  drivers/mmc/host/dw_mmc-pltfm.c    |  3 ---
>  drivers/mmc/host/jz4740_mmc.c      |  1 -
>  drivers/mmc/host/moxart-mmc.c      |  1 -
>  drivers/mmc/host/mxcmmc.c          |  1 -
>  drivers/mmc/host/mxs-mmc.c         |  1 -
>  drivers/mmc/host/omap.c            |  1 -
>  drivers/mmc/host/omap_hsmmc.c      |  1 -
>  drivers/mmc/host/pxamci.c          |  1 -
>  drivers/mmc/host/rtsx_pci_sdmmc.c  |  1 -
>  drivers/mmc/host/rtsx_usb_sdmmc.c  |  1 -
>  drivers/mmc/host/s3cmci.c          |  1 -
>  drivers/mmc/host/sdhci-acpi.c      | 11 ++---------
>  drivers/mmc/host/sdhci-bcm-kona.c  |  1 -
>  drivers/mmc/host/sdhci-bcm2835.c   |  1 -
>  drivers/mmc/host/sdhci-cns3xxx.c   |  1 -
>  drivers/mmc/host/sdhci-dove.c      |  1 -
>  drivers/mmc/host/sdhci-esdhc-imx.c |  1 -
>  drivers/mmc/host/sdhci-msm.c       |  1 -
>  drivers/mmc/host/sdhci-of-arasan.c |  1 -
>  drivers/mmc/host/sdhci-of-esdhc.c  |  1 -
>  drivers/mmc/host/sdhci-of-hlwd.c   |  1 -
>  drivers/mmc/host/sdhci-pci.c       | 11 ++---------
>  drivers/mmc/host/sdhci-pxav2.c     |  1 -
>  drivers/mmc/host/sdhci-pxav3.c     |  1 -
>  drivers/mmc/host/sdhci-s3c.c       |  1 -
>  drivers/mmc/host/sdhci-sirf.c      |  1 -
>  drivers/mmc/host/sdhci-spear.c     |  1 -
>  drivers/mmc/host/sdhci-tegra.c     |  1 -
>  drivers/mmc/host/sh_mmcif.c        |  1 -
>  drivers/mmc/host/sh_mobile_sdhi.c  |  1 -
>  drivers/mmc/host/sunxi-mmc.c       |  1 -
>  32 files changed, 4 insertions(+), 52 deletions(-)
>
> --
> 1.9.1
>
