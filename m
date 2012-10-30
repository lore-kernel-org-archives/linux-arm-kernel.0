From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 30 Oct 2012 16:03:19 +0000
Subject: arm-soc tree was Re: [PATCH] Fix socfpga compilation with
 early_printk() enabled
In-Reply-To: <201210290441.25964.arnd@arndb.de>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <20121028230153.GA8284@elf.ucw.cz> <20121028231330.GB8284@elf.ucw.cz>
 <201210290441.25964.arnd@arndb.de>
Message-ID: <1351612999.6199.7.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-10-29 at 04:41 +0000, Arnd Bergmann wrote:
> On Sunday 28 October 2012, Pavel Machek wrote:
> > arch/arm/mach-vexpress/v2m.c:   vexpress_clk_init(ioremap(V2M_SYSCTL, SZ_4K));
> > include/linux/vexpress.h:void vexpress_clk_init(void __iomem *sp810_base);
> > 
> > ...seems vexpress_clk_init is not there, yet... And what is more
> > serious:
> > 
> > pavel at amd:~/mainline-altera/linux$ grep mach-vexpress MAINTAINERS
> > pavel at amd:~/mainline-altera/linux$ 
> > 
> > vexpress_clk_of_init();     has same problem.
> 
> I've already reported both to Pawel Moll, and he already came  back with
> a new series, but we're still trying to work out the dependencies.

Yes, it's been a glitch in -next between arm-soc and clk, but it should
be fine now (as of next-20121030).

Sorry about the hassle

Pawel
