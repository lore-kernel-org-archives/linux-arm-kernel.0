From: broonie@kernel.org (Mark Brown)
Date: Fri, 18 Apr 2014 16:10:56 +0100
Subject: [PATCH v2 2/2] regmap: i2c: fallback to SMBus if the adapter
 does not support standard I2C
In-Reply-To: <1397727612-32103-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1397727612-32103-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397727612-32103-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140418151056.GY12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 11:40:12AM +0200, Boris BREZILLON wrote:

> +const struct regmap_bus *regmap_get_i2c_bus(struct i2c_client *i2c,
> +					    const struct regmap_config *config)

Non-exported functions should be static.  Otherwise this looks good
modulo the register size issue that Guenter identified.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140418/196e6243/attachment.sig>
