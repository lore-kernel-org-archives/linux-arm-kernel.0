From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 Sep 2011 17:59:04 -0700
Subject: [PATCH v3 2/3] ARM: gic: consolidate PPI handling
In-Reply-To: <1316793788-14500-3-git-send-email-marc.zyngier@arm.com>
References: <1316793788-14500-1-git-send-email-marc.zyngier@arm.com>
	<1316793788-14500-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20110928005904.GR6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marc Zyngier <marc.zyngier@arm.com> [110923 12:03]:
> PPI handling is a bit of an odd beast. It uses its own low level
> handling code and is hardwired to the local timers (hence lacking
> a registration interface).
> 
> Instead, switch the low handling to the normal SPI handling code.
> PPIs are handled by the handle_percpu_devid_irq flow.
> 
> This also allows the removal of some duplicated code.
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Bryan Huntsman <bryanh@codeaurora.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

For the omap changes:

Tested-by: Tony Lindgren <tony@atomide.com>

(Sorry had to dig this one from the archive, looks like
the Cc addresses might be left out)
