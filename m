From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 3 Feb 2016 11:48:17 -0600
Subject: [PATCH v10 4/5] Watchdog: introduce ARM SBSA watchdog driver
In-Reply-To: <1454519923-25230-5-git-send-email-fu.wei@linaro.org>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
 <1454519923-25230-5-git-send-email-fu.wei@linaro.org>
Message-ID: <56B23D61.2050001@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fu.wei at linaro.org wrote:
> +static struct platform_driver sbsa_gwdt_driver = {
> +	.driver = {
> +		.name = "sbsa-gwdt",
> +		.pm = &sbsa_gwdt_pm_ops,
> +		.of_match_table = sbsa_gwdt_of_match,
> +	},
> +	.probe = sbsa_gwdt_probe,
> +	.remove = sbsa_gwdt_remove,
> +	.shutdown = sbsa_gwdt_shutdown,
> +	.id_table = sbsa_gwdt_pdev_match,
> +};

I just noticed you dropped ACPI support.  Server platforms are supposed 
to use ACPI, so that seems like a critical omission to me.  You had a 
GTDT parser in an older version of this patch.  What happened to it?
