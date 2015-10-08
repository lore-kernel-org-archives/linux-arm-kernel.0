From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 8 Oct 2015 19:35:46 +0200
Subject: [PATCH 1/8] mmc: sdhci-pxav3: remove broken clock base quirk for
 Armada 38x sdhci driver
In-Reply-To: <1444094562-31165-2-git-send-email-mw@semihalf.com>
References: <1444094562-31165-1-git-send-email-mw@semihalf.com>
 <1444094562-31165-2-git-send-email-mw@semihalf.com>
Message-ID: <CAPDyKFrdZPbmK1Gtw8f-uKeYGbZLdfTtsCnLPUPC1XFa8Xmb1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 October 2015 at 03:22, Marcin Wojtas <mw@semihalf.com> wrote:
> From: Nadav Haklai <nadavh@marvell.com>
>
> shci-pxav3 driver is enabling by default the
> SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN quirk. However this quirk is not
> required for Armada 38x and leads to wrong clock setting in the divider.
>
> Signed-off-by: Nadav Haklai <nadavh@marvell.com>
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> Cc: <stable@vger.kernel.org> # v4.2

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pxav3.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index 946d37f..976cddd 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -135,6 +135,7 @@ static int armada_38x_quirks(struct platform_device *pdev,
>         struct sdhci_pxa *pxa = pltfm_host->priv;
>         struct resource *res;
>
> +       host->quirks &= ~SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;
>         host->quirks |= SDHCI_QUIRK_MISSING_CAPS;
>         res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>                                            "conf-sdio3");
> --
> 1.8.3.1
>
