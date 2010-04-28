From: philippe.langlais@stericsson.com (Philippe Langlais)
Date: Wed, 28 Apr 2010 09:32:50 +0200
Subject: U6/U6715 ARM architecture files, 1rst try
Message-ID: <1272439976-24799-1-git-send-email-philippe.langlais@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Here my first contribution, for ST-Ericsson U6715 & U6 familly ARM926ejs SoC.
This patch series apply on version v2.6.33.
Information on U6715 is here: http://www.stericsson.com/platforms/U6715.jsp

Content:

U67xx reference board configuration
arch/arm/mach-u67xx/board_u67xx_wavex.c
- setup for pins multiplexing, padding and initial configuration.
- machine definition

U67xx default configuration file:
arch/arm/configs/u67xx_wavex_defconfig

U67xx machine subdrivers, based on existing linux kernel code:
arch/arm/mach-u67xx/
- clock gating subdriver
- U67xx devices definitions (only GPIO resources). 

U6xxx platform drivers, based on existing linux kernel code:
arch/arm/plat-u6xxx/ and arch/arm/plat-u6xxx/include/mach/
- platform debugging macros (basic UART support)
- IRQ helper macros
- shared clock framework
- gpio subdriver
- I/O (chipset register) memory mapping
- IRQ subdriver
- serial driver registration, based on 8250 serial driver
- timers subdriver
- all related registers mapping definition.

Modification of existing 8250 serial driver for U6xxx
drivers/serial/8250.c
drivers/serial/8250_u6.c
include/linux/serial_8250.h
- modifications of existing 8250 serial driver for U6xxx support.
- clock gating specific support for 8250 serial driver for U6xxx

Regards,

Philippe.
