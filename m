From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Dec 2010 13:05:06 +0100
Subject: [PATCH 1/6 v9] ARM: Add basic architecture support for
	VIA/WonderMedia 85xx SoC's
In-Reply-To: <AANLkTi=7O-HwQRcybnLSt+r+A64g=D7rZY7NbdEMFys3@mail.gmail.com>
References: <1289147348-31969-1-git-send-email-alchark@gmail.com>
	<4D1011CF.9080800@bluewatersys.com>
	<AANLkTi=7O-HwQRcybnLSt+r+A64g=D7rZY7NbdEMFys3@mail.gmail.com>
Message-ID: <201012211305.06344.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 December 2010 11:00:43 Alexey Charkov wrote:
> #define WMT_IRQ_RES(__irq) \
> {\
>         .flags = IORESOURCE_IRQ,\
>         .start = __irq,\
>         .end = __irq,\
> }
> 
> void __init wmt_set_resources(void)
> {
>      resources_lcdc[0] = WMT_MMIO_RES(wmt_current_regs->lcdc, SZ_1K);
>      resources_lcdc[1] = WMT_IRQ_RES(wmt_current_irqs->lcdc);
> ...
> }
> 
> Then there will be no half-empty initializations scattered around
> separate from the other assignments (which is probably the worst thing
> in current configuration).

If you use platform_device_add_resources() to add the resource
at a later point, or platform_device_register_simple, you don't
even need to statically allocate the resource structure, which may
also make this simpler because you can keep all the data structures
local to the function filling them out.

	Arnd
