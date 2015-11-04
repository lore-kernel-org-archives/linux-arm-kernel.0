From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Nov 2015 11:09:58 +0100
Subject: [PATCH 2/2] drivers/gpio: Port gpio driver to layerscape platform
In-Reply-To: <1446628658.12676.14.camel@freescale.com>
References: <1446619704-27669-1-git-send-email-Gang.Liu@freescale.com>
 <4040829.fHtCUjX87j@wuerfel> <1446628658.12676.14.camel@freescale.com>
Message-ID: <20116723.9FINQ9c1Gk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 November 2015 03:17:38 Scott Wood wrote:
> > I guess this is fixed per architecture, so you could also do this as
> > 
> > static inline void gpio_out32(u32 val, void __iomem *addr)
> > {
> >       if (IS_ENABLED(CONFIG_ARM))
> >               iowrite32(val, addr);
> >       else if (IS_ENABLED(CONFIG_PPC))
> >               iowrite32be(val, addr);
> >       else
> >               BUG();
> > }
> 
> Unfortunately that guess is wrong.  Some of our ARM chips have big-endian I/O 
> and some have little-endian I/O.

Ok, I see. In that case, using run-time detection everywhere is
probably best.

	Arnd
