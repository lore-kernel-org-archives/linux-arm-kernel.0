From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Sun, 25 Oct 2009 00:37:41 +0400
Subject: [PATCH 20/20] SA1100: h3600: update defconfig
In-Reply-To: <1256416661-23039-1-git-send-email-mad_soft@inbox.ru>
References: <1256416257-23003-2-git-send-email-mad_soft@inbox.ru>
	<1256416661-23039-1-git-send-email-mad_soft@inbox.ru>
Message-ID: <1256416661-23039-2-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update defconfig to current kernel, enable support for iPAQ H3100
and following drivers: gpio-keys, htc-egpio, ide_cs.

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 arch/arm/configs/h3600_defconfig |  976 ++++++++++++++++++++++++--------------
 1 files changed, 612 insertions(+), 364 deletions(-)

diff --git a/arch/arm/configs/h3600_defconfig b/arch/arm/configs/h3600_defconfig
index f6aed77..efa78e1 100644
--- a/arch/arm/configs/h3600_defconfig
+++ b/arch/arm/configs/h3600_defconfig
@@ -1,86 +1,189 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.12-rc4
-# Thu Jun  9 01:59:03 2005
+# Linux kernel version: 2.6.32-rc5
+# Sat Oct 24 00:09:30 2009
 #
 CONFIG_ARM=y
-CONFIG_MMU=y
-CONFIG_UID16=y
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
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_ARCH_HAS_CPUFREQ=y
+CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
-CONFIG_GENERIC_IOMAP=y
+CONFIG_ARCH_MTD_XIP=y
+CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
+CONFIG_VECTORS_BASE=0xffff0000
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+CONFIG_CONSTRUCTORS=y
 
 #
-# Code maturity level options
+# General setup
 #
 CONFIG_EXPERIMENTAL=y
-CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
-
-#
-# General setup
-#
 CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
-CONFIG_SYSCTL=y
+# CONFIG_TASKSTATS is not set
 # CONFIG_AUDIT is not set
-CONFIG_HOTPLUG=y
-CONFIG_KOBJECT_UEVENT=y
+
+#
+# RCU Subsystem
+#
+CONFIG_TREE_RCU=y
+# CONFIG_TREE_PREEMPT_RCU is not set
+# CONFIG_RCU_TRACE is not set
+CONFIG_RCU_FANOUT=32
+# CONFIG_RCU_FANOUT_EXACT is not set
+# CONFIG_TREE_RCU_TRACE is not set
 # CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_GROUP_SCHED is not set
+# CONFIG_CGROUPS is not set
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
+# CONFIG_RELAY is not set
+CONFIG_NAMESPACES=y
+# CONFIG_UTS_NS is not set
+# CONFIG_IPC_NS is not set
+# CONFIG_USER_NS is not set
+# CONFIG_PID_NS is not set
+# CONFIG_NET_NS is not set
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
+CONFIG_RD_GZIP=y
+CONFIG_RD_BZIP2=y
+CONFIG_RD_LZMA=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
 # CONFIG_EMBEDDED is not set
+CONFIG_UID16=y
+CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
+CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
-CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
-CONFIG_CC_ALIGN_FUNCTIONS=0
-CONFIG_CC_ALIGN_LABELS=0
-CONFIG_CC_ALIGN_LOOPS=0
-CONFIG_CC_ALIGN_JUMPS=0
-# CONFIG_TINY_SHMEM is not set
-CONFIG_BASE_SMALL=0
+CONFIG_AIO=y
+
+#
+# Kernel Performance Events And Counters
+#
+CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLUB_DEBUG=y
+CONFIG_COMPAT_BRK=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
+# CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+CONFIG_HAVE_OPROFILE=y
+# CONFIG_KPROBES is not set
+CONFIG_HAVE_KPROBES=y
+CONFIG_HAVE_KRETPROBES=y
+CONFIG_HAVE_CLK=y
 
 #
-# Loadable module support
+# GCOV-based kernel profiling
 #
+# CONFIG_SLOW_WORK is not set
+CONFIG_HAVE_GENERIC_DMA_COHERENT=y
+CONFIG_SLABINFO=y
+CONFIG_RT_MUTEXES=y
+CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
 # CONFIG_MODULE_UNLOAD is not set
-CONFIG_OBSOLETE_MODPARM=y
 # CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
-# CONFIG_KMOD is not set
+CONFIG_BLOCK=y
+# CONFIG_LBDAF is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_BLK_DEV_INTEGRITY is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+# CONFIG_IOSCHED_AS is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+# CONFIG_DEFAULT_AS is not set
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+CONFIG_DEFAULT_NOOP=y
+CONFIG_DEFAULT_IOSCHED="noop"
+CONFIG_FREEZER=y
 
 #
 # System Type
 #
