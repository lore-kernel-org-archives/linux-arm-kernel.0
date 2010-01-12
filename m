From: epeer@tmtservices.co.za (Edwin Peer)
Date: Tue, 12 Jan 2010 12:06:38 +0200
Subject: [PATCH] ARM: Support for Embedian MXM-8x10 eval kit
Message-ID: <201001121206.38686.epeer@tmtservices.co.za>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the Embedian MXM-8x10 evaluation kit.
Product URL: http://www.embedian.com/index.php?main_page=product_info&amp;cPath=68&amp;products_id=229

Signed-off-by: Edwin Peer <epeer@tmtservices.co.za>
---
diff -Nrpu linux-2.6.33-rc3/arch/arm/configs/capc7117_defconfig linux-embedian-2.6.33-
rc3/arch/arm/configs/capc7117_defconfig
--- linux-2.6.33-rc3/arch/arm/configs/capc7117_defconfig	1970-01-01 02:00:00.000000000 +0200
+++ linux-embedian-2.6.33-rc3/arch/arm/configs/capc7117_defconfig	2010-01-11 16:59:47.000000000 +0200
@@ -0,0 +1,1506 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.33-rc3
+# Mon Jan 11 16:41:07 2010
+#
+CONFIG_ARM=y
+CONFIG_SYS_SUPPORTS_APM_EMULATION=y
+CONFIG_GENERIC_GPIO=y
+CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_CLOCKEVENTS=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_HAVE_LATENCYTOP_SUPPORT=y
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
+CONFIG_HARDIRQS_SW_RESEND=y
+CONFIG_GENERIC_IRQ_PROBE=y
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_ARCH_HAS_CPUFREQ=y
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_ARCH_MTD_XIP=y
+CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
+CONFIG_VECTORS_BASE=0xffff0000
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+CONFIG_CONSTRUCTORS=y
+
+#
+# General setup
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_LOCK_KERNEL=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_POSIX_MQUEUE_SYSCTL=y
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_AUDIT is not set
+
+#
+# RCU Subsystem
+#
+CONFIG_TREE_RCU=y
+# CONFIG_TREE_PREEMPT_RCU is not set
+# CONFIG_TINY_RCU is not set
+# CONFIG_RCU_TRACE is not set
+CONFIG_RCU_FANOUT=32
+# CONFIG_RCU_FANOUT_EXACT is not set
+# CONFIG_TREE_RCU_TRACE is not set
+CONFIG_IKCONFIG=m
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_GROUP_SCHED is not set
+# CONFIG_CGROUPS is not set
+CONFIG_SYSFS_DEPRECATED=y
+CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_RELAY is not set
+CONFIG_NAMESPACES=y
+# CONFIG_UTS_NS is not set
+# CONFIG_IPC_NS is not set
+# CONFIG_USER_NS is not set
+# CONFIG_PID_NS is not set
+# CONFIG_NET_NS is not set
+# CONFIG_BLK_DEV_INITRD is not set
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
+# CONFIG_EMBEDDED is not set
+CONFIG_UID16=y
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
+CONFIG_SHMEM=y
+CONFIG_AIO=y
+
+#
+# Kernel Performance Events And Counters
+#
+CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLUB_DEBUG=y
+# CONFIG_COMPAT_BRK is not set
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
+# CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+CONFIG_HAVE_OPROFILE=y
+# CONFIG_KPROBES is not set
+CONFIG_HAVE_KPROBES=y
+CONFIG_HAVE_KRETPROBES=y
+CONFIG_HAVE_CLK=y
+
+#
+# GCOV-based kernel profiling
+#
+CONFIG_SLOW_WORK=y
+CONFIG_HAVE_GENERIC_DMA_COHERENT=y
+CONFIG_SLABINFO=y
+CONFIG_RT_MUTEXES=y
+CONFIG_BASE_SMALL=0
+CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_BLOCK=y
+CONFIG_LBDAF=y
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_BLK_DEV_INTEGRITY is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+# CONFIG_IOSCHED_DEADLINE is not set
+CONFIG_IOSCHED_CFQ=y
+# CONFIG_DEFAULT_DEADLINE is not set
+CONFIG_DEFAULT_CFQ=y
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="cfq"
+# CONFIG_INLINE_SPIN_TRYLOCK is not set
+# CONFIG_INLINE_SPIN_TRYLOCK_BH is not set
+# CONFIG_INLINE_SPIN_LOCK is not set
+# CONFIG_INLINE_SPIN_LOCK_BH is not set
+# CONFIG_INLINE_SPIN_LOCK_IRQ is not set
+# CONFIG_INLINE_SPIN_LOCK_IRQSAVE is not set
+# CONFIG_INLINE_SPIN_UNLOCK is not set
+# CONFIG_INLINE_SPIN_UNLOCK_BH is not set
+# CONFIG_INLINE_SPIN_UNLOCK_IRQ is not set
+# CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE is not set
+# CONFIG_INLINE_READ_TRYLOCK is not set
+# CONFIG_INLINE_READ_LOCK is not set
+# CONFIG_INLINE_READ_LOCK_BH is not set
+# CONFIG_INLINE_READ_LOCK_IRQ is not set
+# CONFIG_INLINE_READ_LOCK_IRQSAVE is not set
+# CONFIG_INLINE_READ_UNLOCK is not set
+# CONFIG_INLINE_READ_UNLOCK_BH is not set
+# CONFIG_INLINE_READ_UNLOCK_IRQ is not set
+# CONFIG_INLINE_READ_UNLOCK_IRQRESTORE is not set
+# CONFIG_INLINE_WRITE_TRYLOCK is not set
+# CONFIG_INLINE_WRITE_LOCK is not set
+# CONFIG_INLINE_WRITE_LOCK_BH is not set
+# CONFIG_INLINE_WRITE_LOCK_IRQ is not set
+# CONFIG_INLINE_WRITE_LOCK_IRQSAVE is not set
+# CONFIG_INLINE_WRITE_UNLOCK is not set
+# CONFIG_INLINE_WRITE_UNLOCK_BH is not set
+# CONFIG_INLINE_WRITE_UNLOCK_IRQ is not set
+# CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE is not set
+# CONFIG_MUTEX_SPIN_ON_OWNER is not set
+# CONFIG_FREEZER is not set
+
+#
+# System Type
+#
+CONFIG_MMU=y
+# CONFIG_ARCH_AAEC2000 is not set
+# CONFIG_ARCH_INTEGRATOR is not set
+# CONFIG_ARCH_REALVIEW is not set
+# CONFIG_ARCH_VERSATILE is not set
+# CONFIG_ARCH_AT91 is not set
+# CONFIG_ARCH_CLPS711X is not set
+# CONFIG_ARCH_GEMINI is not set
+# CONFIG_ARCH_EBSA110 is not set
+# CONFIG_ARCH_EP93XX is not set
+# CONFIG_ARCH_FOOTBRIDGE is not set
+# CONFIG_ARCH_MXC is not set
+# CONFIG_ARCH_STMP3XXX is not set
+# CONFIG_ARCH_NETX is not set
+# CONFIG_ARCH_H720X is not set
+# CONFIG_ARCH_NOMADIK is not set
+# CONFIG_ARCH_IOP13XX is not set
+# CONFIG_ARCH_IOP32X is not set
+# CONFIG_ARCH_IOP33X is not set
+# CONFIG_ARCH_IXP23XX is not set
+# CONFIG_ARCH_IXP2000 is not set
+# CONFIG_ARCH_IXP4XX is not set
+# CONFIG_ARCH_L7200 is not set
+# CONFIG_ARCH_DOVE is not set
+# CONFIG_ARCH_KIRKWOOD is not set
+# CONFIG_ARCH_LOKI is not set
+# CONFIG_ARCH_MV78XX0 is not set
+# CONFIG_ARCH_ORION5X is not set
+# CONFIG_ARCH_MMP is not set
+# CONFIG_ARCH_KS8695 is not set
+# CONFIG_ARCH_NS9XXX is not set
+# CONFIG_ARCH_W90X900 is not set
+# CONFIG_ARCH_PNX4008 is not set
+CONFIG_ARCH_PXA=y
+# CONFIG_ARCH_MSM is not set
+# CONFIG_ARCH_RPC is not set
+# CONFIG_ARCH_SA1100 is not set
+# CONFIG_ARCH_S3C2410 is not set
+# CONFIG_ARCH_S3C64XX is not set
+# CONFIG_ARCH_S5PC1XX is not set
+# CONFIG_ARCH_SHARK is not set
+# CONFIG_ARCH_LH7A40X is not set
+# CONFIG_ARCH_U300 is not set
+# CONFIG_ARCH_DAVINCI is not set
+# CONFIG_ARCH_OMAP is not set
+# CONFIG_ARCH_BCMRING is not set
+# CONFIG_ARCH_U8500 is not set
+
+#
+# Intel PXA2xx/PXA3xx Implementations
+#
+
+#
+# Intel/Marvell Dev Platforms (sorted by hardware release time)
+#
+# CONFIG_ARCH_LUBBOCK is not set
+# CONFIG_MACH_MAINSTONE is not set
+# CONFIG_MACH_ZYLONITE300 is not set
+# CONFIG_MACH_ZYLONITE320 is not set
+# CONFIG_MACH_LITTLETON is not set
+# CONFIG_MACH_TAVOREVB is not set
+# CONFIG_MACH_SAAR is not set
+
+#
+# Third Party Dev Platforms (sorted by vendor name)
+#
+# CONFIG_ARCH_PXA_IDP is not set
+# CONFIG_ARCH_VIPER is not set
+# CONFIG_MACH_ARCOM_ZEUS is not set
+# CONFIG_MACH_BALLOON3 is not set
+# CONFIG_MACH_CSB726 is not set
+# CONFIG_MACH_ARMCORE is not set
+# CONFIG_MACH_EM_X270 is not set
+# CONFIG_MACH_EXEDA is not set
+# CONFIG_MACH_CM_X300 is not set
+CONFIG_MACH_CAPC7117=y
+# CONFIG_ARCH_GUMSTIX is not set
+# CONFIG_MACH_INTELMOTE2 is not set
+# CONFIG_MACH_STARGATE2 is not set
+# CONFIG_MACH_XCEP is not set
+# CONFIG_TRIZEPS_PXA is not set
+# CONFIG_MACH_LOGICPD_PXA270 is not set
+# CONFIG_MACH_PCM027 is not set
+# CONFIG_MACH_COLIBRI is not set
+# CONFIG_MACH_COLIBRI300 is not set
+# CONFIG_MACH_COLIBRI320 is not set
+
+#
+# End-user Products (sorted by vendor name)
+#
+# CONFIG_MACH_H4700 is not set
+# CONFIG_MACH_H5000 is not set
+# CONFIG_MACH_HIMALAYA is not set
+# CONFIG_MACH_MAGICIAN is not set
+# CONFIG_MACH_MIOA701 is not set
+# CONFIG_PXA_EZX is not set
+# CONFIG_MACH_MP900C is not set
+# CONFIG_ARCH_PXA_PALM is not set
+# CONFIG_PXA_SHARPSL is not set
+# CONFIG_ARCH_PXA_ESERIES is not set
+CONFIG_PXA3xx=y
+CONFIG_CPU_PXA320=y
+CONFIG_PXA_SSP=y
+CONFIG_PLAT_PXA=y
+
+#
+# Processor Type
+#
+CONFIG_CPU_XSC3=y
+CONFIG_CPU_32v5=y
+CONFIG_CPU_ABRT_EV5T=y
+CONFIG_CPU_PABRT_LEGACY=y
+CONFIG_CPU_CACHE_VIVT=y
+CONFIG_CPU_TLB_V4WBI=y
+CONFIG_CPU_CP15=y
+CONFIG_CPU_CP15_MMU=y
+CONFIG_IO_36=y
+
+#
+# Processor Features
+#
+CONFIG_ARM_THUMB=y
+# CONFIG_CPU_DCACHE_DISABLE is not set
+# CONFIG_CPU_BPREDICT_DISABLE is not set
+# CONFIG_CACHE_XSC3L2 is not set
+CONFIG_ARM_L1_CACHE_SHIFT=5
+CONFIG_IWMMXT=y
+CONFIG_COMMON_CLKDEV=y
+
+#
+# Bus support
+#
+# CONFIG_PCI_SYSCALL is not set
+# CONFIG_ARCH_SUPPORTS_MSI is not set
+# CONFIG_PCCARD is not set
+
+#
+# Kernel Features
+#
+CONFIG_TICK_ONESHOT=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
+CONFIG_VMSPLIT_3G=y
+# CONFIG_VMSPLIT_2G is not set
+# CONFIG_VMSPLIT_1G is not set
+CONFIG_PAGE_OFFSET=0xC0000000
+# CONFIG_PREEMPT_NONE is not set
+# CONFIG_PREEMPT_VOLUNTARY is not set
+CONFIG_PREEMPT=y
+CONFIG_HZ=100
+# CONFIG_AEABI is not set
+# CONFIG_ARCH_SPARSEMEM_DEFAULT is not set
+# CONFIG_ARCH_SELECT_MEMORY_MODEL is not set
+# CONFIG_HIGHMEM is not set
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+CONFIG_PAGEFLAGS_EXTENDED=y
+CONFIG_SPLIT_PTLOCK_CPUS=999999
+# CONFIG_PHYS_ADDR_T_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=0
+CONFIG_VIRT_TO_BUS=y
+# CONFIG_KSM is not set
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
+CONFIG_ALIGNMENT_TRAP=y
+# CONFIG_UACCESS_WITH_MEMCPY is not set
+
+#
+# Boot options
+#
+CONFIG_ZBOOT_ROM_TEXT=0x0
+CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_CMDLINE="root=/dev/mtdblock2 rootfstype=jffs2 console=ttyS1,115200 mem=128M init=/linuxrc debug"
+# CONFIG_XIP_KERNEL is not set
+# CONFIG_KEXEC is not set
+
+#
+# CPU Power Management
+#
+# CONFIG_CPU_FREQ is not set
+# CONFIG_CPU_IDLE is not set
+
+#
+# Floating point emulation
+#
+
+#
+# At least one emulation must be selected
+#
+CONFIG_FPE_NWFPE=y
+# CONFIG_FPE_NWFPE_XP is not set
+# CONFIG_FPE_FASTFPE is not set
+
+#
+# Userspace binary formats
+#
+CONFIG_BINFMT_ELF=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_HAVE_AOUT=y
+# CONFIG_BINFMT_AOUT is not set
+# CONFIG_BINFMT_MISC is not set
+# CONFIG_ARTHUR is not set
+
+#
+# Power management options
+#
+CONFIG_PM=y
+# CONFIG_PM_DEBUG is not set
+# CONFIG_SUSPEND is not set
+# CONFIG_APM_EMULATION is not set
+# CONFIG_PM_RUNTIME is not set
+CONFIG_ARCH_SUSPEND_POSSIBLE=y
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+# CONFIG_IP_PNP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_ARPD is not set
+CONFIG_SYN_COOKIES=y
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+CONFIG_INET_DIAG=m
+CONFIG_INET_TCP_DIAG=m
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_NETLABEL is not set
+# CONFIG_NETWORK_SECMARK is not set
+# CONFIG_NETFILTER is not set
+# CONFIG_IP_DCCP is not set
+# CONFIG_IP_SCTP is not set
+# CONFIG_RDS is not set
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_NET_DSA is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_PHONET is not set
+# CONFIG_IEEE802154 is not set
+# CONFIG_NET_SCHED is not set
+# CONFIG_DCB is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+CONFIG_CAN=m
+CONFIG_CAN_RAW=m
+# CONFIG_CAN_BCM is not set
+
+#
+# CAN Device Drivers
+#
+CONFIG_CAN_VCAN=m
+CONFIG_CAN_DEV=m
+CONFIG_CAN_CALC_BITTIMING=y
+# CONFIG_CAN_MCP251X is not set
+# CONFIG_CAN_SJA1000 is not set
+
+#
+# CAN USB interfaces
+#
+# CONFIG_CAN_EMS_USB is not set
+CONFIG_CAN_DEBUG_DEVICES=y
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
+CONFIG_WIRELESS=y
+# CONFIG_CFG80211 is not set
+# CONFIG_LIB80211 is not set
+
+#
+# CFG80211 needs to be enabled for MAC80211
+#
+# CONFIG_WIMAX is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+# CONFIG_DEVTMPFS is not set
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=y
+CONFIG_FIRMWARE_IN_KERNEL=y
+CONFIG_EXTRA_FIRMWARE=""
+# CONFIG_SYS_HYPERVISOR is not set
+# CONFIG_CONNECTOR is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_TESTS is not set
+# CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+# CONFIG_MTD_CMDLINE_PARTS is not set
+# CONFIG_MTD_AFS_PARTS is not set
+# CONFIG_MTD_AR7_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+# CONFIG_MTD_CFI is not set
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_DATAFLASH is not set
+# CONFIG_MTD_M25P80 is not set
+# CONFIG_MTD_SST25L is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+CONFIG_MTD_NAND=y
+# CONFIG_MTD_NAND_VERIFY_WRITE is not set
+# CONFIG_MTD_NAND_ECC_SMC is not set
+# CONFIG_MTD_NAND_MUSEUM_IDS is not set
+# CONFIG_MTD_NAND_H1900 is not set
+# CONFIG_MTD_NAND_GPIO is not set
+CONFIG_MTD_NAND_IDS=y
+# CONFIG_MTD_NAND_DISKONCHIP is not set
+# CONFIG_MTD_NAND_SHARPSL is not set
+CONFIG_MTD_NAND_PXA3xx=y
+# CONFIG_MTD_NAND_PXA3xx_BUILTIN is not set
+# CONFIG_MTD_NAND_NANDSIM is not set
+# CONFIG_MTD_NAND_PLATFORM is not set
+# CONFIG_MTD_ALAUDA is not set
+# CONFIG_MTD_ONENAND is not set
+
+#
+# LPDDR flash memory drivers
+#
+# CONFIG_MTD_LPDDR is not set
+
+#
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
+# CONFIG_PARPORT is not set
+CONFIG_BLK_DEV=y
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=m
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+
+#
+# DRBD disabled because PROC_FS, INET or CONNECTOR not selected
+#
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_UB is not set
+# CONFIG_BLK_DEV_RAM is not set
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_MG_DISK is not set
+# CONFIG_MISC_DEVICES is not set
+CONFIG_HAVE_IDE=y
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+CONFIG_SCSI=m
+CONFIG_SCSI_DMA=y
+# CONFIG_SCSI_TGT is not set
+# CONFIG_SCSI_NETLINK is not set
+# CONFIG_SCSI_PROC_FS is not set
+
+#
+# SCSI support type (disk, tape, CD-ROM)
+#
+CONFIG_BLK_DEV_SD=m
+# CONFIG_CHR_DEV_ST is not set
+# CONFIG_CHR_DEV_OSST is not set
+# CONFIG_BLK_DEV_SR is not set
+# CONFIG_CHR_DEV_SG is not set
+# CONFIG_CHR_DEV_SCH is not set
+# CONFIG_SCSI_MULTI_LUN is not set
+# CONFIG_SCSI_CONSTANTS is not set
+# CONFIG_SCSI_LOGGING is not set
+# CONFIG_SCSI_SCAN_ASYNC is not set
+CONFIG_SCSI_WAIT_SCAN=m
+
+#
+# SCSI Transports
+#
+# CONFIG_SCSI_SPI_ATTRS is not set
+# CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
+# CONFIG_SCSI_SAS_LIBSAS is not set
+# CONFIG_SCSI_SRP_ATTRS is not set
+# CONFIG_SCSI_LOWLEVEL is not set
+# CONFIG_SCSI_DH is not set
+# CONFIG_SCSI_OSD_INITIATOR is not set
+# CONFIG_ATA is not set
+# CONFIG_MD is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+# CONFIG_VETH is not set
+# CONFIG_PHYLIB is not set
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_AX88796 is not set
+# CONFIG_SMC91X is not set
+CONFIG_DM9000=y
+CONFIG_DM9000_DEBUGLEVEL=4
+# CONFIG_DM9000_FORCE_SIMPLE_PHY_POLL is not set
+# CONFIG_ENC28J60 is not set
+# CONFIG_ETHOC is not set
+# CONFIG_SMC911X is not set
+# CONFIG_SMSC911X is not set
+# CONFIG_DNET is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
+# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
+# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
+# CONFIG_B44 is not set
+# CONFIG_KS8842 is not set
+# CONFIG_KS8851 is not set
+# CONFIG_KS8851_MLL is not set
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
+CONFIG_WLAN=y
+# CONFIG_USB_ZD1201 is not set
+# CONFIG_HOSTAP is not set
+
+#
+# Enable WiMAX (Networking options) to see the WiMAX drivers
+#
+
+#
+# USB Network Adapters
+#
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET is not set
+# CONFIG_WAN is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_ISDN is not set
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
+# CONFIG_INPUT_SPARSEKMAP is not set
+
+#
+# Userland interfaces
+#
+CONFIG_INPUT_MOUSEDEV=y
+# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+CONFIG_SERIO_SERPORT=y
+# CONFIG_SERIO_RAW is not set
+# CONFIG_SERIO_ALTERA_PS2 is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+CONFIG_VT=y
+CONFIG_CONSOLE_TRANSLATIONS=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
+CONFIG_DEVKMEM=y
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+# CONFIG_SERIAL_8250 is not set
+
+#
+# Non-8250 serial port support
+#
+# CONFIG_SERIAL_MAX3100 is not set
+CONFIG_SERIAL_PXA=y
+CONFIG_SERIAL_PXA_CONSOLE=y
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_UNIX98_PTYS=y
+# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_IPMI_HANDLER is not set
+# CONFIG_HW_RANDOM is not set
+# CONFIG_R3964 is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+CONFIG_I2C_COMPAT=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_HELPER_AUTO=y
+
+#
+# I2C Hardware Bus support
+#
+
+#
+# I2C system bus drivers (mostly embedded / system-on-chip)
+#
+# CONFIG_I2C_DESIGNWARE is not set
+# CONFIG_I2C_GPIO is not set
+# CONFIG_I2C_OCORES is not set
+CONFIG_I2C_PXA=y
+# CONFIG_I2C_PXA_SLAVE is not set
+# CONFIG_I2C_SIMTEC is not set
+
+#
+# External I2C/SMBus adapter drivers
+#
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_TAOS_EVM is not set
+# CONFIG_I2C_TINY_USB is not set
+
+#
+# Other I2C/SMBus bus drivers
+#
+# CONFIG_I2C_PCA_PLATFORM is not set
+# CONFIG_I2C_STUB is not set
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_SENSORS_TSL2550 is not set
+CONFIG_I2C_DEBUG_CORE=y
+CONFIG_I2C_DEBUG_ALGO=y
+CONFIG_I2C_DEBUG_BUS=y
+CONFIG_I2C_DEBUG_CHIP=y
+CONFIG_SPI=y
+CONFIG_SPI_MASTER=y
+
+#
+# SPI Master Controller Drivers
+#
+# CONFIG_SPI_BITBANG is not set
+# CONFIG_SPI_GPIO is not set
+CONFIG_SPI_PXA2XX=y
+# CONFIG_SPI_XILINX is not set
+# CONFIG_SPI_DESIGNWARE is not set
+
+#
+# SPI Protocol Masters
+#
+# CONFIG_SPI_SPIDEV is not set
+# CONFIG_SPI_TLE62X0 is not set
+
+#
+# PPS support
+#
+# CONFIG_PPS is not set
+CONFIG_ARCH_REQUIRE_GPIOLIB=y
+CONFIG_GPIOLIB=y
+# CONFIG_GPIO_SYSFS is not set
+
+#
+# Memory mapped GPIO expanders:
+#
+
+#
+# I2C GPIO expanders:
+#
+# CONFIG_GPIO_MAX732X is not set
+# CONFIG_GPIO_PCA953X is not set
+# CONFIG_GPIO_PCF857X is not set
+
+#
+# PCI GPIO expanders:
+#
+
+#
+# SPI GPIO expanders:
+#
+# CONFIG_GPIO_MAX7301 is not set
+# CONFIG_GPIO_MCP23S08 is not set
+# CONFIG_GPIO_MC33880 is not set
+
+#
+# AC97 GPIO expanders:
+#
+# CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_HWMON is not set
+# CONFIG_THERMAL is not set
+CONFIG_WATCHDOG=y
+# CONFIG_WATCHDOG_NOWAYOUT is not set
+
+#
+# Watchdog Device Drivers
+#
+# CONFIG_SOFT_WATCHDOG is not set
+CONFIG_SA1100_WATCHDOG=m
+
+#
+# USB-based Watchdog Cards
+#
+# CONFIG_USBPCWATCHDOG is not set
+CONFIG_SSB_POSSIBLE=y
+
+#
+# Sonics Silicon Backplane
+#
+# CONFIG_SSB is not set
+
+#
+# Multifunction device drivers
+#
+# CONFIG_MFD_CORE is not set
+# CONFIG_MFD_SM501 is not set
+# CONFIG_MFD_ASIC3 is not set
+# CONFIG_HTC_EGPIO is not set
+# CONFIG_HTC_PASIC3 is not set
+# CONFIG_TPS65010 is not set
+# CONFIG_TWL4030_CORE is not set
+# CONFIG_MFD_TMIO is not set
+# CONFIG_MFD_T7L66XB is not set
+# CONFIG_MFD_TC6387XB is not set
+# CONFIG_MFD_TC6393XB is not set
+# CONFIG_PMIC_DA903X is not set
+# CONFIG_PMIC_ADP5520 is not set
+# CONFIG_MFD_WM8400 is not set
+# CONFIG_MFD_WM831X is not set
+# CONFIG_MFD_WM8350_I2C is not set
+# CONFIG_MFD_PCF50633 is not set
+# CONFIG_MFD_MC13783 is not set
+# CONFIG_AB3100_CORE is not set
+# CONFIG_EZX_PCAP is not set
+# CONFIG_MFD_88PM8607 is not set
+# CONFIG_AB4500_CORE is not set
+# CONFIG_REGULATOR is not set
+# CONFIG_MEDIA_SUPPORT is not set
+
+#
+# Graphics support
+#
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
+# CONFIG_FB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+CONFIG_DISPLAY_SUPPORT=m
+
+#
+# Display hardware drivers
+#
+
+#
+# Console display driver support
+#
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
+# CONFIG_SOUND is not set
+# CONFIG_HID_SUPPORT is not set
+CONFIG_USB_SUPPORT=y
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+# CONFIG_USB_ARCH_HAS_EHCI is not set
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
+
+#
+# Miscellaneous USB options
+#
+CONFIG_USB_DEVICEFS=y
+CONFIG_USB_DEVICE_CLASS=y
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_SUSPEND is not set
+# CONFIG_USB_OTG is not set
+# CONFIG_USB_MON is not set
+# CONFIG_USB_WUSB is not set
+# CONFIG_USB_WUSB_CBAF is not set
+
+#
+# USB Host Controller Drivers
+#
+# CONFIG_USB_C67X00_HCD is not set
+# CONFIG_USB_OXU210HP_HCD is not set
+# CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_ISP1760_HCD is not set
+# CONFIG_USB_ISP1362_HCD is not set
+# CONFIG_USB_OHCI_HCD is not set
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
+# CONFIG_USB_HWA_HCD is not set
+# CONFIG_USB_MUSB_HDRC is not set
+
+#
+# USB Device Class drivers
+#
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
+# CONFIG_USB_WDM is not set
+# CONFIG_USB_TMC is not set
+
+#
+# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
+#
+
+#
+# also be needed; see USB_STORAGE Help for more info
+#
+CONFIG_USB_STORAGE=m
+# CONFIG_USB_STORAGE_DEBUG is not set
+# CONFIG_USB_STORAGE_DATAFAB is not set
+# CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_ISD200 is not set
+# CONFIG_USB_STORAGE_USBAT is not set
+# CONFIG_USB_STORAGE_SDDR09 is not set
+# CONFIG_USB_STORAGE_SDDR55 is not set
+# CONFIG_USB_STORAGE_JUMPSHOT is not set
+# CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_ONETOUCH is not set
+# CONFIG_USB_STORAGE_KARMA is not set
+# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
+# CONFIG_USB_LIBUSUAL is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+# CONFIG_USB_MICROTEK is not set
+
+#
+# USB port drivers
+#
+CONFIG_USB_SERIAL=m
+# CONFIG_USB_EZUSB is not set
+# CONFIG_USB_SERIAL_GENERIC is not set
+# CONFIG_USB_SERIAL_AIRCABLE is not set
+# CONFIG_USB_SERIAL_ARK3116 is not set
+# CONFIG_USB_SERIAL_BELKIN is not set
+# CONFIG_USB_SERIAL_CH341 is not set
+# CONFIG_USB_SERIAL_WHITEHEAT is not set
+# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
+# CONFIG_USB_SERIAL_CP210X is not set
+# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
+# CONFIG_USB_SERIAL_EMPEG is not set
+# CONFIG_USB_SERIAL_FTDI_SIO is not set
+# CONFIG_USB_SERIAL_FUNSOFT is not set
+# CONFIG_USB_SERIAL_VISOR is not set
+# CONFIG_USB_SERIAL_IPAQ is not set
+# CONFIG_USB_SERIAL_IR is not set
+# CONFIG_USB_SERIAL_EDGEPORT is not set
+# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
+# CONFIG_USB_SERIAL_GARMIN is not set
+# CONFIG_USB_SERIAL_IPW is not set
+# CONFIG_USB_SERIAL_IUU is not set
+# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
+# CONFIG_USB_SERIAL_KEYSPAN is not set
+# CONFIG_USB_SERIAL_KLSI is not set
+# CONFIG_USB_SERIAL_KOBIL_SCT is not set
+# CONFIG_USB_SERIAL_MCT_U232 is not set
+# CONFIG_USB_SERIAL_MOS7720 is not set
+# CONFIG_USB_SERIAL_MOS7840 is not set
+# CONFIG_USB_SERIAL_MOTOROLA is not set
+# CONFIG_USB_SERIAL_NAVMAN is not set
+# CONFIG_USB_SERIAL_PL2303 is not set
+# CONFIG_USB_SERIAL_OTI6858 is not set
+# CONFIG_USB_SERIAL_QUALCOMM is not set
+# CONFIG_USB_SERIAL_SPCP8X5 is not set
+# CONFIG_USB_SERIAL_HP4X is not set
+# CONFIG_USB_SERIAL_SAFE is not set
+# CONFIG_USB_SERIAL_SIEMENS_MPI is not set
+# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
+# CONFIG_USB_SERIAL_SYMBOL is not set
+# CONFIG_USB_SERIAL_TI is not set
+# CONFIG_USB_SERIAL_CYBERJACK is not set
+# CONFIG_USB_SERIAL_XIRCOM is not set
+CONFIG_USB_SERIAL_OPTION=m
+# CONFIG_USB_SERIAL_OMNINET is not set
+# CONFIG_USB_SERIAL_OPTICON is not set
+# CONFIG_USB_SERIAL_DEBUG is not set
+
+#
+# USB Miscellaneous drivers
+#
+# CONFIG_USB_EMI62 is not set
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
+# CONFIG_USB_SEVSEG is not set
+# CONFIG_USB_RIO500 is not set
+# CONFIG_USB_LEGOTOWER is not set
+# CONFIG_USB_LCD is not set
+# CONFIG_USB_BERRY_CHARGE is not set
+# CONFIG_USB_LED is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
+# CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
+# CONFIG_USB_APPLEDISPLAY is not set
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
+# CONFIG_USB_TEST is not set
+# CONFIG_USB_ISIGHTFW is not set
+# CONFIG_USB_VST is not set
+# CONFIG_USB_GADGET is not set
+
+#
+# OTG and related infrastructure
+#
+# CONFIG_USB_GPIO_VBUS is not set
+# CONFIG_USB_ULPI is not set
+# CONFIG_NOP_USB_XCEIV is not set
+CONFIG_MMC=m
+CONFIG_MMC_DEBUG=y
+# CONFIG_MMC_UNSAFE_RESUME is not set
+
+#
+# MMC/SD/SDIO Card Drivers
+#
+CONFIG_MMC_BLOCK=m
+CONFIG_MMC_BLOCK_BOUNCE=y
+CONFIG_SDIO_UART=m
+# CONFIG_MMC_TEST is not set
+
+#
+# MMC/SD/SDIO Host Controller Drivers
+#
+CONFIG_MMC_PXA=m
+# CONFIG_MMC_SDHCI is not set
+# CONFIG_MMC_AT91 is not set
+# CONFIG_MMC_ATMELMCI is not set
+# CONFIG_MMC_SPI is not set
+# CONFIG_MEMSTICK is not set
+# CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
+CONFIG_RTC_LIB=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+# CONFIG_RTC_DEBUG is not set
+
+#
+# RTC interfaces
+#
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
+# CONFIG_RTC_DRV_TEST is not set
+
+#
+# I2C RTC drivers
+#
+# CONFIG_RTC_DRV_DS1307 is not set
+# CONFIG_RTC_DRV_DS1374 is not set
+# CONFIG_RTC_DRV_DS1672 is not set
+# CONFIG_RTC_DRV_MAX6900 is not set
+# CONFIG_RTC_DRV_RS5C372 is not set
+# CONFIG_RTC_DRV_ISL1208 is not set
+# CONFIG_RTC_DRV_X1205 is not set
+# CONFIG_RTC_DRV_PCF8563 is not set
+# CONFIG_RTC_DRV_PCF8583 is not set
+# CONFIG_RTC_DRV_M41T80 is not set
+# CONFIG_RTC_DRV_BQ32K is not set
+# CONFIG_RTC_DRV_S35390A is not set
+# CONFIG_RTC_DRV_FM3130 is not set
+# CONFIG_RTC_DRV_RX8581 is not set
+# CONFIG_RTC_DRV_RX8025 is not set
+
+#
+# SPI RTC drivers
+#
+# CONFIG_RTC_DRV_M41T94 is not set
+# CONFIG_RTC_DRV_DS1305 is not set
+# CONFIG_RTC_DRV_DS1390 is not set
+# CONFIG_RTC_DRV_MAX6902 is not set
+# CONFIG_RTC_DRV_R9701 is not set
+# CONFIG_RTC_DRV_RS5C348 is not set
+# CONFIG_RTC_DRV_DS3234 is not set
+# CONFIG_RTC_DRV_PCF2123 is not set
+
+#
+# Platform RTC drivers
+#
+# CONFIG_RTC_DRV_CMOS is not set
+# CONFIG_RTC_DRV_DS1286 is not set
+# CONFIG_RTC_DRV_DS1511 is not set
+# CONFIG_RTC_DRV_DS1553 is not set
+# CONFIG_RTC_DRV_DS1742 is not set
+# CONFIG_RTC_DRV_STK17TA8 is not set
+# CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_M48T35 is not set
+# CONFIG_RTC_DRV_M48T59 is not set
+# CONFIG_RTC_DRV_MSM6242 is not set
+# CONFIG_RTC_DRV_BQ4802 is not set
+# CONFIG_RTC_DRV_RP5C01 is not set
+# CONFIG_RTC_DRV_V3020 is not set
+
+#
+# on-CPU RTC drivers
+#
+CONFIG_RTC_DRV_SA1100=y
+# CONFIG_RTC_DRV_PXA is not set
+# CONFIG_DMADEVICES is not set
+# CONFIG_AUXDISPLAY is not set
+# CONFIG_UIO is not set
+
+#
+# TI VLYNQ
+#
+# CONFIG_STAGING is not set
+
+#
+# File systems
+#
+# CONFIG_EXT2_FS is not set
+CONFIG_EXT3_FS=y
+# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT3_FS_XATTR=y
+CONFIG_EXT3_FS_POSIX_ACL=y
+# CONFIG_EXT3_FS_SECURITY is not set
+# CONFIG_EXT4_FS is not set
+CONFIG_JBD=y
+CONFIG_FS_MBCACHE=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+CONFIG_FS_POSIX_ACL=y
+# CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_BTRFS_FS is not set
+# CONFIG_NILFS2_FS is not set
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
+# CONFIG_DNOTIFY is not set
+CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
+# CONFIG_QUOTA is not set
+CONFIG_AUTOFS_FS=y
+CONFIG_AUTOFS4_FS=y
+CONFIG_FUSE_FS=m
+# CONFIG_CUSE is not set
+
+#
+# Caches
+#
+# CONFIG_FSCACHE is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+CONFIG_FAT_FS=m
+CONFIG_MSDOS_FS=m
+CONFIG_VFAT_FS=m
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_SYSCTL=y
+CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_CONFIGFS_FS=y
+CONFIG_MISC_FILESYSTEMS=y
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_ECRYPT_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
+# CONFIG_JFFS2_SUMMARY is not set
+# CONFIG_JFFS2_FS_XATTR is not set
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_ZLIB=y
+# CONFIG_JFFS2_LZO is not set
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_SQUASHFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_OMFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+CONFIG_NETWORK_FILESYSTEMS=y
+# CONFIG_NFS_FS is not set
+# CONFIG_NFSD is not set
+# CONFIG_SMB_FS is not set
+CONFIG_CIFS=m
+# CONFIG_CIFS_STATS is not set
+# CONFIG_CIFS_WEAK_PW_HASH is not set
+# CONFIG_CIFS_UPCALL is not set
+# CONFIG_CIFS_XATTR is not set
+# CONFIG_CIFS_DEBUG2 is not set
+# CONFIG_CIFS_DFS_UPCALL is not set
+# CONFIG_CIFS_EXPERIMENTAL is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+# CONFIG_NLS_CODEPAGE_437 is not set
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
+# CONFIG_NLS_ISO8859_1 is not set
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+# CONFIG_NLS_UTF8 is not set
+# CONFIG_DLM is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
+CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
+# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_STRIP_ASM_SYMS is not set
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
+# CONFIG_DEBUG_KERNEL is not set
+# CONFIG_SLUB_DEBUG_ON is not set
+# CONFIG_SLUB_STATS is not set
+CONFIG_DEBUG_BUGVERBOSE=y
+CONFIG_DEBUG_MEMORY_INIT=y
+CONFIG_FRAME_POINTER=y
+# CONFIG_RCU_CPU_STALL_DETECTOR is not set
+# CONFIG_LATENCYTOP is not set
+CONFIG_SYSCTL_SYSCALL_CHECK=y
+CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_TRACING_SUPPORT=y
+# CONFIG_FTRACE is not set
+# CONFIG_SAMPLES is not set
+CONFIG_HAVE_ARCH_KGDB=y
+CONFIG_DEBUG_USER=y
+# CONFIG_OC_ETM is not set
+
+#
+# Security options
+#
+CONFIG_KEYS=y
+CONFIG_KEYS_DEBUG_PROC_KEYS=y
+CONFIG_SECURITY=y
+# CONFIG_SECURITYFS is not set
+# CONFIG_SECURITY_NETWORK is not set
+# CONFIG_SECURITY_PATH is not set
+# CONFIG_SECURITY_TOMOYO is not set
+# CONFIG_DEFAULT_SECURITY_SELINUX is not set
+# CONFIG_DEFAULT_SECURITY_SMACK is not set
+# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
+CONFIG_DEFAULT_SECURITY_DAC=y
+CONFIG_DEFAULT_SECURITY=""
+CONFIG_CRYPTO=m
+
+#
+# Crypto core or helper
+#
+# CONFIG_CRYPTO_FIPS is not set
+CONFIG_CRYPTO_ALGAPI=m
+CONFIG_CRYPTO_ALGAPI2=m
+CONFIG_CRYPTO_HASH=m
+CONFIG_CRYPTO_HASH2=m
+CONFIG_CRYPTO_RNG=m
+CONFIG_CRYPTO_RNG2=m
+# CONFIG_CRYPTO_MANAGER is not set
+# CONFIG_CRYPTO_MANAGER2 is not set
+# CONFIG_CRYPTO_GF128MUL is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_CRYPTD is not set
+# CONFIG_CRYPTO_AUTHENC is not set
+# CONFIG_CRYPTO_TEST is not set
+
+#
+# Authenticated Encryption with Associated Data
+#
+# CONFIG_CRYPTO_CCM is not set
+# CONFIG_CRYPTO_GCM is not set
+# CONFIG_CRYPTO_SEQIV is not set
+
+#
+# Block modes
+#
+# CONFIG_CRYPTO_CBC is not set
+# CONFIG_CRYPTO_CTR is not set
+# CONFIG_CRYPTO_CTS is not set
+# CONFIG_CRYPTO_ECB is not set
+# CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_PCBC is not set
+# CONFIG_CRYPTO_XTS is not set
+
+#
+# Hash modes
+#
+# CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_XCBC is not set
+# CONFIG_CRYPTO_VMAC is not set
+
+#
+# Digest
+#
+CONFIG_CRYPTO_CRC32C=m
+# CONFIG_CRYPTO_GHASH is not set
+# CONFIG_CRYPTO_MD4 is not set
+# CONFIG_CRYPTO_MD5 is not set
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_RMD128 is not set
+# CONFIG_CRYPTO_RMD160 is not set
+# CONFIG_CRYPTO_RMD256 is not set
+# CONFIG_CRYPTO_RMD320 is not set
+# CONFIG_CRYPTO_SHA1 is not set
+# CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_WP512 is not set
+
+#
+# Ciphers
+#
+CONFIG_CRYPTO_AES=m
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+# CONFIG_CRYPTO_DES is not set
+# CONFIG_CRYPTO_FCRYPT is not set
+# CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_SALSA20 is not set
+# CONFIG_CRYPTO_SEED is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+
+#
+# Compression
+#
+# CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_ZLIB is not set
+# CONFIG_CRYPTO_LZO is not set
+
+#
+# Random Number Generation
+#
+CONFIG_CRYPTO_ANSI_CPRNG=m
+CONFIG_CRYPTO_HW=y
+# CONFIG_BINARY_PRINTF is not set
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=y
+CONFIG_GENERIC_FIND_LAST_BIT=y
+CONFIG_CRC_CCITT=m
+CONFIG_CRC16=m
+# CONFIG_CRC_T10DIF is not set
+CONFIG_CRC_ITU_T=m
+CONFIG_CRC32=y
+CONFIG_CRC7=m
+CONFIG_LIBCRC32C=m
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
+CONFIG_NLATTR=y
diff -Nrpu linux-2.6.33-rc3/arch/arm/mach-pxa/Kconfig linux-embedian-2.6.33-rc3/arch/arm/mach-pxa/Kconfig
--- linux-2.6.33-rc3/arch/arm/mach-pxa/Kconfig	2010-01-12 11:12:42.000000000 +0200
+++ linux-embedian-2.6.33-rc3/arch/arm/mach-pxa/Kconfig	2010-01-11 15:30:49.000000000 +0200
@@ -113,6 +113,11 @@ config MACH_CM_X300
 	select CPU_PXA310
 	select HAVE_PWM
 
