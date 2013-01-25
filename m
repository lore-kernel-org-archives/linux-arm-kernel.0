From: monstr@monstr.eu (Michal Simek)
Date: Fri, 25 Jan 2013 08:56:22 +0100
Subject: arm: Kernel failures when several memory banks are used with
 starting address above 128MB
In-Reply-To: <20130123091537.GN23505@n2100.arm.linux.org.uk>
References: <CAHTX3dJZxuoz_0Eaa7QcoK9bF4LdLuWcDcwK3OUKc6qY_0PeuQ@mail.gmail.com>
 <20130123091537.GN23505@n2100.arm.linux.org.uk>
Message-ID: <CAHTX3dKu5xOOuPSt5WU=vO1HvggXfctrfLeGrotS-zJgPJJbSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/1/23 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Tue, Jan 22, 2013 at 08:18:13PM +0100, Michal Simek wrote:
>> I have a question regarding to the case where DTS specify one memory bank
>> for example <0x0 0x40000000> with CONFIG_ARM_PATCH_PHYS_VIRT=y
>> where the kernel can be loaded at a 16MB boundary.
>
> That's where you're going wrong.  We assume that the kernel is loaded
> within the 16MB of memory _always_.  Can't get around this on a
> multiplatform kernel.

Then please mentor me if why the case below also works without any
visible problem.
Loading address is 0x7008000. If there is requirement that the kernel
should be loaded within the 16MB of memory why this case also works.

What am I doing wrong?

Thanks,
Michal


U-Boot 2013.01-00473-g4669149 (Jan 25 2013 - 08:46:13)

I2C:   ready
DRAM:  1 GiB
WARNING: Caches not enabled
MMC:   SDHCI: 0
SF: Detected N25Q128A with page size 64 KiB, total 16 MiB
In:    serial
Out:   serial
Err:   serial
Net:   Gem.e000b000
Hit any key to stop autoboot:  0
TFTPing Linux to RAM...
Gem.e000b000 Waiting for PHY auto negotiation to complete... done
Using Gem.e000b000 device
TFTP from server 192.168.0.101; our IP address is 192.168.0.99
Filename 'uImage'.
Load address: 0x3000000
Loading: #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 ################################################
	 2.4 MiB/s
done
Bytes transferred = 6420088 (61f678 hex)
Gem.e000b000:7 is connected to Gem.e000b000.  Reconnecting to Gem.e000b000
Gem.e000b000 Waiting for PHY auto negotiation to complete... done
Using Gem.e000b000 device
TFTP from server 192.168.0.101; our IP address is 192.168.0.99
Filename 'devicetree.dtb'.
Load address: 0x2a00000
Loading: #
	 789.1 KiB/s
done
Bytes transferred = 3232 (ca0 hex)
Gem.e000b000:7 is connected to Gem.e000b000.  Reconnecting to Gem.e000b000
Gem.e000b000 Waiting for PHY auto negotiation to complete... done
Using Gem.e000b000 device
TFTP from server 192.168.0.101; our IP address is 192.168.0.99
Filename 'uramdisk.image.gz'.
Load address: 0x2000000
Loading: #################################################################
	 #################################################################
	 #################################################################
	 ##################################
	 1.9 MiB/s
done
Bytes transferred = 3352699 (33287b hex)
## Booting kernel from Legacy Image at 03000000 ...
   Image Name:   Linux-3.8.0-rc4+
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    6420024 Bytes = 6.1 MiB
   Load Address: 07008000
   Entry Point:  07008000
   Verifying Checksum ... OK
## Loading init Ramdisk from Legacy Image at 02000000 ...
   Image Name:
   Image Type:   ARM Linux RAMDisk Image (gzip compressed)
   Data Size:    3352635 Bytes = 3.2 MiB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 02a00000
   Booting using the fdt blob at 0x02a00000
   Loading Kernel Image ... OK
OK
   Loading Ramdisk to 1fccd000, end 1ffff83b ... OK
   Loading Device Tree to 1fcc9000, end 1fcccc9f ... OK

Starting kernel ...

Booting Linux on physical CPU 0x0
Linux version 3.8.0-rc4+ (monstr at monstr-desktop) (gcc version 4.6.1
(Sourcery CodeBench Lite 2011.09-50) ) #159 PREEMPT Fri Jan 25
08:20:25 CET 2013
CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=18c5387d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: Xilinx Zynq Platform, model: Zynq ZC702 Development Board
bootconsole [earlycon0] enabled
Memory policy: ECC disabled, Data cache writeback
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260096
Kernel command line: console=ttyPS0,115200 earlyprintk
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
__ex_table already sorted, skipping sort
Memory: 1024MB = 1024MB total
Memory: 1019804k/1019804k available, 28772k reserved, 270336K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
    lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
      .text : 0xc0008000 - 0xc0681f24   (6632 kB)
      .init : 0xc0682000 - 0xc0fd3594   (9542 kB)
      .data : 0xc0fd4000 - 0xc0ff5360   ( 133 kB)
       .bss : 0xc0ff5360 - 0xc100bf40   (  91 kB)
