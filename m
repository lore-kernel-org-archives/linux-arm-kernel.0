From: stigge@antcom.de (Roland Stigge)
Date: Wed, 26 Sep 2012 10:52:31 +0200
Subject: [GIT PULL] ARM: LPC32xx: core update
In-Reply-To: <1348647884.24309.35.camel@sauron.fi.intel.com>
References: <50488FD6.4080402@antcom.de> <201209131155.16756.arnd@arndb.de>
 <5052FE40.2030305@antcom.de> <1348647884.24309.35.camel@sauron.fi.intel.com>
Message-ID: <5062C24F.4090603@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2012 10:24 AM, Artem Bityutskiy wrote:
>> On 13/09/12 13:55, Arnd Bergmann wrote:
>>> On Thursday 06 September 2012, Roland Stigge wrote:
>>>> ARM: LPC32xx: Provide DMA filter callbacks via platform data
>>> 
>>> This patch results in build errors in the for-next branch with
>>> lpc32xx_defconfig:
>>> 
>>> arch/arm/mach-lpc32xx/phy3250.c:40:35: fatal error:
>>> linux/mtd/lpc32xx_slc.h: No such file or directory 
>>> arch/arm/mach-lpc32xx/phy3250.c:41:35: fatal error:
>>> linux/mtd/lpc32xx_mlc.h: No such file or directory 
>>> arch/arm/mach-lpc32xx/phy3250.c:226:15: error: variable
>>> 'lpc32xx_slc_data' has initializer but incomplete type 
>>> arch/arm/mach-lpc32xx/phy3250.c:227:2: error: unknown field
>>> 'dma_filter' specified in initializer 
>>> arch/arm/mach-lpc32xx/phy3250.c:227:2: error: excess elements
>>> in struct initializer [-Werror] 
>>> arch/arm/mach-lpc32xx/phy3250.c:227:2: error: (near
>>> initialization for 'lpc32xx_slc_data') [-Werror] 
>>> arch/arm/mach-lpc32xx/phy3250.c:230:15: error: variable
>>> 'lpc32xx_mlc_data' has initializer but incomplete type 
>>> arch/arm/mach-lpc32xx/phy3250.c:231:2: error: unknown field
>>> 'dma_filter' specified in initializer 
>>> arch/arm/mach-lpc32xx/phy3250.c:231:2: error: excess elements
>>> in struct initializer [-Werror] 
>>> arch/arm/mach-lpc32xx/phy3250.c:231:2: error: (near
>>> initialization for 'lpc32xx_mlc_data') [-Werror]
>>> 
>>> It seems that we're missing a dependency. Which tree did the
>>> patch to add these go through? Can we add that to the same
>>> branch in arm-soc?
>> 
>> Right - there is a dependency on l2-mtd.git here.
>> 
>> Since they didn't request pull for 3.6, there is quite some
>> stuff pending in their tree (but I wonder why it isn't already
>> part of linux-next, so the above error at least shouldn't occur
>> in linux-next).
> 
> It is in linux-next:
> 
> [dedekind at sauron linux-next (master)]$ git log --format='%h %an %s'
> drivers/mtd/ | grep Stigge 562dec8 Roland Stigge mtd: lpc32xx_mlc:
> Cleanup after DT-only conversion ad978ee Roland Stigge mtd:
> lpc32xx_slc: Cleanup after DT-only conversion 7359e4c Roland Stigge
> mtd: lpc32xx_mlc: Make driver independent of AMBA DMA engine
> driver fa5eae7 Roland Stigge mtd: lpc32xx_slc: Make driver
> independent of AMBA DMA engine driver 79f9df7 Roland Stigge mtd:
> lpc32xx_mlc: Adjust to pl08x DMA interface changes 314a156 Roland
> Stigge mtd: lpc32xx_slc: Adjust to pl08x DMA interface changes 
> 70f7cb7 Roland Stigge mtd: add LPC32xx MLC NAND driver d5842ab
> Roland Stigge mtd: lpc32xx_slc: Make probe() return -EPROBE_DEFER
> if necessary 21535ab Roland Stigge mtd: lpc32xx_slc: Use
> of_get_named_gpio() 2944a44 Roland Stigge mtd: add LPC32xx SLC NAND
> driver 9d7b4b5 Roland Stigge [MTD] [NAND] Fix refactoring of
> EDB7312 hwcontrol function. 4a32cfa Roland Stigge [MTD] [NAND] Fix
> refactoring of EDB7312 hwcontrol function.

Good, thanks! Then, the above issue should be gone now.

Please note that there is still the dependency of mtd on mach-lpc32xx.

Roland
