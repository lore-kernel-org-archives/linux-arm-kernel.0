From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Aug 2015 12:59:37 +0100
Subject: [PATCH 15/20] regmap-i2c: Add smbus i2c block support
In-Reply-To: <1439374365-20623-16-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-16-git-send-email-mpa@pengutronix.de>
Message-ID: <20150812115936.GC10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 12:12:40PM +0200, Markus Pargmann wrote:

> +	if (count < 1 || count >= I2C_SMBUS_BLOCK_MAX)
> +		return -EINVAL;

Elsewhere you added returns of -E2BIG if the transfer was too big, why
not do that here as well?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/ccefdfa7/attachment.sig>