-# CONFIG_ARCH_CLPS7500 is not set
+CONFIG_MMU=y
+# CONFIG_ARCH_AAEC2000 is not set
+# CONFIG_ARCH_INTEGRATOR is not set
+# CONFIG_ARCH_REALVIEW is not set
+# CONFIG_ARCH_VERSATILE is not set
+# CONFIG_ARCH_AT91 is not set
 # CONFIG_ARCH_CLPS711X is not set
-# CONFIG_ARCH_CO285 is not set
+# CONFIG_ARCH_GEMINI is not set
 # CONFIG_ARCH_EBSA110 is not set
+# CONFIG_ARCH_EP93XX is not set
 # CONFIG_ARCH_FOOTBRIDGE is not set
-# CONFIG_ARCH_INTEGRATOR is not set
-# CONFIG_ARCH_IOP3XX is not set
-# CONFIG_ARCH_IXP4XX is not set
+# CONFIG_ARCH_MXC is not set
+# CONFIG_ARCH_STMP3XXX is not set
+# CONFIG_ARCH_NETX is not set
+# CONFIG_ARCH_H720X is not set
+# CONFIG_ARCH_NOMADIK is not set
+# CONFIG_ARCH_IOP13XX is not set
+# CONFIG_ARCH_IOP32X is not set
+# CONFIG_ARCH_IOP33X is not set
+# CONFIG_ARCH_IXP23XX is not set
 # CONFIG_ARCH_IXP2000 is not set
+# CONFIG_ARCH_IXP4XX is not set
 # CONFIG_ARCH_L7200 is not set
+# CONFIG_ARCH_KIRKWOOD is not set
+# CONFIG_ARCH_LOKI is not set
+# CONFIG_ARCH_MV78XX0 is not set
+# CONFIG_ARCH_ORION5X is not set
+# CONFIG_ARCH_MMP is not set
+# CONFIG_ARCH_KS8695 is not set
+# CONFIG_ARCH_NS9XXX is not set
+# CONFIG_ARCH_W90X900 is not set
+# CONFIG_ARCH_PNX4008 is not set
 # CONFIG_ARCH_PXA is not set
+# CONFIG_ARCH_MSM is not set
 # CONFIG_ARCH_RPC is not set
 CONFIG_ARCH_SA1100=y
 # CONFIG_ARCH_S3C2410 is not set
+# CONFIG_ARCH_S3C64XX is not set
+# CONFIG_ARCH_S5PC1XX is not set
 # CONFIG_ARCH_SHARK is not set
 # CONFIG_ARCH_LH7A40X is not set
+# CONFIG_ARCH_U300 is not set
+# CONFIG_ARCH_DAVINCI is not set
 # CONFIG_ARCH_OMAP is not set
-# CONFIG_ARCH_VERSATILE is not set
-# CONFIG_ARCH_IMX is not set
-# CONFIG_ARCH_H720X is not set
+# CONFIG_ARCH_BCMRING is not set
 
 #
 # SA11x0 Implementations
@@ -106,27 +209,31 @@ CONFIG_CPU_32=y
 CONFIG_CPU_SA1100=y
 CONFIG_CPU_32v4=y
 CONFIG_CPU_ABRT_EV4=y
+CONFIG_CPU_PABRT_LEGACY=y
 CONFIG_CPU_CACHE_V4WB=y
 CONFIG_CPU_CACHE_VIVT=y
 CONFIG_CPU_TLB_V4WB=y
-CONFIG_CPU_MINICACHE=y
+CONFIG_CPU_CP15=y
+CONFIG_CPU_CP15_MMU=y
 
 #
 # Processor Features
 #
+# CONFIG_CPU_ICACHE_DISABLE is not set
+# CONFIG_CPU_DCACHE_DISABLE is not set
+CONFIG_ARM_L1_CACHE_SHIFT=5
 
 #
 # Bus support
 #
 CONFIG_ISA=y
-CONFIG_ISA_DMA_API=y
-
-#
-# PCCARD (PCMCIA/CardBus) support
-#
+# CONFIG_PCI_SYSCALL is not set
+# CONFIG_ARCH_SUPPORTS_MSI is not set
 CONFIG_PCCARD=y
 # CONFIG_PCMCIA_DEBUG is not set
 CONFIG_PCMCIA=y
+CONFIG_PCMCIA_LOAD_CIS=y
+CONFIG_PCMCIA_IOCTL=y
 
 #
 # PC-card bridges
@@ -138,11 +245,41 @@ CONFIG_PCMCIA_SA1100=y
 #
 # Kernel Features
 #
