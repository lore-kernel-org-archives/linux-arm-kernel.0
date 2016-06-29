From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 29 Jun 2016 09:57:14 +0200
Subject: [PATCH v2 2/2] ARM: at91: pm: switch to the PIE infrastructure
In-Reply-To: <2349417.jWuiI2GXql@ws-stein>
References: <1467153886-21144-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1467153886-21144-3-git-send-email-alexandre.belloni@free-electrons.com>
 <2349417.jWuiI2GXql@ws-stein>
Message-ID: <20160629075714.GP29249@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/06/2016 at 08:12:21 +0200, Alexander Stein wrote :
> > +#if defined(CONFIG_CPU_V7)
> > +	dsb();
> > +	wfi();
> > +#else
> > +	asm volatile ("mcr	p15, 0, %0, c7, c0, 4" \
> > +		      : : "r" (0) : "memory");
> > +#endif
> 
> Why not defining wfi() for __LINUX_ARM_ARCH__ < 7 as it is done for dsb() and 
> friends in arch/arm/include/asm/barrier.h? So you can get rid of that #if 
> completly.

Well, Russell said it was not useful because "there's no architected WFI
instruction which doesn't have CPU specific issues (hence why we have
cpu_do_idle() to abstract that)"

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
