From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 13 Jul 2010 21:38:52 +0100
Subject: [PATCH v2 2/2] ux500: add ab8500-regulators machine specific data
In-Reply-To: <20100713161343.GA25342@bnru01.bnr.st.com>
References: <1279030173-3086-1-git-send-email-sundar.iyer@stericsson.com>
	<1279030173-3086-2-git-send-email-sundar.iyer@stericsson.com>
	<20100713141828.GB24260@rakim.wolfsonmicro.main>
	<33A307AF30D7BF4F811B1568FE7A9B1810E7E88D@EXDCVYMBSTM006.EQ1STM.local>
	<20100713145645.GA24626@rakim.wolfsonmicro.main>
	<20100713150814.GA13767@bnru01.bnr.st.com>
	<20100713150905.GD24626@rakim.wolfsonmicro.main>
	<20100713161343.GA25342@bnru01.bnr.st.com>
Message-ID: <20100713203852.GA1756@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 13, 2010 at 09:43:44PM +0530, Sundar R IYER wrote:

> Subject: [PATCH v3 2/2] ux500: add ab8500-regulators machine specific data

> Acked-by: Linus Walleij <linus.walleij@stericsson.com>
> Acked-by: Bengt JONSSON <bengt.g.jonsson@stericsson.com>
> Signed-off-by: Sundar R Iyer <sundar.iyer@stericsson.com>

> +static struct regulator_consumer_supply ab8500_vaux1_consumers[] = {
> +};

You may as well just remove these if they're not used but still...

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

One other thing...

> +struct regulator_init_data ab8500_vaudio_init = {
> +	.supply_regulator_dev = NULL,
> +	.constraints = {
> +		.name = "ab8500-vaudio",
> +		.min_uV = 1925000,
> +		.max_uV = 2075000,

Are you *sure* that all these constraints are accurate for the board?
It seems every single voltage is variable even though there are no
consumers set up, and they can all be disabled too.
