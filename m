From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 12 Aug 2015 14:28:56 +0200
Subject: [PATCH 02/20] regmap: Remove regmap_bulk_write 64bit support
In-Reply-To: <20150812105758.GU10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-3-git-send-email-mpa@pengutronix.de>
 <20150812102550.GQ10748@sirena.org.uk>
 <20150812104436.GA19600@pengutronix.de>
 <20150812105758.GU10748@sirena.org.uk>
Message-ID: <20150812122856.GF19600@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 11:57:58AM +0100, Mark Brown wrote:
> On Wed, Aug 12, 2015 at 12:44:36PM +0200, Markus Pargmann wrote:
> 
> > I wasn't aware that any 64 bit architecture actually has unsigned ints
> > that are 64 bit in size. So wouldn't at least on x86_64 this would lead
> > to a compiler warning as unsigned int is 4 byte and u64 8 bytes?
> 
> Nobody complained about warnings yet.  The compiler probably shouldn't
> be complaining given the casts, they're supposed to be an "I know what
> I'm doing" thing.  If you want to change something here it's changing
> the test to be based on sizeof(unsigned int).

Ok, would work for me as well although sizeof is not a preprocessor
macro so I would probably leave it as it is. The whole regmap framework
just didn't seem to support 64bit so I thought this was just not
working.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/a8047f85/attachment.sig>
