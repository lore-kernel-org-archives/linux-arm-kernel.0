From: john.tobias.ph@gmail.com (John Tobias)
Date: Mon, 20 Jan 2014 20:09:40 -0800
Subject: No subject
Message-ID: <CACUGKYPRA7fTKh9mf9D3=+XSSRrfKvWD05e1n1OFDzfA3pOLcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guys,

Just wondering if you encountered the error below and if there's any
existing patch?.

Regards,

john



[  860.354231] Unable to handle kernel paging request at virtual
address eaffff9d
[  860.361466] pgd = bf190000
[  860.364177] [eaffff9d] *pgd=00000000
[  860.367773] Internal error: Oops: 5 [#1] ARM
[  860.372048] Modules linked in: bt8xxx(O) sd8xxx(O) mlan(O)
[  860.377597] CPU: 0 PID: 82 Comm: ksdioirqd/mmc1 Tainted: G
 O 3.13.0-rc1 #1
[  860.385344] task: bf05c280 ti: bf01a000 task.ti: bf01a000
[  860.390756] PC is at mmc_io_rw_extended+0x38/0x310
[  860.395552] LR is at mmc_io_rw_extended+0x38/0x310
[  860.400346] pc : [<80319b68>]    lr : [<80319b68>]    psr: 400f0013
[  860.400346] sp : bf01bc90  ip : bf01bd60  fp : bf01bd8c
[  860.411824] r10: 806f9748  r9 : bf9e7800  r8 : eb075fb4
[  860.417051] r7 : eaffff9d  r6 : 80327c24  r5 : 1a000009  r4 : 00000007
[  860.423580] r3 : 00000000  r2 : ffffffc4  r1 : 00000000  r0 : bf01bd1c
[  860.430112] Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
Segment kernel
[  860.437423] Control: 10c53c7d  Table: bf190059  DAC: 00000015
[  860.443172] Process ksdioirqd/mmc1 (pid: 82, stack limit = 0xbf01a238)
[  860.449702] Stack: (0xbf01bc90 to 0xbf01c000)
[  860.454065] bc80:                                     80319e04
00000440 00000139 00000000
[  860.462246] bca0: 00000139 00000000 817de8c2 000000c0 00000700
beac60c0 3b9aca00 00000000
[  860.470427] bcc0: 00000100 00000007 00000000 00000200 00000700
00000000 bf01bd1c 00000001
[  860.478609] bce0: bf01bca8 00000000 00000035 1a001207 00002000
00000000 00000000 00000000
[  860.486790] bd00: 000001b5 00000000 00000000 00000000 00000000
bf01bcb8 bf01bd1c 00000000
[  860.494971] bd20: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[  860.503153] bd40: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[  860.511334] bd60: bf01bd94 bf01bd70 80324254 80327c24 bf01be04
bf9e7800 806f9748 b600003f
[  860.519515] bd80: bf01bdd4 bf01bd90 8031ade8 80319b3c bf01be04
80327c24 00000007 1a000009
[  860.527697] bda0: bf05c280 000001ff 00100100 bfb52000 00000100
00000007 beac60c0 00010009
[  860.535878] bdc0: 7f03e578 c0adb000 bf01bdec bf01bdd8 8031aef8
8031ad10 beac60c0 00000700
[  860.544059] bde0: bf01be14 bf01bdf0 7f08c2bc 8031aee0 00000000
00000009 00000700 7f03d328
[  860.552240] be00: bfad9a00 00000000 bf01be24 bf01be18 7f0622f0
7f08c278 bf01be6c bf01be28
[  860.560422] be20: 7f0137a8 7f0622ec bf01be44 bf01be38 8004efd4
00000001 bf01be5c 00000000
[  860.568603] be40: 804fc960 c0adb000 c0adbce4 7f03d328 00000000
7f03e578 7f061dec bfb52000
[  860.576784] be60: bf01beac bf01be70 7f001e68 7f0134f8 00000000
00000000 00000000 00000000
[  860.584965] be80: 00000000 bfb52000 7f09a0d4 bfb51800 00000000
bf9e7800 bf01a000 00000001
[  860.593146] bea0: bf01bec4 bf01beb0 7f05a138 7f001ce0 00000001
00000000 bf01bed4 bf01bec8
[  860.601327] bec0: 7f08bfe4 7f05a0cc bf01bf24 bf01bed8 8031ba0c
7f08bfc4 00000000 bf01bef3
[  860.609509] bee0: bfb51800 00000001 bf9e7bb4 7fffffff 0215d9c0
00000001 8031b874 00000000
[  860.617690] bf00: bf15d9c0 bf9e7800 8031b874 00000000 00000000
00000000 bf01bfac bf01bf28
[  860.625871] bf20: 8003c7e8 8031b880 bf01bf44 00000000 8004efd4
bf9e7800 00000000 00000001
[  860.634052] bf40: dead4ead ffffffff ffffffff 80702208 00000000
00000000 80600be8 bf01bf5c
[  860.642233] bf60: bf01bf5c 00000000 00000001 dead4ead ffffffff
ffffffff 80702208 00000000
[  860.650415] bf80: 00000000 80600be8 bf01bf88 bf01bf88 bf15d9c0
8003c724 00000000 00000000
[  860.658595] bfa0: 00000000 bf01bfb0 8000f308 8003c730 00000000
00000000 00000000 00000000
[  860.666776] bfc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[  860.674956] bfe0: 00000000 00000000 00000000 00000000 00000013
00000000 00000000 00000000
[  860.683133] Backtrace:
[  860.685607] [<80319b30>] (mmc_io_rw_extended+0x0/0x310) from
[<8031ade8>] (sdio_io_rw_ext_helper+0xe4/0x1a4)
[  860.695442] [<8031ad04>] (sdio_io_rw_ext_helper+0x0/0x1a4) from
[<8031aef8>] (sdio_readsb+0x24/0x2c)
[  860.704676] [<8031aed4>] (sdio_readsb+0x0/0x2c) from [<7f08c2bc>]
(woal_read_data_sync+0x50/0x8c [sd8xxx])
[  860.714455] [<7f08c26c>] (woal_read_data_sync+0x0/0x8c [sd8xxx])
from [<7f0622f0>] (moal_read_data_sync+0x10/0x14 [sd8xxx])
[  860.725586]  r8:00000000 r7:bfad9a00 r6:7f03d328 r5:00000700 r4:00000009
r3:00000000
[  860.733603] [<7f0622e0>] (moal_read_data_sync+0x0/0x14 [sd8xxx])
from [<7f0137a8>] (wlan_process_int_status+0x2bc/0x928 [mlan])
[  860.745139] [<7f0134ec>] (wlan_process_int_status+0x0/0x928 [mlan])
from [<7f001e68>] (mlan_main_process+0x194/0x750 [mlan])
[  860.756436] [<7f001cd4>] (mlan_main_process+0x0/0x750 [mlan]) from
[<7f05a138>] (woal_interrupt+0x78/0x94 [sd8xxx])
[  860.766982] [<7f05a0c0>] (woal_interrupt+0x0/0x94 [sd8xxx]) from
[<7f08bfe4>] (woal_sdio_interrupt+0x2c/0x30 [sd8xxx])
[  860.777677]  r5:00000000 r4:00000001
[  860.781351] [<7f08bfb8>] (woal_sdio_interrupt+0x0/0x30 [sd8xxx])
from [<8031ba0c>] (sdio_irq_thread+0x198/0x368)
[  860.791537] [<8031b874>] (sdio_irq_thread+0x0/0x368) from
[<8003c7e8>] (kthread+0xc4/0xe0)
[  860.799814] [<8003c724>] (kthread+0x0/0xe0) from [<8000f308>]
(ret_from_fork+0x14/0x2c)
[  860.807818]  r7:00000000 r6:00000000 r5:8003c724 r4:bf15d9c0
[  860.813538] Code: e1a09003 e59b400c e59b5010 ebfc3a75 (e5973000)
[  860.819646] ---[ end trace 1920724507aeb8b4 ]---
[  860.824270] Kernel panic - not syncing: Fatal exception
