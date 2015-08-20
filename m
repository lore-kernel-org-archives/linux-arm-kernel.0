From: broonie@kernel.org (Mark Brown)
Date: Thu, 20 Aug 2015 11:30:03 -0700
Subject: [PATCH v2 4/5] regmap: regmap_raw_read return error on !bus->read
In-Reply-To: <1440061956-29064-5-git-send-email-mpa@pengutronix.de>
References: <1440061956-29064-1-git-send-email-mpa@pengutronix.de>
 <1440061956-29064-5-git-send-email-mpa@pengutronix.de>
Message-ID: <20150820183003.GL12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 11:12:35AM +0200, Markus Pargmann wrote:
> Return -ENOTSUPP if map->bus->read is not implemented and we do not use
> the cache. This code path would directly use bus->read would run into an
> NULL pointer for the read function.

Please put fixes like this before coding style changes like patch 3.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150820/e1056c60/attachment.sig>