-# CONFIG_SMP is not set
+CONFIG_TICK_ONESHOT=y
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
+CONFIG_VMSPLIT_3G=y
+# CONFIG_VMSPLIT_2G is not set
+# CONFIG_VMSPLIT_1G is not set
+CONFIG_PAGE_OFFSET=0xC0000000
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
-CONFIG_DISCONTIGMEM=y
+CONFIG_HZ=100
+# CONFIG_AEABI is not set
+CONFIG_ARCH_SPARSEMEM_ENABLE=y
+CONFIG_ARCH_SPARSEMEM_DEFAULT=y
+# CONFIG_ARCH_SELECT_MEMORY_MODEL is not set
+# CONFIG_HIGHMEM is not set
+CONFIG_SELECT_MEMORY_MODEL=y
+# CONFIG_FLATMEM_MANUAL is not set
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+CONFIG_SPARSEMEM_MANUAL=y
+CONFIG_SPARSEMEM=y
+CONFIG_HAVE_MEMORY_PRESENT=y
+CONFIG_SPARSEMEM_EXTREME=y
+CONFIG_SPLIT_PTLOCK_CPUS=4096
+# CONFIG_PHYS_ADDR_T_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=0
+CONFIG_VIRT_TO_BUS=y
+CONFIG_HAVE_MLOCK=y
+CONFIG_HAVE_MLOCKED_PAGE_BIT=y
+# CONFIG_KSM is not set
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
 # CONFIG_LEDS is not set
 CONFIG_ALIGNMENT_TRAP=y
+# CONFIG_UACCESS_WITH_MEMCPY is not set
 
 #
 # Boot options
@@ -151,22 +288,26 @@ CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE=""
 # CONFIG_XIP_KERNEL is not set
+# CONFIG_KEXEC is not set
 
 #
-# CPU Frequency scaling
+# CPU Power Management
 #
 CONFIG_CPU_FREQ=y
-CONFIG_CPU_FREQ_TABLE=y
 # CONFIG_CPU_FREQ_DEBUG is not set
-CONFIG_CPU_FREQ_STAT=y
-# CONFIG_CPU_FREQ_STAT_DETAILS is not set
+# CONFIG_CPU_FREQ_STAT is not set
 # CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
+# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
 CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
+# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
+# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
 # CONFIG_CPU_FREQ_GOV_PERFORMANCE is not set
 # CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
 CONFIG_CPU_FREQ_GOV_USERSPACE=y
 # CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
+# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
 CONFIG_CPU_FREQ_SA1100=y
+# CONFIG_CPU_IDLE is not set
 
 #
 # Floating point emulation
@@ -183,6 +324,8 @@ CONFIG_FPE_NWFPE=y
 # Userspace binary formats
 #
 CONFIG_BINFMT_ELF=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_HAVE_AOUT=y
 # CONFIG_BINFMT_AOUT is not set
 # CONFIG_BINFMT_MISC is not set
 # CONFIG_ARTHUR is not set
@@ -191,8 +334,120 @@ CONFIG_BINFMT_ELF=y
 # Power management options
 #
 CONFIG_PM=y
-# CONFIG_PM_LEGACY is not set
-# CONFIG_APM is not set
+# CONFIG_PM_DEBUG is not set
+CONFIG_PM_SLEEP=y
+CONFIG_SUSPEND=y
+CONFIG_SUSPEND_FREEZER=y
+# CONFIG_APM_EMULATION is not set
+# CONFIG_PM_RUNTIME is not set
+CONFIG_ARCH_SUSPEND_POSSIBLE=y
+CONFIG_NET=y
+
+#
+# Networking options
+#
+# CONFIG_PACKET is not set
+CONFIG_UNIX=y
+CONFIG_XFRM=y
+# CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
+# CONFIG_XFRM_STATISTICS is not set
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+# CONFIG_IP_PNP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_XFRM_MODE_BEET=y
+CONFIG_INET_LRO=y
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
+# CONFIG_IPV6 is not set
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
+# CONFIG_CAN is not set
+CONFIG_IRDA=m
+
+#
+# IrDA protocols
+#
+CONFIG_IRLAN=m
+CONFIG_IRNET=m
+CONFIG_IRCOMM=m
+# CONFIG_IRDA_ULTRA is not set
+
+#
+# IrDA options
+#
+# CONFIG_IRDA_CACHE_LAST_LSAP is not set
+# CONFIG_IRDA_FAST_RR is not set
+# CONFIG_IRDA_DEBUG is not set
+
+#
+# Infrared-port device drivers
+#
+
+#
+# SIR device drivers
+#
+# CONFIG_IRTTY_SIR is not set
+
+#
+# Dongle support
+#
+
+#
+# FIR device drivers
+#
+CONFIG_SA1100_FIR=m
+# CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
+# CONFIG_WIRELESS is not set
+# CONFIG_WIMAX is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 
 #
 # Device Drivers
@@ -201,15 +456,17 @@ CONFIG_PM=y
 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
