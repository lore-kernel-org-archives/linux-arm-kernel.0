From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 4 Jan 2018 21:35:35 +0200
Subject: [PATCH 2/4] dt-bindings: gpio: add raspberry pi GPIO expander
 binding
In-Reply-To: <860502005.181510.1514917560724@email.1und1.de>
References: <cover.1514898134.git.baruch@tkos.co.il>
 <4ca1795c6e09eb89f481cdec55180b4f1165bbfd.1514898134.git.baruch@tkos.co.il>
 <860502005.181510.1514917560724@email.1und1.de>
Message-ID: <20180104193535.63jmkxjvo3mynzpc@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Tue, Jan 02, 2018 at 07:26:00PM +0100, Stefan Wahren wrote: 
> > Baruch Siach <baruch@tkos.co.il> hat am 2. Januar 2018 um 14:19 geschrieben:
> > 
> > 
> > The Raspberry Pi 3 GPIO expander is controlled by the VC4 firmware over
> > I2C. The firmware mailbox interface allows the ARM core to control the
> > GPIO lines.
> > 
> > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > ---
> >  .../bindings/gpio/brcm,bcm2835-expgpio.txt         | 24 ++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/gpio/brcm,bcm2835-expgpio.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/gpio/brcm,bcm2835-expgpio.txt b/Documentation/devicetree/bindings/gpio/brcm,bcm2835-expgpio.txt
> > new file mode 100644
> > index 000000000000..55257f31a9be
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpio/brcm,bcm2835-expgpio.txt
> > @@ -0,0 +1,24 @@
> > +Raspberry Pi GPIO expander
> > +
> > +The Raspberry Pi 3 GPIO expander is controlled by the VC4 firmware. The
> > +firmware exposes a mailbox interface that allows the ARM core to control the
> > +GPIO lines on the expander.
> > +
> > +Required properties:
> > +
> > +- compatible : Should be "brcm,bcm2835-expgpio"
> 
> from my understand this driver is specific to the Raspberry Pi and it's 
> vendor is the Raspberry Pi Foundation. So i prefer Eric's suggestion of 
> "raspberrypi,firmware-gpio", which also applies to the filename.

That was my inclination as well. But I thought that keeping DT compatibility 
with downstream is desirable.

I'll change compatible/file/driver names to raspberry something.

baruch

> > +- gpio-controller : Marks the device node as a gpio controller
> > +- #gpio-cells : Should be two.  The first cell is the pin number, and
> > +  the second cell is used to specify the gpio polarity:
> > +  0 = active high
> > +  1 = active low
> > +- firmware : Reference to the RPi firmware device node
> > +
> > +Example:
> > +
> > +expgpio: expgpio {
> > +	compatible = "brcm,bcm2835-expgpio";
> > +	gpio-controller;
> > +	#gpio-cells = <2>;
> > +	firmware = <&firmware>;
> > +};

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
