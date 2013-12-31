From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 31 Dec 2013 13:24:38 +0800
Subject: [PATCH V2 1/2] mmc: sdhci-esdhc-imx: fix access hardirq-unsafe
 lock in atomic context
In-Reply-To: <1388042634-17281-1-git-send-email-b29396@freescale.com>
References: <1388042634-17281-1-git-send-email-b29396@freescale.com>
Message-ID: <20131231052436.GA22122@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 26, 2013 at 03:23:53PM +0800, Dong Aisheng wrote:
> Sometimes we may meet the following lockdep issue.
> The root cause is .set_clock callback is executed with spin_lock_irqsave
> in sdhci_do_set_ios. However, the IMX set_clock callback will try to access
> clk_get_rate which is using a mutex lock.
> 
> The fix avoids access mutex in .set_clock callback by initializing the
> pltfm_host->clock at probe time and use it later instead of calling
> clk_get_rate again in atomic context.

<snip>

> Cc: Chris Ball <cjb@laptop.org>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>

For both,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> Fixes: 0ddf03c mmc: esdhc-imx: parse max-frequency from devicetree
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
