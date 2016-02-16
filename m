From: pankaj.embedded@gmail.com (Pankaj Pandey)
Date: Tue, 16 Feb 2016 20:50:52 +0530
Subject: e1000e: eth0: Detected Hardware Unit Hang
Message-ID: <CAOdCjQsRAOh4duc4-tABduF=9qTR5cNSDaDkEqr4zz4LXGTRSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I am booting 3.10 kernel uImage on arm64 based target. During NFS
booting from eth0 port I am getting  "eth0: Detected Hardware Unit
Hang" . Eth0  port is  intel ethernet 1gb  PCIe card.
 Same intel PCIe card  eth0 Port working fine in 4.1 kernel. Please
find the error log below :-

Any pointer what could be reason of below mentioned error in 3.10
kernel and this same error is coming till 4.0 kernel ?

[    0.847742] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[    0.854820] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    0.860657] e1000e: Intel(R) PRO/1000 Network Driver - 2.3.2-k
[    0.866522] e1000e: Copyright(c) 1999 - 2013 Intel Corporation.
[    0.872483] e1000e 0000:03:00.0: Disabling ASPM L0s L1
[    0.877765] e1000e 0000:03:00.0: Interrupt Throttling Rate (ints/sec) set to
dynamic conservative mode
[    0.887131] e1000e 0000:03:00.0 (unregistered net_device): Failed to
initialize MSI-X interrupts.  Falling back to MSI interrupts.
[    0.898931] e1000e 0000:03:00.0 (unregistered net_device): Failed to
initialize MSI interrupts.  Falling back to legacy interrupts.
[    1.117898] e1000e 0000:03:00.0 eth0: registered PHC clock
[    1.123412] e1000e 0000:03:00.0 eth0: (PCI Express:2.5GT/s:Width x1)
68:05:ca:3b:99:d1
[    1.131364] e1000e 0000:03:00.0 eth0: Intel(R) PRO/1000 Network Connection
[    1.138280] e1000e 0000:03:00.0 eth0: MAC: 3, PHY: 8, PBA No: E46981-008
......................................
.................................
..................................

