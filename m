From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Sat, 24 Jul 2010 11:58:14 +0200
Subject: [PATCH 1/2] mxc_nand: fix Unbalanced enable for IRQ
In-Reply-To: <4C4616D6.1050803@pengutronix.de>
References: <1276178584-10074-1-git-send-email-eric@eukrea.com>	<1279345824.3212.24.camel@localhost.localdomain>	<4C457885.9000404@pengutronix.de>
	<1279621337.16462.100.camel@localhost>
	<4C4616D6.1050803@pengutronix.de>
Message-ID: <4C4AB936.4090206@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello David,

Marc Kleine-Budde wrote:
> Hey David,
> 
> Artem Bityutskiy wrote:
>> On Tue, 2010-07-20 at 12:20 +0200, Marc Kleine-Budde wrote:
>>> Current mainline has (still) this problem, too. Is there any change to
>>> get this patch into 2.6.35 before the release?
>> You should bug David Woodhouse about this.
> 
> The imx NAND driver does throw this unbalanced IRQ warning in the
> current 2.6.35-rcX mainline tree. David can you try to get this into
> mainline before the release?

2.6.35-rc6 has this problem, any change to get this patch merged before
the release?

Marc

>> Uncompressing Linux... done, booting the kernel.
>> Linux version 2.6.35-rc6 (sisyphus at himalia) (gcc version 4.3.2 (OSELAS.Toolchain-1.99.3) ) #1 PREEMPT Fri Jul 23 22:55:19 CEST 2010
>> CPU: ARMv6-compatible processor [4117b363] revision 3 (ARMv6TEJ), cr=00c5387f
>> CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
>> Machine: Phytec Phycore pcm043
>> Memory policy: ECC disabled, Data cache writeback
>> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
>> Kernel command line: console=ttymxc0,115200 video=mx3fb:CTP-CLAA070LC0AC mtdparts=physmap-flash.0:256k(barebox)ro,512k(bareboxenv),4M(kernel),-(root);mxc_nand:256k(barebox)ro,512k(bareboxenv),4M(kernel),-(root); ip=192.168.42.1:192.168.23.2:192.168.23.1:255.255.0.0::: root=/dev/nfs nfsroot=/tftpboot/exported_fs_cdKWZPxiy ro
>> PID hash table entries: 512 (order: -1, 2048 bytes)
>> Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
>> Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
>> Memory: 128MB = 128MB total
>> Memory: 126196k/126196k available, 4876k reserved, 0K highmem
>> Virtual kernel memory layout:
>>     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>>     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
>>     DMA     : 0xff600000 - 0xffe00000   (   8 MB)
>>     vmalloc : 0xc8800000 - 0xf4000000   ( 696 MB)
>>     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
>>     modules : 0xbf000000 - 0xc0000000   (  16 MB)
>>       .init : 0xc0008000 - 0xc0021000   ( 100 kB)
>>       .text : 0xc0021000 - 0xc0354000   (3276 kB)
>>       .data : 0xc036c000 - 0xc0394aa0   ( 163 kB)
>> Hierarchical RCU implementation.
>> 	RCU-based detection of stalled CPUs is disabled.
>> 	Verbose stalled-CPUs detection is disabled.
>> NR_IRQS:244
>> MXC GPIO hardware
>> MXC IRQ initialized
>> Calibrating delay loop... 530.84 BogoMIPS (lpj=2654208)
>> pid_max: default: 32768 minimum: 301
>> Mount-cache hash table entries: 512
>> CPU: Testing write buffer coherency: ok
>> regulator: core version 0.5
>> NET: Registered protocol family 16
>> L210 cache controller enabled
>> l2x0: 8 ways, CACHE_ID 0x4100004b, AUX_CTRL 0x00030024
>> bio: create slab <bio-0> at 0
>> Switching to clocksource mxc_timer1
>> NET: Registered protocol family 2
>> IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
>> TCP established hash table entries: 4096 (order: 3, 32768 bytes)
>> TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
>> TCP: Hash tables configured (established 4096 bind 4096)
>> TCP reno registered
>> UDP hash table entries: 256 (order: 0, 4096 bytes)
>> UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
>> NET: Registered protocol family 1
>> RPC: Registered udp transport module.
>> RPC: Registered tcp transport module.
>> RPC: Registered tcp NFSv4.1 backchannel transport module.
>> JFFS2 version 2.2. (NAND) ? 2001-2006 Red Hat, Inc.
>> msgmni has been set to 246
>> alg: No test for stdrng (krng)
>> io scheduler noop registered
>> io scheduler deadline registered
>> io scheduler cfq registered (default)
>> mx3_sdc_fb mx3_sdc_fb: registered, using mode CTP-CLAA070LC0AC
>> Serial: IMX driver
>> imx-uart.0: ttymxc0 at MMIO 0x43f90000 (irq = 45) is a IMX
>> console [ttymxc0] enabled
>> imx-uart.1: ttymxc1 at MMIO 0x43f94000 (irq = 32) is a IMX
>> at24 0-0052: 4096 byte at24 EEPROM (writable)
>> physmap platform flash device: 02000000 at a0000000
>> physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank
>> Support for command set 0001 not present
>> gen_probe: No supported Vendor Command Set found
>> physmap-flash physmap-flash.0: map_probe failed
>> ------------[ cut here ]------------
>> WARNING: at kernel/irq/manage.c:290 enable_irq+0x58/0x9c()
>> Unbalanced enable for IRQ 33
>> Modules linked in:
>> [<c002760c>] (unwind_backtrace+0x0/0xec) from [<c0039c9c>] (warn_slowpath_common+0x4c/0x7c)
>> [<c0039c9c>] (warn_slowpath_common+0x4c/0x7c) from [<c0039d60>] (warn_slowpath_fmt+0x30/0x40)
>> [<c0039d60>] (warn_slowpath_fmt+0x30/0x40) from [<c0068664>] (enable_irq+0x58/0x9c)
>> [<c0068664>] (enable_irq+0x58/0x9c) from [<c01b8ea8>] (wait_op_done+0x38/0x128)
>> [<c01b8ea8>] (wait_op_done+0x38/0x128) from [<c01b94ac>] (mxc_nand_command+0x358/0x420)
>> [<c01b94ac>] (mxc_nand_command+0x358/0x420) from [<c01b6050>] (nand_scan_ident+0x180/0x6b0)
>> [<c01b6050>] (nand_scan_ident+0x180/0x6b0) from [<c0016a68>] (mxcnd_probe+0x268/0x384)
>> [<c0016a68>] (mxcnd_probe+0x268/0x384) from [<c01a4ffc>] (platform_drv_probe+0x1c/0x24)
>> [<c01a4ffc>] (platform_drv_probe+0x1c/0x24) from [<c01a3fd8>] (driver_probe_device+0xac/0x188)
>> [<c01a3fd8>] (driver_probe_device+0xac/0x188) from [<c01a4114>] (__driver_attach+0x60/0x84)
>> [<c01a4114>] (__driver_attach+0x60/0x84) from [<c01a37dc>] (bus_for_each_dev+0x4c/0x8c)
>> [<c01a37dc>] (bus_for_each_dev+0x4c/0x8c) from [<c01a3058>] (bus_add_driver+0xa0/0x228)
>> [<c01a3058>] (bus_add_driver+0xa0/0x228) from [<c01a4420>] (driver_register+0xc0/0x150)
>> [<c01a4420>] (driver_register+0xc0/0x150) from [<c01a544c>] (platform_driver_probe+0x18/0xa4)
>> [<c01a544c>] (platform_driver_probe+0x18/0xa4) from [<c0021374>] (do_one_initcall+0x5c/0x1bc)
>> [<c0021374>] (do_one_initcall+0x5c/0x1bc) from [<c000841c>] (kernel_init+0xac/0x16c)
>> [<c000841c>] (kernel_init+0xac/0x16c) from [<c0022f04>] (kernel_thread_exit+0x0/0x8)
>> ---[ end trace 6fdffdc941b35459 ]---
>> NAND device: Manufacturer ID: 0x20, Chip ID: 0xd3 (ST Micro NAND 1GiB 3,3V 8-bit)
>> Scanning device for bad blocks
>> Bad eraseblock 6273 at 0x000031020000
>> Bad eraseblock 8190 at 0x00003ffc0000
>> Bad eraseblock 8191 at 0x00003ffe0000
>> RedBoot partition parsing not available
>> mtd: no mtd-id
>> 4 cmdlinepart partitions found on MTD device mxc_nand
>> Creating 4 MTD partitions on "mxc_nand":
>> 0x000000000000-0x000000040000 : "barebox"
>> 0x000000040000-0x0000000c0000 : "bareboxenv"
>> 0x0000000c0000-0x0000004c0000 : "kernel"
>> 0x0000004c0000-0x000040000000 : "root"
>> FEC Ethernet Driver
>> fec_enet_mii_bus: probed
>> i2c /dev entries driver
>> Linux video capture interface: v2.00
>> Driver for 1-wire Dallas network protocol.
>> TCP cubic registered
>> NET: Registered protocol family 17
>> VFP support v0.3: implementor 41 architecture 1 part 20 variant b rev 3
>> eth0: Freescale FEC PHY driver [Generic PHY] (mii_bus:phy_addr=0:00, irq=-1)
>> IP-Config: Complete:
>>      device=eth0, addr=192.168.42.1, mask=255.255.0.0, gw=192.168.23.1,
>>      host=192.168.42.1, domain=, nis-domain=(none),
>>      bootserver=192.168.23.2, rootserver=192.168.23.2, rootpath=
>> Looking up port of RPC 100003/2 on 192.168.23.2
>> PHY: 0:00 - Link is Up - 100/Full
>> Looking up port of RPC 100005/1 on 192.168.23.2
>> VFS: Mounted root (nfs filesystem) readonly on device 0:11.
>> Freeing init memory: 100K
>> 
>> init started: BusyBox v1.15.3 (2010-02-19 10:00:14 CET)

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 260 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100724/34bff0bc/attachment.sig>
