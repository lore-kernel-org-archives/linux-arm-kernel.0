From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 13 Aug 2015 15:14:03 +0200
Subject: [PATCH 1/6] gpiolib-of: Rename gpio_hog functions to be generic
In-Reply-To: <CACRpkdYpeoo2scKzNuSYbWfWLTBodXJEX3KyRzoRQPuoaeqzKw@mail.gmail.com>
References: <1438680203-13432-1-git-send-email-mpa@pengutronix.de>
 <1438680203-13432-2-git-send-email-mpa@pengutronix.de>
 <CACRpkdYpeoo2scKzNuSYbWfWLTBodXJEX3KyRzoRQPuoaeqzKw@mail.gmail.com>
Message-ID: <20150813131403.GW19600@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 10, 2015 at 11:29:58AM +0200, Linus Walleij wrote:
> On Tue, Aug 4, 2015 at 11:23 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
> 
> > The gpio hogging functions are currently only used for gpio-hogging. But
> > these functions are widely generic ones which parse gpio device nodes in
> > the DT.
> >
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> (...)
> >  /**
> > - * of_get_gpio_hog() - Get a GPIO hog descriptor, names and flags for GPIO API
> > + * of_parse_gpio() - Get a GPIO hog descriptor, names and flags for GPIO API
> 
> It's not a good name, too generic. It could easily be assued this is
> for something
> wider.
> 
> of_parse_own_gpio() or something, indicating that this pertains to the
> chip itself and not to outside users, would be better.

Yes, changed to of_parse_own_gpio() for next version.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150813/06c025d3/attachment.sig>
