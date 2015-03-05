From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 5 Mar 2015 19:36:06 +0100
Subject: [PATCH v1 4/6] eeprom: sunxi: Move the SID driver to the eeprom
 framework
In-Reply-To: <1425550515.24292.212.camel@x220>
References: <1425548685-12887-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1425548775-13067-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1425550515.24292.212.camel@x220>
Message-ID: <20150305183606.GC4911@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Thu, Mar 05, 2015 at 11:15:15AM +0100, Paul Bolle wrote:
> >  endif
> > diff --git a/drivers/eeprom/Makefile b/drivers/eeprom/Makefile
> > index e130079..661422c 100644
> > --- a/drivers/eeprom/Makefile
> > +++ b/drivers/eeprom/Makefile
> > @@ -7,3 +7,4 @@ ccflags-$(CONFIG_EEPROM_DEBUG) += -DDEBUG
> >  obj-$(CONFIG_EEPROM)		+= core.o
> >  
> >  # Devices
> > +obj-$(CONFIG_EEPROM_SUNXI_SID)	+= eeprom-sunxi-sid.o
> > diff --git a/drivers/eeprom/eeprom-sunxi-sid.c b/drivers/eeprom/eeprom-sunxi-sid.c
> > new file mode 100644
> > index 0000000..eb32afb
> > --- /dev/null
> > +++ b/drivers/eeprom/eeprom-sunxi-sid.c
> > @@ -0,0 +1,129 @@
> > +/*
> > + * Allwinner sunXi SoCs Security ID support.
> > + *
> > + * Copyright (c) 2013 Oliver Schinagl <oliver@schinagl.nl>
> > + * Copyright (C) 2014 Maxime Ripard <maxime.ripard@free-electrons.com>
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > + * License version 2.  This program is licensed "as is" without any
> > + * warranty of any kind, whether express or implied.
> > + */
> 
> So the license is GPL v2.
> 
> > +MODULE_LICENSE("GPL");
> 
> Which means you probably want
>     MODULE_LICENSE("GPL v2");
> 
> > --- a/drivers/misc/eeprom/sunxi_sid.c
> > +++ /dev/null
> > @@ -1,156 +0,0 @@
> > -/*
> > - * Copyright (c) 2013 Oliver Schinagl <oliver@schinagl.nl>
> > - * http://www.linux-sunxi.org
> > - *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License as published by
> > - * the Free Software Foundation; either version 2 of the License, or
> > - * (at your option) any later version.
> 
> But the previous driver was GPL v2 or later.
> 
> > -MODULE_LICENSE("GPL");
> 
> And this matches that.
> 
> Was it intended to re-license this, or is the code basically new? (I
> haven't compared the before and after code, to be honest.)

That was unintentional, especially since this driver is not new at
all, and is barely a conversion to that framework.

Thanks for catching this!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150305/dfbfd47e/attachment.sig>
