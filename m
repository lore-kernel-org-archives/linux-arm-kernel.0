From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 24 Apr 2014 10:25:42 +0200
Subject: [PATCH 00/38] MMC updates, plus CuBox-i WiFi support
In-Reply-To: <20140423185534.GA26756@n2100.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Message-ID: <CAPDyKFozP69yngKAkdwHYyyvi+pdLEm05udOmBiVshQFi4hnLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 April 2014 20:55, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> All,
>
> This is where I'm at with trying to clean up the SDHCI mess, and sort out
> issues I've noticed when trying to get UHS support working on CuBoxes.
> This is my full patch set, but I recommend not applying patch 37 as there
> appears to be a hardware issue preventing it working reliably.
>
> In any case, patches 0-33 inclusive are the SDHCI clean up, based against
> v3.15-rc1.  Patches 34 and 35 are Olof's Wifi support, 36 is my fix against
> those, and 38 adds the Broadcom Wifi and BT support for CuBox.
>
> The questions over how to handle these devices were never properly settled,
> so I recommend against merging patch 34 onwards.  As for the rest, I'm not
> planning on any further work, so it may be a good idea for people to
> consider testing them with a view to getting them merged.
>

I have looked though the patches up until patch 33 and this is clearly
a nice piece of clean-up /fixes work for sdhci. Besides my minor
comments per patch, I don't have any objections code-review wise to
proceed merging them.

I have also tried to applied them on Chris' mmc-next branch,
unfortunate it fails at patch 23, so it would be nice to get a
re-based patchset for the mmc-next branch.

Kind regards
Ulf Hansson

>  Documentation/devicetree/bindings/mmc/mmc.txt |  11 +
>  arch/arm/boot/dts/imx6qdl-cubox-i.dtsi        |  34 +-
>  arch/arm/boot/dts/imx6qdl-microsom.dtsi       |  98 ++++
>  drivers/mmc/core/core.c                       |  42 ++
>  drivers/mmc/core/host.c                       |  68 +++
>  drivers/mmc/core/sdio_irq.c                   |  41 +-
>  drivers/mmc/host/Kconfig                      |  63 +--
>  drivers/mmc/host/dw_mmc.c                     |   2 +
>  drivers/mmc/host/sdhci-acpi.c                 |   8 +
>  drivers/mmc/host/sdhci-bcm-kona.c             |   4 +
>  drivers/mmc/host/sdhci-bcm2835.c              |   4 +
>  drivers/mmc/host/sdhci-cns3xxx.c              |  13 +-
>  drivers/mmc/host/sdhci-dove.c                 |   4 +
>  drivers/mmc/host/sdhci-esdhc-imx.c            |  82 +--
>  drivers/mmc/host/sdhci-esdhc.h                |   4 +-
>  drivers/mmc/host/sdhci-of-arasan.c            |   4 +
>  drivers/mmc/host/sdhci-of-esdhc.c             |  70 ++-
>  drivers/mmc/host/sdhci-of-hlwd.c              |   4 +
>  drivers/mmc/host/sdhci-pci.c                  |   9 +-
>  drivers/mmc/host/sdhci-pltfm.c                |   4 +
>  drivers/mmc/host/sdhci-pxav2.c                |  14 +-
>  drivers/mmc/host/sdhci-pxav3.c                |  13 +-
>  drivers/mmc/host/sdhci-s3c.c                  |  36 +-
>  drivers/mmc/host/sdhci-sirf.c                 |   4 +
>  drivers/mmc/host/sdhci-spear.c                |   5 +-
>  drivers/mmc/host/sdhci-tegra.c                |  27 +-
>  drivers/mmc/host/sdhci.c                      | 728 +++++++++++++-------------
>  drivers/mmc/host/sdhci.h                      |  20 +-
>  include/linux/mmc/host.h                      |   8 +
>  include/linux/mmc/sdhci.h                     |  15 +-
>  30 files changed, 885 insertions(+), 554 deletions(-)
>
>
> --
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
> improving, and getting towards what was expected from it.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
