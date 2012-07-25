From: afzal@ti.com (Mohammed, Afzal)
Date: Wed, 25 Jul 2012 14:01:21 +0000
Subject: [PATCH v2 1/6] rtc: omap: kicker mechanism support
In-Reply-To: <500FD551.9070002@mvista.com>
References: <cover.1343191280.git.afzal@ti.com>
 <ecf6520fc9d5da53b670675a71ebece3d006cbb8.1343191280.git.afzal@ti.com>
 <500FD551.9070002@mvista.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9AD898@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Wed, Jul 25, 2012 at 16:45:29, Sergei Shtylyov wrote:

> > +/* OMAP_RTC_KICKER values */
> > +#define	KICK0_VALUE			(0x83e70b13)
> > +#define	KICK1_VALUE			(0x95a4f1e0)
> 
>     Parens not needed around simple literals.

Thanks for catching it

> 
> >   static void __iomem	*rtc_base;
> >
> >   #define rtc_read(addr)		__raw_readb(rtc_base + (addr))
> >   #define rtc_write(val, addr)	__raw_writeb(val, rtc_base + (addr))
> >
> > +#define rtc_writel(val, addr)	writel(val, rtc_base + (addr))
> > +
> 
>     Why not __raw_writel() like the above functions?

This driver would be used in AM335X, it being ARMv7, writel would be
safe (existing __raw_readb/__raw_writeb too needs to be replaced)

Regards
Afzal
