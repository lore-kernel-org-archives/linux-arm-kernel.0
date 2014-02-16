From: mikpelinux@gmail.com (Mikael Pettersson)
Date: Sun, 16 Feb 2014 12:00:37 +0100
Subject: [REGRESSION] 3.14-rc2 boot failure on Kirkwood (qnap ts-119p+)
Message-ID: <21248.39509.418884.931848@gargle.gargle.HOWL>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

My Kirkwood box worked fine with the 3.13 kernel, but with 3.14-rc2
boot always fails due to a kernel NULL dereference in __clk_put.

This is a non-DT kernel, with:

CONFIG_ARCH_KIRKWOOD=y
CONFIG_KIRKWOOD_LEGACY=y
CONFIG_MACH_TS219=y
# CONFIG_ARCH_KIRKWOOD_DT is not set

bootm 0x800000
## Booting image at 00800000 ...
   Image Name:   
   Created:      2014-02-16  10:32:28 UTC
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2184040 Bytes =  2.1 MB
   Load Address: 00008000
   Entry Point:  00008000
   Verifying Checksum ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0x0
Linux version 3.14.0-rc2 (mikpe at hallertau) (gcc version 4.7.4 20130921 (prerelease) (GCC) ) #1 Sun Feb 16 11:31:46 CET 2014
CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=00053977
CPU: VIVT data cache, VIVT instruction cache
Machine: QNAP TS-119/TS-219
Ignoring unrecognised tag 0x41000403
Memory policy: Data cache writeback
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: console=ttyS0,115200n8 ro root=/dev/sda1
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 515268K/524288K available (3063K kernel code, 203K rwdata, 968K rodata, 123K init, 89K bss, 9020K reserved)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
    lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0xc0008000 - 0xc03f7ee4   (4032 kB)
      .init : 0xc03f8000 - 0xc0416e88   ( 124 kB)
      .data : 0xc0418000 - 0xc044af98   ( 204 kB)
       .bss : 0xc044af98 - 0xc04613ac   (  90 kB)
