From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 21:11:28 +0100
Subject: [PATCH 7/7] ARM: mmp: move into ARCH_MULTIPLATFORM
In-Reply-To: <20151125192709.GC11298@codeaurora.org>
References: <1448465875-435039-1-git-send-email-arnd@arndb.de>
 <1448465875-435039-8-git-send-email-arnd@arndb.de>
 <20151125192709.GC11298@codeaurora.org>
Message-ID: <3103786.X1psj6MdNt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 November 2015 11:27:09 Stephen Boyd wrote:
> On 11/25, Arnd Bergmann wrote:
> > diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
> > index fdbfadf00c84..4773fe1d8b3f 100644
> > --- a/arch/arm/mach-mmp/Kconfig
> > +++ b/arch/arm/mach-mmp/Kconfig
> > @@ -1,9 +1,24 @@
> > +menuconfig ARCH_MMP
> > +     bool "Marvell PXA168/910/MMP2"
> > +     depends on ARCH_MULTI_V5 || ARCH_MULTI_V7
> > +     select ARCH_REQUIRE_GPIOLIB
> > +     select GENERIC_ALLOCATOR
> > +     select GENERIC_CLOCKEVENTS
> 
> ARCH_MULTIPLATFORM already selects this.

Ok, I'll remove it.

> > -
> > -#define UART1_BASE   (APB_PHYS_BASE + 0x36000)
> > -#define UART2_BASE   (APB_PHYS_BASE + 0x17000)
> > -#define UART3_BASE   (APB_PHYS_BASE + 0x18000)
> > -
> > -volatile unsigned long *UART;
> 
> Doesn't this file need to be ported over to
> arch/arm/include/debug/?

The multiplatform based platforms all use the DEBUG_LL based uncompress
output, which doesn't require the header but is a little more limited
otherwise.

	Arnd
