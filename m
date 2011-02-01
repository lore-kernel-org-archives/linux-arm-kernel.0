From: gadiyar@ti.com (Gadiyar, Anand)
Date: Tue, 1 Feb 2011 11:09:52 +0530
Subject: linux-next-20100201 - OMAP2+ defconfig broken with CONFIG_DEBUG_LL
Message-ID: <AANLkTinF+dpKvuRztChBM01MAjgL-foGp_yVq3uC9ghu@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I tried to build linux-next as of 20100201 with omap2plus_defconfig. In addition
I turned on CONFIG_DEBUG_LL and hit the following error.

  AS      arch/arm/kernel/debug.o
arch/arm/kernel/debug.S: Assembler messages:
arch/arm/kernel/debug.S:174: Error: garbage following instruction --
`ldreq r1,=
__virt_to_phys(omap_uart_phys)'
arch/arm/kernel/debug.S:174: Error: garbage following instruction --
`ldrne r1,=
__phys_to_virt((0x80000000+0x3ffc))'
arch/arm/kernel/debug.S:174: Error: garbage following instruction --
`ldreq r2,=
__virt_to_phys(omap_uart_phys)'
arch/arm/kernel/debug.S:174: Error: garbage following instruction --
`ldreq r2,=
__virt_to_phys(omap_uart_phys)'
arch/arm/kernel/debug.S:178: Error: garbage following instruction --
`ldreq r2,=
__virt_to_phys(omap_uart_lsr)'
arch/arm/kernel/debug.S:190: Error: garbage following instruction --
`ldreq r1,=
__virt_to_phys(omap_uart_phys)'
arch/arm/kernel/debug.S:190: Error: garbage following instruction --
`ldrne r1,=
__phys_to_virt((0x80000000+0x3ffc))'
arch/arm/kernel/debug.S:190: Error: garbage following instruction --
`ldreq r2,=
__virt_to_phys(omap_uart_phys)'
arch/arm/kernel/debug.S:190: Error: garbage following instruction --
`ldreq r2,=
__virt_to_phys(omap_uart_phys)'
make[1]: *** [arch/arm/kernel/debug.o] Error 1
make: *** [arch/arm/kernel] Error 2

Will try and bisect this down later. Just reporting for now.

- Anand
