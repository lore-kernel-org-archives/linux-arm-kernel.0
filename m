From: adrian.hunter@intel.com (Adrian Hunter)
Date: Wed, 22 Mar 2017 16:48:43 +0200
Subject: [PATCH v6 04/14] mmc: sdhci: Export sdhci_set_ios() from sdhci.c
In-Reply-To: <b95bc01da68874afbf85968d6181c60508fc56ff.1487091464.git-series.gregory.clement@free-electrons.com>
References: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
 <b95bc01da68874afbf85968d6181c60508fc56ff.1487091464.git-series.gregory.clement@free-electrons.com>
Message-ID: <05648b8f-26e8-8af7-5544-6e8ef1df7c43@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/02/17 19:01, Gregory CLEMENT wrote:
> From: Hu Ziji <huziji@marvell.com>
> 
> Export sdhci_set_ios() in sdhci.c.
> Thus vendor sdhci driver can implement its own set_ios() routine.
> 
> Signed-off-by: Hu Ziji <huziji@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 3 ++-
>  drivers/mmc/host/sdhci.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 23909804ffb8..0e9ed0fadff9 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1570,7 +1570,7 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_set_uhs_signaling);
>  
> -static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
>  	unsigned long flags;
> @@ -1730,6 +1730,7 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	mmiowb();
>  	spin_unlock_irqrestore(&host->lock, flags);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_set_ios);
>  
>  static int sdhci_get_cd(struct mmc_host *mmc)
>  {
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0b66f210ae82..3563c0c384ca 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -691,6 +691,7 @@ void sdhci_set_bus_width(struct sdhci_host *host, int width);
>  void sdhci_reset(struct sdhci_host *host, u8 mask);
>  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
>  int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
> +void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
>  
>  #ifdef CONFIG_PM
>  extern int sdhci_suspend_host(struct sdhci_host *host);
> 
