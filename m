From: broonie@kernel.org (Mark Brown)
Date: Thu, 20 Aug 2015 11:27:25 -0700
Subject: [PATCH v2 2/5] regmap: Fix regmap_bulk_write for bus writes
In-Reply-To: <1440061956-29064-3-git-send-email-mpa@pengutronix.de>
References: <1440061956-29064-1-git-send-email-mpa@pengutronix.de>
 <1440061956-29064-3-git-send-email-mpa@pengutronix.de>
Message-ID: <20150820182725.GJ12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 11:12:33AM +0200, Markus Pargmann wrote:

> +	} else if (map->use_single_rw) {
> +		/*
> +		 * We need to handle bus writes separate to support val_bytes
> +		 * that are not powers of 2.
> +		 */

This comment is really hard to understand - the condition block we're in
is nothing to do with the number of val_bytes and the comment is just
making a statement, there's no why in there.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150820/01c16aa5/attachment.sig>
