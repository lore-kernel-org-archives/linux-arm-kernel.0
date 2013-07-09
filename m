From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 09 Jul 2013 09:45:58 +0200
Subject: [PATCH 01/04] ARM: shmobile: Only build clocks when COMMON_CLK=n
In-Reply-To: <201307090943.07898.arnd@arndb.de>
References: <20130709054331.14007.66068.sendpatchset@w520>
 <20130709054341.14007.99736.sendpatchset@w520>
 <201307090943.07898.arnd@arndb.de>
Message-ID: <1774541.9WRl3VrJqz@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Magnus,

On Tuesday 09 July 2013 09:43:07 Arnd Bergmann wrote:
> On Tuesday 09 July 2013, Magnus Damm wrote:
> > +obj-y                          += $(clk-y$(CONFIG_COMMON_CLK))
> 
> It took me a bit to understand the Makefile trick you are using here.
> I assume other readers will have the same problem. How about just
> doing
> 
> +ifndef CONFIG_COMMON_CLK
>  obj-$(CONFIG_ARCH_SH7372)      += setup-sh7372.o intc-sh7372.o
>  obj-$(CONFIG_ARCH_SH73A0)      += setup-sh73a0.o intc-sh73a0.o
>  obj-$(CONFIG_ARCH_R8A73A4)     += setup-r8a73a4.o
>  obj-$(CONFIG_ARCH_R8A7740)     += setup-r8a7740.o intc-r8a7740.o
>  obj-$(CONFIG_ARCH_R8A7778)     += setup-r8a7778.o
>  obj-$(CONFIG_ARCH_R8A7779)     += setup-r8a7779.o intc-r8a7779.o
>  obj-$(CONFIG_ARCH_R8A7790)     += setup-r8a7790.o
>  obj-$(CONFIG_ARCH_EMEV2)       += setup-emev2.o
> +endif

I was about to mention the same, so I think that would be a good idea.

-- 
Regards,

Laurent Pinchart
