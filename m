From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 14 Feb 2018 11:38:39 +0100
Subject: [PATCH] mmc: sdhci-iproc: Disable preset values for BCM2835
In-Reply-To: <1518465764-30051-1-git-send-email-stefan.wahren@i2se.com>
References: <1518465764-30051-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <CAPDyKFov+8-t1awEQqB+vJxkbVvDKNae=JVUoyZsO3uRj=YeOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 February 2018 at 21:02, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> According to the BCM2835 datasheet there are no preset value registers.
> This wasn't an issue before, because we didn't propagate 1.8V support.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-iproc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index 61666d2..0ef741b 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -214,6 +214,7 @@ static const struct sdhci_pltfm_data sdhci_bcm2835_pltfm_data = {
>                   SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
>                   SDHCI_QUIRK_MISSING_CAPS |
>                   SDHCI_QUIRK_NO_HISPD_BIT,
> +       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>         .ops = &sdhci_iproc_32only_ops,
>  };
>
> --
> 2.7.4
>
