From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 24 Oct 2012 10:28:46 -0700
Subject: [PATCHv2] Input: omap4-keypad: Add pinctrl support
In-Reply-To: <CACRpkdai3NocZQnW6YRF+k6GXUSx3P_Ge=F-tkuivrFm6tBbLg@mail.gmail.com>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com>
 <20121024161429.GA16350@core.coreip.homeip.net>
 <CACRpkdai3NocZQnW6YRF+k6GXUSx3P_Ge=F-tkuivrFm6tBbLg@mail.gmail.com>
Message-ID: <4099134.xWUIfbbahk@dtor-d630.eng.vmware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, October 24, 2012 06:51:47 PM Linus Walleij wrote:
> On Wed, Oct 24, 2012 at 6:14 PM, Dmitry Torokhov
> 
> <dmitry.torokhov@gmail.com> wrote:
> > On Wed, Oct 24, 2012 at 11:37:04AM +0300, Felipe Balbi wrote:
> >> - we ask another layer to allocate memory for us
> >> - we ask another layer to call our ISR once the IRQ line is asserted
> >> - we ask another layer to handle the input events we just received
> >> - we ask another layer to transfer data through DMA for us
> >> - we ask another layer to turn regulators on and off.
> > 
> > But we are _directly_ _using_ all of these. You allocate memory and you
> > (the driver) stuff data into that memory. You ask for DMA and you take
> > the DMAed data and work with it. Not so with pinctrl in omap keypad and
> > other drivers I have seen so far.
> 
> Consult:
> drivers/tty/serial/amba-pl011.c

OK.

> drivers/spi/spi-pl022.c

Default/sleep transitions could be moved into bus code.

> drivers/i2c/busses/i2c-nomadik.c

Don't see pinctrl in linux-next.

 
> for more complex pinctrl use cases. These are my dogfood drivers ...
> Most of these will request more than one state and switch the driver
> between these different states at runtime, in these examples for power
> saving there are states named "default", "sleep" and in the I2C driver
> also "idle".
> 
> These examples are more typical to how the ux500 platform will
> look, also the SKE input driver will move the devise to sleep/default
> states but we need to merge PM code before we can do that.

I do not say that no drivers should ever touch pinctrl, just that most
of them do not have to if you have other layers to the right thing for
them.

Thanks.

-- 
Dmitry