-# CONFIG_FW_LOADER is not set
-
-#
-# Memory Technology Devices (MTD)
-#
+CONFIG_FW_LOADER=y
+CONFIG_FIRMWARE_IN_KERNEL=y
+CONFIG_EXTRA_FIRMWARE=""
+# CONFIG_SYS_HYPERVISOR is not set
+# CONFIG_CONNECTOR is not set
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_TESTS is not set
 # CONFIG_MTD_CONCAT is not set
 CONFIG_MTD_PARTITIONS=y
 CONFIG_MTD_REDBOOT_PARTS=y
@@ -218,15 +475,20 @@ CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
 # CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
 # CONFIG_MTD_CMDLINE_PARTS is not set
 # CONFIG_MTD_AFS_PARTS is not set
+# CONFIG_MTD_AR7_PARTS is not set
 
 #
 # User Modules And Translation Layers
 #
 CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
 CONFIG_MTD_BLOCK=y
 # CONFIG_FTL is not set
 # CONFIG_NFTL is not set
 # CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
 
 #
 # RAM/ROM/Flash chip drivers
@@ -249,6 +511,7 @@ CONFIG_MTD_MAP_BANK_WIDTH_4=y
 CONFIG_MTD_CFI_I2=y
 # CONFIG_MTD_CFI_I4 is not set
 # CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_OTP is not set
 CONFIG_MTD_CFI_INTELEXT=y
 # CONFIG_MTD_CFI_AMDSTD is not set
 # CONFIG_MTD_CFI_STAA is not set
@@ -265,7 +528,7 @@ CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_PHYSMAP is not set
 # CONFIG_MTD_ARM_INTEGRATOR is not set
 CONFIG_MTD_SA1100=y
-# CONFIG_MTD_EDB7312 is not set
+# CONFIG_MTD_PLATRAM is not set
 
 #
 # Self-contained MTD device drivers
@@ -273,7 +536,6 @@ CONFIG_MTD_SA1100=y
 # CONFIG_MTD_SLRAM is not set
 # CONFIG_MTD_PHRAM is not set
 # CONFIG_MTD_MTDRAM is not set
-# CONFIG_MTD_BLKMTD is not set
 # CONFIG_MTD_BLOCK2MTD is not set
 
 #
@@ -282,26 +544,21 @@ CONFIG_MTD_SA1100=y
 # CONFIG_MTD_DOC2000 is not set
 # CONFIG_MTD_DOC2001 is not set
 # CONFIG_MTD_DOC2001PLUS is not set
-
-#
-# NAND Flash Device Drivers
-#
 # CONFIG_MTD_NAND is not set
+# CONFIG_MTD_ONENAND is not set
 
 #
-# Parallel port support
+# LPDDR flash memory drivers
 #
-# CONFIG_PARPORT is not set
+# CONFIG_MTD_LPDDR is not set
 
 #
-# Plug and Play support
+# UBI - Unsorted block images
 #
+# CONFIG_MTD_UBI is not set
+# CONFIG_PARPORT is not set
 # CONFIG_PNP is not set
-
-#
-# Block devices
-#
-# CONFIG_BLK_DEV_XD is not set
+CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=m
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
@@ -309,212 +566,58 @@ CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=8192
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_BLK_DEV_XIP is not set
 # CONFIG_CDROM_PKTCDVD is not set
-
-#
-# IO Schedulers
-#
-CONFIG_IOSCHED_NOOP=y
-CONFIG_IOSCHED_AS=y
-CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
 # CONFIG_ATA_OVER_ETH is not set
+# CONFIG_MG_DISK is not set
+# CONFIG_MISC_DEVICES is not set
+CONFIG_HAVE_IDE=y
+CONFIG_IDE=y
 
 #
-# ATA/ATAPI/MFM/RLL support
-#
-CONFIG_IDE=m
-CONFIG_BLK_DEV_IDE=m
-
-#
-# Please see Documentation/ide.txt for help/info on IDE drives
+# Please see Documentation/ide/ide.txt for help/info on IDE drives
 #
 # CONFIG_BLK_DEV_IDE_SATA is not set
-CONFIG_BLK_DEV_IDEDISK=m
-# CONFIG_IDEDISK_MULTI_MODE is not set
-# CONFIG_BLK_DEV_IDECS is not set
-CONFIG_BLK_DEV_IDECD=m
+CONFIG_IDE_GD=y
+CONFIG_IDE_GD_ATA=y
+# CONFIG_IDE_GD_ATAPI is not set
+CONFIG_BLK_DEV_IDECS=y
+# CONFIG_BLK_DEV_IDECD is not set
 # CONFIG_BLK_DEV_IDETAPE is not set
-# CONFIG_BLK_DEV_IDEFLOPPY is not set
 # CONFIG_IDE_TASK_IOCTL is not set
+CONFIG_IDE_PROC_FS=y
 
 #
 # IDE chipset support/bugfixes
 #