NR_IRQS:114
sched_clock: 32 bits at 200MHz, resolution 5ns, wraps every 21474836475ns
Console: colour dummy device 80x30
Calibrating delay loop... 1587.60 BogoMIPS (lpj=7938048)
pid_max: default: 32768 minimum: 301
Security Framework initialized
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0x303af8 - 0x303b34
devtmpfs: initialized
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
Kirkwood: MV88F6282-Rev-A0, TCLK=200000000.
Feroceon L2: Enabling L2
Feroceon L2: Cache support initialised.
Kirkwood PCIe port 0: link down
Kirkwood PCIe port 1: link down
PCI: bus0 uses PCIe port 0
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
pci_bus 0000:00: root bus resource [io  0x1000-0xffff]
pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
PCI: bus0: Fast back to back transfers disabled
PCI: bus1 uses PCIe port 1
PCI host bridge to bus 0000:01
pci_bus 0000:01: root bus resource [mem 0xe8000000-0xefffffff]
pci_bus 0000:01: root bus resource [io  0x10000-0x1ffff]
pci_bus 0000:01: No busn resource found for root bus, will use [bus 01-ff]
PCI: bus1: Fast back to back transfers disabled
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Switched to clocksource orion_clocksource
NET: Registered protocol family 2
TCP established hash table entries: 4096 (order: 2, 16384 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP: reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
futex hash table entries: 256 (order: -1, 2048 bytes)
Installing knfsd (copyright (C) 1996 okir at monad.swb.de).
msgmni has been set to 1006
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
mv_xor mv_xor.0: Marvell shared XOR driver
mv_xor mv_xor.0: Marvell XOR: ( xor cpy )
mv_xor mv_xor.0: Marvell XOR: ( xor cpy )
mv_xor mv_xor.1: Marvell shared XOR driver
mv_xor mv_xor.1: Marvell XOR: ( xor cpy )
mv_xor mv_xor.1: Marvell XOR: ( xor cpy )
Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xf1012000 (irq = 33, base_baud = 12500000) is a 16550A
console [ttyS0] enabled
serial8250.1: ttyS1 at MMIO 0xf1012100 (irq = 34, base_baud = 12500000) is a 16550A
loop: module loaded
sata_mv sata_mv.0: cannot get optional clkdev
sata_mv sata_mv.0: error getting phy
Unable to handle kernel NULL pointer dereference at virtual address 00000050
pgd = c0004000
[00000050] *pgd=00000000
Internal error: Oops: 5 [#1] ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 3.14.0-rc2 #1
task: df433a40 ti: df434000 task.ti: df434000
PC is at __clk_put+0x50/0x98
LR is at clk_prepare_lock+0x14/0xf0
pc : [<c02643e4>]    lr : [<c0262278>]    psr: 60000093
sp : df435d60  ip : df435d48  fp : df435d74
r10: df4526a0  r9 : df570ed0  r8 : 00000002
r7 : 00000000  r6 : ffffffda  r5 : 00000001  r4 : 00000000
r3 : 60000093  r2 : 60000013  r1 : df435d48  r0 : 00000001
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 0005397f  Table: 00004000  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xdf4341c0)
Stack: (0xdf435d60 to 0xdf436000)
5d60: df56c2b0 df5107b0 df435d84 df435d78 c0261d98 c02643a4 df435ddc df435d88
5d80: c01f8468 c0261d98 00000000 c0412094 df435dc4 00000015 c0319668 00000000
5da0: 74726f70 c0420030 c0425eb8 00000000 c01c55e4 c0425eb0 c043bdd4 c043bdd4
5dc0: c01c55e4 c040b388 00000000 c0412094 df435df4 df435de0 c01c6710 c01f8130
5de0: c0425eb0 00000000 df435e14 df435df8 c01c5494 c01c6700 00000000 c0425eb0
5e00: c0425ee4 c043bdd4 df435e34 df435e18 c01c5654 c01c53e8 c01c55e4 00000000
5e20: df435e38 c043bdd4 df435e5c df435e38 c01c3ce8 c01c55f4 df415d6c df45ac90
5e40: c043bdd4 df570f20 00000000 c043ad00 df435e6c df435e60 c01c4ff8 c01c3c7c
5e60: df435e94 df435e70 c01c4c38 c01c4fe8 c03a1f9f df435e80 c043bdd4 c0412088
5e80: c0416dbc c044afa0 df435eac df435e98 c01c5ae8 c01c4b64 00000000 c0412088
5ea0: df435ebc df435eb0 c01c6664 c01c5a54 df435ed4 df435ec0 c040b3b8 c01c6624
5ec0: df434000 00000006 df435f54 df435ed8 c000859c c040b398 df435f04 df435ee8
5ee0: c00d0038 dfffceba df435f00 df435ef8 c03f84e4 c01762c0 dfffceba dfffcebf
5f00: df435f54 df435f10 c002b4a0 c03f84d8 00000000 c03f6a20 00000006 00000006
5f20: 00000066 c03f63c0 df435f54 00000006 c0412088 c0416dbc c044afa0 00000066
5f40: 00000000 c0412094 df435f94 df435f58 c03f8b90 c0008510 00000006 00000006
5f60: c03f84c8 ffffffff ffffffff ffffffff 00000000 c02fc9c0 00000000 00000000
5f80: 00000000 00000000 df435fac df435f98 c02fc9d0 c03f8aa8 00000000 00000000
5fa0: 00000000 df435fb0 c0009170 c02fc9d0 00000000 00000000 00000000 00000000
5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 ffffffff ffffffff
Backtrace: 
[<c0264394>] (__clk_put) from [<c0261d98>] (clk_put+0x10/0x14)
 r4:df5107b0 r3:df56c2b0
[<c0261d88>] (clk_put) from [<c01f8468>] (mv_platform_probe+0x348/0x390)
[<c01f8120>] (mv_platform_probe) from [<c01c6710>] (platform_drv_probe+0x20/0x50)
 r10:c0412094 r9:00000000 r8:c040b388 r7:c01c55e4 r6:c043bdd4 r5:c043bdd4
 r4:c0425eb0
[<c01c66f0>] (platform_drv_probe) from [<c01c5494>] (driver_probe_device+0xbc/0x20c)
 r5:00000000 r4:c0425eb0
[<c01c53d8>] (driver_probe_device) from [<c01c5654>] (__driver_attach+0x70/0x94)
 r6:c043bdd4 r5:c0425ee4 r4:c0425eb0 r3:00000000
[<c01c55e4>] (__driver_attach) from [<c01c3ce8>] (bus_for_each_dev+0x7c/0x94)
 r6:c043bdd4 r5:df435e38 r4:00000000 r3:c01c55e4
[<c01c3c6c>] (bus_for_each_dev) from [<c01c4ff8>] (driver_attach+0x20/0x28)
 r7:c043ad00 r6:00000000 r5:df570f20 r4:c043bdd4
[<c01c4fd8>] (driver_attach) from [<c01c4c38>] (bus_add_driver+0xe4/0x1d8)
[<c01c4b54>] (bus_add_driver) from [<c01c5ae8>] (driver_register+0xa4/0xe8)
 r7:c044afa0 r6:c0416dbc r5:c0412088 r4:c043bdd4
[<c01c5a44>] (driver_register) from [<c01c6664>] (__platform_driver_register+0x50/0x64)
 r5:c0412088 r4:00000000
[<c01c6614>] (__platform_driver_register) from [<c040b3b8>] (mv_init+0x30/0x54)
[<c040b388>] (mv_init) from [<c000859c>] (do_one_initcall+0x9c/0x148)
 r4:00000006 r3:df434000
[<c0008500>] (do_one_initcall) from [<c03f8b90>] (kernel_init_freeable+0xf8/0x1bc)
 r10:c0412094 r9:00000000 r8:00000066 r7:c044afa0 r6:c0416dbc r5:c0412088
 r4:00000006
[<c03f8a98>] (kernel_init_freeable) from [<c02fc9d0>] (kernel_init+0x10/0xec)
 r10:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c02fc9c0 r4:00000000
[<c02fc9c0>] (kernel_init) from [<c0009170>] (ret_from_fork+0x14/0x24)
 r4:00000000 r3:00000000
Code: ebfff7a2 e10f2000 e3823080 e121f003 (e5943050) 
---[ end trace f432dda240fa88b0 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

Rebooting in 180 seconds..
