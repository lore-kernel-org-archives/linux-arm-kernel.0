From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 10 Sep 2010 10:41:04 +0100
Subject: [PATCH 6/6] ARM: S5PC110: add support for MMC regulators on
	Goni board
In-Reply-To: <1284103403-10696-7-git-send-email-m.szyprowski@samsung.com>
References: <1284103403-10696-1-git-send-email-m.szyprowski@samsung.com>
	<1284103403-10696-7-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20100910094104.GC3068@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 10, 2010 at 09:23:23AM +0200, Marek Szyprowski wrote:

> +static struct regulator_consumer_supply goni_ldo5_consumers[] = {
> +	{ .supply = "vmmc",	.dev = &s3c_device_hsmmc0.dev },
> +};
> +

This is OK but it is better to use dev_name rather than dev - dev may
be removed at some point since given dev you can always use dev_name but
you don't always have dev.

Acked-by: Mark Brown <broonie@opoensource.wolfsonmicro.com>