-CONFIG_IDE_GENERIC=m
-# CONFIG_IDE_ARM is not set
-# CONFIG_IDE_CHIPSETS is not set
+# CONFIG_BLK_DEV_PLATFORM is not set
 # CONFIG_BLK_DEV_IDEDMA is not set
-# CONFIG_IDEDMA_AUTO is not set
-# CONFIG_BLK_DEV_HD is not set
 
 #
 # SCSI device support
 #
+# CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
-
-#
-# Multi-device support (RAID and LVM)
-#
+# CONFIG_SCSI_DMA is not set
+# CONFIG_SCSI_NETLINK is not set
+# CONFIG_ATA is not set
 # CONFIG_MD is not set
-
-#
-# Fusion MPT device support
-#
-
-#
-# IEEE 1394 (FireWire) support
-#
-
-#
-# I2O device support
-#
-
-#
-# Networking support
-#
-CONFIG_NET=y
-
-#
-# Networking options
-#
-# CONFIG_PACKET is not set
-CONFIG_UNIX=y
-# CONFIG_NET_KEY is not set
-CONFIG_INET=y
-# CONFIG_IP_MULTICAST is not set
-# CONFIG_IP_ADVANCED_ROUTER is not set
-# CONFIG_IP_PNP is not set
-# CONFIG_NET_IPIP is not set
-# CONFIG_NET_IPGRE is not set
-# CONFIG_ARPD is not set
-# CONFIG_SYN_COOKIES is not set
-# CONFIG_INET_AH is not set
-# CONFIG_INET_ESP is not set
-# CONFIG_INET_IPCOMP is not set
-# CONFIG_INET_TUNNEL is not set
-# CONFIG_IP_TCPDIAG is not set
-# CONFIG_IP_TCPDIAG_IPV6 is not set
-# CONFIG_IPV6 is not set
-# CONFIG_NETFILTER is not set
-
-#
-# SCTP Configuration (EXPERIMENTAL)
-#
-# CONFIG_IP_SCTP is not set
-# CONFIG_ATM is not set
-# CONFIG_BRIDGE is not set
-# CONFIG_VLAN_8021Q is not set
-# CONFIG_DECNET is not set
-# CONFIG_LLC2 is not set
-# CONFIG_IPX is not set
-# CONFIG_ATALK is not set
-# CONFIG_X25 is not set
-# CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
-# CONFIG_ECONET is not set
-# CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
-# CONFIG_NET_SCHED is not set
-# CONFIG_NET_CLS_ROUTE is not set
-
-#
-# Network testing
-#
-# CONFIG_NET_PKTGEN is not set
-# CONFIG_NETPOLL is not set
-# CONFIG_NET_POLL_CONTROLLER is not set
-# CONFIG_HAMRADIO is not set
-CONFIG_IRDA=m
-
-#
-# IrDA protocols
-#
-CONFIG_IRLAN=m
-CONFIG_IRNET=m
-CONFIG_IRCOMM=m
-# CONFIG_IRDA_ULTRA is not set
-
-#
-# IrDA options
-#
-# CONFIG_IRDA_CACHE_LAST_LSAP is not set
-# CONFIG_IRDA_FAST_RR is not set
-# CONFIG_IRDA_DEBUG is not set
-
-#
-# Infrared-port device drivers
-#
-
-#
-# SIR device drivers
-#
-# CONFIG_IRTTY_SIR is not set
-
-#
-# Dongle support
-#
-
-#
-# Old SIR device drivers
-#
-# CONFIG_IRPORT_SIR is not set
-
-#
-# Old Serial dongle support
-#
-
-#
-# FIR device drivers
-#
-# CONFIG_NSC_FIR is not set
-# CONFIG_WINBOND_FIR is not set
-# CONFIG_SMC_IRCC_FIR is not set
-# CONFIG_ALI_FIR is not set
-CONFIG_SA1100_FIR=m
-# CONFIG_VIA_FIR is not set
-# CONFIG_BT is not set
 CONFIG_NETDEVICES=y
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
-
-#
-# ARCnet devices
-#
+# CONFIG_VETH is not set
 # CONFIG_ARCNET is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
 # CONFIG_NET_ETHERNET is not set
-
-#
-# Ethernet (1000 Mbit)
-#
-
-#
-# Ethernet (10000 Mbit)
-#
-
-#
-# Token Ring devices
-#
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
 # CONFIG_TR is not set
+# CONFIG_WLAN is not set
 
 #
-# Wireless LAN (non-hamradio)
-#
-# CONFIG_NET_RADIO is not set
-
-#
-# PCMCIA network device support
+# Enable WiMAX (Networking options) to see the WiMAX drivers
 #
 CONFIG_NET_PCMCIA=y
 # CONFIG_PCMCIA_3C589 is not set
@@ -525,10 +628,6 @@ CONFIG_PCMCIA_PCNET=y
 # CONFIG_PCMCIA_SMC91C92 is not set
 # CONFIG_PCMCIA_XIRC2PS is not set
 # CONFIG_PCMCIA_AXNET is not set
