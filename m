From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 1 Jul 2010 13:25:45 +0100
Subject: [PATCH 3/3] arm: s5pv210: GONI: add support for MAX8998 PMIC
In-Reply-To: <1277964466-23891-4-git-send-email-m.szyprowski@samsung.com>
References: <1277964466-23891-1-git-send-email-m.szyprowski@samsung.com>
	<1277964466-23891-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20100701122544.GB17698@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 01, 2010 at 08:07:46AM +0200, Marek Szyprowski wrote:

> +static struct regulator_consumer_supply goni_ldo3_consumers[] = {
> +	{	.supply	= "VMIPI_1.1V",	},
> +};

A similar issue to the previous patch applies here - you should be
defining consumers using struct device based lookups only.