+config MACH_CAPC7117
+	bool "Embedian CAPC-7117 evaluation kit based on the MXM-8x10 CoM"
+	select CPU_PXA320
+	select PXA3xx
+
 config ARCH_GUMSTIX
 	bool "Gumstix XScale 255 boards"
 	select PXA25x
diff -Nrpu linux-2.6.33-rc3/arch/arm/mach-pxa/Makefile linux-embedian-2.6.33-rc3/arch/arm/mach-pxa/Makefile
--- linux-2.6.33-rc3/arch/arm/mach-pxa/Makefile	2010-01-12 11:12:42.000000000 +0200
+++ linux-embedian-2.6.33-rc3/arch/arm/mach-pxa/Makefile	2010-01-11 15:31:16.000000000 +0200
@@ -48,6 +48,7 @@ obj-$(CONFIG_MACH_ARMCORE)	+= cm-x2xx-pc
 endif
 obj-$(CONFIG_MACH_EM_X270)	+= em-x270.o
 obj-$(CONFIG_MACH_CM_X300)      += cm-x300.o
+obj-$(CONFIG_MACH_CAPC7117)     += capc7117.o mxm8x10.o
 obj-$(CONFIG_ARCH_GUMSTIX)	+= gumstix.o
 obj-$(CONFIG_GUMSTIX_AM200EPD)	+= am200epd.o
 obj-$(CONFIG_GUMSTIX_AM300EPD)	+= am300epd.o
