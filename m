From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 21 Feb 2011 11:04:39 +0100
Subject: [PATCH 5/5] mmc: sdhci: add quirk
	SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO
In-Reply-To: <1298282095-2279-5-git-send-email-richard.zhao@freescale.com>
References: <1298282095-2279-1-git-send-email-richard.zhao@freescale.com>
	<1298282095-2279-5-git-send-email-richard.zhao@freescale.com>
Message-ID: <20110221100439.GE2616@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 21, 2011 at 05:54:55PM +0800, Richard Zhao wrote:
> Fix no INT in MULTI-BLK IO.
> 
> Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 9b82910..2eeb03e 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -113,7 +113,10 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
>  	clk_enable(clk);
>  	pltfm_host->clk = clk;
>  
> -	if (cpu_is_mx35() || cpu_is_mx51())
> +	if (cpu_is_mx53())
> +		host->quirks |= SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO;

Have you tried it doing it via IO-accessors?

> +	if (cpu_is_mx35() || cpu_is_mx51() || cpu_is_mx53())

Maybe we should use !cpu_is_mx25 for simplicity?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110221/41168972/attachment.sig>
