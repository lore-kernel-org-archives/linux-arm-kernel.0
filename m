From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 15 Apr 2013 15:48:25 -0400
Subject: [PATCHv1 0/5] Marvell EBU irqchip improvements
In-Reply-To: <1365542778-27959-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1365542778-27959-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130415194825.GT28693@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 09, 2013 at 11:26:13PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> Here is a set of 5 patches that move the Marvell EBU IRQ controller
> driver to drivers/irqchip/ and do a few minor related cleanup or
> improvements.
> 
> Those commits were originally part of the series introducing PCIe MSI
> support for Marvell EBU platform, but the MSI support is not ready for
> merging. However, I'd like those preparation patches to be considered
> for 3.10.
> 
> Thanks,
> 
> Thomas
> 
> Thomas Petazzoni (5):
>   ARM: mvebu: move L2 cache initialization in init_early()
>   irqchip: move IRQ driver for Armada 370/XP
>   irqchip: armada-370-xp: move IRQ handler to avoid forward declaration
>   irqchip: armada-370-xp: slightly cleanup irq controller driver

I applied the above 4 patches to mvebu/irqchip in case tglx objects, it
can be dropped without impacting other work.

>   ARM: mvebu: do not duplicate the mpic alias

I already sent the PR for LPAE, which will conflict with this.  I'll add
this to mvebu/fixes once v3.9 drops.

>  arch/arm/boot/dts/armada-370.dtsi                  |    2 +-
>  arch/arm/boot/dts/armada-xp.dtsi                   |    2 +-
>  arch/arm/mach-mvebu/Makefile                       |    2 +-
>  arch/arm/mach-mvebu/armada-370-xp.c                |    9 +-
>  drivers/irqchip/Makefile                           |    1 +
>  .../irqchip}/irq-armada-370-xp.c                   |  106 ++++++++++----------
>  6 files changed, 62 insertions(+), 60 deletions(-)
>  rename {arch/arm/mach-mvebu => drivers/irqchip}/irq-armada-370-xp.c (91%)

thx,

Jason.
