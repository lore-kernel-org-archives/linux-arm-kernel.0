From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 2 Sep 2009 19:42:35 +0100
Subject: [PATCH 2/2] U300 AB3100 boardinfo v3
In-Reply-To: <1251756324-24216-1-git-send-email-linus.walleij@stericsson.com>
References: <1251756324-24216-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20090902184234.GB10581@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 01, 2009 at 12:05:24AM +0200, Linus Walleij wrote:
> This defines regulator platform data and board power
> regulator hogs for the ST-Ericsson U300 platform.

This is pretty much OK, just...

> +static struct regulator_consumer_supply supply_ldo_a[] = {
> +	{
> +		.dev = NULL,
> +		.supply = "vrad", /* Powers the radio */
> +	},
> +};

Now you're using the regulator init stuff to set the voltages you should
be able to drop most of the deviceless supplies.  I'd expect that you'd
want to keep the CPU core supplies for cpufreq support but the others
shouldn't need to be defined.  The names can be set in the constraints
- if set there they will be displayed to user space which normally makes
the diagnostics easier to follow for board users.
