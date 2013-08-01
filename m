From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 1 Aug 2013 15:39:27 +0300
Subject: [PATCHv3 3/3] fb: backlight: HX8357: Add HX8369 support
In-Reply-To: <1375346437-18991-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1375346437-18991-1-git-send-email-maxime.ripard@free-electrons.com>
 <1375346437-18991-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <51FA56FF.8090308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/08/13 11:40, Maxime Ripard wrote:
> From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Add support for the Himax HX8369 controller as it is quite similar to the
> hx8357.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/video/backlight/hx8357.c | 219 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 204 insertions(+), 15 deletions(-)

I don't have comments about this patch as such, but hx8357.c in general:

- The commands used look like MIPI DCS commands. We have defined those
in include/video/mipi_display.h.

- The command arrays could be const

- I don't like command arrays. Rather than having array for
"HX8357_SET_COLUMN_ADDRESS, 0x00, 0x00, 0x01, 0x3f,", I'd much more like
a function hx8357_set_column_address(int x1, int x2) or such.

- Looking at the driver makes me think it resembles very much the panel
driver(s) we have for OMAP. If only CDF was ready... ;)

Those said, I don't see a problem with applying this. We could clean up
later those things mentioned above, but maybe it's better to do that
when moving to CDF.

For this and the two other patches:

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

I can apply these to my 3.12-fbdev branch some day soon, if
Jean-Christophe hasn't come back yet (I'd normally rather deal only with
trivial patches, and leave the rest to Jean-Christophe).

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130801/d8f53c2d/attachment.sig>
