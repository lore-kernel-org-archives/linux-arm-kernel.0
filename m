From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 27 Oct 2014 14:38:49 +0100
Subject: [PATCH RESEND 02/12] mmc: sdhci-pxav3: Respect MMC_DDR52 timing
 on uhs signaling
In-Reply-To: <1413883364-681-3-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1413883364-681-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1413883364-681-3-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CAPDyKFqOf7JgYv23hqwf-fee5h+588qxPR7=-7ae61XLd+YYKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 October 2014 11:22, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:
> commit bb8175a8aa42d731a840cd474e348ac3367eb5a0
>   ("mmc: sdhci: clarify DDR timing mode between SD-UHS and eMMC")
> added MMC_DDR52 as eMMC's DDR mode to be distinguished from SD-UHS.
>
> While the differentation may be useful, pxav3 SDHCI controller lacks
> a corresponding check in its custom .set_uhs_signaling callback for
> MMC_DDR52. This patch adds a new switch case for MMC_TIMING_MMC_DDR52
> to MMC_TIMING_UHS_DDR50 case.
>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Thanks! Applied for next!

Kind regards
Uffe


> ---
> Cc: Chris Ball <chris@printf.net>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: "Antoine T?nart" <antoine.tenart@free-electrons.com>
> Cc: linux-mmc at vger.kernel.org
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/mmc/host/sdhci-pxav3.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index 5036d7d39529..b55c807982fe 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -211,6 +211,7 @@ static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
>         case MMC_TIMING_UHS_SDR104:
>                 ctrl_2 |= SDHCI_CTRL_UHS_SDR104 | SDHCI_CTRL_VDD_180;
>                 break;
> +       case MMC_TIMING_MMC_DDR52:
>         case MMC_TIMING_UHS_DDR50:
>                 ctrl_2 |= SDHCI_CTRL_UHS_DDR50 | SDHCI_CTRL_VDD_180;
>                 break;
> --
> 2.1.1
>
