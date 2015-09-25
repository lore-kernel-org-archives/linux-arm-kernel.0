From: slash.tmp@free.fr (Mason)
Date: Fri, 25 Sep 2015 15:06:32 +0200
Subject: Steps to submit a new arch/arm port
In-Reply-To: <144297172.JfjI0hNJ9J@wuerfel>
References: <56001B78.2090001@free.fr> <2206647.QPrIpE2UC0@wuerfel>
 <56016780.5080104@free.fr> <144297172.JfjI0hNJ9J@wuerfel>
Message-ID: <560546D8.1010407@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/09/2015 16:51, Arnd Bergmann wrote:

> Move this to the platform Kconfig file. Also, drop all the
> 'select' statements that are implied by ARCH_MULTIPLATFORM
> and ARCH_MULTI_V7

I've trimmed my platform Kconfig down to:

config ARCH_TANGO4
	bool "Sigma Designs Tango4 (SMP87xx)"
	default y
	select ARCH_HAS_HOLES_MEMORYMODEL
	select ARM_ERRATA_754322
	select ARM_ERRATA_764369
	select ARM_GIC
	select CACHE_L2X0
	select CLKSRC_MMIO
	select GENERIC_IRQ_CHIP
	select HAVE_ARM_SCU
	select HAVE_ARM_TWD
	select NEON
	select SMP


Didn't find much documentation on ARCH_HAS_HOLES_MEMORYMODEL.
What is it used for?

http://cateee.net/lkddb/web-lkddb/ARCH_HAS_HOLES_MEMORYMODEL.html

Is it OK to select CACHE_L2X0, NEON, and SMP?

Regards.
