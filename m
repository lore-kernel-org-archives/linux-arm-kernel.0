From: try2share@gmail.com (K K)
Date: Wed, 27 Jun 2012 17:59:20 +0530
Subject: kernel boot stops with "zlib_deflate: version magic" , "zlib_inflate:
 version magic"
Message-ID: <CACZ0kf9+=jXuqKSH1Rnnp2AvvoVUr7zmepOP_71_XQx8RU2BNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

*Hi,

I have a lpc-3180 based board and it is up and running fine with 2.6.10
kernel version. Planned to port board changes into 2.6.32 kernel version.
As a part of this, i added the architecture dependent  code  (mach files)
 first. Then changed some of the kernel upgradations. *
I took .config file from the v2.6.10 and saved with "make menuconfig" in
v2.6.32 kernel.*
kernel build successfully. When i boot the board with the new v2.6.32
kernel iam getting following messages and its stops.*

I have kept some debug messages using printk to check the flow of kernel
booting, In the following log i removed some debug messages which i have
printed the remaining i found important are the red coloured messages with
filename and function from which iam getting.

I am using same uboot, secondary bootloader and filesystem images which i
have successfully boot v2.6.10 on lpc3180 board, with the addition of new
v2.6.32 kernel image onto lpc3180 board.


*Starting kernel ...

