From: eddie.huang@mediatek.com (Eddie Huang)
Date: Mon, 15 Dec 2014 11:37:31 +0800
Subject: [PATCH v2 1/2] watchdog: Add driver for Mediatek watchdog
In-Reply-To: <1418395859-32209-2-git-send-email-matthias.bgg@gmail.com>
References: <1418395859-32209-1-git-send-email-matthias.bgg@gmail.com>
 <1418395859-32209-2-git-send-email-matthias.bgg@gmail.com>
Message-ID: <1418614651.18671.3.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 2014-12-12 at 15:50 +0100, Matthias Brugger wrote:
> This patch adds a driver for the Mediatek SoC integrated
> watchdog. This driver supports watchdog and software reset
> for mt65xx and mt81xx SoCs.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

> +static int mtk_reset_handler(struct notifier_block *this, unsigned long mode,
> +				void *cmd)
> +{
> +	struct mtk_wdt_dev *mtk_wdt = container_of(this,
> +						       struct mtk_wdt_dev,
> +						       restart_handler);
> +	void __iomem *wdt_base = mtk_wdt->wdt_base;
> +	u32 reg;
> +
> +	/* Reset system */
> +	writel(WDT_SWRST_KEY, wdt_base + WDT_SWRST);
> +
> +	while (1) {
> +		mdelay(5);
> +		writel(WDT_SWRST_KEY, wdt_base + WDT_SWRST);
> +	}
> +	return NOTIFY_DONE;
> +
> +}

Build warning
../drivers/watchdog/mtk_wdt.c:78:6: warning: unused variable
'reg' [-Wunused-variable]
