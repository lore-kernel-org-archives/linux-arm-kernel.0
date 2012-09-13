From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Sep 2012 11:55:16 +0000
Subject: [GIT PULL] ARM: LPC32xx: core update
In-Reply-To: <50488FD6.4080402@antcom.de>
References: <50488FD6.4080402@antcom.de>
Message-ID: <201209131155.16756.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 September 2012, Roland Stigge wrote:
>       ARM: LPC32xx: Provide DMA filter callbacks via platform data

This patch results in build errors in the for-next branch with lpc32xx_defconfig:

arch/arm/mach-lpc32xx/phy3250.c:40:35: fatal error: linux/mtd/lpc32xx_slc.h: No such file or directory
arch/arm/mach-lpc32xx/phy3250.c:41:35: fatal error: linux/mtd/lpc32xx_mlc.h: No such file or directory
arch/arm/mach-lpc32xx/phy3250.c:226:15: error: variable 'lpc32xx_slc_data' has initializer but incomplete type
arch/arm/mach-lpc32xx/phy3250.c:227:2: error: unknown field 'dma_filter' specified in initializer
arch/arm/mach-lpc32xx/phy3250.c:227:2: error: excess elements in struct initializer [-Werror]
arch/arm/mach-lpc32xx/phy3250.c:227:2: error: (near initialization for 'lpc32xx_slc_data') [-Werror]
arch/arm/mach-lpc32xx/phy3250.c:230:15: error: variable 'lpc32xx_mlc_data' has initializer but incomplete type
arch/arm/mach-lpc32xx/phy3250.c:231:2: error: unknown field 'dma_filter' specified in initializer
arch/arm/mach-lpc32xx/phy3250.c:231:2: error: excess elements in struct initializer [-Werror]
arch/arm/mach-lpc32xx/phy3250.c:231:2: error: (near initialization for 'lpc32xx_mlc_data') [-Werror]

It seems that we're missing a dependency. Which tree did the patch to add
these go through? Can we add that to the same branch in arm-soc?

	Arnd
