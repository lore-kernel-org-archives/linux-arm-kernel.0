From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Feb 2016 17:31:56 +0100
Subject: [PATCH v2 5/6] serial: 8250/mediatek: fix building with
 SERIAL_8250=m
In-Reply-To: <20160211160438.GH28452@windriver.com>
References: <1455205297-1021302-1-git-send-email-arnd@arndb.de>
 <1455205297-1021302-6-git-send-email-arnd@arndb.de>
 <20160211160438.GH28452@windriver.com>
Message-ID: <4817391.g2eX6rsJJ6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 February 2016 11:04:38 you wrote:
> > diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> > index 6ecc6e3e82dc..55be90c1d85e 100644
> > --- a/drivers/tty/serial/8250/8250_mtk.c
> > +++ b/drivers/tty/serial/8250/8250_mtk.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/module.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/of_platform.h>
> > +#include <linux/module.h>
> 
> Something isn't right here ; I can see module.h three lines up in the
> context.  Guessing your addition of the revert makes this addition no
> longer required...
> 

Ok, thanks for noticing this. Also, I really should know my alphabet
at this point. I saw that the headers were sorted alphabetically and
thought I had added it in the right place, which would have worked fine
after the revert. Oh well.

	Arnd
