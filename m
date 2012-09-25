From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 25 Sep 2012 18:52:55 +0100
Subject: [PATCHv2 1/4] mfd: smsc: Add support for smsc gpio io/keypad
 driver
In-Reply-To: <1346844964-24839-1-git-send-email-sourav.poddar@ti.com>
References: <1346844964-24839-1-git-send-email-sourav.poddar@ti.com>
Message-ID: <20120925175255.GA13823@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2012 at 05:06:04PM +0530, Sourav Poddar wrote:

> +static struct regmap_config smsc_regmap_config = {
> +		.reg_bits = 8,
> +		.val_bits = 8,
> +		.max_register = SMSC_MAX_REGISTER - 1;
> +		.cache_type = REGCACHE_COMPRESSED,
> +};

That definition of max_register looks wrong - why are we subtracting 1
from a macro called MAX_REGISTER to get it?

Indentation here is a bit odd too.

> +static int smsc_i2c_remove(struct i2c_client *i2c)
> +{
> +	return 0;
> +}

Remove empty functions.
