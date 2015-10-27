From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 27 Oct 2015 10:54:04 +0100
Subject: [PATCH v3 00/10] Add tune support of Mediatek MMC driver
In-Reply-To: <1445927070-5102-1-git-send-email-chaotian.jing@mediatek.com>
References: <1445927070-5102-1-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <CAPDyKFprx7UcZ6OypGZfEC_nLOd02bAFMdmxrOcig0ANVKGRwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 October 2015 at 07:24, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> Change in v3:
> Fix checkpatch errors and warnings for patch 8
> Split patch 9, make DT parts enabling hw reset separately
>
> Change in v2:
> Drop the 400mhz and use assigned-clock-parents to instead
> Split the original tune patch to several independent patches
> Re-write the mmc_send_tuning()
> Fix GPD checksum error
> Move the HS400 setting to ops->prepare_hs400_tuning()
> Modify SD driving settings
>
> Change in v1:
> Add DT bindings for eMMC hardware reset
> Add pinctrl of data strobe pin for HS400 mode
> Modify eMMC driving settings
> Add 400mhz source clock for HS400 mode
> Add eMMC HS200/HS400 mode support
> Add SD SDR50/SDR104 mode support
> Add implement of tune function with CMD19/CMD21
>
> Chaotian Jing (10):
>   mmc: core: Add DT bindings for eMMC hardware reset support
>   mmc: dt-bindings: update Mediatek MMC bindings
>   mmc: mediatek: make cmd_ints_mask to const
>   mmc: mediatek: change the argument "ddr" to "timing"
>   mmc: mediatek: fix got GPD checksum error interrupt when data transfer
>   mmc: mediatek: add implement of ops->hw_reset()
>   arm64: dts: mediatek: add eMMC hw reset support
>   mmc: mmc: extend the mmc_send_tuning()
>   mmc: mediatek: add HS400 support
>   arm64: dts: mediatek: add HS200/HS400/SDR50/SDR104 support
>
>  Documentation/devicetree/bindings/mmc/mmc.txt    |   1 +
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt |  11 +-
>  arch/arm64/boot/dts/mediatek/mt8173-evb.dts      |  27 +-
>  drivers/mmc/core/host.c                          |   2 +
>  drivers/mmc/core/mmc_ops.c                       |   8 +-
>  drivers/mmc/host/dw_mmc-exynos.c                 |   4 +-
>  drivers/mmc/host/dw_mmc.c                        |   2 +-
>  drivers/mmc/host/dw_mmc.h                        |   2 +-
>  drivers/mmc/host/mtk-sd.c                        | 304 ++++++++++++++++++++---
>  drivers/mmc/host/sdhci-esdhc-imx.c               |   6 +-
>  drivers/mmc/host/sdhci-msm.c                     |   2 +-
>  drivers/mmc/host/sdhci-sirf.c                    |   2 +-
>  include/linux/mmc/core.h                         |   2 +-
>  13 files changed, 322 insertions(+), 51 deletions(-)
>
> --
> 1.8.1.1.dirty
>

Chaotian,

I have applied this except the ARM patches (patch7 and patch10) as I
think those should go via ARM SoC (unless I get acks for them).

Regarding patch8, it didn't apply since it needed a re-base. This time
it was trivial to fix, so I decided to pick it up anyway.

Future wise I also advise you to significantly trim the cc/to list
when posting patches. Likely what happens when that many people are
requested for input, is that *none* cares. :-)

Thanks and kind regards!
Uffe
