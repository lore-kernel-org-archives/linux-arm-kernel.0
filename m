From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 17 Aug 2015 09:19:32 +0200
Subject: [PATCH 01/20] regmap: Add missing comments about struct regmap_bus
In-Reply-To: <55CBA8A6.7020404@gmx.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-2-git-send-email-mpa@pengutronix.de>
 <55CBA8A6.7020404@gmx.de>
Message-ID: <20150817071932.GH19600@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 10:12:22PM +0200, Hartmut Knaack wrote:
> Markus Pargmann schrieb am 12.08.2015 um 12:12:
> > There are some fields of this struct undocumented or old. This patch
> > updates the missing comments.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  include/linux/regmap.h | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> > index 59c55ea0f0b5..6ff83c9ddb45 100644
> > --- a/include/linux/regmap.h
> > +++ b/include/linux/regmap.h
> > @@ -296,8 +296,11 @@ typedef void (*regmap_hw_free_context)(void *context);
> >   *                if not implemented  on a given device.
> >   * @async_write: Write operation which completes asynchronously, optional and
> >   *               must serialise with respect to non-async I/O.
> > + * @reg_write: Write operation for a register. Writes value to register.
> >   * @read: Read operation.  Data is returned in the buffer used to transmit
> >   *         data.
> > + * @reg_read: Read operation for a register. Reads a value from a register.
> > + * @free_conetext: Free context.
> 
> Typo: free_context

Thanks, fixed for next version.

Best regards,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150817/5d67c2aa/attachment.sig>
