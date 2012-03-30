From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 30 Mar 2012 06:34:56 +0200
Subject: [PATCH 03/17] ARM: mark const init data with __initconst
 instead of __initdata
In-Reply-To: <1333055554-31300-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20120329211131.GA31250@pengutronix.de>
 <1333055554-31300-3-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120330043456.GL7757@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23:12 Thu 29 Mar     , Uwe Kleine-K?nig wrote:
> As long as there is no other non-const variable marked __initdata in the
> same compilation unit it doesn't hurt. If there were one however
> compilation would fail with
> 
> 	error: $variablename causes a section type conflict
> 
> because a section containing const variables is marked read only and so
> cannot contain non-const variables.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Andrew Victor <linux@maxim.org.za>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Lennert Buytenhek <kernel@wantstofly.org>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Daniel Walker <dwalker@fifo99.com>
> Cc: Bryan Huntsman <bryanh@codeaurora.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Barry Song <baohua.song@csr.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: davinci-linux-open-source at linux.davincidsp.com
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: linux-arm-msm at vger.kernel.org
> Cc: linux-omap at vger.kernel.org
> ---
>  arch/arm/mach-at91/board-dt.c                 |    2 +-
>  arch/arm/mach-at91/clock.c                    |    2 +-
for at91
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
