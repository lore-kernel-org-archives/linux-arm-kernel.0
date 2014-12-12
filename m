From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 12 Dec 2014 11:15:39 +0100
Subject: [PATCH] arm: imx: create temporary irq_desc of #32 irq for GPC
 operation
In-Reply-To: <1418363138-19805-1-git-send-email-b20788@freescale.com>
References: <1418363138-19805-1-git-send-email-b20788@freescale.com>
Message-ID: <1418379339.3172.6.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

Am Freitag, den 12.12.2014, 13:45 +0800 schrieb Anson Huang:
> The irq_get_irq_data may return NULL if irq_data is NOT ready,
> it is fine for now because imx6q_set_lpm is called after all
> irq_data is ready. But in linux-next branch where irq descriptor
> alloc is moved to behind the imx6q_set_lpm called by
> (9a1091e irqchip: gic: Support hierarchy irq domain), below crash
> occurs, as all we need is a irq number passed to GPC module, rather
> than making sure irq_data is ready before imx6q_set_lpm is called,
> let's create a temporary variable of irq_desc for GPC to unmask/mask the
> irq #32 we want, then below issue fixed.

This is already fixed in
e2fd06f6be69 ("ARM: imx: irq: fix buggy usage of irq_data irq field")
65bb688aab94 ("ARM: imx6: fix bogus use of irq_get_irq_data")

regards
Philipp