NR_IRQS:16 nr_irqs:16 16
sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 4294967286ms
Console: colour dummy device 80x30
Calibrating delay loop... 666.41 BogoMIPS (lpj=3332096)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0x2f0db0 - 0x2f0de4
devtmpfs: initialized
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
L310 cache controller enabled
l2x0: 8 ways, CACHE_ID 0x000000c0, AUX_CTRL 0x72360000, Cache size: 524288 B
bio: create slab <bio-0> at 0
SCSI subsystem initialized
Switching to clocksource ttc0.0
NET: Registered protocol family 2
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP: reno registered
UDP hash table entries: 512 (order: 1, 8192 bytes)
UDP-Lite hash table entries: 512 (order: 1, 8192 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
Trying to unpack rootfs image as initramfs...
rootfs image is not initramfs (no cpio magic); looks like an initrd
Freeing initrd memory: 3272K
bounce pool size: 64 pages
msgmni has been set to 1470
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
e00??????[ttyPS0] enabled, bootconsole disabled
console [ttyPS0] enabled, bootconsole disabled
e0000000.uart: ttyPS1 at MMIO 0xe0000000 (irq = 59) is a xuartps
brd: module loaded
loop: module loaded
st: Version 20101219, fixed bufsize 32768, s/g segs 256
osst :I: Tape driver with OnStream support version 0.99.4
osst :I: $Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $
SCSI Media Changer driver v0.25
mousedev: PS/2 mouse device common for all mice
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pltfm: SDHCI platform and OF driver helper
TCP: cubic registered
NET: Registered protocol family 10
sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
Registering SWP/SWPB emulation handler
Freeing init memory: 9540K
Mounting proc:
Mounting var:
Populating /var:
Running local start scripts.
Mounting debugfs:
Mounting sysfs:
mdev: initialising /dev
mdev: Registering hotplug handler
/proc/mtd doesn't exist. Will not create /dev/flash/* device nodes
Mounting devpts:
Mounting all filesystem
Setting hostname:
Bringing up network interfaces:
ip: SIOCGIFFLAGS: No such device
Starting portmap:
Starting uWeb server:

Welcome to
 _____       _           _      _
| ___ \     | |         | |    (_)
| |_/ / ___ | |_   __ _ | |     _  _ __   _   _ __  __
|  __/ / _ \| __| / _` || |    | || '_ \ | | | |\ \/ /
| |   |  __/| |_ | (_| || |____| || | | || |_| | >  <
\_|    \___| \__| \__,_|\_____/|_||_| |_| \__,_|/_/\_\

on EDK_2D3D_FMC


EDK_2D3D_FMC login: root
Password:
~ # hexdump /proc/device-tree/memory/reg
0000000 0000 0000 0040 0000
0000008
~ #

Defconfig for this platform.

CONFIG_EXPERIMENTAL=y
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SYSVIPC=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_SYSFS_DEPRECATED=y
CONFIG_SYSFS_DEPRECATED_V2=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE="rootfs.cpio"
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_KALLSYMS_ALL=y
CONFIG_EMBEDDED=y
CONFIG_SLAB=y
CONFIG_PARTITION_ADVANCED=y
# CONFIG_EFI_PARTITION is not set
CONFIG_ARCH_ZYNQ=y
CONFIG_SWP_EMULATE=y
CONFIG_PREEMPT=y
CONFIG_AEABI=y
# CONFIG_OABI_COMPAT is not set
CONFIG_HIGHMEM=y
CONFIG_HIGHPTE=y
# CONFIG_COMPACTION is not set
CONFIG_ZBOOT_ROM_TEXT=0x0
CONFIG_ZBOOT_ROM_BSS=0x0
CONFIG_CMDLINE="console=ttyPS0,115200n8 root=/dev/ram rw
initrd=0x00800000,16M earlyprintk
mtdparts=physmap-flash.0:512K(nor-fsbl),512K(nor-u-boot),5M(nor-linux),9M(nor-user),1M(nor-scratch),-(nor-rootfs)"
CONFIG_VFP=y
CONFIG_NEON=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
# CONFIG_SUSPEND is not set
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_WIRELESS is not set
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_EXTRA_FIRMWARE="test"
CONFIG_PROC_DEVICETREE=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_SCSI=y
CONFIG_SCSI_TGT=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
CONFIG_CHR_DEV_OSST=y
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=y
CONFIG_CHR_DEV_SCH=y
CONFIG_NETDEVICES=y
# CONFIG_NET_VENDOR_BROADCOM is not set
# CONFIG_NET_VENDOR_FARADAY is not set
# CONFIG_NET_VENDOR_INTEL is not set
# CONFIG_NET_VENDOR_MARVELL is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SMSC is not set
# CONFIG_NET_VENDOR_STMICRO is not set
CONFIG_PHYLIB=y
# CONFIG_WLAN is not set
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_XILINX_PS_UART=y
CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
# CONFIG_HW_RANDOM is not set
CONFIG_I2C=y
CONFIG_SPI=y
# CONFIG_HWMON is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_FB=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_LOGO=y
# CONFIG_USB_SUPPORT is not set
CONFIG_MMC=y
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_PLTFM=y
CONFIG_UIO=y
CONFIG_UIO_PDRV_GENIRQ=y
# CONFIG_IOMMU_SUPPORT is not set
CONFIG_VIRT_DRIVERS=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT3_FS=y
CONFIG_EXT4_FS=y
# CONFIG_DNOTIFY is not set
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_TMPFS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3_ACL=y
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_UTF8=y
# CONFIG_ENABLE_WARN_DEPRECATED is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_DEBUG_FS=y
# CONFIG_SCHED_DEBUG is not set
# CONFIG_DEBUG_PREEMPT is not set
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_SG=y
# CONFIG_FTRACE is not set
CONFIG_SAMPLES=y
CONFIG_DEBUG_USER=y
CONFIG_DEBUG_LL=y
CONFIG_DEBUG_ZYNQ_UART1=y
CONFIG_EARLY_PRINTK=y



-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