[    4.414294] IP-Config: Complete:
[    4.417540]      device=eth0, hwaddr=68:05:ca:3b:99:d1, ipaddr=10.162.10.20,
mask=255.255.0.0, gw=10.162.103.241
[    4.427759]      host=arm64, domain=, nis-domain=(none)
[    4.433182]      bootserver=10.162.103.241, rootserver=10.162.103.241,
rootpath=
[    8.164526] e1000e 0000:03:00.0 eth0: Detected Hardware Unit Hang:
[    8.164526]   TDH                  <1>
[    8.164526]   TDT                  <1>
[    8.164526]   next_to_use          <1>
[    8.164526]   next_to_clean        <0>
[    8.164526] buffer_info[next_to_clean]:
[    8.164526]   time_stamp           <ffffe8e9>
[    8.164526]   next_to_watch        <0>
[    8.164526]   jiffies              <ffffe934>
[    8.164526]   next_to_watch.status <0>
[    8.164526] MAC Status             <80783>
[    8.164526] PHY Status             <796d>
[    8.164526] PHY 1000BASE-T Status  <3800>
[    8.164526] PHY Extended Status    <3000>
[    8.164526] PCI Status             <10>
[   12.164522] e1000e 0000:03:00.0 eth0: Detected Hardware Unit Hang:
[   12.164522]   TDH                  <1>
[   12.164522]   TDT                  <1>
[   12.164522]   next_to_use          <1>
[   12.164522]   next_to_clean        <0>
[   12.164522] buffer_info[next_to_clean]:
[   12.164522]   time_stamp           <ffffe8e9>
[   12.164522]   next_to_watch        <0>
[   12.164522]   jiffies              <ffffe984>
[   12.164522]   next_to_watch.status <0>
[   12.164522] MAC Status             <80783>
[   12.164522] PHY Status             <796d>
[   12.164522] PHY 1000BASE-T Status  <3800>
[   12.164522] PHY Extended Status    <3000>
[   12.164522] PCI Status             <10>
[   14.164136] ------------[ cut here ]------------
[   14.168782] WARNING: at net/sched/sch_generic.c:255
dev_watchdog+0x2d8/0x2e8()
[   14.176037] NETDEV WATCHDOG: eth0 (e1000e): transmit queue 0 timed out
[   14.182591] Modules linked in:
[   14.185675] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
3.10.94-rt102-04142-gcce5fca-dirty #108
[   14.194238] Call trace:
[   14.196699] [<ffffffc000087c80>] dump_backtrace+0x0/0x128
[   14.202124] [<ffffffc000087dbc>] show_stack+0x14/0x20
[   14.207200] [<ffffffc000541954>] dump_stack+0x20/0x28
[   14.212276] [<ffffffc00009b09c>] warn_slowpath_common+0x7c/0xa0
[   14.218226] [<ffffffc00009b188>] warn_slowpath_fmt+0x50/0x58
[   14.223910] [<ffffffc00049e018>] dev_watchdog+0x2d8/0x2e8
[   14.229333] [<ffffffc0000a978c>] call_timer_fn.isra.30+0x2c/0x90
[   14.235366] [<ffffffc0000aa138>] run_timer_softirq+0x1c0/0x230
[   14.241226] [<ffffffc0000a283c>] __do_softirq+0x184/0x1d8
[   14.246648] [<ffffffc0000a294c>] do_softirq+0x54/0x58
[   14.251724] [<ffffffc0000a3088>] irq_exit+0x88/0xe0
[   14.256626] [<ffffffc0000fb630>] __handle_domain_irq+0x78/0xd8
[   14.262484] [<ffffffc0000813b0>] gic_handle_irq+0x50/0x98
[   14.267909] Exception stack(0xffffffc000713db0 to 0xffffffc000713ed0)
[   14.274379] 3da0:                                     ffffffc0 00710000
ffffffc0 00766300
[   14.282594] 3dc0: ffffffc0 00713f00 ffffffc0 00084d80 00000000 ffffe985
ffffffc1 fefa1780
[   14.290809] 3de0: 00000000 000012ba 00000000 00000000 ffffffc1 fef9d0a4
00000000 00010000
[   14.299022] 3e00: 00000000 00000020 000bebc2 00000000 00000000 28000000
00000001 8d0d2938
[   14.307235] 3e20: ffffffc0 0071b000 ffffffc0 00713ce0 00000000 ffffe986
20537461 74757320
[   14.315451] 3e40: 00000000 00000006 00000000 00000000 00000000 00000003
00000000 00000001
[   14.323666] 3e60: ffffffc1 f6f72e38 ffffffc0 00594210 00000000 00000000
ffffffc0 00710000
[   14.331880] 3e80: ffffffc0 00766300 ffffffc0 0076d420 ffffffc0 0054ae00
ffffffc0 0075ce5c
[   14.340097] 3ea0: ffffffc0 00667498 00000000 00000001 00000000 0007d000
ffffffc0 00080498
[   14.348310] 3ec0: 00000000 00080270 ffffffc0 00713f00
[   14.353383] [<ffffffc000083dac>] el1_irq+0x6c/0xc0
[   14.358198] [<ffffffc0000d5a50>] cpu_startup_entry+0xf8/0x140
[   14.363972] [<ffffffc00053c0f8>] rest_init+0x70/0x78
[   14.368965] [<ffffffc0006e47b4>] start_kernel+0x318/0x328
[   14.374386] ---[ end trace 4804658c584f9eb7 ]---
[   14.379044] e1000e 0000:03:00.0 eth0: Reset adapter unexpectedly
[   17.615130] e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control:
Rx/Tx
[   23.164143] e1000e 0000:03:00.0 eth0: Reset adapter unexpectedly
[   26.315131] e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control:
Rx/Tx

Regards,
Pankaj Pandey
