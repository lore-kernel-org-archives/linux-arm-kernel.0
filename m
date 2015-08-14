From: broonie@kernel.org (Mark Brown)
Date: Fri, 14 Aug 2015 17:36:25 +0100
Subject: [PATCH 14/20] regmap: Add raw_write/read checks for
 max_raw_write/read sizes
In-Reply-To: <20150812124706.GI19600@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-15-git-send-email-mpa@pengutronix.de>
 <20150812115759.GB10748@sirena.org.uk>
 <20150812124706.GI19600@pengutronix.de>
Message-ID: <20150814163625.GY10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 02:47:06PM +0200, Markus Pargmann wrote:
> On Wed, Aug 12, 2015 at 12:57:59PM +0100, Mark Brown wrote:
> > On Wed, Aug 12, 2015 at 12:12:39PM +0200, Markus Pargmann wrote:

> > > Check in regmap_raw_read() and regmap_raw_write() for correct maximum
> > > sizes of the operations. Return -E2BIG if this size is not supported
> > > because it is too big.

> > Why not just split the transaction up like your other changes did?

> My intention was to keep these raw functions as close to the actual
> hardware as possible also reporting proper error values. For
> transactions that are split up you could still use the bulk functions.

That's not what we do otherwise, and not what you yourself have done for
some of the other changes in the series like those around multi write.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150814/d9f822a2/attachment.sig>
