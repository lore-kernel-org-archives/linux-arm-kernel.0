From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 17 Mar 2017 08:51:27 +0100
Subject: [PATCH v4 0/7] mmc: bcm2835: Add new driver for the sdhost
 controller
In-Reply-To: <1488964751-22763-1-git-send-email-kraxel@redhat.com>
References: <1488964751-22763-1-git-send-email-kraxel@redhat.com>
Message-ID: <CAPDyKFoLLJnJW-rSQ9QigxM14pa7WWPd9XcwQ2J=H1cbxHXqCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 March 2017 at 10:19, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> Next version if the bcm2835 sdhost patch series.
>
> New in v4:
>  * squashed in more cleanups by Stefan.
>  * removed the long cleanup patch list
>    from commit message (patch 2).
>  * rebased to (and tested with) 4.11-rc1.
>  * minor fixes pointed out in review.
>
> New in v3:
>  * squashed in cleanups by Stefan.
>  * use one dma channel only.
>  * improve commit messages.
>
> New in v2:
>  * DMA fixed.
>  * updated docs (kconfig, file comment, commit message) clarifying
>    the two sd controller situation.
>  * some code cleanups, as pointed out by Stefan.
>  * dt bindings use mmc at ... now.
>  * added patches to update defconfigs.
>  * added patch for rpi3 device tree, so wifi is actually enabled.
>
> please review & test,
>   Gerd
>
> Eric Anholt (2):
>   dt-bindings: Add binding for brcm,bcm2835-sdhost.
>   mmc: bcm2835: Add new driver for the sdhost controller.
>
> Gerd Hoffmann (5):
>   mmc: bcm2835: add sdhost controller to devicetree
>   arm: set CONFIG_MMC_BCM2835=y in bcm2835_defconfig and
>     multi_v7_defconfig
>   arm64: set CONFIG_MMC_BCM2835=y in defconfig
>   arm: dts: bcm283x: switch from &sdhci to &sdhost
>   arm64: dts: bcm2837: add &sdhci and &sdhost
>
>  .../bindings/mmc/brcm,bcm2835-sdhost.txt           |   23 +
>  arch/arm/boot/dts/bcm2835-rpi.dtsi                 |    6 +
>  arch/arm/boot/dts/bcm283x.dtsi                     |   10 +
>  arch/arm/configs/bcm2835_defconfig                 |    1 +
>  arch/arm/configs/multi_v7_defconfig                |    1 +
>  arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts   |   17 +
>  arch/arm64/configs/defconfig                       |    1 +
>  drivers/mmc/host/Kconfig                           |   14 +
>  drivers/mmc/host/Makefile                          |    1 +
>  drivers/mmc/host/bcm2835.c                         | 1465 ++++++++++++++++++++
>  10 files changed, 1539 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt
>  create mode 100644 drivers/mmc/host/bcm2835.c
>
> --
> 1.8.3.1
>

Thanks, applied patch1 and patch2 from the series.

Kind regards
Uffe
