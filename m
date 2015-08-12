From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 12 Aug 2015 14:38:44 +0200
Subject: [PATCH 12/20] regmap: Introduce max_raw_io for
 regmap_bulk_read/write
In-Reply-To: <20150812114931.GZ10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-13-git-send-email-mpa@pengutronix.de>
 <20150812114931.GZ10748@sirena.org.uk>
Message-ID: <20150812123844.GH19600@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 12:49:31PM +0100, Mark Brown wrote:
> On Wed, Aug 12, 2015 at 12:12:37PM +0200, Markus Pargmann wrote:
> 
> > +	/* if set, raw reads/writes are limited to this size */
> > +	size_t max_raw_io;
> > +
> 
> Do this separately for read and write, there's doubtless going to be
> something that has asymmetry.

Okay.

> 
> > +		if (!map->use_single_rw) {
> > +			write_count = total_bytes / map->max_raw_io;
> > +			write_bytes = map->max_raw_io;
> 
> We may not be able to fit a whole number of values into whatever the
> constraint that the bus has is and partial values don't seem like a good
> idea.

Oh right. Will change the calculation so that there are no partial
values being written.

> 
> > +			reg_stride *= write_bytes / val_bytes;
> > +		}
> 
> This is very confusing, regmap already has a concept of stride and this
> isn't the same thing.

Okay, will rename it.

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/a6dbd200/attachment.sig>
