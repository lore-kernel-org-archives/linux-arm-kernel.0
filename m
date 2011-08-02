From: pj0585@gmail.com (Prasant J)
Date: Tue, 2 Aug 2011 16:35:58 +0530
Subject: at91sam9g45: MMC: Issues with MMC driver
Message-ID: <CAA2DH4v+v2Vvv_2MzD1dGqbc5a4W1h+30FqwwpsqKmYk6nvZxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm using Linux 3.0.0 on a custom board design based on AT91SAM9G45-EKES

I'm getting this kernel dump while booting:


Waiting 3sec before mounting root device...
mmc0: host does not support reading read-only switch. assuming write-enable.
mmc0: new SD card at address 0007
mmcblk0: mmc0:0007 SU02G 1.83 GiB
 mmcblk0: p1 p2
eth0: link up (100/Full)
EXT3-fs: barriers not enabled
kjournald starting.  Commit interval 5 seconds
EXT3-fs (mmcblk0p2): using internal journal
EXT3-fs (mmcblk0p2): mounted filesystem with writeback data mode
VFS: Mounted root (ext3 filesystem) on device 179:2.
Freeing init memory: 116K
------------[ cut here ]------------
WARNING: at kernel/irq/handle.c:130 handle_irq_event_percpu+0x6c/0x18c()
irq 11 handler atmci_interrupt+0x0/0x6e4 enabled interrupts
Modules linked in:
[<c00307a4>] (unwind_backtrace+0x0/0xec) from [<c003af7c>]
(warn_slowpath_common+0x4c/0x64)
[<c003af7c>] (warn_slowpath_common+0x4c/0x64) from [<c003b028>]
(warn_slowpath_fmt+0x30/0x40)
[<c003b028>] (warn_slowpath_fmt+0x30/0x40) from [<c006530c>]
(handle_irq_event_percpu+0x6c/0x18c)
[<c006530c>] (handle_irq_event_percpu+0x6c/0x18c) from [<c0065454>]
(handle_irq_event+0x28/0x38)
[<c0065454>] (handle_irq_event+0x28/0x38) from [<c0067594>]
(handle_level_irq+0xc8/0xdc)
[<c0067594>] (handle_level_irq+0xc8/0xdc) from [<c0065058>]
(generic_handle_irq+0x28/0x30)
[<c0065058>] (generic_handle_irq+0x28/0x30) from [<c0025064>]
(asm_do_IRQ+0x64/0x98)
[<c0025064>] (asm_do_IRQ+0x64/0x98) from [<c002b374>] (__irq_svc+0x34/0x60)
Exception stack(0xc02b7f68 to 0xc02b7fb0)
7f60:                   00000000 0005317f 0005217f 60000013 c02b6000 c02bab9c
7f80: c02baa18 c02d18e4 70004000 41069265 700203d0 00000000 600000d3 c02b7fb0
7fa0: c002cc5c c002cc68 60000013 ffffffff
[<c002b374>] (__irq_svc+0x34/0x60) from [<c002cc68>] (default_idle+0x38/0x40)
[<c002cc68>] (default_idle+0x38/0x40) from [<c002ca90>] (cpu_idle+0x68/0xbc)
[<c002ca90>] (cpu_idle+0x68/0xbc) from [<c00089fc>] (start_kernel+0x284/0x2e4)
[<c00089fc>] (start_kernel+0x284/0x2e4) from [<70008040>] (0x70008040)
---[ end trace 6f60efeaa497bae3 ]---


Can someone tell me what is possibly wrong in the mmc driver's
interrupt handler?

-Prasant
