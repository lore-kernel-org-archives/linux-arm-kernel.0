From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 16 Feb 2016 17:49:37 +0000
Subject: [PATCH v3 0/6] irqchip: irq-armada-370-xp: generic MSI
 infrastructure and assorted fixes
In-Reply-To: <1455115621-22846-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1455115621-22846-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160216174937.GF5183@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Thomas,

On Wed, Feb 10, 2016 at 03:46:55PM +0100, Thomas Petazzoni wrote:
> This patch series converts the Armada 370/XP irqchip driver (also used
> on Armada 375, 38x and 39x) to the new MSI infrastructure put in place
> by Marc. It doesn't bring any functional difference other than using
> the right, modern, MSI mechanism, which might ultimately allow Marc to
> remove the old way of implementing MSI support.
> 
> It has been tested on Armada 38x and Armada XP with an Intel e1000e
> NIC and an Intel IGB NIC, both of which use MSI interrupts.
> 
> Note that this patch series depends on the patch series from Marc
> Zyngier for proper operation, which have already been merged in
> tip.git by Thomas Gleixner:
> 
>   http://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?id=530cbe100ef7587aa5b5ac3a4b670cda4d50e598
>   http://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?id=14a0db3cdd114da757197193f66786e63649c91e

When based against v4.5-rc1, I encountered:

drivers/irqchip/irq-armada-370-xp.c:584:41: error: 'DOMAIN_BUS_WIRED' undeclared (first use in this function)

Rebased the branch against v4.5-rc2 to pick up:

  530cbe100ef7 irqdomain: Allow domain lookup with DOMAIN_BUS_WIRED token

Which builds without warning.

> Thomas Petazzoni (6):
>   irqchip: irq-armada-370-xp: add Kconfig option for the driver
>   irqchip: irq-armada-370-xp: use the generic MSI infrastructure
>   irqchip: irq-armada-370-xp: use PCI_MSI_DOORBELL_START where
>     appropriate
>   irqchip: irq-armada-370-xp: use shorter names for irq_chip
>   irqchip: irq-armada-370-xp: allow allocation of multiple MSIs
>   ARM: mvebu: use the ARMADA_370_XP_IRQ option
> 
>  arch/arm/mach-mvebu/Kconfig         |   6 +-
>  drivers/irqchip/Kconfig             |   6 ++
>  drivers/irqchip/Makefile            |   2 +-
>  drivers/irqchip/irq-armada-370-xp.c | 156 +++++++++++++++---------------------
>  4 files changed, 78 insertions(+), 92 deletions(-)

Whole series applied to irqchip/mvebu which will not be rebased.  I'll
only append to it if you send me a patch to add.  ;-)

thx,

Jason.