diff -Nrpu linux-2.6.33-rc3/arch/arm/mach-pxa/capc7117.c linux-embedian-2.6.33-rc3/arch/arm/mach-pxa/capc7117.c
--- linux-2.6.33-rc3/arch/arm/mach-pxa/capc7117.c	1970-01-01 02:00:00.000000000 +0200
+++ linux-embedian-2.6.33-rc3/arch/arm/mach-pxa/capc7117.c	2010-01-12 11:49:58.000000000 +0200
@@ -0,0 +1,180 @@
+/*
+ * linux/arch/arm/mach-pxa/capc7117.c
+ *
+ * Support for the Embedian CAPC-7117 Evaluation Kit
+ * based on the Embedian MXM-8x10 Computer on Module
+ *
+ * Copyright (C) 2009 Embedian Inc.
+ * Copyright (C) 2009 TMT Services & Supplies (Pty) Ltd.
+ *
+ * 2007-09-04: eric miao <eric.y.miao@gmail.com>
+ *             rewrite to align with latest kernel
+ *
+ * 2010-01-09: Edwin Peer <epeer@tmtservices.co.za>
+ *             Hennie van der Merwe <hvdmerwe@tmtservices.co.za>
+ *             rework for upstream merge
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/irq.h>
+#include <linux/platform_device.h>
+#include <linux/ata_platform.h>
+#include <linux/serial_8250.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <mach/gpio.h>
+#include <mach/mfp-pxa320.h>
+#include <mach/mxm8x10.h>
+
+#include "generic.h"
+
+/* IDE (PATA) Support */
+static struct pata_platform_info pata_platform_data = {
+	.ioport_shift = 1,
+};
+
+static struct resource capc7117_ide_resources[] = {
+	[0] = {
+	       .start = 0x11000020,
+	       .end = 0x1100003f,
+	       .flags = IORESOURCE_MEM,
+	       },
+	[1] = {
+	       .start = 0x1100001c,
+	       .end = 0x1100001c,
+	       .flags = IORESOURCE_MEM,
+	       },
+	[2] = {
+	       .start = 0,
+	       .end = 0,
+	       .flags = IORESOURCE_IRQ,
+	       },
+};
+
+struct platform_device capc7117_ide_device = {
+	.name = "pata_platform",
+	.num_resources = ARRAY_SIZE(capc7117_ide_resources),
+	.resource = capc7117_ide_resources,
+	.dev = {
+		.platform_data = &pata_platform_data,
+		.coherent_dma_mask = ~0,	/* grumble */
+		},
+};
+
+int capc7117_ide_mach_init(void)
+{
+	return 0;
+}
+EXPORT_SYMBOL(capc7117_ide_mach_init);
+
+static void __init capc7117_ide_init(void)
+{
+	pxa3xx_mfp_write(MFP_PIN_GPIO76, 0xa0c0);	/* EXT_IRQ3 */
+
+	capc7117_ide_resources[2].start =
+	    gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO76));
+	capc7117_ide_resources[2].end =
+	    gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO76));
+	set_irq_type(capc7117_ide_resources[2].start, IRQ_TYPE_EDGE_RISING);
+	platform_device_register(&capc7117_ide_device);
+}
+
+/* TI16C752 UART support */
+#define	TI16C752_FLAGS		(UPF_BOOT_AUTOCONF | \
+					UPF_IOREMAP | \
+					UPF_BUGGY_UART | \
+					UPF_SKIP_TEST)
+#define	TI16C752_UARTCLK	(22118400)
+static struct plat_serial8250_port ti16c752_platform_data[] = {
+	[0] = {
+	       .mapbase = 0x14000000,
+	       .irq = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO78)),
+	       .flags = TI16C752_FLAGS,
+	       .iotype = UPIO_MEM,
+	       .regshift = 1,
+	       .uartclk = TI16C752_UARTCLK,
+	       },
+	[1] = {
+	       .mapbase = 0x14000040,
+	       .irq = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO79)),
+	       .flags = TI16C752_FLAGS,
+	       .iotype = UPIO_MEM,
+	       .regshift = 1,
+	       .uartclk = TI16C752_UARTCLK,
+	       },
+	[2] = {
+	       .mapbase = 0x14000080,
+	       .irq = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO80)),
+	       .flags = TI16C752_FLAGS,
+	       .iotype = UPIO_MEM,
+	       .regshift = 1,
+	       .uartclk = TI16C752_UARTCLK,
+	       },
+	[3] = {
+	       .mapbase = 0x140000c0,
+	       .irq = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO81)),
+	       .flags = TI16C752_FLAGS,
+	       .iotype = UPIO_MEM,
+	       .regshift = 1,
+	       .uartclk = TI16C752_UARTCLK,
+	       },
+	[4] = {
+	       .flags = 0,
+	       },
+};
+
+static struct platform_device ti16c752_device = {
+	.name = "serial8250",
+	.id = PLAT8250_DEV_PLATFORM,
+	.dev = {
+		.platform_data = ti16c752_platform_data,
+		},
+};
+
+static void __init capc7117_uarts_init(void)
+{
+	int i;
+
+	pxa3xx_mfp_write(MFP_PIN_GPIO78, 0xa090);	/* EXT_IRQ5 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO79, 0xa090);	/* EXT_IRQ6 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO80, 0xa090);	/* EXT_IRQ7 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO81, 0xa090);	/* EXT_IRQ8 */
+
+	for (i = 0; i < 4; i++)
+		set_irq_type(ti16c752_platform_data[i].irq,
+			     IRQ_TYPE_EDGE_RISING);
+
+	platform_device_register(&ti16c752_device);
+}
+
+static void __init capc7117_init(void)
+{
+	if (cpu_is_pxa320()) {
+		mxm_8x10_barebones_init();
+
+		mxm_8x10_lcd_init();
+		mxm_8x10_ac97_init();
+		mxm_8x10_usb_host_init();
+		mxm_8x10_mmc_init();
+
+		capc7117_uarts_init();
+		capc7117_ide_init();
+	} else {
+		panic("Unsupported processor. Platform must be pxa320\n");
+	}
+}
+
+MACHINE_START(CAPC7117,
+	      "Embedian CAPC-7117 evaluation kit based on the MXM-8x10 CoM")
+    .phys_io = 0x40000000,
+    .boot_params = 0xa0000100,
+    .io_pg_offst = (io_p2v(0x40000000) >> 18) & 0xfffc,
+    .map_io = pxa_map_io,
+    .init_irq = pxa3xx_init_irq,
+    .timer = &pxa_timer,
+    .init_machine = capc7117_init,
+MACHINE_END
diff -Nrpu linux-2.6.33-rc3/arch/arm/mach-pxa/include/mach/mxm8x10.h linux-embedian-2.6.33-rc3/arch/arm/mach-
pxa/include/mach/mxm8x10.h
--- linux-2.6.33-rc3/arch/arm/mach-pxa/include/mach/mxm8x10.h	1970-01-01 02:00:00.000000000 +0200
+++ linux-embedian-2.6.33-rc3/arch/arm/mach-pxa/include/mach/mxm8x10.h	2010-01-11 15:30:10.000000000 +0200
@@ -0,0 +1,28 @@
+#ifndef __MACH_MXM_8X10_H
+#define __MACH_MXM_8X10_H
+
+#define MXM_8X10_ETH_PHYS	0x13000000
+
+#define NAND_MMIO_START         0x43100000
+#define NAND_MMIO_END           0x43100080
+
+#define EXT_GPIO(x)     (128 + (x))
+
+struct platform_mmc_slot {
+	int gpio_cd;
+	int gpio_wp;
+};
+
+extern void mxm_8x10_mmc_init(void);
+extern void mxm_8x10_usb_host_init(void);
+extern void mxm_8x10_ac97_init(void);
+extern void mxm_8x10_nand_init(void);
+extern void mxm_8x10_ethernet_init(void);
+extern void mxm_8x10_ide_init(void);
+extern void mxm_8x10_uart_init(void);
+extern void mxm_8x10_lcd_init(void);
+extern void mxm_8x10_i2c_init(void);
+
+extern void mxm_8x10_barebones_init(void);
+
+#endif /* __MACH_MXM_8X10_H */
diff -Nrpu linux-2.6.33-rc3/arch/arm/mach-pxa/include/mach/pxa3xx-regs.h linux-embedian-2.6.33-rc3/arch/arm/mach-
pxa/include/mach/pxa3xx-regs.h
--- linux-2.6.33-rc3/arch/arm/mach-pxa/include/mach/pxa3xx-regs.h	2009-12-03 05:51:21.000000000 +0200
+++ linux-embedian-2.6.33-rc3/arch/arm/mach-pxa/include/mach/pxa3xx-regs.h	2010-01-11 17:32:52.000000000 +0200
@@ -211,4 +211,19 @@
 #define CKEN_PXA300_GCU		42	/* Graphics controller clock enable */
 #define CKEN_PXA320_GCU		7	/* Graphics controller clock enable */
 
