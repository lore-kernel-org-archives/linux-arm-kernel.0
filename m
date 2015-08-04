From: raghumag@gmail.com (raghu MG)
Date: Tue, 4 Aug 2015 20:54:27 +0530
Subject: GPIO interrupts on ARMADAXP GP board
Message-ID: <CAG1O52XxwAZgOnd6on_mo+EmPtR1TSiWAfoB2DH658p2tZchqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I am working on a card which as GPIOs connected to external I/O's. The
board consists of ARMADAXP 78460 host cpu.

Board currently runs Linux-4.1 with modified  armada-xp-gp.dtb for ArmadaXP.
I enabled "orion-gpio" driver to initialize GPIOs as given in armada-xp-mv78460.


The driver while initializing calls irq_domain_add_simple which throws
up following warning
"irq: Cannot allocate irq_descs @ IRQ47, assuming pre-allocated"
The warning repeats for next set(32-63  & 64-66).

Also the GPIO IRQs are not getting listed in cat /proc/interrupts

My understanding is GPIO interrupts are not getting registered . As
per DTS file the following GPIO interrupts should be registered
82,83,84,85,87,88,89,90,91

But none of them are registered nor the irq handler is getting invoked.

Please suggest some fix to this problem.
Regards
