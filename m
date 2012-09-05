From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 5 Sep 2012 12:03:19 +0800
Subject: [PATCH v3 2/4] misc: Generic on-chip SRAM allocation driver
In-Reply-To: <1346688128-22395-3-git-send-email-p.zabel@pengutronix.de>
References: <1346688128-22395-1-git-send-email-p.zabel@pengutronix.de>
 <1346688128-22395-3-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20120905040317.GX2362@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 03, 2012 at 06:02:06PM +0200, Philipp Zabel wrote:
> +static struct platform_driver sram_driver = {
> +	.driver = {
> +		.name = "sram",
> +		.of_match_table = of_match_ptr(sram_dt_ids),
> +	},
> +	.probe = sram_probe,
> +	.remove = __devexit_p(sram_remove),
> +};
> +
> +module_platform_driver(sram_driver);

I think we'd better make it a postcore_initcall time driver, so that
it can be ensured that when the client drivers call gen_pool_* API
the pool has been created by sram_driver. 

-- 
Regards,
Shawn
