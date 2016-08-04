From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Aug 2016 16:48:14 +0100
Subject: [PATCH 1/2] regmap: Add a function to check if a regmap register
 is cached
In-Reply-To: <1470322558-7501-2-git-send-email-cristian.birsan@microchip.com>
References: <1470322558-7501-1-git-send-email-cristian.birsan@microchip.com>
 <1470322558-7501-2-git-send-email-cristian.birsan@microchip.com>
Message-ID: <20160804154814.GA10383@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2016 at 05:55:57PM +0300, Cristian Birsan wrote:

> +bool regmap_cached(struct regmap *map, unsigned int reg)
> +{
> +	if (map->cache == REGCACHE_NONE)
> +		return false;
> +
> +	if (!map->cache_ops)
> +		return false;
> +
> +	if (map->max_register && reg > map->max_register)
> +		return false;
> +
> +	return true;
> +}

As Lars said this isn't actually checking if the register is cached.  To
do this you need to modify the output code to check if there's a value
cached and try a read if there is one instead.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160804/c7df4d0f/attachment.sig>
