From: notasas@gmail.com (Grazvydas Ignotas)
Date: Fri, 1 Oct 2010 18:57:46 +0300
Subject: multiple linux-next OMAP3 build errors
Message-ID: <AANLkTim9v1Y2o9QebYcJkh+QLVQq9fFOFE5P+OoyUHXa@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

I've been building linux-next for a while now and keep getting these
build errors, just posting them here in case not all are known. Not
familiar enough with that code to send patches unfortunately.

  AS      arch/arm/mm/proc-v7.o
arch/arm/mm/proc-v7.S: Assembler messages:
arch/arm/mm/proc-v7.S:363: Error: undefined symbol `PMD_FLAGS' in operation

  CC      drivers/usb/musb/musb_gadget.o
drivers/usb/musb/musb_gadget.c:1789: error:
'usb_gadget_register_driver' undeclared here (not in a function)
drivers/usb/musb/musb_gadget.c:1789: warning: type defaults to 'int'
in declaration of 'usb_gadget_register_driver'

  CC      drivers/video/omap2/vram.o
drivers/video/omap2/vram.c: In function 'omap_vram_reserve_sdram_memblock':
drivers/video/omap2/vram.c:568: error: implicit declaration of
function 'memblock_region_is_memory'

  LD      .tmp_vmlinux1
arch/arm/mach-omap2/built-in.o: In function `serial_write_reg':
/home/notaz/dev/pnd/kernel/linux-next/arch/arm/mach-omap2/serial.c:168:
undefined reference to `enable_off_mode'
arch/arm/mach-omap2/built-in.o: In function `omap_uart_prepare_idle':
/home/notaz/dev/pnd/kernel/linux-next/arch/arm/mach-omap2/serial.c:404:
undefined reference to `enable_off_mode'
arch/arm/mach-omap2/built-in.o: In function `omap3_can_sleep':
/home/notaz/dev/pnd/kernel/linux-next/arch/arm/mach-omap2/pm34xx.c:484:
undefined reference to `sleep_while_idle'

I'm using this customized config:
http://notaz.gp2x.de/misc/pnd/config_next_101001
