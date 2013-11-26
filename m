From: jbe@pengutronix.de (=?iso-8859-1?q?J=FCrgen_Beisert?=)
Date: Tue, 26 Nov 2013 14:43:30 +0100
Subject: ACPI
In-Reply-To: <CACxGe6t_9hUXL_1PHRU=2DYOYfCqZykd7gYRCshZn0XsVoCdRw@mail.gmail.com>
References: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org>
 <CACRpkdY+6dzs8MpKKtW-3kzsLkZjsit9SeN20k_33TAtVf3NEA@mail.gmail.com>
 <CACxGe6t_9hUXL_1PHRU=2DYOYfCqZykd7gYRCshZn0XsVoCdRw@mail.gmail.com>
Message-ID: <201311261443.30784.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 November 2013 13:55:10 Grant Likely wrote:
> On Tue, Nov 26, 2013 at 12:43 PM, Linus Walleij
>
> <linus.walleij@linaro.org> wrote:
> > On Mon, Nov 25, 2013 at 4:41 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> >> In the past ACPI implementations handled GPIO by providing
> >> methods that accessed hardware registers directly. I've seen DSDTs that
> >> implement i2c entirely in ASL.
> >
> > Is that common?
> >
> > Since i2c is a slow bus, can be 100kHz or so, how does that
> > avoid locking the entire CPU while e.g. waiting for transactions on
> > the external bus to complete?
> >
> > In I2C drivers we typically use completion IRQs so that we can
> > do other stuff when the I2C traffic is busy ...
> >
> > I have a feeling we should not recommend ARM implementers
> > to go and do things like this.
>
> ACPI5 defines a binding for serial busses (i2c & spi) which allows
> real device drivers to drive the bus and allows ACPI and the kernel to
> share the bus safely. Using that binding means some i2c devices can be
> 'owned' by ACPI and others owned by the kernel.

This means bus locking. And Linus' other question about CPU locking while ACPI
drives the I2C bus?

jbe
-- 
Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| Juergen Beisert ? ? ? ? ? ? |
Linux Solutions for Science and Industry ? ? ?| http://www.pengutronix.de/  |
