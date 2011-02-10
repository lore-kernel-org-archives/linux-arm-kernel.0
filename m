From: B20596@freescale.com (Li Frank-B20596)
Date: Thu, 10 Feb 2011 09:23:34 +0000
Subject: [PATCH 1/2] video: Add i.MX23/28 framebuffer driver
In-Reply-To: <1297257651-8002-2-git-send-email-s.hauer@pengutronix.de>
References: <1297257651-8002-1-git-send-email-s.hauer@pengutronix.de>
	<1297257651-8002-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <09EC74FE2C9E8444BF2FF67BD36E1D69167919@039-SN1MPN1-003.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +
> +	/* if it was disabled, re-enable the mode again */
> +	reg = readl(host->base + CTRL);
> +	reg |= CTRL_DOTCLK_MODE;
> +	writel(reg, host->base + CTRL);

writel(CTRL_DOTCLK_MODE, host->base + CTRL_SET)
CTRL_SET is CTRL+0x4
SET and CLR register is easier than Read and write back.
