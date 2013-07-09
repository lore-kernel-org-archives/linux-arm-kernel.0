From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Jul 2013 23:06:37 +0200
Subject: [PATCH 01/04] ARM: shmobile: Only build clocks when COMMON_CLK=n
In-Reply-To: <CANqRtoRJhrbT4NMv4e7NwvXj0JoO001ShtjSwdquv7x-7dxKeA@mail.gmail.com>
References: <20130709054331.14007.66068.sendpatchset@w520>
 <1774541.9WRl3VrJqz@avalon>
 <CANqRtoRJhrbT4NMv4e7NwvXj0JoO001ShtjSwdquv7x-7dxKeA@mail.gmail.com>
Message-ID: <201307092306.38004.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 July 2013, Magnus Damm wrote:
> >>
> >> +ifndef CONFIG_COMMON_CLK
> >>  obj-$(CONFIG_ARCH_SH7372)      += setup-sh7372.o intc-sh7372.o
> >>  obj-$(CONFIG_ARCH_SH73A0)      += setup-sh73a0.o intc-sh73a0.o
> >>  obj-$(CONFIG_ARCH_R8A73A4)     += setup-r8a73a4.o
> >>  obj-$(CONFIG_ARCH_R8A7740)     += setup-r8a7740.o intc-r8a7740.o
> >>  obj-$(CONFIG_ARCH_R8A7778)     += setup-r8a7778.o
> >>  obj-$(CONFIG_ARCH_R8A7779)     += setup-r8a7779.o intc-r8a7779.o
> >>  obj-$(CONFIG_ARCH_R8A7790)     += setup-r8a7790.o
> >>  obj-$(CONFIG_ARCH_EMEV2)       += setup-emev2.o
> >> +endif
> >
> > I was about to mention the same, so I think that would be a good idea.
> 
> Sure, that may be a more common way to handle this. =)
> 
> To be clear, I assume you wanted that ifndef to cover the clock-xxx.c
> files instead of setup-xxx.c. So I will do that in next version.
> 

Yes, that's right, sorry for screwing up the example.

	Arnd
