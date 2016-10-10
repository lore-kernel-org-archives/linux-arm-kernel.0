From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 10 Oct 2016 14:37:48 +0200
Subject: [PATCH -next] mmc: sdhci-of-arasan: Fix non static symbol warning
In-Reply-To: <1474818243-19207-1-git-send-email-weiyj.lk@gmail.com>
References: <1474818243-19207-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <CAPDyKFoGM7+pzSHCTVYfi1S1uo3DRauXLhY5ZQ8gDmeBBQV47A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 September 2016 at 17:44, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
>
> Fixes the following sparse warning:
>
> drivers/mmc/host/sdhci-of-arasan.c:253:6: warning:
>  symbol 'sdhci_arasan_reset' was not declared. Should it be static?
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index da8e40a..e263671 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -250,7 +250,7 @@ static void sdhci_arasan_hs400_enhanced_strobe(struct mmc_host *mmc,
>         writel(vendor, host->ioaddr + SDHCI_ARASAN_VENDOR_REGISTER);
>  }
>
> -void sdhci_arasan_reset(struct sdhci_host *host, u8 mask)
> +static void sdhci_arasan_reset(struct sdhci_host *host, u8 mask)
>  {
>         u8 ctrl;
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>
>
>
