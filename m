From: moinejf@free.fr (Jean-Francois Moine)
Date: Sun, 9 Feb 2014 09:10:16 +0100
Subject: irqchip: irq-dove: problem with the PMU interrupt controller.
Message-ID: <20140209091016.26a59d44@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

I have a WARN_ON at system startup time of the Cubox (Marvell Dove).
Sorry for I don't know enough about the IRQ subsystem to fix it.

irq: no irq domain found for /mbus/internal-regs/pmu-interrupt-ctrl at d0050 !
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at /home/jef/c-3.14/drivers/of/platform.c:171 of_device_alloc+0x190/0x194()
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 3.14.0-rc1-dirty #45
Backtrace: 
[<80011720>] (dump_backtrace) from [<800119fc>] (show_stack+0x18/0x1c)
 r6:000000ab r5:00000009 r4:00000000 r3:00000000
[<800119e4>] (show_stack) from [<803c8fcc>] (dump_stack+0x24/0x28)
[<803c8fa8>] (dump_stack) from [<8001b5cc>] (warn_slowpath_common+0x74/0x8c)
[<8001b558>] (warn_slowpath_common) from [<8001b688>] (warn_slowpath_null+0x24/0x2c)
 r8:00000000 r7:00000001 r6:bb075c40 r5:bb7d7cb4 r4:00000001
[<8001b664>] (warn_slowpath_null) from [<802dbf0c>] (of_device_alloc+0x190/0x194)
[<802dbd7c>] (of_device_alloc) from [<802dbf48>] (of_platform_device_create_pdata+0x38/0x90)
 r10:00000000 r9:bb05d890 r8:803f28fc r7:00000000 r6:bb05d890 r5:00000000
 r4:bb7d7cb4
[<802dbf10>] (of_platform_device_create_pdata) from [<802dc0ac>] (of_platform_bus_create+0xf0/0x174)
 r7:00000001 r6:00000000 r5:bb7d7cb4 r4:00000000
[<802dbfbc>] (of_platform_bus_create) from [<802dc108>] (of_platform_bus_create+0x14c/0x174)
...

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
