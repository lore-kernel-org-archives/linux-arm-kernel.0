From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 12 Aug 2015 12:44:36 +0200
Subject: [PATCH 02/20] regmap: Remove regmap_bulk_write 64bit support
In-Reply-To: <20150812102550.GQ10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-3-git-send-email-mpa@pengutronix.de>
 <20150812102550.GQ10748@sirena.org.uk>
Message-ID: <20150812104436.GA19600@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 11:25:50AM +0100, Mark Brown wrote:
> On Wed, Aug 12, 2015 at 12:12:27PM +0200, Markus Pargmann wrote:
> > Regmap does not support 64bit. The ival that is used to write the 64bit
> > data to, is unsigned int and can't hold 64bit. _regmap_write also just
> > supports unsigend int.
> 
> What makes you say that unsigned int can't hold 64 bit?  An architecture
> can have 64 bit ints if it likes.

I wasn't aware that any 64 bit architecture actually has unsigned ints
that are 64 bit in size. So wouldn't at least on x86_64 this would lead
to a compiler warning as unsigned int is 4 byte and u64 8 bytes?

Best Regards,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/a9e797d9/attachment.sig>