Uncompressing
Linux.............................................................................
done, booting the kernel.
A
41069264:00001267:0005107C
801554B0-803A4A30>80008000
803A4A80
80008000: E321F0D3 EE109F10 EB0000D0 E1B0A005  0A00005F EB0000E6 E1B08005
0A000072
80008020: EB0000F5 EB000013 E59FD0F4 E28FE000  E28AF010 E3800002 E3A0501F
EE035F10
80008040: EE024F10 EA000005 E1A00000 E1A00000  E1A00000 E1A00000 E1A00000
E1A00000
80008060: E1A00000 EE010F10 EE103F10 E1A03003  E1A0300D E1A0F003 E59F409C
E1A00004
80008080: E3A03000 E2806901 E4803004 E4803004  E4803004 E4803004 E1300006
1AFFFFF9
800080A0: E59A7008 E1A0600F E1A06A26 E1873A06  E7843106 E2840A03 E5A03000
E59F605C
800080C0: E2800004 E0846926 E1500006 E2833601  94803004 9AFFFFFB E2840A03
E3876102
800080E0: E5806000 E59A700C E5983008 E0840003  E2633901 E3530B02 83A03B02
E0806003
B<5>Linux version 2.6.32 (kk at KK) (gcc version 4.6.1 (Sourcery CodeBench
Lite 2011.09-70) ) #49 Fri Jun 22 13:08:04 IST 2012
CPU: ARM926EJ-S [41069264] revision 4 (ARMv5TEJ), cr=00057177
CPU: VIVT data cache, VIVT instruction cache
Machine: LPC3180
serial : early init
Memory policy: ECC disabled, Data cache writethrough
<7>On node 0 totalpages: 7936
<7>free_area_init_node: node 0, pgdat c0256ee0, node_mem_map c0268000
<7>  Normal zone: 62 pages used for memmap
<7>  Normal zone: 0 pages reserved
<7>  Normal zone: 7874 pages, LIFO batch:0
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 7874
<5>Kernel command line: console=ttyS0,115200n8 root=/dev/ram
initrd=0x80800000,12M
<6>PID hash table entries: 128 (order: -3, 512 bytes)
---debug @ pidhash_init:pidhash_shift = 7::pidhash_size= 128
<6>Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
<6>Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
<6>Memory: 31MB = 31MB total
<5>Memory: 16700KB available (2172K code, 146K data, 104K init, 0K highmem)
<6>SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
<6>Hierarchical RCU implementation.
<6>NR_IRQS:96
<4>Trying to install interrupt handler for IRQ2
<4>Trying to install interrupt handler for IRQ3
<4>Trying to install interrupt handler for IRQ4
<4>Trying to install interrupt handler for IRQ5
<4>Trying to install interrupt handler for IRQ6
<4>Trying to install interrupt handler for IRQ7
<4>Trying to install interrupt handler for IRQ8
<4>Trying to install interrupt handler for IRQ9
<4>Trying to install interrupt handler for IRQ10
<4>Trying to install interrupt handler for IRQ11
<4>Trying to install interrupt handler for IRQ12
<4>Trying to install interrupt handler for IRQ13
<4>Trying to install interrupt handler for IRQ14
<4>Trying to install interrupt handler for IRQ15
<4>Trying to install interrupt handler for IRQ16
<4>Trying to install interrupt handler for IRQ17
<4>Trying to install interrupt handler for IRQ18
<4>Trying to install interrupt handler for IRQ19
<4>Trying to install interrupt handler for IRQ20
<4>Trying to install interrupt handler for IRQ21
<4>Trying to install interrupt handler for IRQ22
<4>Trying to install interrupt handler for IRQ23
<4>Trying to install interrupt handler for IRQ24
<4>Trying to install interrupt handler for IRQ25
<4>Trying to install interrupt handler for IRQ26
<4>Trying to install interrupt handler for IRQ27
<4>Trying to install interrupt handler for IRQ28
<4>Trying to install interrupt handler for IRQ29
<4>Trying to install interrupt handler for IRQ32
<4>Trying to install interrupt handler for IRQ33
<4>Trying to install interrupt handler for IRQ34
<4>Trying to install interrupt handler for IRQ35
<4>Trying to install interrupt handler for IRQ36
<4>Trying to install interrupt handler for IRQ37
<4>Trying to install interrupt handler for IRQ38
<4>Trying to install interrupt handler for IRQ39
<4>Trying to install interrupt handler for IRQ40
<4>Trying to install interrupt handler for IRQ41
<4>Trying to install interrupt handler for IRQ42
<4>Trying to install interrupt handler for IRQ43
<4>Trying to install interrupt handler for IRQ44
<4>Trying to install interrupt handler for IRQ45
<4>Trying to install interrupt handler for IRQ46
<4>Trying to install interrupt handler for IRQ47
<4>Trying to install interrupt handler for IRQ48
<4>Trying to install interrupt handler for IRQ49
<4>Trying to install interrupt handler for IRQ50
<4>Trying to install interrupt handler for IRQ51
<4>Trying to install interrupt handler for IRQ52
<4>Trying to install interrupt handler for IRQ53
<4>Trying to install interrupt handler for IRQ54
<4>Trying to install interrupt handler for IRQ55
<4>Trying to install interrupt handler for IRQ56
<4>Trying to install interrupt handler for IRQ57
<4>Trying to install interrupt handler for IRQ58
<4>Trying to install interrupt handler for IRQ59
<4>Trying to install interrupt handler for IRQ60
<4>Trying to install interrupt handler for IRQ61
<4>Trying to install interrupt handler for IRQ62
<4>Trying to install interrupt handler for IRQ63
<4>Trying to install interrupt handler for IRQ64
<4>Trying to install interrupt handler for IRQ65
<4>Trying to install interrupt handler for IRQ66
<4>Trying to install interrupt handler for IRQ67
<4>Trying to install interrupt handler for IRQ68
<4>Trying to install interrupt handler for IRQ69
<4>Trying to install interrupt handler for IRQ70
<4>Trying to install interrupt handler for IRQ71
<4>Trying to install interrupt handler for IRQ72
<4>Trying to install interrupt handler for IRQ73
<4>Trying to install interrupt handler for IRQ74
<4>Trying to install interrupt handler for IRQ75
<4>Trying to install interrupt handler for IRQ76
<4>Trying to install interrupt handler for IRQ77
<4>Trying to install interrupt handler for IRQ78
<4>Trying to install interrupt handler for IRQ79
<4>Trying to install interrupt handler for IRQ80
<4>Trying to install interrupt handler for IRQ81
<4>Trying to install interrupt handler for IRQ82
<4>Trying to install interrupt handler for IRQ83
<4>Trying to install interrupt handler for IRQ84
<4>Trying to install interrupt handler for IRQ85
<4>Trying to install interrupt handler for IRQ86
<4>Trying to install interrupt handler for IRQ87
<4>Trying to install interrupt handler for IRQ88
<4>Trying to install interrupt handler for IRQ89
<4>Trying to install interrupt handler for IRQ90
<4>Trying to install interrupt handler for IRQ91
<4>Trying to install interrupt handler for IRQ92
<4>Trying to install interrupt handler for IRQ93
<4>Trying to install interrupt handler for IRQ94
<4>Trying to install interrupt handler for IRQ95
<4>Trying to install interrupt handler for IRQ30
<4>Trying to install interrupt handler for IRQ31
<4>Trying to install interrupt handler for IRQ0
<4>Trying to install interrupt handler for IRQ1
Interrupt masks are setup
Console: colour dummy device 80x30
Linux version 2.6.32 (kk at KK) (gcc version 4.6.1 (Sourcery CodeBench Lite
2011.09-70) ) #49 Fri Jun 22 13:08:04 IST 2012
CPU: ARM926EJ-S [41069264] revision 4 (ARMv5TEJ), cr=00057177
CPU: VIVT data cache, VIVT instruction cache
Machine: LPC3180
serial at esn : early init
Memory policy: ECC disabled, Data cache writethrough
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 7874
Kernel command line: console=ttyS0,115200n8 root=/dev/ram
initrd=0x80800000,12M
PID hash table entries: 128 (order: -3, 512 bytes)
.---debug @ pidhash_init:pidhash_shift = 7::pidhash_size= 128
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 31MB = 31MB total
Memory: 16700KB available (2172K code, 146K data, 104K init, 0K highmem)
SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Hierarchical RCU implementation.
NR_IRQS:96
Trying to install interrupt handler for IRQ2
Trying to install interrupt handler for IRQ3
Trying to install interrupt handler for IRQ4
Trying to install interrupt handler for IRQ5
Trying to install interrupt handler for IRQ6
Trying to install interrupt handler for IRQ7
Trying to install interrupt handler for IRQ8
Trying to install interrupt handler for IRQ9
Trying to install interrupt handler for IRQ10
Trying to install interrupt handler for IRQ11
Trying to install interrupt handler for IRQ12
Trying to install interrupt handler for IRQ13
Trying to install interrupt handler for IRQ14
Trying to install interrupt handler for IRQ15
Trying to install interrupt handler for IRQ16
Trying to install interrupt handler for IRQ17
Trying to install interrupt handler for IRQ18
Trying to install interrupt handler for IRQ19
Trying to install interrupt handler for IRQ20
Trying to install interrupt handler for IRQ21
Trying to install interrupt handler for IRQ22
Trying to install interrupt handler for IRQ23
Trying to install interrupt handler for IRQ24
Trying to install interrupt handler for IRQ25
Trying to install interrupt handler for IRQ26
Trying to install interrupt handler for IRQ27
Trying to install interrupt handler for IRQ28
Trying to install interrupt handler for IRQ29
Trying to install interrupt handler for IRQ32
Trying to install interrupt handler for IRQ33
Trying to install interrupt handler for IRQ34
Trying to install interrupt handler for IRQ35
Trying to install interrupt handler for IRQ36
Trying to install interrupt handler for IRQ37
Trying to install interrupt handler for IRQ38
Trying to install interrupt handler for IRQ39
Trying to install interrupt handler for IRQ40
Trying to install interrupt handler for IRQ41
Trying to install interrupt handler for IRQ42
Trying to install interrupt handler for IRQ43
Trying to install interrupt handler for IRQ44
Trying to install interrupt handler for IRQ45
Trying to install interrupt handler for IRQ46
Trying to install interrupt handler for IRQ47
Trying to install interrupt handler for IRQ48
Trying to install interrupt handler for IRQ49
Trying to install interrupt handler for IRQ50
Trying to install interrupt handler for IRQ51
Trying to install interrupt handler for IRQ52
Trying to install interrupt handler for IRQ53
Trying to install interrupt handler for IRQ54
Trying to install interrupt handler for IRQ55
Trying to install interrupt handler for IRQ56
Trying to install interrupt handler for IRQ57
Trying to install interrupt handler for IRQ58
Trying to install interrupt handler for IRQ59
Trying to install interrupt handler for IRQ60
Trying to install interrupt handler for IRQ61
Trying to install interrupt handler for IRQ62
Trying to install interrupt handler for IRQ63
Trying to install interrupt handler for IRQ64
Trying to install interrupt handler for IRQ65
Trying to install interrupt handler for IRQ66
Trying to install interrupt handler for IRQ67
Trying to install interrupt handler for IRQ68
Trying to install interrupt handler for IRQ69
Trying to install interrupt handler for IRQ70
Trying to install interrupt handler for IRQ71
Trying to install interrupt handler for IRQ72
Trying to install interrupt handler for IRQ73
Trying to install interrupt handler for IRQ74
Trying to install interrupt handler for IRQ75
Trying to install interrupt handler for IRQ76
Trying to install interrupt handler for IRQ77
Trying to install interrupt handler for IRQ78
Trying to install interrupt handler for IRQ79
Trying to install interrupt handler for IRQ80
Trying to install interrupt handler for IRQ81
Trying to install interrupt handler for IRQ82
Trying to install interrupt handler for IRQ83
Trying to install interrupt handler for IRQ84
Trying to install interrupt handler for IRQ85
Trying to install interrupt handler for IRQ86
Trying to install interrupt handler for IRQ87
Trying to install interrupt handler for IRQ88
Trying to install interrupt handler for IRQ89
Trying to install interrupt handler for IRQ90
Trying to install interrupt handler for IRQ91
Trying to install interrupt handler for IRQ92
Trying to install interrupt handler for IRQ93
Trying to install interrupt handler for IRQ94
Trying to install interrupt handler for IRQ95
Trying to install interrupt handler for IRQ30
Trying to install interrupt handler for IRQ31
Trying to install interrupt handler for IRQ0
Trying to install interrupt handler for IRQ1
Interrupt masks are setup
Console: colour dummy device 80x30
<6>console [ttyS0] enabled
console [ttyS0] enabled
<6>Calibrating delay loop... Calibrating delay loop...
<c>103.83 BogoMIPS (lpj=519168)
103.83 BogoMIPS (lpj=519168)
Mount-cache hash table entries: 512
Mount-cache hash table entries: 512
<6>CPU: Testing write buffer coherency: CPU: Testing write buffer
coherency: ok
ok
<6>NET: Registered protocol family 16
NET: Registered protocol family 16
.late serial init
late serial init
serial at esn : late init
serial at esn : late init
bio: create slab <bio-0> at 0
bio: create slab <bio-0> at 0
<5>SCSI subsystem initialized
SCSI subsystem initialized
<6>usbcore: registered new interface driver usbfs
usbcore: registered new interface driver usbfs
<6>usbcore: registered new interface driver hub
usbcore: registered new interface driver hub
<6>usbcore: registered new device driver usb
usbcore: registered new device driver usb
<6>NET: Registered protocol family 2
NET: Registered protocol family 2
<6>IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
<6>TCP established hash table entries: 1024 (order: 1, 8192 bytes)
TCP established hash table entries: 1024 (order: 1, 8192 bytes)
<6>TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
<6>TCP: Hash tables configured (established 1024 bind 1024)
TCP: Hash tables configured (established 1024 bind 1024)
<6>TCP reno registered
TCP reno registered
<6>NET: Registered protocol family 1
NET: Registered protocol family 1
<6>Trying to unpack rootfs image as initramfs...
Trying to unpack rootfs image as initramfs...
<6>rootfs image is not initramfs (no cpio magic); looks like an initrd
rootfs image is not initramfs (no cpio magic); looks like an initrd
<6>Freeing initrd memory: 12288K
Freeing initrd memory: 12288K
<4>NetWinder Floating Point Emulator V0.97 (double precision)
NetWinder Floating Point Emulator V0.97 (double precision)
.....@ <arch/arm/mm/fault.c>  <do_DataAbort>  <543>
.....@ <arch/arm/mm/fault.c>  <do_translation_fault>  <413>
.....@ <arch/arm/mm/fault.c>  <do_page_fault>  <373>
<6>ROMFS MTD (C) 2007 Red Hat, Inc.
ROMFS MTD (C) 2007 Red Hat, Inc.
<6>msgmni has been set to 56
msgmni has been set to 56
<6>Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
<6>io scheduler noop registered
io scheduler noop registered
<6>io scheduler anticipatory registered
io scheduler anticipatory registered
<6>io scheduler deadline registered
io scheduler deadline registered
<6>io scheduler cfq registered (default)
io scheduler cfq registered (default)
<6>Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
<6>serial8250: ttyS0 at MMIO 0x0 (irq = 9) is a 16550A
serial8250: ttyS0 at MMIO 0x0 (irq = 9) is a 16550A
<6>serial8250.0: ttyS0 at MMIO 0x0 (irq = 7) is a 16550A
<6>serial8250.0: ttyS0 at MMIO 0x0 (irq = 8) is a 16550A
<6>serial8250.0: ttyS0 at MMIO 0x0 (irq = 10) is a 16550A
<6>brd: module loaded
<6>loop: module loaded
<6>nbd: registered device at major 43
<6>mice: PS/2 mouse device common for all mice
<6>i2c /dev entries driver
<6>TCP cubic registered
<6>NET: Registered protocol family 17
<6>VFP support v0.3: implementor 41 architecture 1 part 10 variant 9 rev 1
<5>RAMDISK: gzip image found at block 0
VFS: Mounted root (ext2 filesystem) on device 1:0.
<6>Freeing init memory: 104K
--debug .@ <kernel/module.c>  <load_module>  <2186>
<3>zlib_deflate: version magic '2.6.10 ARMv5 gcc-3.4' should be '2.6.32
mod_unload ARMv5 '
--debug .@ <kernel/module.c>  <load_module>  <2186>
<3>zlib_inflate: version magic '2.6.10 ARMv5 gcc-3.4' should be '2.6.32
mod_unload ARMv5 '*
*
*
*
*
*
*
*can anyone help me regarding this...*
*
*
*Thanks,*
*KK*
*
*
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120627/eae15a2e/attachment-0001.html>
