From: robherring2@gmail.com (Rob Herring)
Date: Fri, 19 Apr 2013 17:42:37 -0500
Subject: linux-next arm64 randconfig errors
Message-ID: <5171C85D.8020909@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are errors in today's linux-next for arm64. Looks like most are missing arch pieces.

of_get_next_parent has a fix pending.

Rob

arch/arm64/kernel/early_printk.c:98:23: error: conflicting types for 'early_console'
drivers/base/regmap/regmap-mmio.c:120:4: error: implicit declaration of function 'readq' [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:64:4: error: implicit declaration of function 'writeq' [-Werror=implicit-function-declaration]
drivers/block/blockconsole.c:164:2: error: implicit declaration of function 'cmpxchg64' [-Werror=implicit-function-declaration]
drivers/dma/amba-pl08x.c:303:13: error: expected identifier before '(' token
drivers/gpio/gpio-generic.c:103:2: error: implicit declaration of function 'readq' [-Werror=implicit-function-declaration]
drivers/gpio/gpio-generic.c:98:2: error: implicit declaration of function 'writeq' [-Werror=implicit-function-declaration]
drivers/mfd/tps65912-core.c:147: undefined reference to `mfd_add_devices'
drivers/mfd/tps65912-core.c:164: undefined reference to `mfd_remove_devices'
drivers/mfd/tps65912-core.c:171: undefined reference to `mfd_remove_devices'
drivers/parport/parport_pc.c:67:25: fatal error: asm/parport.h: No such file or directory
ERROR: "of_get_next_parent" [drivers/media/v4l2-core/videodev.ko] undefined!
ERROR: "read_current_timer" [crypto/tcrypt.ko] undefined!
include/linux/vt_buffer.h:18:21: fatal error: asm/vga.h: No such file or directory
include/video/vga.h:22:21: fatal error: asm/vga.h: No such file or directory
