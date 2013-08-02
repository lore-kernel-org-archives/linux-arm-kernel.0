From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 2 Aug 2013 10:28:56 +0200
Subject: [PATCHv3 3/3] fb: backlight: HX8357: Add HX8369 support
In-Reply-To: <51FA56FF.8090308@ti.com>
References: <1375346437-18991-1-git-send-email-maxime.ripard@free-electrons.com>
 <1375346437-18991-4-git-send-email-maxime.ripard@free-electrons.com>
 <51FA56FF.8090308@ti.com>
Message-ID: <20130802082856.GQ2911@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomi,

On Thu, Aug 01, 2013 at 03:39:27PM +0300, Tomi Valkeinen wrote:
> Hi,
> 
> On 01/08/13 11:40, Maxime Ripard wrote:
> > From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > 
> > Add support for the Himax HX8369 controller as it is quite similar to the
> > hx8357.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Acked-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> >  drivers/video/backlight/hx8357.c | 219 ++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 204 insertions(+), 15 deletions(-)
> 
> I don't have comments about this patch as such, but hx8357.c in general:
> 
> - The commands used look like MIPI DCS commands. We have defined those
> in include/video/mipi_display.h.

Aaah, yes indeed. Thanks for pointing that out.

> - The command arrays could be const

True.

> - I don't like command arrays. Rather than having array for
> "HX8357_SET_COLUMN_ADDRESS, 0x00, 0x00, 0x01, 0x3f,", I'd much more like
> a function hx8357_set_column_address(int x1, int x2) or such.

Hmm, Ok.

> - Looking at the driver makes me think it resembles very much the panel
> driver(s) we have for OMAP. If only CDF was ready... ;)
> 
> Those said, I don't see a problem with applying this. We could clean up
> later those things mentioned above, but maybe it's better to do that
> when moving to CDF.

Yes, CDF would be really great for this :)

Alexandre and I will try to find some time to do the cleanups you
requested.

> For this and the two other patches:
> 
> Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> 
> I can apply these to my 3.12-fbdev branch some day soon, if
> Jean-Christophe hasn't come back yet (I'd normally rather deal only with
> trivial patches, and leave the rest to Jean-Christophe).

Great, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130802/cc613e15/attachment.sig>
