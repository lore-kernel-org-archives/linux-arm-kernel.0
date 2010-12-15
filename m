From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 15 Dec 2010 10:10:26 +0100
Subject: [PATCH 02/16] ARM: Remove dependency of plat-orion GPIO code on
	mach directory includes.
In-Reply-To: <FCBE654890C0334289D0AD3AF4EF009FE148BBBCFC@IL-MB01.marvell.com>
References: <cover.1292377339.git.buytenh@wantstofly.org>
	<20101215020233.GU15575@mail.wantstofly.org>
	<FCBE654890C0334289D0AD3AF4EF009FE148BBBCFC@IL-MB01.marvell.com>
Message-ID: <20101215091025.GK15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 15, 2010 at 10:08:51AM +0200, Saeed Bishara wrote:

> >diff --git a/arch/arm/mach-dove/include/mach/dove.h 
> >b/arch/arm/mach-dove/include/mach/dove.h
> >index f6a0839..df51131 100644
> >--- a/arch/arm/mach-dove/include/mach/dove.h
> >+++ b/arch/arm/mach-dove/include/mach/dove.h
> >@@ -130,7 +130,8 @@
> > #define DOVE_PMU_MPP_GENERAL_CTRL (DOVE_MPP_VIRT_BASE + 0x10)
> > #define DOVE_RESET_SAMPLE_LO	(DOVE_MPP_VIRT_BASE | 0x014)
> > #define DOVE_RESET_SAMPLE_HI	(DOVE_MPP_VIRT_BASE | 0x018)
> >-#define DOVE_GPIO_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE | 0xd0400)
> >+#define DOVE_GPIO_LO_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE 
> >| 0xd0400)
> >+#define DOVE_GPIO_HI_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE 
> >| 0xd0420)
> > #define DOVE_MPP_GENERAL_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE 
> >| 0xe803c)
> > #define  DOVE_AU1_SPDIFO_GPIO_EN	(1 << 1)
> > #define  DOVE_NAND_GPIO_EN		(1 << 0)
> >diff --git a/arch/arm/mach-dove/include/mach/gpio.h 
> >b/arch/arm/mach-dove/include/mach/gpio.h
> >index 0ee70ff..e7e5101 100644
> >--- a/arch/arm/mach-dove/include/mach/gpio.h
> >+++ b/arch/arm/mach-dove/include/mach/gpio.h
> 
> Lennert, this patch conflicts with 2 paches sent by Mike that deal with dove gpio/mpp
> [PATCH v4 1/2] [ARM] Dove: add support for GPIOs 64-71
> [PATCH v3 2/2] [ARM] Dove: add support for multi-purpose pins configuration
> 
> Nico, I've acked those patches but didn't notice that it wasn't merged in the orion git.
> Can you please merge it.

OK, I'll rework this patch once they are merged.