-
-#
-# Wan interfaces
-#
 # CONFIG_WAN is not set
 CONFIG_PPP=m
 # CONFIG_PPP_MULTILINK is not set
@@ -537,20 +636,23 @@ CONFIG_PPP_ASYNC=m
 # CONFIG_PPP_SYNC_TTY is not set
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_BSDCOMP=m
+# CONFIG_PPP_MPPE is not set
 # CONFIG_PPPOE is not set
+# CONFIG_PPPOL2TP is not set
 # CONFIG_SLIP is not set
-# CONFIG_SHAPER is not set
+CONFIG_SLHC=m
 # CONFIG_NETCONSOLE is not set
-
-#
-# ISDN subsystem
-#
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
 # CONFIG_ISDN is not set
+# CONFIG_PHONE is not set
 
 #
 # Input device support
 #
 CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
 
 #
 # Userland interfaces
@@ -560,7 +662,6 @@ CONFIG_INPUT_MOUSEDEV_PSAUX=y
 CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
 CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_TSDEV is not set
 # CONFIG_INPUT_EVDEV is not set
 # CONFIG_INPUT_EVBUG is not set
 
@@ -568,47 +669,42 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # Input Device Drivers
 #
 CONFIG_INPUT_KEYBOARD=y
-CONFIG_KEYBOARD_ATKBD=y
-# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_ATKBD is not set
 # CONFIG_KEYBOARD_LKKBD is not set
-# CONFIG_KEYBOARD_XTKBD is not set
+CONFIG_KEYBOARD_GPIO=y
+# CONFIG_KEYBOARD_MATRIX is not set
 # CONFIG_KEYBOARD_NEWTON is not set
-CONFIG_INPUT_MOUSE=y
-CONFIG_MOUSE_PS2=y
-# CONFIG_MOUSE_SERIAL is not set
-# CONFIG_MOUSE_INPORT is not set
-# CONFIG_MOUSE_LOGIBM is not set
-# CONFIG_MOUSE_PC110PAD is not set
-# CONFIG_MOUSE_VSXXXAA is not set
+# CONFIG_KEYBOARD_OPENCORES is not set
+# CONFIG_KEYBOARD_STOWAWAY is not set
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_XTKBD is not set
+# CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
 # CONFIG_INPUT_TOUCHSCREEN is not set
 # CONFIG_INPUT_MISC is not set
 
 #
 # Hardware I/O ports
 #
-CONFIG_SERIO=y
-CONFIG_SERIO_SERPORT=y
-CONFIG_SERIO_LIBPS2=y
-# CONFIG_SERIO_RAW is not set
+# CONFIG_SERIO is not set
 # CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
 
 #
 # Character devices
 #
 CONFIG_VT=y
+CONFIG_CONSOLE_TRANSLATIONS=y
 CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
+CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set
 
 #
 # Serial drivers
 #
-CONFIG_SERIAL_8250=m
-# CONFIG_SERIAL_8250_CS is not set
-CONFIG_SERIAL_8250_NR_UARTS=4
-# CONFIG_SERIAL_8250_EXTENDED is not set
+# CONFIG_SERIAL_8250 is not set
 
 #
 # Non-8250 serial port support
@@ -618,71 +714,125 @@ CONFIG_SERIAL_SA1100_CONSOLE=y
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
+# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
+# CONFIG_IPMI_HANDLER is not set
+# CONFIG_HW_RANDOM is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
 
 #
-# IPMI
+# PCMCIA character devices
 #
-# CONFIG_IPMI_HANDLER is not set
+# CONFIG_SYNCLINK_CS is not set
+# CONFIG_CARDMAN_4000 is not set
+# CONFIG_CARDMAN_4040 is not set
+# CONFIG_IPWIRELESS is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+CONFIG_DEVPORT=y
+# CONFIG_I2C is not set
+# CONFIG_SPI is not set
 
 #
-# Watchdog Cards
+# PPS support
 #
-# CONFIG_WATCHDOG is not set
-# CONFIG_NVRAM is not set
-# CONFIG_RTC is not set
-# CONFIG_DTLK is not set
-# CONFIG_R3964 is not set
+# CONFIG_PPS is not set
+CONFIG_ARCH_REQUIRE_GPIOLIB=y
+CONFIG_GPIOLIB=y
+# CONFIG_GPIO_SYSFS is not set
 
 #
-# Ftape, the floppy tape device driver
+# Memory mapped GPIO expanders:
 #
-# CONFIG_DRM is not set
 
 #
-# PCMCIA character devices
+# I2C GPIO expanders:
 #
-# CONFIG_SYNCLINK_CS is not set
-# CONFIG_RAW_DRIVER is not set
 
 #
