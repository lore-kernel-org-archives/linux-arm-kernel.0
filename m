From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 8 Apr 2015 11:40:16 +0200
Subject: [PATCH v2 2/2] mmc: host: Add some quirks to be read from fdt in
 sdhci-pltm.c
In-Reply-To: <1427726768-17233-3-git-send-email-stripathi@apm.com>
References: <1427726768-17233-1-git-send-email-stripathi@apm.com>
 <1427726768-17233-3-git-send-email-stripathi@apm.com>
Message-ID: <CAPDyKFoc0V5BdKCO8v92Y1qHzEPgwxRdYR3cCj8nCyU-s25NuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 March 2015 at 16:46, Suman Tripathi <stripathi@apm.com> wrote:
> This patch adds some quirks support to be read from fdt.
>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
>  drivers/mmc/host/sdhci-pltfm.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index bef250e..9f6a4b9 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -85,6 +85,21 @@ void sdhci_get_of_property(struct platform_device *pdev)
>
>                 if (of_get_property(np, "broken-cd", NULL))
>                         host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> +
> +               if (of_get_property(np, "delay-after-power", NULL))
> +                       host->quirks |= SDHCI_QUIRK_DELAY_AFTER_POWER;
> +
> +               if (of_get_property(np, "no-hispd", NULL))
> +                       host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
> +
> +               if (of_get_property(np, "broken-adma", NULL))
> +                       host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
> +
> +               if (of_get_property(np, "broken-dma", NULL))
> +                       host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
> +
> +               if (of_get_property(np, "no-cmd23", NULL))
> +                       host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;

Can't at least some of these be distinguished from what sdhci variant
that is being used? Instead of having them in DT...

Kind regards
Uffe

>
>                 if (of_get_property(np, "no-1-8-v", NULL))
>                         host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
> --
> 1.8.2.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
