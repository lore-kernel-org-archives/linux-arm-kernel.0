From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 6 May 2014 14:10:23 +0200
Subject: [PATCH v3 06/20] usb: host: xhci-plat: Add support for the
 Armada 38x
In-Reply-To: <61061197.hLhKsFqJLF@wuerfel>
References: <1399335255-589-1-git-send-email-gregory.clement@free-electrons.com>
 <1399335255-589-7-git-send-email-gregory.clement@free-electrons.com>
 <1584794.IM1uiSkBdk@amdc1032> <61061197.hLhKsFqJLF@wuerfel>
Message-ID: <20140506141023.715b932d@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Tue, 06 May 2014 13:57:44 +0200, Arnd Bergmann wrote:

> > Please limit this driver to mvebu arch and compile testing, i.e.
> > 
> >         depends on ARCH_MVEBU || COMPILE_TEST
> 
> I think it actually needs a dependency on MVEBU_MBUS.

That's not what we do for any of the other drivers that use the
MVEBU_MBUS functions.

> You probably need something like
> 
> 	depends on MVEBU_MBUS=y || (MVEBU_MBUS=m && USB_XHCI=m)

MVEBU_MBUS is a bool, so there is no way is can be =m.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