-# TPM devices
+# PCI GPIO expanders:
 #
 
 #
-# I2C support
+# SPI GPIO expanders:
 #
-# CONFIG_I2C is not set
 
 #
-# Misc devices
+# AC97 GPIO expanders:
 #
+# CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_HWMON is not set
+# CONFIG_THERMAL is not set
+# CONFIG_WATCHDOG is not set
+CONFIG_SSB_POSSIBLE=y
 
 #
-# Multimedia devices
+# Sonics Silicon Backplane
 #
-# CONFIG_VIDEO_DEV is not set
+# CONFIG_SSB is not set
 
 #
-# Digital Video Broadcasting Devices
+# Multifunction device drivers
 #
-# CONFIG_DVB is not set
+# CONFIG_MFD_CORE is not set
+# CONFIG_MFD_SM501 is not set
+# CONFIG_MFD_ASIC3 is not set
+CONFIG_HTC_EGPIO=y
+# CONFIG_HTC_PASIC3 is not set
+# CONFIG_MFD_TMIO is not set
+# CONFIG_MFD_T7L66XB is not set
+# CONFIG_MFD_TC6387XB is not set
+# CONFIG_MFD_TC6393XB is not set
+
+#
+# Multimedia Capabilities Port drivers
+#
+# CONFIG_MCP_SA11X0 is not set
+# CONFIG_REGULATOR is not set
+# CONFIG_MEDIA_SUPPORT is not set
 
 #
 # Graphics support
 #
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
 CONFIG_FB=y
+# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_FB_DDC is not set
+# CONFIG_FB_BOOT_VESA_SUPPORT is not set
 CONFIG_FB_CFB_FILLRECT=y
 CONFIG_FB_CFB_COPYAREA=y
 CONFIG_FB_CFB_IMAGEBLIT=y
-CONFIG_FB_SOFT_CURSOR=y
+# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_FOREIGN_ENDIAN is not set
+# CONFIG_FB_SYS_FOPS is not set
+# CONFIG_FB_SVGALIB is not set
 # CONFIG_FB_MACMODES is not set
+# CONFIG_FB_BACKLIGHT is not set
 # CONFIG_FB_MODE_HELPERS is not set
 # CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frame buffer hardware drivers
+#
 CONFIG_FB_SA1100=y
 # CONFIG_FB_S1D13XXX is not set
 # CONFIG_FB_VIRTUAL is not set
+# CONFIG_FB_METRONOME is not set
+# CONFIG_FB_MB862XX is not set
+# CONFIG_FB_BROADSHEET is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
 
 #
 # Console display driver support
@@ -691,65 +841,54 @@ CONFIG_FB_SA1100=y
 # CONFIG_MDA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
 # CONFIG_FRAMEBUFFER_CONSOLE is not set
-
-#
-# Logo configuration
-#
 # CONFIG_LOGO is not set
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
-
-#
-# Sound
-#
-CONFIG_SOUND=y
-
-#
-# Advanced Linux Sound Architecture
-#
-# CONFIG_SND is not set
-
-#
-# Open Sound System
-#
-# CONFIG_SOUND_PRIME is not set
-
-#
-# USB support
-#
-CONFIG_USB_ARCH_HAS_HCD=y
-# CONFIG_USB_ARCH_HAS_OHCI is not set
-# CONFIG_USB is not set
+# CONFIG_SOUND is not set
+# CONFIG_HID_SUPPORT is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
+# CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
+CONFIG_RTC_LIB=y
+# CONFIG_RTC_CLASS is not set
+# CONFIG_DMADEVICES is not set
+# CONFIG_AUXDISPLAY is not set
+# CONFIG_UIO is not set
 
 #
-# USB Gadget Support
+# TI VLYNQ
 #
-# CONFIG_USB_GADGET is not set
-
-#
-# MMC/SD Card support
-#
-# CONFIG_MMC is not set
+# CONFIG_STAGING is not set
 
 #
 # File systems
 #
 CONFIG_EXT2_FS=y
 # CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
 # CONFIG_EXT3_FS is not set
-# CONFIG_JBD is not set
+# CONFIG_EXT4_FS is not set
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
-
-#
-# XFS support
-#
+# CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
-# CONFIG_MINIX_FS is not set
-# CONFIG_ROMFS_FS is not set
-# CONFIG_QUOTA is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_BTRFS_FS is not set
+# CONFIG_NILFS2_FS is not set
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
 CONFIG_DNOTIFY=y
+# CONFIG_INOTIFY is not set
+CONFIG_INOTIFY_USER=y
+# CONFIG_QUOTA is not set
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# Caches
+#
+# CONFIG_FSCACHE is not set
 
 #
 # CD-ROM/DVD Filesystems
@@ -771,16 +910,13 @@ CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 # Pseudo filesystems
 #
 CONFIG_PROC_FS=y
