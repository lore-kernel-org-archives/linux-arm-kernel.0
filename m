From: marex@denx.de (Marek Vasut)
Date: Wed, 13 Jun 2012 18:00:38 +0200
Subject: [Patch v5 08/13] ARM: imx6q: add config-on-boot gpios
In-Reply-To: <20120613152841.GA23590@richard-laptop>
References: <1339590863-10564-1-git-send-email-richard.zhao@freescale.com>
 <4FD8AD42.6010702@gmail.com> <20120613152841.GA23590@richard-laptop>
Message-ID: <201206131800.38622.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Richard Zhao,

> On Wed, Jun 13, 2012 at 10:09:54AM -0500, Rob Herring wrote:
> > On 06/13/2012 07:34 AM, Richard Zhao wrote:
> > > Sometimes, boards have gpios that don't own by any driver or owner
> > > by a generic driver that don't like hacks. Such gpios is normally
> > > output and need setup once on boot. So I introduce the config-on-boot
> > > gpios.
> > > 
> > > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > > Cc: Shawn Guo <shawn.guo@linaro.org>
> > > Cc: Rob Herring <rob.herring@calxeda.com>
> > > Cc: Grant Likely <grant.likely@secretlab.ca>
> > > ---
> > > 
> > >  .../devicetree/bindings/arm/config-on-boot.txt     |   12 +++++++
> > >  arch/arm/boot/dts/imx6q-sabrelite.dts              |    7 ++++
> > >  arch/arm/mach-imx/mach-imx6q.c                     |   35
> > >  ++++++++++++++++++++ 3 files changed, 54 insertions(+)
> > >  create mode 100644
> > >  Documentation/devicetree/bindings/arm/config-on-boot.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/arm/config-on-boot.txt
> > > b/Documentation/devicetree/bindings/arm/config-on-boot.txt new file
> > > mode 100644
> > > index 0000000..f98ed74
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/arm/config-on-boot.txt
> > > @@ -0,0 +1,12 @@
> > > +* Configure on Boot
> > > +
> > > +Node name: config-on-boot
> > > +  It must be in root node. config-on-boot means to describe settings
> > > that needs +  to be set one time on boot but aren't owned by any
> > > driver, or the owned driver +  is too generic to handle such settings.
> > > For example, usb hub uses generic +  driver in usb core code, a
> > > on-board usb may need deassert reset pin.
> > 
> > NAK. This is not a h/w description
> 
> It's misc things, but is hw description.
> 
> > and should be solved within the
> > kernel or bootloader. Either fix this in u-boot,
> 
> Kernel might be better not to depend on uboot.

And we don't want to polute uboot either, so this is a good move.

> > the platform code, or
> 
> How do I get gpio in platfrom code without dts description?

Write a driver that does the GPIO setup in some generic way? Wasn't there 
something about this stuff going on? Shawn, you had some comments /wrt the M28 
DTS. This might be what you meant?

> > make the generic driver support this in a generic way.
> 
> It's called just after populate devices. It's hard for generic driver to
> decide when it's called.
> 
> Thanks
> Richard

Best regards,
Marek Vasut
