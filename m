From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 17 Jul 2010 21:17:45 +0200
Subject: [FAILED] BLD phyCORE-i.MX31 + linux-next git kernel
In-Reply-To: <E1OZs5K-0005Px-5r@himalia.hi.pengutronix.de>
References: <E1OZs5K-0005Px-5r@himalia.hi.pengutronix.de>
Message-ID: <20100717191745.GC30077@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

Our nightly built found a problem while working on linux-next.
Commit v2.6.35-rc5-17-g6f7dd68 broke your devel branch
by renaming lmb to memblock.

Best regards
Uwe

On Fri, Jul 16, 2010 at 11:04:42PM +0200, Pengutronix Sisyphus Druid wrote:
>                               Source URL .... git://git.kernel.org/pub/scm/linux/kernel/git/sfr/linux-next.git
>                         Current git hash .... c221ef77c77c18dd981338cd6ec60e0a50967857
>                     Kernel configuration .... use config: mx3_defconfig
> [...]
>   LD      arch/arm/common/built-in.o
>   CC      arch/arm/kernel/return_address.o
>   CC      arch/arm/mm/init.o
> arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
> arch/arm/kernel/return_address.c:61:2: warning: #warning "TODO: return_address should use unwind tables"
>   CC      arch/arm/kernel/setup.o
>   CC      arch/arm/mach-mx3/mm.o
>   CC      arch/arm/plat-mxc/irq.o
> arch/arm/mm/init.c:20:23: error: linux/lmb.h: No such file or directory
> arch/arm/kernel/setup.c:30:23: error: linux/lmb.h: No such file or directory
> arch/arm/mm/init.c: In function 'arm_bootmem_init':
> arch/arm/mm/init.c:163: error: implicit declaration of function 'lmb_alloc_base'
> arch/arm/mm/init.c:183: error: 'lmb' undeclared (first use in this function)
> arch/arm/mm/init.c:183: error: (Each undeclared identifier is reported only once
> arch/arm/mm/init.c:183: error: for each function it appears in.)
> arch/arm/mm/init.c:184: error: implicit declaration of function 'lmb_start_pfn'
> arch/arm/mm/init.c:186: error: implicit declaration of function 'lmb_end_pfn'
> arch/arm/mm/init.c:188: error: implicit declaration of function 'lmb_size_bytes'
> arch/arm/mm/init.c: In function 'pfn_valid':
> arch/arm/mm/init.c:240: error: 'lmb' undeclared (first use in this function)
> arch/arm/mm/init.c:241: error: dereferencing pointer to incomplete type
> arch/arm/mm/init.c: In function 'arm_lmb_init':
> arch/arm/mm/init.c:274: error: implicit declaration of function 'lmb_init'
> arch/arm/mm/init.c:276: error: implicit declaration of function 'lmb_add'
> arch/arm/mm/init.c:282: error: implicit declaration of function 'lmb_reserve'
> arch/arm/mm/init.c:300: error: implicit declaration of function 'lmb_analyze'
> arch/arm/mm/init.c:301: error: implicit declaration of function 'lmb_dump_all'
> make[1]: *** [arch/arm/mm/init.o] Error 1
> make: *** [arch/arm/mm] Error 2
> make: *** Waiting for unfinished jobs....

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