+CONFIG_PROC_SYSCTL=y
+CONFIG_PROC_PAGE_MONITOR=y
 CONFIG_SYSFS=y
-# CONFIG_DEVFS_FS is not set
-# CONFIG_DEVPTS_FS_XATTR is not set
 # CONFIG_TMPFS is not set
 # CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=y
-
-#
-# Miscellaneous filesystems
-#
+# CONFIG_CONFIGFS_FS is not set
+CONFIG_MISC_FILESYSTEMS=y
 # CONFIG_ADFS_FS is not set
 # CONFIG_AFFS_FS is not set
 # CONFIG_HFS_FS is not set
@@ -788,34 +924,37 @@ CONFIG_RAMFS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
-# CONFIG_JFFS_FS is not set
 CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_FS_DEBUG=0
-# CONFIG_JFFS2_FS_NAND is not set
-# CONFIG_JFFS2_FS_NOR_ECC is not set
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
+# CONFIG_JFFS2_SUMMARY is not set
+# CONFIG_JFFS2_FS_XATTR is not set
 # CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
 CONFIG_JFFS2_ZLIB=y
+# CONFIG_JFFS2_LZO is not set
 CONFIG_JFFS2_RTIME=y
 # CONFIG_JFFS2_RUBIN is not set
 CONFIG_CRAMFS=m
+# CONFIG_SQUASHFS is not set
 # CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_OMFS_FS is not set
 # CONFIG_HPFS_FS is not set
 # CONFIG_QNX4FS_FS is not set
+# CONFIG_ROMFS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-
-#
-# Network File Systems
-#
+CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 # CONFIG_NFS_V3 is not set
 # CONFIG_NFS_V4 is not set
-# CONFIG_NFS_DIRECTIO is not set
 CONFIG_NFSD=m
 # CONFIG_NFSD_V3 is not set
-CONFIG_NFSD_TCP=y
+# CONFIG_NFSD_V4 is not set
 CONFIG_LOCKD=y
 CONFIG_EXPORTFS=m
+CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
@@ -831,10 +970,6 @@ CONFIG_SMB_FS=m
 #
 # CONFIG_PARTITION_ADVANCED is not set
 CONFIG_MSDOS_PARTITION=y
-
-#
-# Native Language Support
-#
 CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_NLS_CODEPAGE_437 is not set
@@ -875,20 +1010,34 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_NLS_KOI8_R is not set
 # CONFIG_NLS_KOI8_U is not set
 # CONFIG_NLS_UTF8 is not set
-
-#
-# Profiling support
-#
-# CONFIG_PROFILING is not set
+# CONFIG_DLM is not set
 
 #
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
+CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
+# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_STRIP_ASM_SYMS is not set
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
 # CONFIG_DEBUG_KERNEL is not set
-CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_SLUB_DEBUG_ON is not set
+# CONFIG_SLUB_STATS is not set
 CONFIG_DEBUG_BUGVERBOSE=y
+CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_FRAME_POINTER=y
+# CONFIG_RCU_CPU_STALL_DETECTOR is not set
+# CONFIG_LATENCYTOP is not set
+# CONFIG_SYSCTL_SYSCALL_CHECK is not set
+CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_TRACING_SUPPORT=y
+# CONFIG_FTRACE is not set
+# CONFIG_SAMPLES is not set
+CONFIG_HAVE_ARCH_KGDB=y
 # CONFIG_DEBUG_USER is not set
 
 #
@@ -896,21 +1045,120 @@ CONFIG_FRAME_POINTER=y
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
+# CONFIG_SECURITYFS is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
+CONFIG_CRYPTO=y
+
+#
+# Crypto core or helper
+#
+# CONFIG_CRYPTO_FIPS is not set
+CONFIG_CRYPTO_ALGAPI=m
+CONFIG_CRYPTO_ALGAPI2=m
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
+# CONFIG_CRYPTO_CRC32C is not set
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
 
 #
-# Cryptographic options
+# Compression
 #
-# CONFIG_CRYPTO is not set
+# CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_ZLIB is not set
+# CONFIG_CRYPTO_LZO is not set
 
 #
-# Hardware crypto devices
+# Random Number Generation
 #
+CONFIG_CRYPTO_ANSI_CPRNG=m
+CONFIG_CRYPTO_HW=y
+# CONFIG_BINARY_PRINTF is not set
 
 #
 # Library routines
 #
+CONFIG_BITREVERSE=y
+CONFIG_GENERIC_FIND_LAST_BIT=y
 CONFIG_CRC_CCITT=m
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_T10DIF is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
 # CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=y
+CONFIG_DECOMPRESS_GZIP=y
+CONFIG_DECOMPRESS_BZIP2=y
+CONFIG_DECOMPRESS_LZMA=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
+CONFIG_NLATTR=y
-- 
1.6.5.1.63.ga9d7.dirty
