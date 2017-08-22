From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 22 Aug 2017 11:40:52 +0200
Subject: [PATCH 0/5] mmc: sdhci-msm: Corrections to implementation of
 power irq
In-Reply-To: <1503033582-48703-1-git-send-email-vviswana@codeaurora.org>
References: <1503033582-48703-1-git-send-email-vviswana@codeaurora.org>
Message-ID: <CAPDyKFqFAbkwXyvfHOTRoe6J8EHirJFUYwR6TGq9BBRDq2Xfpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 August 2017 at 07:19, Vijay Viswanath <vviswana@codeaurora.org> wrote:
> Register writes which change voltage of IO lines or turn the IO bus on/off
> require sdhc controller to be ready before progressing further. Once a
> register write which affects IO lines is done, the driver should wait for
> power irq from controller. Once the irq comes, the driver should acknowledge
> the irq by writing to power control register. If the acknowledgement is not
> given to controller, the controller may not complete the corresponding
> register write action and this can mess up the controller if drivers proceeds
> without power irq completing.
>
> Sahitya Tummala (2):
>   mmc: sdhci-msm: Fix HW issue with power IRQ handling during reset
>   mmc: sdhci-msm: Add support to wait for power irq
>
> Subhash Jadavani (1):
>   mmc: sdhci-msm: fix issue with power irq
>
> Vijay Viswanath (2):
>   mmc: sdhci-msm: Add ops to do sdhc register write
>   defconfig: msm: Enable CONFIG_MMC_SDHCI_IO_ACCESSORS
>
>  arch/arm64/configs/defconfig |   1 +
>  drivers/mmc/host/sdhci-msm.c | 233 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 229 insertions(+), 5 deletions(-)
>
> --
>  Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
>

Looks good to me, besides patch 5 which I provided comments for.

Unless Adrian objects, I intend to queue this within the next couple of days.

Kind regards
Uffe
