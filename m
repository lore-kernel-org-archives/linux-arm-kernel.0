From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 12 Aug 2015 15:08:38 +0200
Subject: [PATCH 02/20] regmap: Remove regmap_bulk_write 64bit support
In-Reply-To: <20150812123537.GH10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-3-git-send-email-mpa@pengutronix.de>
 <20150812102550.GQ10748@sirena.org.uk>
 <20150812104436.GA19600@pengutronix.de>
 <20150812105758.GU10748@sirena.org.uk>
 <20150812122856.GF19600@pengutronix.de>
 <20150812123537.GH10748@sirena.org.uk>
Message-ID: <20150812130838.GN19600@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 01:35:37PM +0100, Mark Brown wrote:
> On Wed, Aug 12, 2015 at 02:28:56PM +0200, Markus Pargmann wrote:
> 
> > Ok, would work for me as well although sizeof is not a preprocessor
> > macro so I would probably leave it as it is. The whole regmap framework
> > just didn't seem to support 64bit so I thought this was just not
> > working.
> 
> I'd expect the framework to cope with things when ints are 64 bit.  We
> don't try to support anything else, though.

For all non-busses it probably will. All the format functions are not
working for 64bit at the moment. But that's something different, also I
didn't see a bus device with 64bit yet.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/f8619d20/attachment.sig>
