From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 13 Feb 2011 17:10:32 +0100
Subject: [PATCH 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
In-Reply-To: <20110213235207.GA10397@S2100-06.ap.freescale.net>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com>
	<201102131634.40468.arnd@arndb.de>
	<20110213235207.GA10397@S2100-06.ap.freescale.net>
Message-ID: <201102131710.33041.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 February 2011 00:52:08 Shawn Guo wrote:
> I rewriting the code to use mmc core card detect polling framework.
> 
> static int mxs_mmc_get_cd(struct mmc_host *mmc)
> {
>         struct mxs_mmc_host *host = mmc_priv(mmc);
> 
>         return !(readl(host->base + HW_SSP_STATUS) &
>                         BM_SSP_STATUS_CARD_DETECT);
> }
> 
> static const struct mmc_host_ops mxs_mmc_ops = {
>         ...
>         .get_cd = mxs_mmc_get_cd,
> };
> 
> static int mxs_mmc_probe(struct platform_device *pdev)
> {
>         ...
>         mmc_caps |= MMC_CAP_NEEDS_POLL;
>         ...
> }
> 
> It looks pretty simple and mmc core code has taken care of the case
> of power management.  So if this looks fine to you, I will go for it
> in v2 of the patch set.

Yes, that looks very good.

	Arnd