+/* USB Host Controller Reset Register */
+
+#define UHCHR           __REG(0x4C000064) /* UHC Reset Register */
+#define UHCHR_SSEP3     (1 << 11)       /* Sleep Standby Enable for Port3 */
+#define UHCHR_SSEP2     (1 << 10)       /* Sleep Standby Enable for Port2 */
+#define UHCHR_SSEP1     (1 << 9)        /* Sleep Standby Enable for Port1 */
+#define UHCHR_PCPL      (1 << 7)        /* Power control polarity low */
+#define UHCHR_PSPL      (1 << 6)        /* Power sense polarity low */
+#define UHCHR_SSE       (1 << 5)        /* Sleep Standby Enable */
+#define UHCHR_UIT       (1 << 4)        /* USB Interrupt Test */
+#define UHCHR_SSDC      (1 << 3)        /* Simulation Scale Down Clock */
+#define UHCHR_CGR       (1 << 2)        /* Clock Generation Reset */
+#define UHCHR_FHR       (1 << 1)        /* Force Host Controller Reset */
+#define UHCHR_FSBIR     (1 << 0)        /* Force System Bus Iface Reset */
+
 #endif /* __ASM_ARCH_PXA3XX_REGS_H */
diff -Nrpu linux-2.6.33-rc3/arch/arm/mach-pxa/mxm8x10.c linux-embedian-2.6.33-rc3/arch/arm/mach-pxa/mxm8x10.c
--- linux-2.6.33-rc3/arch/arm/mach-pxa/mxm8x10.c	1970-01-01 02:00:00.000000000 +0200
+++ linux-embedian-2.6.33-rc3/arch/arm/mach-pxa/mxm8x10.c	2010-01-12 11:48:28.000000000 +0200
@@ -0,0 +1,857 @@
+/*
+ * linux/arch/arm/mach-pxa/mxm8x10.c
+ *
+ * Support for the Embedian MXM-8x10 Computer on Module
+ *
+ * Copyright (C) 2006 Marvell International Ltd.
+ * Copyright (C) 2009 Embedian Inc.
+ * Copyright (C) 2009 TMT Services & Supplies (Pty) Ltd.
+ *
+ * 2007-09-04: eric miao <eric.y.miao@gmail.com>
+ *             rewrite to align with latest kernel
+ *
+ * 2010-01-09: Edwin Peer <epeer@tmtservices.co.za>
+ * 	       Hennie van der Merwe <hvdmerwe@tmtservices.co.za>
+ *             rework for upstream merge
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/serial_8250.h>
+#include <linux/dm9000.h>
+
+#include <plat/i2c.h>
+#include <plat/pxa3xx_nand.h>
+
+#include <mach/gpio.h>
+#include <mach/pxafb.h>
+#include <mach/mmc.h>
+#include <mach/mfp-pxa320.h>
+#include <mach/ohci.h>
+#include <mach/pxa3xx-regs.h>
+
+#include <mach/mxm8x10.h>
+
+#include "devices.h"
+#include "generic.h"
+
+/* GPIO pin definition
+
+External device stuff   - Leave unconfigured for now...
+---------------------
+GPIO0   -   DREQ    (External DMA Request)
+GPIO3   -   nGCS2   (External Chip Select) Where is nGCS0; nGCS1; nGCS4; nGCS5 ?
+GPIO4   -   nGCS3
+GPIO15  -   EXT_GPIO1
+GPIO16  -   EXT_GPIO2
+GPIO17  -   EXT_GPIO3
+GPIO24  -   EXT_GPIO4
+GPIO25  -   EXT_GPIO5
+GPIO26  -   EXT_GPIO6
+GPIO27  -   EXT_GPIO7
+GPIO28  -   EXT_GPIO8
+GPIO29  -   EXT_GPIO9
+GPIO30  -   EXT_GPIO10
+GPIO31  -   EXT_GPIO11
+GPIO57  -   EXT_GPIO12
+GPIO74  -   EXT_IRQ1
+GPIO75  -   EXT_IRQ2
+GPIO76  -   EXT_IRQ3
+GPIO77  -   EXT_IRQ4
+GPIO78  -   EXT_IRQ5
+GPIO79  -   EXT_IRQ6
+GPIO80  -   EXT_IRQ7
+GPIO81  -   EXT_IRQ8
+GPIO87  -   VCCIO_PWREN (External Device PWREN)
+
+Dallas 1-Wire   - Leave unconfigured for now...
+-------------
+GPIO0_2 -   DS - 1Wire
+
+Ethernet
+--------
+GPIO1   -   DM9000 PWR
+GPIO9   -   DM9K_nIRQ
+GPIO36  -   DM9K_RESET
+
+Keypad  - Leave unconfigured by for now...
+------
+GPIO1_2 -   KP_DKIN0
+GPIO5_2 -   KP_MKOUT7
+GPIO82  -   KP_DKIN1
+GPIO85  -   KP_DKIN2
+GPIO86  -   KP_DKIN3
+GPIO113 -   KP_MKIN0
+GPIO114 -   KP_MKIN1
+GPIO115 -   KP_MKIN2
+GPIO116 -   KP_MKIN3
+GPIO117 -   KP_MKIN4
+GPIO118 -   KP_MKIN5
+GPIO119 -   KP_MKIN6
+GPIO120 -   KP_MKIN7
+GPIO121 -   KP_MKOUT0
+GPIO122 -   KP_MKOUT1
+GPIO122 -   KP_MKOUT2
+GPIO123 -   KP_MKOUT3
+GPIO124 -   KP_MKOUT4
+GPIO125 -   KP_MKOUT5
+GPIO127 -   KP_MKOUT6
+
+Data Bus    - Leave unconfigured for now...
+--------
+GPIO2   -   nWait (Data Bus)
+
+USB Device
+----------
+GPIO4_2 -   USBD_PULLUP
+GPIO10  -   UTM_CLK (USB Device UTM Clk)
+GPIO49  -   USB 2.0 Device UTM_DATA0
+GPIO50  -   USB 2.0 Device UTM_DATA1
+GPIO51  -   USB 2.0 Device UTM_DATA2
+GPIO52  -   USB 2.0 Device UTM_DATA3
+GPIO53  -   USB 2.0 Device UTM_DATA4
+GPIO54  -   USB 2.0 Device UTM_DATA5
+GPIO55  -   USB 2.0 Device UTM_DATA6
+GPIO56  -   USB 2.0 Device UTM_DATA7
+GPIO58  -   UTM_RXVALID (USB 2.0 Device)
+GPIO59  -   UTM_RXACTIVE (USB 2.0 Device)
+GPIO60  -   UTM_RXERROR
+GPIO61  -   UTM_OPMODE0
+GPIO62  -   UTM_OPMODE1
+GPIO71  -   USBD_INT    (USB Device?)
+GPIO73  -   UTM_TXREADY (USB 2.0 Device)
+GPIO83  -   UTM_TXVALID (USB 2.0 Device)
+GPIO98  -   UTM_RESET   (USB 2.0 device)
+GPIO99  -   UTM_XCVR_SELECT
+GPIO100 -   UTM_TERM_SELECT
+GPIO101 -   UTM_SUSPENDM_X
+GPIO102 -   UTM_LINESTATE0
+GPIO103 -   UTM_LINESTATE1
+
+Card-Bus Interface  - Leave unconfigured for now...
+------------------
+GPIO5   -   nPIOR (I/O space output enable)
+GPIO6   -   nPIOW (I/O space write enable)
+GPIO7   -   nIOS16 (Input from I/O space telling size of data bus)
+GPIO8   -   nPWAIT (Input for inserting wait states)
+
+LCD
+---
+GPIO6_2     -   LDD0
+GPIO7_2     -   LDD1
+GPIO8_2     -   LDD2
+GPIO9_2     -   LDD3
+GPIO11_2    -   LDD5
+GPIO12_2    -   LDD6
+GPIO13_2    -   LDD7
+GPIO14_2    -   VSYNC
+GPIO15_2    -   HSYNC
+GPIO16_2    -   VCLK
+GPIO17_2    -   HCLK
+GPIO18_2    -   VDEN
+GPIO63      -   LDD8    (CPU LCD)
+GPIO64      -   LDD9    (CPU LCD)
+GPIO65      -   LDD10   (CPU LCD)
+GPIO66      -   LDD11   (CPU LCD)
+GPIO67      -   LDD12   (CPU LCD)
+GPIO68      -   LDD13   (CPU LCD)
+GPIO69      -   LDD14   (CPU LCD)
+GPIO70      -   LDD15   (CPU LCD)
+GPIO88      -   VCCLCD_PWREN (LCD Panel PWREN)
+GPIO97      -   BACKLIGHT_EN
+GPIO104     -   LCD_PWREN
+
+PWM   - Leave unconfigured for now...
+---
+GPIO11  -   PWM0
+GPIO12  -   PWM1
+GPIO13  -   PWM2
+GPIO14  -   PWM3
+
+SD-CARD
+-------
+GPIO18  -   SDDATA0
+GPIO19  -   SDDATA1
+GPIO20  -   SDDATA2
+GPIO21  -   SDDATA3
+GPIO22  -   SDCLK
+GPIO23  -   SDCMD
+GPIO72  -   SD_WP
+GPIO84  -   SD_nIRQ_CD  (SD-Card)
+
+I2C
+---
+GPIO32  -   I2CSCL
+GPIO33  -   I2CSDA
+
+AC97
+----
+GPIO35  -   AC97_SDATA_IN
+GPIO37  -   AC97_SDATA_OUT
+GPIO38  -   AC97_SYNC
+GPIO39  -   AC97_BITCLK
+GPIO40  -   AC97_nRESET
+
+UART1
+-----
+GPIO41  -   UART_RXD1
+GPIO42  -   UART_TXD1
+GPIO43  -   UART_CTS1
+GPIO44  -   UART_DCD1
+GPIO45  -   UART_DSR1
+GPIO46  -   UART_nRI1
+GPIO47  -   UART_DTR1
+GPIO48  -   UART_RTS1
+
+UART2
+-----
+GPIO109 -   RTS2
+GPIO110 -   RXD2
+GPIO111 -   TXD2
+GPIO112 -   nCTS2
+
+UART3
+-----
+GPIO105 -   nCTS3
+GPIO106 -   nRTS3
+GPIO107 -   TXD3
+GPIO108 -   RXD3
+
+SSP3    - Leave unconfigured for now...
+----
+GPIO89  -   SSP3_CLK
+GPIO90  -   SSP3_SFRM
+GPIO91  -   SSP3_TXD
+GPIO92  -   SSP3_RXD
+
+SSP4
+GPIO93  -   SSP4_CLK
+GPIO94  -   SSP4_SFRM
+GPIO95  -   SSP4_TXD
+GPIO96  -   SSP4_RXD
+
+Original Definition from Embedian:
+----------------------------------
+#include <mach/mfp-pxa3xx.h>
+
+void xpc8100_mfp_init(void)
+{
+	pxa3xx_mfp_write(MFP_PIN_GPIO0		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO1		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO2		, 0x20c1);
+	pxa3xx_mfp_write(MFP_PIN_GPIO3		, 0x0801);
+	pxa3xx_mfp_write(MFP_PIN_GPIO4		, 0x0801);
+	pxa3xx_mfp_write(MFP_PIN_GPIO5		, 0x00c3);
+	pxa3xx_mfp_write(MFP_PIN_GPIO6		, 0x00c3);
+	pxa3xx_mfp_write(MFP_PIN_GPIO7		, 0x00c3);
+	pxa3xx_mfp_write(MFP_PIN_GPIO8		, 0x00c3);
+	pxa3xx_mfp_write(MFP_PIN_GPIO9		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO10		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO11		, 0x00c1);
+	pxa3xx_mfp_write(MFP_PIN_GPIO12		, 0x00c1);
+	pxa3xx_mfp_write(MFP_PIN_GPIO13		, 0x00c1);
+	pxa3xx_mfp_write(MFP_PIN_GPIO14		, 0x00c1);
+	pxa3xx_mfp_write(MFP_PIN_GPIO15		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO16		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO17		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO18		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO19		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO20		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO21		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO22		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO23		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO24		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO25		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO26		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO27		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO28		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO29		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO30		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO31		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO32		, 0x4981);
+	pxa3xx_mfp_write(MFP_PIN_GPIO33		, 0x4981);
+	pxa3xx_mfp_write(MFP_PIN_GPIO34		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO35		, 0x0801);
+	pxa3xx_mfp_write(MFP_PIN_GPIO36		, 0xc0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO37		, 0x0801);
+	pxa3xx_mfp_write(MFP_PIN_GPIO38		, 0x0801);
+	pxa3xx_mfp_write(MFP_PIN_GPIO39		, 0x0801);
+	pxa3xx_mfp_write(MFP_PIN_GPIO40		, 0x0801);
+	pxa3xx_mfp_write(MFP_PIN_GPIO41		, 0x08a2);
+	pxa3xx_mfp_write(MFP_PIN_GPIO42		, 0x0882);
+	pxa3xx_mfp_write(MFP_PIN_GPIO43		, 0x0882);
+	pxa3xx_mfp_write(MFP_PIN_GPIO44		, 0x0882);
+	pxa3xx_mfp_write(MFP_PIN_GPIO45		, 0x08a2);
+	pxa3xx_mfp_write(MFP_PIN_GPIO46		, 0x0882);
+	pxa3xx_mfp_write(MFP_PIN_GPIO47		, 0x0882);
+	pxa3xx_mfp_write(MFP_PIN_GPIO48		, 0x0882);
+	pxa3xx_mfp_write(MFP_PIN_GPIO49		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO50		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO51		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO52		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO53		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO54		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO55		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO56		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO57		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO58		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO59		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO60		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO61		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO62		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO63		, 0x1c01);
+	pxa3xx_mfp_write(MFP_PIN_GPIO64		, 0x1c01);
+	pxa3xx_mfp_write(MFP_PIN_GPIO65		, 0x1c01);
+	pxa3xx_mfp_write(MFP_PIN_GPIO66		, 0x1c01);
+	pxa3xx_mfp_write(MFP_PIN_GPIO67		, 0x1c01);
+	pxa3xx_mfp_write(MFP_PIN_GPIO68		, 0x1c01);
+	pxa3xx_mfp_write(MFP_PIN_GPIO69		, 0x1c01);
+	pxa3xx_mfp_write(MFP_PIN_GPIO70		, 0x1c01);
+	pxa3xx_mfp_write(MFP_PIN_GPIO71		, 0x1c01);
+	pxa3xx_mfp_write(MFP_PIN_GPIO72		, 0x1c01);
+	pxa3xx_mfp_write(MFP_PIN_GPIO73		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO74		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO75		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO76		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO77		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO78		, 0xa090);
+	pxa3xx_mfp_write(MFP_PIN_GPIO79		, 0xa090);
+	pxa3xx_mfp_write(MFP_PIN_GPIO80		, 0xa090);
+	pxa3xx_mfp_write(MFP_PIN_GPIO81		, 0xa090);
+	pxa3xx_mfp_write(MFP_PIN_GPIO82		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO83		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO84		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO85		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO86		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO87		, 0xc0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO88		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO89		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO90		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO91		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO92		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO93		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO94		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO95		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO96		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO97		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO98		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO99		, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO100	, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO101	, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO102	, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO103	, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO104	, 0xc0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO105	, 0x0801);
+	pxa3xx_mfp_write(MFP_PIN_GPIO106	, 0x0801);
+	pxa3xx_mfp_write(MFP_PIN_GPIO107	, 0x0801);
+	pxa3xx_mfp_write(MFP_PIN_GPIO108	, 0x0801);
+	pxa3xx_mfp_write(MFP_PIN_GPIO109	, 0x0801);
+	pxa3xx_mfp_write(MFP_PIN_GPIO110	, 0x0801);
+	pxa3xx_mfp_write(MFP_PIN_GPIO111	, 0x0801);
+	pxa3xx_mfp_write(MFP_PIN_GPIO112	, 0x0801);
+	pxa3xx_mfp_write(MFP_PIN_GPIO113	, 0x08b1);
+	pxa3xx_mfp_write(MFP_PIN_GPIO114	, 0x08b1);
+	pxa3xx_mfp_write(MFP_PIN_GPIO115	, 0x08b1);
+	pxa3xx_mfp_write(MFP_PIN_GPIO116	, 0x08b1);
+	pxa3xx_mfp_write(MFP_PIN_GPIO117	, 0x08b1);
+	pxa3xx_mfp_write(MFP_PIN_GPIO118	, 0x08b1);
+	pxa3xx_mfp_write(MFP_PIN_GPIO119	, 0x08b1);
+	pxa3xx_mfp_write(MFP_PIN_GPIO120	, 0x08b1);
+	pxa3xx_mfp_write(MFP_PIN_GPIO121	, 0x4901);
+	pxa3xx_mfp_write(MFP_PIN_GPIO122	, 0x4901);
+	pxa3xx_mfp_write(MFP_PIN_GPIO123	, 0x4901);
+	pxa3xx_mfp_write(MFP_PIN_GPIO124	, 0x4901);
+	pxa3xx_mfp_write(MFP_PIN_GPIO125	, 0x4901);
+	pxa3xx_mfp_write(MFP_PIN_GPIO126	, 0x4901);
+	pxa3xx_mfp_write(MFP_PIN_GPIO127	, 0x4901);
+	pxa3xx_mfp_write(MFP_PIN_GPIO0_2	, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO1_2	, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO2_2	, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO3_2	, 0xa0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO4_2	, 0xc0c0);
+	pxa3xx_mfp_write(MFP_PIN_GPIO5_2	, 0x4901);
+	pxa3xx_mfp_write(MFP_PIN_GPIO6_2	, 0x1c01);
+	pxa3xx_mfp_write(MFP_PIN_GPIO7_2	, 0x1c01);
+	pxa3xx_mfp_write(MFP_PIN_GPIO8_2	, 0x1c01);
+	pxa3xx_mfp_write(MFP_PIN_GPIO9_2	, 0x1c01);
+	pxa3xx_mfp_write(MFP_PIN_GPIO10_2	, 0x1c01);
+	pxa3xx_mfp_write(MFP_PIN_GPIO11_2	, 0x1c01);
+	pxa3xx_mfp_write(MFP_PIN_GPIO12_2	, 0x1c01);
+	pxa3xx_mfp_write(MFP_PIN_GPIO13_2	, 0x1c01);
+	pxa3xx_mfp_write(MFP_PIN_GPIO14_2	, 0x1c01);
+	pxa3xx_mfp_write(MFP_PIN_GPIO15_2	, 0x1c01);
+	pxa3xx_mfp_write(MFP_PIN_GPIO16_2	, 0x1c01);
+	pxa3xx_mfp_write(MFP_PIN_GPIO17_2	, 0x1c01);
+}
+*/
+
+/* MMC/MCI Support */
+#define MAX_MMC_SLOTS	3
+
+#if defined(CONFIG_MMC)
+struct platform_mmc_slot mxm_8x10_mmc_slot[MAX_MMC_SLOTS];
+
+static int mxm_8x10_mci_ro(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+
+	return gpio_get_value(mxm_8x10_mmc_slot[pdev->id].gpio_wp);
+}
+
+static int mxm_8x10_mci_init(struct device *dev,
+			     irq_handler_t mxm_8x10_detect_int, void *data)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	int err, cd_irq, gpio_cd, gpio_wp;
+
+	cd_irq = gpio_to_irq(mxm_8x10_mmc_slot[pdev->id].gpio_cd);
+	gpio_cd = mxm_8x10_mmc_slot[pdev->id].gpio_cd;
+	gpio_wp = mxm_8x10_mmc_slot[pdev->id].gpio_wp;
+
+	/*
+	 * setup GPIO for Zylonite MMC controller
+	 */
+	err = gpio_request(gpio_cd, "mmc card detect");
+	if (err)
+		goto err_request_cd;
+	gpio_direction_input(gpio_cd);
+
+	err = gpio_request(gpio_wp, "mmc write protect");
+	if (err)
+		goto err_request_wp;
+	gpio_direction_input(gpio_wp);
+
+	err = request_irq(cd_irq, mxm_8x10_detect_int,
+			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+			  "MMC card detect", data);
+	if (err) {
+		printk(KERN_ERR "%s: MMC/SD/SDIO: "
+		       "can't request card detect IRQ\n", __func__);
+		goto err_request_irq;
+	}
+
+	return 0;
+
+err_request_irq:
+	gpio_free(gpio_wp);
+err_request_wp:
+	gpio_free(gpio_cd);
+err_request_cd:
+	return err;
+}
+
+static void mxm_8x10_mci_exit(struct device *dev, void *data)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	int cd_irq, gpio_cd, gpio_wp;
+
+	cd_irq = gpio_to_irq(xpc8100_mmc_slot[pdev->id].gpio_cd);
+	gpio_cd = mxm_8x10_mmc_slot[pdev->id].gpio_cd;
+	gpio_wp = mxm_8x10_mmc_slot[pdev->id].gpio_wp;
+
+	free_irq(cd_irq, data);
+	gpio_free(gpio_cd);
+	gpio_free(gpio_wp);
+}
+
+static struct pxamci_platform_data mxm_8x10_mci_platform_data = {
+	.detect_delay = 20,
+	.ocr_mask = MMC_VDD_32_33 | MMC_VDD_33_34,
+	.init = mxm_8x10_mci_init,
+	.exit = mxm_8x10_mci_exit,
+	.get_ro = mxm_8x10_mci_ro,
+};
+
+static struct pxamci_platform_data mxm_8x10_mci2_platform_data = {
+	.detect_delay = 20,
+	.ocr_mask = MMC_VDD_32_33 | MMC_VDD_33_34,
+};
+
+void __init mxm_8x10_mmc_init(void)
+{
+	/* Seems a bit insane - GPIO1 and GPIO5 has nothing to do with MMC
+	 * according to the docs, but they are used here as Card Detect and
+	 * Write Protect. What is going on on pins 72 and 83?
+	 * Note: Embedian docs say that SD-Card does not work under linux.
+	 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO1, 0xa0c0);	/* Card Detect */
+	pxa3xx_mfp_write(MFP_PIN_GPIO5, 0x00c3);	/* Write Protect */
+	pxa3xx_mfp_write(MFP_PIN_GPIO18, 0xa0c0);	/* SD_DATA0 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO19, 0xa0c0);	/* SD_DATA1 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO20, 0xa0c0);	/* SD_DATA2 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO21, 0xa0c0);	/* SD_DATA3 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO22, 0xa0c0);	/* SD_CLK */
+	pxa3xx_mfp_write(MFP_PIN_GPIO23, 0xa0c0);	/* SD_CMD */
+	pxa3xx_mfp_write(MFP_PIN_GPIO72, 0x1c01);	/* SD_WP */
+	pxa3xx_mfp_write(MFP_PIN_GPIO83, 0xa0c0);	/* SD_CD_nIRQ */
+
+	/* MMC card detect & write protect for controller 0 */
+	mxm_8x10_mmc_slot[0].gpio_cd = mfp_to_gpio(MFP_PIN_GPIO1);
+	mxm_8x10_mmc_slot[0].gpio_wp = mfp_to_gpio(MFP_PIN_GPIO5);
+
+	pxa_set_mci_info(&mxm_8x10_mci_platform_data);
+	pxa3xx_set_mci2_info(&mxm_8x10_mci2_platform_data);
+	if (cpu_is_pxa310())
+		pxa3xx_set_mci3_info(&mxm_8x10_mci_platform_data);
+}
+#else
+inline void mxm_8x10_mmc_init(void)
+{
+}
+#endif
+
+/* USB Open Host Controler Interface */
+static int mxm_8x10_ohci_init(struct device *dev)
+{
+	/* Set the Power Control Polarity Low and Power Sense
+	   Polarity Low to active low. */
+	UHCHR = (UHCHR) &
+	    ~(UHCHR_SSEP1 | UHCHR_SSEP2 | UHCHR_SSEP3 | UHCHR_SSE);
+	return 0;
+}
+
+static void mxm_8x10_ohci_exit(struct device *dev)
+{
+	return;
+}
+
+static struct pxaohci_platform_data mxm_8x10_ohci_platform_data = {
+	.port_mode = PMM_NPS_MODE,
+	.init = mxm_8x10_ohci_init,
+	.exit = mxm_8x10_ohci_exit,
+};
+
+void __init mxm_8x10_usb_host_init(void)
+{
+	pxa3xx_mfp_write(MFP_PIN_GPIO10, 0xa0c0);	/* UTM_CLK */
+	pxa3xx_mfp_write(MFP_PIN_GPIO49, 0xa0c0);	/* UTM_DATA0 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO50, 0xa0c0);	/* UTM_DATA1 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO51, 0xa0c0);	/* UTM_DATA2 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO52, 0xa0c0);	/* UTM_DATA3 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO53, 0xa0c0);	/* UTM_DATA4 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO54, 0xa0c0);	/* UTM_DATA5 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO55, 0xa0c0);	/* UTM_DATA6 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO56, 0xa0c0);	/* UTM_DATA7 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO58, 0xa0c0);	/* UTM_RXVALID */
+	pxa3xx_mfp_write(MFP_PIN_GPIO59, 0xa0c0);	/* UTM_RXACTIVE */
+	pxa3xx_mfp_write(MFP_PIN_GPIO60, 0xa0c0);	/* UTM_RXERROR */
+	pxa3xx_mfp_write(MFP_PIN_GPIO61, 0xa0c0);	/* UTM_OPMODE0 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO62, 0xa0c0);	/* UTM_OPMODE1 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO71, 0x1c01);	/* USBD_INT */
+	pxa3xx_mfp_write(MFP_PIN_GPIO73, 0xa0c0);	/* UTM_TXREADY */
+	pxa3xx_mfp_write(MFP_PIN_GPIO83, 0xa0c0);	/* UTM_TXVALID */
+	pxa3xx_mfp_write(MFP_PIN_GPIO98, 0xa0c0);	/* UTM_RESET */
+	pxa3xx_mfp_write(MFP_PIN_GPIO99, 0xa0c0);	/* UTM_XCVR_SELECT */
+	pxa3xx_mfp_write(MFP_PIN_GPIO100, 0xa0c0);	/* UTM_TERM_SELECT */
+	pxa3xx_mfp_write(MFP_PIN_GPIO101, 0xa0c0);	/* UTM_SUSPENDM_X */
+	pxa3xx_mfp_write(MFP_PIN_GPIO102, 0xa0c0);	/* UTM_LINESTATE0 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO103, 0xa0c0);	/* UTM_LINESTATE1 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO4_2, 0xc0c0);	/* UTM_PULLUP */
+
+	pxa_set_ohci_info(&mxm_8x10_ohci_platform_data);
+}
+
+/* AC97 Sound Support */
+static struct platform_device mxm_8x10_ac97_device = {
+	.name = "pxa2xx-ac97",
+};
+
+void __init mxm_8x10_ac97_init(void)
+{
+	pxa3xx_mfp_write(MFP_PIN_GPIO35, 0x0801);	/* AC97_SDATA_IN */
+	pxa3xx_mfp_write(MFP_PIN_GPIO37, 0x0801);	/* AC97_SDATA_OUT */
+	pxa3xx_mfp_write(MFP_PIN_GPIO38, 0x0801);	/* AC97_SYNC */
+	pxa3xx_mfp_write(MFP_PIN_GPIO39, 0x0801);	/* AC97_BITCLK */
+	pxa3xx_mfp_write(MFP_PIN_GPIO40, 0x0801);	/* AC97_nRESET */
+
+	platform_device_register(&mxm_8x10_ac97_device);
+}
+
+/* NAND flash Support */
+#if defined(CONFIG_MTD_NAND_PXA3xx) || defined(CONFIG_MTD_NAND_PXA3xx_MODULE)
+#define NAND_BLOCK_SIZE SZ_128K
+#define NB(x)           (NAND_BLOCK_SIZE * (x))
+struct mtd_partition mxm_8x10_nand_partitions[] = {
+	[0] = {
+	       .name = "boot",
+	       .size = NB(0x002),
+	       .offset = NB(0x000),
+	       .mask_flags = MTD_WRITEABLE,
+	       },
+	[1] = {
+	       .name = "kernel",
+	       .size = NB(0x010),
+	       .offset = NB(0x002),
+	       .mask_flags = MTD_WRITEABLE,
+	       },
+	[2] = {
+	       .name = "root",
+	       .size = NB(0x100),
+	       .offset = NB(0x012),
+	       },
+	[3] = {
+	       .name = "bbt",
+	       .size = NB(0x2EE),
+	       .offset = NB(0x112),
+	       .mask_flags = MTD_WRITEABLE,
+	       },
+};
+
+static struct pxa3xx_nand_platform_data mxm_8x10_nand_info = {
+	.enable_arbiter = 1,
+	.keep_config = 1,
+	.parts = mxm_8x10_nand_partitions,
+	.nr_parts = ARRAY_SIZE(mxm_8x10_nand_partitions),
+};
+
+void __init mxm_8x10_nand_init(void)
+{
+	pxa3xx_set_nand_info(&mxm_8x10_nand_info);
+}
+#else
+inline mxm_8x10_nand_init(void)
+{
+}
+#endif /* CONFIG_MTD_NAND_PXA3xx || CONFIG_MTD_NAND_PXA3xx_MODULE */
+
+/* Ethernet support: Davicom DM9000 */
+int gpio_eth_irq;
+
+static struct resource dm9k_resources[] = {
+	[0] = {
+	       .start = MXM_8X10_ETH_PHYS + 0x300,
+	       .end = MXM_8X10_ETH_PHYS + 0x300,
+	       .flags = IORESOURCE_MEM,
+	       },
+	[1] = {
+	       .start = MXM_8X10_ETH_PHYS + 0x308,
+	       .end = MXM_8X10_ETH_PHYS + 0x308,
+	       .flags = IORESOURCE_MEM,
+	       },
+	[2] = {
+	       .start = -1,	/* for run-time assignment */
+	       .end = -1,
+	       .flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
+	       }
+};
+
+static struct dm9000_plat_data dm9k_plat_data = {
+	.flags = DM9000_PLATF_16BITONLY,
+};
+
+static struct platform_device dm9k_device = {
+	.name = "dm9000",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(dm9k_resources),
+	.resource = dm9k_resources,
+	.dev = {
+		.platform_data = &dm9k_plat_data,
+		}
+};
+
+void __init mxm_8x10_ethernet_init(void)
+{
+	pxa3xx_mfp_write(MFP_PIN_GPIO1, 0xa0c0);	/* DM9000_PWR ? */
+	pxa3xx_mfp_write(MFP_PIN_GPIO9, 0xa0c0);	/* DM9000_nIRQ */
+	pxa3xx_mfp_write(MFP_PIN_GPIO36, 0xc0c0);	/* DM9000_RESET */
+
+	gpio_eth_irq = mfp_to_gpio(MFP_PIN_GPIO9);
+
+	dm9k_resources[2].start = gpio_to_irq(gpio_eth_irq);
+	dm9k_resources[2].end = gpio_to_irq(gpio_eth_irq);
+	platform_device_register(&dm9k_device);
+}
+
+/* PXA UARTs */
+static void __init mxm_8x10_uarts_init(void)
+{
+	pxa3xx_mfp_write(MFP_PIN_GPIO41, 0x08a2);	/* UART_RXD1 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO42, 0x0882);	/* UART_TXD1 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO43, 0x0882);	/* UART_CTS1 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO44, 0x0882);	/* UART_DCD1 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO45, 0x08a2);	/* UART_DSR1 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO46, 0x0882);	/* UART_nRI1 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO47, 0x0882);	/* UART_DTR1 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO48, 0x0882);	/* UART_RTS1 */
+
+	pxa3xx_mfp_write(MFP_PIN_GPIO109, 0x0801);	/* UART_RTS2 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO110, 0x0801);	/* UART_RXD2 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO111, 0x0801);	/* UART_TXD2 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO112, 0x0801);	/* UART_nCTS2 */
+
+	pxa3xx_mfp_write(MFP_PIN_GPIO105, 0x0801);	/* UART_nCTS3 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO106, 0x0801);	/* UART_nRTS3 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO107, 0x0801);	/* UART_TXD3 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO108, 0x0801);	/* UART_RXD3 */
+
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+}
+
+/* Backlight, LCD and Frame-Buffer */
+#if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
+int gpio_backlight;
+
+int lcd_id;
+int lcd_orientation;
+
+#define NUM_LCD_DETECT_PINS	7
+
+static int lcd_detect_pins[] __initdata = {
+	MFP_PIN_GPIO72,		/* LCD_LDD_17 - ORIENT */
+	MFP_PIN_GPIO71,		/* LCD_LDD_16 - LCDID[5] */
+	MFP_PIN_GPIO17_2,	/* LCD_BIAS   - LCDID[4] */
+	MFP_PIN_GPIO15_2,	/* LCD_LCLK   - LCDID[3] */
+	MFP_PIN_GPIO14_2,	/* LCD_FCLK   - LCDID[2] */
+	MFP_PIN_GPIO73,		/* LCD_CS_N   - LCDID[1] */
+	MFP_PIN_GPIO74,		/* LCD_VSYNC  - LCDID[0] */
+	/*
+	 * set the MFP_PIN_GPIO 14/15/17 to alternate function other than
+	 * GPIO to avoid input level confliction with 14_2, 15_2, 17_2
+	 */
+	MFP_PIN_GPIO14,
+	MFP_PIN_GPIO15,
+	MFP_PIN_GPIO17,
+};
+
+static int lcd_detect_mfpr[] __initdata = {
+	/* AF0, DS 1X, Pull Neither, Edge Clear */
+	0x8440, 0x8440, 0x8440, 0x8440, 0x8440, 0x8440, 0x8440,
+	0xc442,			/* Backlight, Pull-Up, AF2 */
+	0x8445,			/* AF5 */
+	0x8445,			/* AF5 */
+};
+
+static void __init mxm_8x10_detect_lcd_panel(void)
+{
+	unsigned long mfpr_save[ARRAY_SIZE(lcd_detect_pins)];
+	int i, gpio, id = 0;
+
+	/* save the original MFP settings of these pins and configure them
+	 * as GPIO Input, DS01X, Pull Neither, Edge Clear
+	 */
+	for (i = 0; i < ARRAY_SIZE(lcd_detect_pins); i++) {
+		mfpr_save[i] = pxa3xx_mfp_read(lcd_detect_pins[i]);
+		pxa3xx_mfp_write(lcd_detect_pins[i], lcd_detect_mfpr[i]);
+	}
+
+	for (i = 0; i < NUM_LCD_DETECT_PINS; i++) {
+		id = id << 1;
+		gpio = mfp_to_gpio(lcd_detect_pins[i]);
+		gpio_request(gpio, "LCD_ID_PINS");
+		gpio_direction_input(gpio);
+
+		if (gpio_get_value(gpio))
+			id = id | 0x1;
+		gpio_free(gpio);
+	}
+
+	/* lcd id, flush out bit 1 */
+	lcd_id = id & 0x3d;
+
+	/* lcd orientation, portrait or landscape */
+	lcd_orientation = (id >> 6) & 0x1;
+
+	printk(KERN_INFO "%s: lcd_id = %d, orientation = %d \n", __func__,
+	       lcd_id, lcd_orientation);
+
+	/* restore the original MFP settings */
+	for (i = 0; i < ARRAY_SIZE(lcd_detect_pins); i++)
+		pxa3xx_mfp_write(lcd_detect_pins[i], mfpr_save[i]);
+}
+
+static void mxm_8x10_backlight_power(int on)
+{
+	gpio_set_value(gpio_backlight, on);
+}
+
+static struct pxafb_mode_info toshiba_ltm04c380k_mode = {
+	.pixclock = 30000,
+	.xres = 640,
+	.yres = 480,
+	.bpp = 16,
+	.hsync_len = 40,
+	.left_margin = 128,
+	.right_margin = 24,
+	.vsync_len = 3,
+	.upper_margin = 28,
+	.lower_margin = 9,
+	.sync = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+};
+
+static struct pxafb_mach_info mxm_8x10_toshiba_lcd_info = {
+	.num_modes = 1,
+	.lccr0 = LCCR0_Act,
+	.lccr3 = LCCR3_PCP,
+	.pxafb_backlight_power = mxm_8x10_backlight_power,
+};
+
+void __init mxm_8x10_lcd_init(void)
+{
+	pxa3xx_mfp_write(MFP_PIN_GPIO6_2, 0x1c01);	/* LDD0 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO7_2, 0x1c01);	/* LDD1 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO8_2, 0x1c01);	/* LDD2 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO9_2, 0x1c01);	/* LDD3 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO10_2, 0x1c01);	/* LDD4 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO11_2, 0x1c01);	/* LDD5 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO12_2, 0x1c01);	/* LDD6 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO13_2, 0x1c01);	/* LDD7 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO63, 0x1c01);	/* LDD8 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO64, 0x1c01);	/* LDD9 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO65, 0x1c01);	/* LDD10 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO66, 0x1c01);	/* LDD11 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO67, 0x1c01);	/* LDD12 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO68, 0x1c01);	/* LDD13 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO69, 0x1c01);	/* LDD14 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO70, 0x1c01);	/* LDD15 */
+	pxa3xx_mfp_write(MFP_PIN_GPIO14_2, 0x1c01);	/* VSYNC */
+	pxa3xx_mfp_write(MFP_PIN_GPIO15_2, 0x1c01);	/* HSYNC */
+	pxa3xx_mfp_write(MFP_PIN_GPIO16_2, 0x1c01);	/* VCLK */
+	pxa3xx_mfp_write(MFP_PIN_GPIO17_2, 0x1c01);	/* HCLK */
+	pxa3xx_mfp_write(MFP_PIN_GPIO88, 0xa0c0);	/* VCCLCD_PWREN */
+	pxa3xx_mfp_write(MFP_PIN_GPIO104, 0xc0c0);	/* LCD_PWREN */
+	pxa3xx_mfp_write(MFP_PIN_GPIO97, 0xa0c0);	/* BACKLIGHT_EN */
+
+	gpio_backlight = mfp_to_gpio(MFP_PIN_GPIO14);
+
+	mxm_8x10_detect_lcd_panel();
+
+	/* backlight GPIO: output, default on */
+	gpio_direction_output(gpio_backlight, 1);
+
+	mxm_8x10_toshiba_lcd_info.modes = &toshiba_ltm04c380k_mode;
+	set_pxa_fb_info(&mxm_8x10_toshiba_lcd_info);
+}
+#else
+inline void mxm_8x10_lcd_init(void)
+{
+}
+#endif
+
+/* I2C and Real Time Clock */
+static struct i2c_board_info __initdata mxm_8x10_i2c_devices[] = {
+	{
+	 I2C_BOARD_INFO("ds1337", 0x68),
+	 },
+};
+
+void __init mxm_8x10_i2c_init(void)
+{
+	pxa3xx_mfp_write(MFP_PIN_GPIO32, 0x4981);	/* I2CSCL */
+	pxa3xx_mfp_write(MFP_PIN_GPIO33, 0x4981);	/* I2CSDA */
+
+	i2c_register_board_info(0, mxm_8x10_i2c_devices,
+				ARRAY_SIZE(mxm_8x10_i2c_devices));
+	pxa_set_i2c_info(NULL);
+}
+
+void __init mxm_8x10_barebones_init(void)
+{
+	mxm_8x10_uarts_init();
+	mxm_8x10_nand_init();
+	mxm_8x10_i2c_init();
+	mxm_8x10_ethernet_init();
+}
