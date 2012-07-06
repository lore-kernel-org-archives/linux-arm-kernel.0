From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 6 Jul 2012 16:04:09 +0800
Subject: [PATCH v2] ARM: imx: select USE_OF
In-Reply-To: <1341560840-30400-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20120706071247.GC30009@pengutronix.de>
 <1341560840-30400-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120706080407.GB22133@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2012 at 09:47:20AM +0200, Uwe Kleine-K?nig wrote:
> Commit
> 
>       544496a (ARM: imx: move irq_domain_add_legacy call into avic driver)
> 
> introduced unconditional calls to irq_find_mapping and
> irq_domain_add_legacy, but it's still possible to have a .config without
> CONFIG_IRQ_DOMAIN=y resulting in
> 
> 	  CC      arch/arm/plat-mxc/avic.o
> 	arch/arm/plat-mxc/avic.c: In function 'avic_handle_irq':
> 	arch/arm/plat-mxc/avic.c:172: error: implicit declaration of function 'irq_find_mapping'
> 	arch/arm/plat-mxc/avic.c: In function 'mxc_init_irq':
> 	arch/arm/plat-mxc/avic.c:207: error: implicit declaration of function 'irq_domain_add_legacy'
> 	arch/arm/plat-mxc/avic.c:208: error: 'irq_domain_simple_ops' undeclared (first use in this function)
> 	arch/arm/plat-mxc/avic.c:208: error: (Each undeclared identifier is reported only once
> 	arch/arm/plat-mxc/avic.c:208: error: for each function it appears in.)
> 	arch/arm/plat-mxc/avic.c:208: warning: assignment makes pointer from integer without a cast
> 	make[3]: *** [arch/arm/plat-mxc/avic.o] Error 1
> 	make[2]: *** [arch/arm/plat-mxc/avic.o] Error 2
> 	make[1]: *** [sub-make] Error 2
> 	make: *** [all] Error 2
> 
> While selecting CONFIG_IRQ_DOMAIN would be enough, USE_OF is the future
> and implies CONFIG_IRQ_DOMAIN. So select USE_OF for ARCH_MXC and drop
> other explicit selects that are superflous now.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Applied on top of imx/sparse-irq branch.  Thanks, Uwe.

Arnd,

One more fix, sorry.  Can you please pull it?

Regards,
Shawn

The following changes since commit 6684294d27abb24e61916871c4ecfdaccc14eb03:

  ARM: imx: Fix build error due to missing irqs.h include (2012-07-04 11:19:40 +0800)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git imx/sparse-irq

Uwe Kleine-K?nig (1):
      ARM: imx: select USE_OF

 arch/arm/Kconfig          |    1 +
 arch/arm/mach-imx/Kconfig |    4 ----
 2 files changed, 1 insertions(+), 4 deletions(-)
