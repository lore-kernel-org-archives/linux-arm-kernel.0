From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Fri, 06 Dec 2013 12:03:54 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSHYxM11bIDIvNF0gdmlkZW86IGlteGZiOiBBbHNvIGFkZCBw?=
 =?UTF-8?B?d21yIGZvciB0aGUgZGV2aWNlIHRyZWUu?=
In-Reply-To: <20131206070525.GV24559@pengutronix.de>
References: <1386258219-26437-1-git-send-email-denis@eukrea.com>
 <1386258219-26437-2-git-send-email-denis@eukrea.com>
 <20131206070525.GV24559@pengutronix.de>
Message-ID: <1386317034.190941796@f354.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Thu, Dec 05, 2013 at 04:43:37PM +0100, Denis Carikli wrote:
> > pwmr has to be set to get the imxfb backlight work,
> > though pwmr was only configurable trough the platform data.
> > 
> > Cc: Rob Herring <rob.herring@calxeda.com>
> > Cc: Pawel Moll <pawel.moll@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Stephen Warren <swarren@wwwdotorg.org>
> > Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> > Cc: devicetree at vger.kernel.org
> > Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Cc: linux-fbdev at vger.kernel.org
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: linux-arm-kernel at lists.infradead.org
> > Cc: Eric B?nard <eric@eukrea.com>
> > Signed-off-by: Denis Carikli <denis@eukrea.com>
> > Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Acked-by: Grant Likely <grant.likely@linaro.org>
> > ---
> >  .../devicetree/bindings/video/fsl,imx-fb.txt       |    3 +++
> >  drivers/video/imxfb.c                              |    2 ++
> >  2 files changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/video/fsl,imx-fb.txt b/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> > index 46da08d..ac457ae 100644
> > --- a/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> > +++ b/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> > @@ -17,6 +17,9 @@ Required nodes:
> >  Optional properties:
> >  - fsl,dmacr: DMA Control Register value. This is optional. By default, the
> >  	register is not modified as recommended by the datasheet.
> > +- fsl,pwmr:  LCDC PWM Contrast Control Register value. That property is
> > +	optional, but defining it is necessary to get the backlight working. If that
> > +	property is ommited, the register is zeroed.
> 
> Why isn't this implemented as a backlight driver? Static devicetree
> provided values is very limiting.

Let's understand the terminology.
This register should be renamed according to the datasheet, i.e. LPCCR.
As I pointed out earlier, it is NOT control the backlight, this is a contrast control.
Yes, it works as PWM, but nothing do with the backlight subsystem.
Yes, we can make a driver for this PWM, but how are we going to control it?
I misunderstood something?

---
