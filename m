From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 May 2013 18:33:03 +0200
Subject: [PATCH] irqchip: Add irqchip_init dummy function
In-Reply-To: <518A6C05.9030303@cogentembedded.com>
References: <1368019204-24448-1-git-send-email-hechtb+renesas@gmail.com>
 <518A6C05.9030303@cogentembedded.com>
Message-ID: <201305081833.03716.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 May 2013, Sergei Shtylyov wrote:
> > --- a/include/linux/irqchip.h
> > +++ b/include/linux/irqchip.h
> > @@ -11,6 +11,10 @@
> >   #ifndef _LINUX_IRQCHIP_H
> >   #define _LINUX_IRQCHIP_H
> >
> > +#ifdef CONFIG_IRQCHIP
> >   void irqchip_init(void);
> > +#else
> > +void irqchip_init(void) {};
> 
>     Semicolon not needed here.
> 
> > +#endif
> 

More importantly, the function should be marked as "static inline", otherwise
you get a link error if this header is included in more than one place.

	Arnd
