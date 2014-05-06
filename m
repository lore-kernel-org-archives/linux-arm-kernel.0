From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 May 2014 14:21:55 +0200
Subject: [PATCH v3 06/20] usb: host: xhci-plat: Add support for the Armada
 38x
In-Reply-To: <20140506141023.715b932d@skate>
References: <1399335255-589-1-git-send-email-gregory.clement@free-electrons.com>
 <61061197.hLhKsFqJLF@wuerfel> <20140506141023.715b932d@skate>
Message-ID: <4660313.evfclGtT1x@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 May 2014 14:10:23 Thomas Petazzoni wrote:
> On Tue, 06 May 2014 13:57:44 +0200, Arnd Bergmann wrote:
> 
> > > Please limit this driver to mvebu arch and compile testing, i.e.
> > > 
> > >         depends on ARCH_MVEBU || COMPILE_TEST
> > 
> > I think it actually needs a dependency on MVEBU_MBUS.
> 
> That's not what we do for any of the other drivers that use the
> MVEBU_MBUS functions.

Fair enough. I guess using ARCH_MVEBU as the dependency works as well
because it implies MVEBU_MBUS. However, you can't use COMPILE_TEST
then because the driver itself needs the interfaces provided by MBUS.

It could be

	depends on ARCH_MVEBU || (MVEBU_MBUS && COMPILE_TEST)

to describe the dependency most accurately.

> > You probably need something like
> > 
> >       depends on MVEBU_MBUS=y || (MVEBU_MBUS=m && USB_XHCI=m)
> 
> MVEBU_MBUS is a bool, so there is no way is can be =m.

Yes, that helps.

	Arnd
