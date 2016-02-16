From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 16 Feb 2016 21:09:09 +0100
Subject: [PATCH v3 0/6] irqchip: irq-armada-370-xp: generic MSI
 infrastructure and assorted fixes
In-Reply-To: <20160216174937.GF5183@io.lakedaemon.net>
References: <1455115621-22846-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160216174937.GF5183@io.lakedaemon.net>
Message-ID: <20160216210909.09f7f685@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 16 Feb 2016 17:49:37 +0000, Jason Cooper wrote:

> > Note that this patch series depends on the patch series from Marc
> > Zyngier for proper operation, which have already been merged in
> > tip.git by Thomas Gleixner:
> > 
> >   http://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?id=530cbe100ef7587aa5b5ac3a4b670cda4d50e598
> >   http://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?id=14a0db3cdd114da757197193f66786e63649c91e
> 
> When based against v4.5-rc1, I encountered:
> 
> drivers/irqchip/irq-armada-370-xp.c:584:41: error: 'DOMAIN_BUS_WIRED' undeclared (first use in this function)
> 
> Rebased the branch against v4.5-rc2 to pick up:
> 
>   530cbe100ef7 irqdomain: Allow domain lookup with DOMAIN_BUS_WIRED token
> 
> Which builds without warning.

Indeed. See above where I was mentioning which commits I was depending
on.

> >  arch/arm/mach-mvebu/Kconfig         |   6 +-
> >  drivers/irqchip/Kconfig             |   6 ++
> >  drivers/irqchip/Makefile            |   2 +-
> >  drivers/irqchip/irq-armada-370-xp.c | 156 +++++++++++++++---------------------
> >  4 files changed, 78 insertions(+), 92 deletions(-)
> 
> Whole series applied to irqchip/mvebu which will not be rebased.  I'll
> only append to it if you send me a patch to add.  ;-)

Thanks for the merge!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
