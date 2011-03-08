From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 8 Mar 2011 11:47:31 +0000
Subject: [PATCH 3/3] mach-ux500: configure board for the TPS61052 regulator
In-Reply-To: <1299577444-31480-1-git-send-email-linus.walleij@stericsson.com>
References: <1299577444-31480-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110308114731.GA20944@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 08, 2011 at 10:44:04AM +0100, Linus Walleij wrote:

> +struct regulator_init_data tps61052_regulator = {
> +	.constraints = {
> +		.name = "vaudio-hf",
> +		.min_uV = 4500000,
> +		.max_uV = 4500000,
> +		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
> +		REGULATOR_CHANGE_STATUS,

You've got _CHANGE_VOLTAGE here but only one voltage is possible.
