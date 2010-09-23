From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Sep 2010 16:25:11 +0100
Subject: [PATCH v8 3/6] OMAP2430: hwmod data: Add watchdog timer
In-Reply-To: <1285252363-3630-4-git-send-email-charu@ti.com>
References: <1285252363-3630-1-git-send-email-charu@ti.com>
	<1285252363-3630-4-git-send-email-charu@ti.com>
Message-ID: <20100923152511.GA26295@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 23, 2010 at 08:02:40PM +0530, Varadarajan, Charulatha wrote:
> +static struct omap_hwmod omap2430_wd_timer2_hwmod = {
> +	.name		= "wd_timer2",
> +	.class		= &omap2430_wd_timer_hwmod_class,
> +	.main_clk	= "mpu_wdt_fck",

Why are we going backwards to naming clocks by source rather than
looking them up by device + connection ?
