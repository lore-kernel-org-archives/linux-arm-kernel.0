From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Aug 2015 12:51:36 +0100
Subject: [PATCH 13/20] regmap: regmap max_raw_io getter function
In-Reply-To: <1439374365-20623-14-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-14-git-send-email-mpa@pengutronix.de>
Message-ID: <20150812115136.GA10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 12:12:38PM +0200, Markus Pargmann wrote:
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Your changelog doesn't mention why anything would reasonably want to use
this and...

> +size_t regmap_get_raw_io_max(struct regmap *map)
> +{
> +	return map->max_raw_io;
> +}
> +EXPORT_SYMBOL_GPL(regmap_get_raw_io_max);
> +
> +/**
> + * regmap_get_raw_read_max - Get the maximum size we can read
> + *
> + * @map: Map to check.
> + */

...it is adding two functions which don't seem very symmetrically named.

> @@ -441,6 +441,8 @@ int regmap_get_max_register(struct regmap *map);
>  int regmap_get_reg_stride(struct regmap *map);
>  int regmap_async_complete(struct regmap *map);
>  bool regmap_can_raw_write(struct regmap *map);
> +size_t regmap_get_raw_write_max(struct regmap *map);
> +size_t regmap_get_raw_io_max(struct regmap *map);

Do we want stubs here?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/0fc84067/attachment.sig>
