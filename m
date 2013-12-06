From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Fri, 06 Dec 2013 12:35:10 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSHYxM11bIDIvNF0gdmlkZW86IGlteGZiOiBBbHNvIGFkZCBw?=
 =?UTF-8?B?d21yIGZvciB0aGUgZGV2aWNlIHRyZWUu?=
In-Reply-To: <20131206081640.GZ24559@pengutronix.de>
References: <1386258219-26437-1-git-send-email-denis@eukrea.com>
 <1386317034.190941796@f354.i.mail.ru>
 <20131206081640.GZ24559@pengutronix.de>
Message-ID: <1386318910.581671226@f322.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Fri, Dec 06, 2013 at 12:03:54PM +0400, Alexander Shiyan wrote:
...
> > > >  - fsl,dmacr: DMA Control Register value. This is optional. By default, the
> > > >  	register is not modified as recommended by the datasheet.
> > > > +- fsl,pwmr:  LCDC PWM Contrast Control Register value. That property is
> > > > +	optional, but defining it is necessary to get the backlight working. If that
> > > > +	property is ommited, the register is zeroed.
> > > 
> > > Why isn't this implemented as a backlight driver? Static devicetree
> > > provided values is very limiting.
> > 
> > Let's understand the terminology.
> > This register should be renamed according to the datasheet, i.e. LPCCR.
> > As I pointed out earlier, it is NOT control the backlight, this is a contrast control.
> > Yes, it works as PWM, but nothing do with the backlight subsystem.
> > Yes, we can make a driver for this PWM, but how are we going to control it?
> > I misunderstood something?
> 
> I stumbled upon 'get the backlight working' which implied for me that it
> should be a backlight driver. But you're right and now I remember we
> talked about this already.

Hallelujah.

> I still think this should be something adjustable, not static data.
> Maybe we could change the wording to something like "This property
> provides the default value for the contrast control register" since even
> if we add driver support for controlling the contrast we still want
> to have a sane default.

Sounds good.

> BTW the contrast could be controlled with a lcd_device (see
> lcd_device_register) which seems to be very easy to implement.

Address of register is placed within LCD area, so we cannot use this
memory region, I think is no so easy as you say....

---
