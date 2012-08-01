From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 31 Jul 2012 23:39:40 -0300
Subject: Several crashes on imx_v6_v7_defconfig
Message-ID: <CAOMZO5D1oM0q2H=ZqNc3Jq9T5+kGypnDbFC8O1a5D6qQYy1ySA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

After manually fixing two build errors (patches already submitted, but
they were not applied into linux-next yet) on imx_v6_v7_defconfig and
booting a dt kernel on mx51evk I get:

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0
Linux version 3.5.0+ (fabio at fabio-Latitude-E6410) (gcc version 4.4.4 (4.4.4_09.2
CPU: ARMv7 Processor [412fc085] revision 5 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: Freescale i.MX51 (Device Tree Support), model: Freescale i.MX51 Babbagd
Memory policy: ECC disabled, Data cache writeback
PERCPU: Embedded 7 pages/cpu @80af1000 s6208 r8192 d14272 u32768
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: console=ttymxc0,115200 root=/dev/nfs ip=dhcp nfsroot=192.1p
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 512MB = 512MB total
Memory: 512636k/512636k available, 11652k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xa0800000 - 0xff000000   (1512 MB)
    lowmem  : 0x80000000 - 0xa0000000   ( 512 MB)
    modules : 0x7f000000 - 0x80000000   (  16 MB)
      .text : 0x80008000 - 0x8060a000   (6152 kB)
      .init : 0x8060a000 - 0x80653840   ( 295 kB)
      .data : 0x80654000 - 0x80691a60   ( 247 kB)
       .bss : 0x80691a84 - 0x806e878c   ( 348 kB)
SLUB: Genslabs=11, HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Hierarchical RCU implementation.
        RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=1.
NR_IRQS:16 nr_irqs:16 16
TrustZone Interrupt Controller (TZIC) initialized
sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956ms
CPU identified as i.MX51, silicon rev 3.0
Console: colour dummy device 80x30
Calibrating delay loop... 531.66 BogoMIPS (lpj=2658304)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
CPU0: thread -1, cpu 0, socket -1, mpidr 0
Setting up static identity map for 0x904bdc08 - 0x904bdc78
Brought up 1 CPUs
SMP: Total of 1 processors activated (531.66 BogoMIPS).
devtmpfs: initialized
pinctrl core: initialized pinctrl subsystem
dummy:
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Advanced Linux Sound Architecture Driver Version 1.0.25.
Switching to clocksource mxc_timer1
NET: Registered protocol family 2
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP: reno registered
UDP hash table entries: 256 (order: 1, 8192 bytes)
UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
NFS: Registering the id_resolver key type
Key type id_resolver registered
jffs2: version 2.2. (NAND) ?? 2001-2006 Red Hat, Inc.
fuse init (API version 7.19)
msgmni has been set to 1001
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
imx-sdma imx35-sdma: initialized
Serial: IMX driver
imx21-uart.2: ttymxc2 at MMIO 0x7000c000 (irq = 49) is a IMX
imx21-uart.0: ttymxc0 at MMIO 0x73fbc000 (irq = 47) is a IMX
console [ttymxc0] enabled
imx21-uart.1: ttymxc1 at MMIO 0x73fc0000 (irq = 48) is a IMX
brd: module loaded
loop: module loaded
spi_imx imx51-ecspi.0: master is unqueued, this is deprecated
mc13xxx spi32766.0: mc13892: rev: 2.0, fin: 2, fab: 0, icid: 7/2
mc13xxx: probe of spi32766.0 failed with error -22
mtd_dataflash spi32766.1: at45db321d (4096 KBytes) pagesize 512 bytes (OTP)
2 ofpart partitions found on MTD device spi32766.1-at45db321d
Creating 2 MTD partitions on "spi32766.1-at45db321d":
0x000000000000-0x000000040000 : "U-Boot"
Unable to handle kernel NULL pointer dereference at virtual address 00000234
pgd = 80004000
[00000234] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: 0    Not tainted  (3.5.0+ #26)
PC is at sysfs_create_dir+0x38/0xf8
LR is at kobject_add_internal+0xc0/0x1fc
pc : [<80118574>]    lr : [<80251f0c>]    psr: 20000013
sp : 9f855a38  ip : 9f855a68  fp : 9f855a64
r10: 9fa40810  r9 : 8067c904  r8 : 9fa40808
r7 : 9fa40900  r6 : 00000200  r5 : 9fa4a100  r4 : 9fa4a100
r3 : 9fa40808  r2 : 00000000  r1 : 00020002  r0 : 9fa4a100
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 90004019  DAC: 00000017
Process swapper/0 (pid: 1, stack limit = 0x9f8542f0)
Stack: (0x9f855a38 to 0x9f856000)
5a20:                                                       00000004 00000000
5a40: 8067c904 9fa40810 80252214 9fa40808 9fa4a100 00000000 9f855a9c 9f855a68
5a60: 80251f0c 80118548 8067c904 9fa40810 9f855a9c 9f855a80 80252214 9fa40808
5a80: 9fa4a100 00000000 9fa40900 00000000 9f855abc 9f855aa0 80252250 80251e58
5aa0: 9fa4a100 9fa40808 8067c320 9fa40900 9f855ad4 9f855ac0 802522ec 80252228
5ac0: 9fa40900 9f855adc 9f855afc 9f855ae0 802ada44 802522c0 80590d70 80584f40
5ae0: 9fa408f8 9fa40800 9fa408f8 9fa40900 9f855b44 9f855b00 802aea98 802ad908
5b00: 00000000 9fa408f8 9f855b2c 9f855b18 802b8a24 8004b7c8 9fa408f8 9fa408f8
5b20: 8067c320 9fa408f8 000001e0 00000000 8067c904 9fa40810 9f855b5c 9f855b48
5b40: 802af058 802aea24 9fa40810 8067c320 9f855b8c 9f855b60 802f08b4 802af048
5b60: 8067c8f0 9fa4a040 9f855b8c 00000000 00000001 9fa4a040 8067c8f0 000001e0
5b80: 9f855bdc 9f855b90 802f41f0 802f0764 00000000 00000000 802f365c 00000002
5ba0: 9f855bdc 9f98cc40 00000000 00000000 9f855c28 00000000 00000000 9f98cc40
5bc0: 00000002 9f98cc04 00000064 9f98cc04 9f855c04 9f855be0 802f0a98 802f413c
5be0: 9f855be4 9fa4a040 9f98cc00 9fa40800 00000200 00000000 9f855c5c 9f855c08
5c00: 804af4e0 802f0a18 00000000 00000000 00000200 805c3bd8 00000000 805c3cdc
5c20: 00000000 00000064 9f855c24 80aec5a4 9f855c7c 806917b8 9fa40800 806917f4
5c40: 001f2701 00000001 9f855c6e 9f855c6d 9f855c9c 9f855c60 804af684 804af360
5c60: 00000009 00000064 8001271f 9fb5d7c0 9f855c8c 806e0b84 9fa40800 9fa40800
5c80: 8067cc6c 806e0b60 9f817080 9f855dc0 9f855cac 9f855ca0 8032acd0 804af544
5ca0: 9f855cd4 9f855cb0 802b1024 8032acbc 8067cc6c 9fa40800 802b1240 00000000
5cc0: 806e0b60 9f817080 9f855cec 9f855cd8 802b1284 802b0fb0 9fa40800 9f855cf0
5ce0: 9f855d14 9f855cf0 802af71c 802b124c 9f834c6c 9f9ff8b8 9fa40834 9fa40800
5d00: 80682818 9fa40808 9f855d34 9f855d18 802b133c 802af6c0 9fa40800 9fa40800
5d20: 80682818 9fa40808 9f855d54 9f855d38 802b0358 802b12c0 9fa40800 9f98c800
5d40: 00000000 9fa40808 9f855d9c 9f855d58 802aef6c 802b02d8 00000000 00000000
5d60: 9fa40800 00000000 9f855d8c 9f855d78 8032d884 9fa40800 00000000 9f883208
5d80: 00000000 9fa40900 9f817080 9f855dc0 9f855dbc 9f855da0 8032bc98 802aea24
5da0: 9f98c800 80aec5a4 9fa40800 00000000 9f855dec 9f855dc0 8032bff4 8032bbf8
5dc0: 00000004 9f98c980 9f98c980 9f882d00 9f817000 80aeb4ec 9f883200 9f98c800
5de0: 9f855e0c 9f855df0 8032c708 8032be20 00000000 804bb29c 00000002 9f882d00
5e00: 9f855e5c 9f855e10 804b04a4 8032c600 805c9330 9f98c980 9f883208 804e01d0
5e20: 9f98c980 9f883208 00000095 00000002 9f855e4c 806e0b84 8068291c 9f883208
5e40: 8068291c 00000095 806513a0 80644ef4 9f855e6c 9f855e60 802b2508 804b00a4
5e60: 9f855e94 9f855e70 802b1024 802b24f4 9f883208 8068291c 9f88323c 00000000
5e80: 00000095 806513a0 9f855eb4 9f855e98 802b123c 802b0fb0 8068291c 9f855eb8
5ea0: 802b11a8 00000000 9f855edc 9f855eb8 802af7b0 802b11b4 9f834158 9f880534
5ec0: 8068291c 8067af08 9f9ff480 00000000 9f855eec 9f855ee0 802b0e84 802af754
5ee0: 9f855f14 9f855ef0 802b00e0 802b0e70 805c9330 9f855f00 9f854000 8068291c
5f00: 80691ac0 00000000 9f855f3c 9f855f18 802b186c 802aff68 9f854000 00000007
5f20: 80691ac0 00000000 00000095 806513a0 9f855f4c 9f855f40 802b28b0 802b17f8
5f40: 9f855f5c 9f855f50 80630f84 802b2870 9f855fb4 9f855f60 800086b4 80630f7c
5f60: 9f855fb4 9f855f70 80630f70 00000000 00000000 00000006 00000006 80608ea8
5f80: 805ceeb0 60000013 9f855fb4 80644eec 00000007 80691ac0 8060a270 00000095
5fa0: 806513a0 80644ef4 9f855ff4 9f855fb8 8060a3f4 80008680 00000006 00000006
5fc0: 8060a270 8060a2f8 800283fc 00000000 8060a2f8 800283fc 00000013 00000000
5fe0: 00000000 00000000 00000000 9f855ff8 800283fc 8060a304 00000000 00000000
Backtrace:
[<8011853c>] (sysfs_create_dir+0x0/0xf8) from [<80251f0c>] (kobject_add_interna)
 r6:00000000 r5:9fa4a100 r4:9fa40808
[<80251e4c>] (kobject_add_internal+0x0/0x1fc) from [<80252250>] (kobject_add_va)
 r8:00000000 r7:9fa40900 r6:00000000 r5:9fa4a100 r4:9fa40808
[<8025221c>] (kobject_add_varg+0x0/0x50) from [<802522ec>] (kobject_add+0x3c/0x)
 r7:9fa40900 r6:8067c320 r5:9fa40808 r4:9fa4a100
[<802522b0>] (kobject_add+0x0/0x64) from [<802ada44>] (get_device_parent+0x148/)
 r3:80584f40 r2:80590d70
[<802ad8fc>] (get_device_parent+0x0/0x1e0) from [<802aea98>] (device_add+0x80/0)
 r7:9fa40900 r6:9fa408f8 r5:9fa40800 r4:9fa408f8
[<802aea18>] (device_add+0x0/0x624) from [<802af058>] (device_register+0x1c/0x2)
[<802af03c>] (device_register+0x0/0x20) from [<802f08b4>] (add_mtd_device+0x15c)
 r5:8067c320 r4:9fa40810
[<802f0758>] (add_mtd_device+0x0/0x2b4) from [<802f41f0>] (add_mtd_partitions+0)
 r7:000001e0 r6:8067c8f0 r5:9fa4a040 r4:00000001
[<802f4130>] (add_mtd_partitions+0x0/0x104) from [<802f0a98>] (mtd_device_parse)
[<802f0a0c>] (mtd_device_parse_register+0x0/0xc4) from [<804af4e0>] (add_datafl)
 r7:00000000 r6:00000200 r5:9fa40800 r4:9f98cc00
[<804af354>] (add_dataflash_otp+0x0/0x1e4) from [<804af684>] (dataflash_probe+0)
[<804af538>] (dataflash_probe+0x0/0x2e8) from [<8032acd0>] (spi_drv_probe+0x20/)
[<8032acb0>] (spi_drv_probe+0x0/0x24) from [<802b1024>] (driver_probe_device+0x)
[<802b0fa4>] (driver_probe_device+0x0/0x204) from [<802b1284>] (__device_attach)
 r9:9f817080 r8:806e0b60 r7:00000000 r6:802b1240 r5:9fa40800
r4:8067cc6c
[<802b1240>] (__device_attach+0x0/0x48) from [<802af71c>] (bus_for_each_drv+0x6)
 r5:9f855cf0 r4:9fa40800
[<802af6b4>] (bus_for_each_drv+0x0/0x94) from [<802b133c>] (device_attach+0x88/)
 r7:9fa40808 r6:80682818 r5:9fa40800 r4:9fa40834
[<802b12b4>] (device_attach+0x0/0xa0) from [<802b0358>] (bus_probe_device+0x8c/)
 r7:9fa40808 r6:80682818 r5:9fa40800 r4:9fa40800
[<802b02cc>] (bus_probe_device+0x0/0xb4) from [<802aef6c>] (device_add+0x554/0x)
 r7:9fa40808 r6:00000000 r5:9f98c800 r4:9fa40800
[<802aea18>] (device_add+0x0/0x624) from [<8032bc98>] (spi_add_device+0xac/0x12)
[<8032bbec>] (spi_add_device+0x0/0x12c) from [<8032bff4>] (spi_register_master+)
 r7:00000000 r6:9fa40800 r5:80aec5a4 r4:9f98c800
[<8032be14>] (spi_register_master+0x0/0x484) from [<8032c708>] (spi_bitbang_sta)
[<8032c5f4>] (spi_bitbang_start+0x0/0x18c) from [<804b04a4>] (spi_imx_probe+0x4)
 r5:9f882d00 r4:00000002
[<804b0098>] (spi_imx_probe+0x0/0x53c) from [<802b2508>] (platform_drv_probe+0x)
[<802b24e8>] (platform_drv_probe+0x0/0x24) from [<802b1024>] (driver_probe_devi)
[<802b0fa4>] (driver_probe_device+0x0/0x204) from [<802b123c>] (__driver_attach)
 r9:806513a0 r8:00000095 r7:00000000 r6:9f88323c r5:8068291c
r4:9f883208
[<802b11a8>] (__driver_attach+0x0/0x98) from [<802af7b0>] (bus_for_each_dev+0x6)
 r7:00000000 r6:802b11a8 r5:9f855eb8 r4:8068291c
[<802af748>] (bus_for_each_dev+0x0/0x94) from [<802b0e84>] (driver_attach+0x20/)
 r7:00000000 r6:9f9ff480 r5:8067af08 r4:8068291c
[<802b0e64>] (driver_attach+0x0/0x28) from [<802b00e0>] (bus_add_driver+0x184/0)
[<802aff5c>] (bus_add_driver+0x0/0x240) from [<802b186c>] (driver_register+0x80)
 r7:00000000 r6:80691ac0 r5:8068291c r4:9f854000
[<802b17ec>] (driver_register+0x0/0x148) from [<802b28b0>] (platform_driver_reg)
 r9:806513a0 r8:00000095 r7:00000000 r6:80691ac0 r5:00000007
r4:9f854000
[<802b2864>] (platform_driver_register+0x0/0x60) from [<80630f84>] (spi_imx_dri)
[<80630f70>] (spi_imx_driver_init+0x0/0x1c) from [<800086b4>] (do_one_initcall+)
[<80008674>] (do_one_initcall+0x0/0x194) from [<8060a3f4>] (kernel_init+0xfc/0x)
[<8060a2f8>] (kernel_init+0x0/0x1cc) from [<800283fc>] (do_exit+0x0/0x810)
Code: e5936018 e3560000 03e00001 0a00001c (e1d653b4)
---[ end trace 86fb1362828fca3e ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = 80004000
[00000000] *pgd=00000000
Internal error: Oops: 80000005 [#2] SMP ARM
Modules linked in:
CPU: 0    Tainted: G      D       (3.5.0+ #26)
PC is at 0x0
LR is at smp_send_stop+0x58/0xfc
pc : [<00000000>]    lr : [<800139d0>]    psr: 60000193
sp : 9f8557a8  ip : 00000000  fp : 9f8557cc
r10: 9f854000  r9 : 9f85587f  r8 : 9f85581c
r7 : 8067015c  r6 : 8065cf18  r5 : 000f4240  r4 : 9f8557ac
r3 : 00000000  r2 : 00000000  r1 : 00000006  r0 : 9f8557ac
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: 90004019  DAC: 00000015
Process swapper/0 (pid: 1, stack limit = 0x9f8542f0)
Stack: (0x9f8557a8 to 0x9f856000)
57a0:                   806928b0 00000000 806928b0 806928b0 0000000b 9f84e000
57c0: 9f8557e4 9f8557d0 804ba978 80013984 9f84e000 9f8557ec 9f85582c 9f8557f8
57e0: 80028b04 804ba90c 8058bf18 0000000b 80656040 9f856000 9f854000 9f855814
5800: 00000001 9f84e25c 9f85587f 80691e20 9f85582c 9f855814 9f855814 9f84e14c
5820: 9f8558b4 9f855830 80012878 80028408 9f8542f0 0000000b 00000001 00000008
5840: 9f854000 00000000 60000113 80118578 33393565 38313036 35336520 30303036
5860: 33302030 30303065 30203130 30303061 20633130 64316528 62333536 00202934
5880: 800159f4 804bab48 805e113c 9f8559f0 00000234 00000000 00000005 00000000
58a0: 9f84e000 00000234 9f8558dc 9f8558b8 80015ac0 80012688 9f854000 00000000
58c0: 9f8559f0 00000005 9fa40808 9f84e000 9f855924 9f8558e0 80015c38 80015a60
58e0: 00000000 80668080 00000000 00000000 00000028 00000001 9f85591c 00000005
5900: 80660c3c 00000234 9f8559f0 9fa40808 8067c904 9fa40810 9f855944 9f855928
5920: 80015e64 80015aec 00000005 80660c3c 00000234 9f8559f0 9f8559ec 9f855948
5940: 80008434 80015dcc 9f8559bc 00000000 00000001 806914c4 80690e60 00000000
5960: 000212d0 8065d148 00000008 80af4b5c 00000000 60000013 202fbf00 80690e40
5980: 1fa2dafe 00000000 806914c0 8065cf90 00000000 000012d0 00000000 806914c4
59a0: 9f855a44 9f8559b0 8008701c 800868f0 00000000 00000041 80690e40 00000000
59c0: 9fa0ce00 8065c94c 9f8559fc 9f8559d8 80118574 20000013 ffffffff 9f855a24
59e0: 9f855a64 9f8559f0 8000e760 80008404 9fa4a100 00020002 00000000 9fa40808
5a00: 9fa4a100 9fa4a100 00000200 9fa40900 9fa40808 8067c904 9fa40810 9f855a64
5a20: 9f855a68 9f855a38 80251f0c 80118574 20000013 ffffffff 00000004 00000000
5a40: 8067c904 9fa40810 80252214 9fa40808 9fa4a100 00000000 9f855a9c 9f855a68
5a60: 80251f0c 80118548 8067c904 9fa40810 9f855a9c 9f855a80 80252214 9fa40808
5a80: 9fa4a100 00000000 9fa40900 00000000 9f855abc 9f855aa0 80252250 80251e58
5aa0: 9fa4a100 9fa40808 8067c320 9fa40900 9f855ad4 9f855ac0 802522ec 80252228
5ac0: 9fa40900 9f855adc 9f855afc 9f855ae0 802ada44 802522c0 80590d70 80584f40
5ae0: 9fa408f8 9fa40800 9fa408f8 9fa40900 9f855b44 9f855b00 802aea98 802ad908
5b00: 00000000 9fa408f8 9f855b2c 9f855b18 802b8a24 8004b7c8 9fa408f8 9fa408f8
5b20: 8067c320 9fa408f8 000001e0 00000000 8067c904 9fa40810 9f855b5c 9f855b48
5b40: 802af058 802aea24 9fa40810 8067c320 9f855b8c 9f855b60 802f08b4 802af048
5b60: 8067c8f0 9fa4a040 9f855b8c 00000000 00000001 9fa4a040 8067c8f0 000001e0
5b80: 9f855bdc 9f855b90 802f41f0 802f0764 00000000 00000000 802f365c 00000002
5ba0: 9f855bdc 9f98cc40 00000000 00000000 9f855c28 00000000 00000000 9f98cc40
5bc0: 00000002 9f98cc04 00000064 9f98cc04 9f855c04 9f855be0 802f0a98 802f413c
5be0: 9f855be4 9fa4a040 9f98cc00 9fa40800 00000200 00000000 9f855c5c 9f855c08
5c00: 804af4e0 802f0a18 00000000 00000000 00000200 805c3bd8 00000000 805c3cdc
5c20: 00000000 00000064 9f855c24 80aec5a4 9f855c7c 806917b8 9fa40800 806917f4
5c40: 001f2701 00000001 9f855c6e 9f855c6d 9f855c9c 9f855c60 804af684 804af360
5c60: 00000009 00000064 8001271f 9fb5d7c0 9f855c8c 806e0b84 9fa40800 9fa40800
5c80: 8067cc6c 806e0b60 9f817080 9f855dc0 9f855cac 9f855ca0 8032acd0 804af544
5ca0: 9f855cd4 9f855cb0 802b1024 8032acbc 8067cc6c 9fa40800 802b1240 00000000
5cc0: 806e0b60 9f817080 9f855cec 9f855cd8 802b1284 802b0fb0 9fa40800 9f855cf0
5ce0: 9f855d14 9f855cf0 802af71c 802b124c 9f834c6c 9f9ff8b8 9fa40834 9fa40800
5d00: 80682818 9fa40808 9f855d34 9f855d18 802b133c 802af6c0 9fa40800 9fa40800
5d20: 80682818 9fa40808 9f855d54 9f855d38 802b0358 802b12c0 9fa40800 9f98c800
5d40: 00000000 9fa40808 9f855d9c 9f855d58 802aef6c 802b02d8 00000000 00000000
5d60: 9fa40800 00000000 9f855d8c 9f855d78 8032d884 9fa40800 00000000 9f883208
5d80: 00000000 9fa40900 9f817080 9f855dc0 9f855dbc 9f855da0 8032bc98 802aea24
5da0: 9f98c800 80aec5a4 9fa40800 00000000 9f855dec 9f855dc0 8032bff4 8032bbf8
5dc0: 00000004 9f98c980 9f98c980 9f882d00 9f817000 80aeb4ec 9f883200 9f98c800
5de0: 9f855e0c 9f855df0 8032c708 8032be20 00000000 804bb29c 00000002 9f882d00
5e00: 9f855e5c 9f855e10 804b04a4 8032c600 805c9330 9f98c980 9f883208 804e01d0
5e20: 9f98c980 9f883208 00000095 00000002 9f855e4c 806e0b84 8068291c 9f883208
5e40: 8068291c 00000095 806513a0 80644ef4 9f855e6c 9f855e60 802b2508 804b00a4
5e60: 9f855e94 9f855e70 802b1024 802b24f4 9f883208 8068291c 9f88323c 00000000
5e80: 00000095 806513a0 9f855eb4 9f855e98 802b123c 802b0fb0 8068291c 9f855eb8
5ea0: 802b11a8 00000000 9f855edc 9f855eb8 802af7b0 802b11b4 9f834158 9f880534
5ec0: 8068291c 8067af08 9f9ff480 00000000 9f855eec 9f855ee0 802b0e84 802af754
5ee0: 9f855f14 9f855ef0 802b00e0 802b0e70 805c9330 9f855f00 9f854000 8068291c
5f00: 80691ac0 00000000 9f855f3c 9f855f18 802b186c 802aff68 9f854000 00000007
5f20: 80691ac0 00000000 00000095 806513a0 9f855f4c 9f855f40 802b28b0 802b17f8
5f40: 9f855f5c 9f855f50 80630f84 802b2870 9f855fb4 9f855f60 800086b4 80630f7c
5f60: 9f855fb4 9f855f70 80630f70 00000000 00000000 00000006 00000006 80608ea8
5f80: 805ceeb0 60000013 9f855fb4 80644eec 00000007 80691ac0 8060a270 00000095
5fa0: 806513a0 80644ef4 9f855ff4 9f855fb8 8060a3f4 80008680 00000006 00000006
5fc0: 8060a270 8060a2f8 800283fc 00000000 8060a2f8 800283fc 00000013 00000000
5fe0: 00000000 00000000 00000000 9f855ff8 800283fc 8060a304 00000000 00000000
Backtrace:
[<80013978>] (smp_send_stop+0x0/0xfc) from [<804ba978>] (panic+0x7c/0x1bc)
 r7:9f84e000 r6:0000000b r5:806928b0 r4:806928b0
[<804ba8fc>] (panic+0x0/0x1bc) from [<80028b04>] (do_exit+0x708/0x810)
 r3:9f856000 r2:80656040 r1:0000000b r0:8058bf18
[<800283fc>] (do_exit+0x0/0x810) from [<80012878>] (die+0x1fc/0x40c)
[<8001267c>] (die+0x0/0x40c) from [<80015ac0>] (__do_kernel_fault+0x6c/0x8c)
[<80015a54>] (__do_kernel_fault+0x0/0x8c) from [<80015c38>] (do_page_fault+0x15)
 r9:9f84e000 r8:9fa40808 r7:00000005 r6:9f8559f0 r5:00000000
r4:9f854000
[<80015ae0>] (do_page_fault+0x0/0x26c) from [<80015e64>] (do_translation_fault+)
[<80015dc0>] (do_translation_fault+0x0/0xac) from [<80008434>] (do_DataAbort+0x)
 r7:9f8559f0 r6:00000234 r5:80660c3c r4:00000005
[<800083f8>] (do_DataAbort+0x0/0xa4) from [<8000e760>] (__dabt_svc+0x40/0x60)
Exception stack(0x9f8559f0 to 0x9f855a38)
59e0:                                     9fa4a100 00020002 00000000 9fa40808
5a00: 9fa4a100 9fa4a100 00000200 9fa40900 9fa40808 8067c904 9fa40810 9f855a64
5a20: 9f855a68 9f855a38 80251f0c 80118574 20000013 ffffffff
 r7:9f855a24 r6:ffffffff r5:20000013 r4:80118574
[<8011853c>] (sysfs_create_dir+0x0/0xf8) from [<80251f0c>] (kobject_add_interna)
 r6:00000000 r5:9fa4a100 r4:9fa40808
[<80251e4c>] (kobject_add_internal+0x0/0x1fc) from [<80252250>] (kobject_add_va)
 r8:00000000 r7:9fa40900 r6:00000000 r5:9fa4a100 r4:9fa40808
[<8025221c>] (kobject_add_varg+0x0/0x50) from [<802522ec>] (kobject_add+0x3c/0x)
 r7:9fa40900 r6:8067c320 r5:9fa40808 r4:9fa4a100
[<802522b0>] (kobject_add+0x0/0x64) from [<802ada44>] (get_device_parent+0x148/)
 r3:80584f40 r2:80590d70
[<802ad8fc>] (get_device_parent+0x0/0x1e0) from [<802aea98>] (device_add+0x80/0)
 r7:9fa40900 r6:9fa408f8 r5:9fa40800 r4:9fa408f8
[<802aea18>] (device_add+0x0/0x624) from [<802af058>] (device_register+0x1c/0x2)
[<802af03c>] (device_register+0x0/0x20) from [<802f08b4>] (add_mtd_device+0x15c)
 r5:8067c320 r4:9fa40810
[<802f0758>] (add_mtd_device+0x0/0x2b4) from [<802f41f0>] (add_mtd_partitions+0)
 r7:000001e0 r6:8067c8f0 r5:9fa4a040 r4:00000001
[<802f4130>] (add_mtd_partitions+0x0/0x104) from [<802f0a98>] (mtd_device_parse)
[<802f0a0c>] (mtd_device_parse_register+0x0/0xc4) from [<804af4e0>] (add_datafl)
 r7:00000000 r6:00000200 r5:9fa40800 r4:9f98cc00
[<804af354>] (add_dataflash_otp+0x0/0x1e4) from [<804af684>] (dataflash_probe+0)
[<804af538>] (dataflash_probe+0x0/0x2e8) from [<8032acd0>] (spi_drv_probe+0x20/)
[<8032acb0>] (spi_drv_probe+0x0/0x24) from [<802b1024>] (driver_probe_device+0x)
[<802b0fa4>] (driver_probe_device+0x0/0x204) from [<802b1284>] (__device_attach)
 r9:9f817080 r8:806e0b60 r7:00000000 r6:802b1240 r5:9fa40800
r4:8067cc6c
[<802b1240>] (__device_attach+0x0/0x48) from [<802af71c>] (bus_for_each_drv+0x6)
 r5:9f855cf0 r4:9fa40800
[<802af6b4>] (bus_for_each_drv+0x0/0x94) from [<802b133c>] (device_attach+0x88/)
 r7:9fa40808 r6:80682818 r5:9fa40800 r4:9fa40834
[<802b12b4>] (device_attach+0x0/0xa0) from [<802b0358>] (bus_probe_device+0x8c/)
 r7:9fa40808 r6:80682818 r5:9fa40800 r4:9fa40800
[<802b02cc>] (bus_probe_device+0x0/0xb4) from [<802aef6c>] (device_add+0x554/0x)
 r7:9fa40808 r6:00000000 r5:9f98c800 r4:9fa40800
[<802aea18>] (device_add+0x0/0x624) from [<8032bc98>] (spi_add_device+0xac/0x12)
[<8032bbec>] (spi_add_device+0x0/0x12c) from [<8032bff4>] (spi_register_master+)
 r7:00000000 r6:9fa40800 r5:80aec5a4 r4:9f98c800
[<8032be14>] (spi_register_master+0x0/0x484) from [<8032c708>] (spi_bitbang_sta)
[<8032c5f4>] (spi_bitbang_start+0x0/0x18c) from [<804b04a4>] (spi_imx_probe+0x4)
 r5:9f882d00 r4:00000002
[<804b0098>] (spi_imx_probe+0x0/0x53c) from [<802b2508>] (platform_drv_probe+0x)
[<802b24e8>] (platform_drv_probe+0x0/0x24) from [<802b1024>] (driver_probe_devi)
[<802b0fa4>] (driver_probe_device+0x0/0x204) from [<802b123c>] (__driver_attach)
 r9:806513a0 r8:00000095 r7:00000000 r6:9f88323c r5:8068291c
r4:9f883208
[<802b11a8>] (__driver_attach+0x0/0x98) from [<802af7b0>] (bus_for_each_dev+0x6)
 r7:00000000 r6:802b11a8 r5:9f855eb8 r4:8068291c
[<802af748>] (bus_for_each_dev+0x0/0x94) from [<802b0e84>] (driver_attach+0x20/)
 r7:00000000 r6:9f9ff480 r5:8067af08 r4:8068291c
[<802b0e64>] (driver_attach+0x0/0x28) from [<802b00e0>] (bus_add_driver+0x184/0)
[<802aff5c>] (bus_add_driver+0x0/0x240) from [<802b186c>] (driver_register+0x80)
 r7:00000000 r6:80691ac0 r5:8068291c r4:9f854000
[<802b17ec>] (driver_register+0x0/0x148) from [<802b28b0>] (platform_driver_reg)
 r9:806513a0 r8:00000095 r7:00000000 r6:80691ac0 r5:00000007
r4:9f854000
[<802b2864>] (platform_driver_register+0x0/0x60) from [<80630f84>] (spi_imx_dri)
[<80630f70>] (spi_imx_driver_init+0x0/0x1c) from [<800086b4>] (do_one_initcall+)
[<80008674>] (do_one_initcall+0x0/0x194) from [<8060a3f4>] (kernel_init+0xfc/0x)
[<8060a2f8>] (kernel_init+0x0/0x1cc) from [<800283fc>] (do_exit+0x0/0x810)
Code: bad PC value
---[ end trace 86fb1362828fca3f ]---
Fixing recursive fault but reboot is needed!
imx-sdma imx35-sdma: firmware not found

I haven't started bisecting this, but in case anyone has seen this and
have some ideas, please let me know.

Booting the non-dt kernel does not cause the crashes.

Regards,

Fabio Estevam
