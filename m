From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 26 Mar 2012 15:47:12 +0100
Subject: [PATCH v1] regulator: i.MX35-PDK Add regulator support
In-Reply-To: <1332772593-13313-1-git-send-email-alexg@meprolight.com>
References: <1332772593-13313-1-git-send-email-alexg@meprolight.com>
Message-ID: <20120326144712.GA8579@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 26, 2012 at 04:36:33PM +0200, Alex Gershgorin wrote:

> +static struct regulator_init_data sw1_init = {
> +	.constraints = {
> +		.name = "SW1",
> +		.min_uV = 600000,
> +		.max_uV = 1375000,
> +		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
> +		.valid_modes_mask = 0,
> +		.always_on = 1,
> +		.boot_on = 1,
> +	}
> +};

These constraints don't make sense, you've got a voltage range and the
ability to change voltages but no consumers so nothing that could ever
change the voltage...

> +static struct regulator_init_data vpll_init = {
> +	.constraints = {
> +		.name = "VPLL",
> +		.min_uV = 1050000,
> +		.max_uV = 1800000,
> +		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
> +		.boot_on = 1,
> +	}
> +};

...and in many cases the supply names don't look like things I'd expect
to be varying too much at runtime.  It looks like you just typed the
maximum datasheet ranges in, not things that make sense for the board.
