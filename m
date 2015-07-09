From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 9 Jul 2015 15:38:35 +0800
Subject: [PATCH 4/6] mmc: sdhci-esdhc-imx: remove duplicated dts parsing
In-Reply-To: <1434564337-24720-5-git-send-email-aisheng.dong@freescale.com>
References: <1434564337-24720-1-git-send-email-aisheng.dong@freescale.com>
 <1434564337-24720-5-git-send-email-aisheng.dong@freescale.com>
Message-ID: <20150709073835.GC23464@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 02:05:35AM +0800, Dong Aisheng wrote:
> After commit 8d86e4fcccf6 ("mmc: sdhci-esdhc-imx: Call mmc_of_parse()"),
> we do not need those duplicated parsing anymore.
> 
> Note: fsl,cd-controller is also deleted due to the driver does
> not support controller card detection anymore after switch to runtime pm.
> And there's no user of it right now in device tree.
> 
> wp-gpios is kept because we're still support fsl,wp-controller,
> so we need a way to check if it's gpio wp or controller wp.

I do not remember the reason why controller based CD stops working after
we switch to runtime PM.  But if CD stops working for some reason,
shouldn't controller based WP stop working for the same reason?

Shawn

> 
> Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
