From: kth3321@gmail.com (Taehun Kim)
Date: Mon, 19 Sep 2011 18:50:10 +0900
Subject: [PATCH] ARM: S3C2410:  Adds WIZnet W5300E01-ARM board support
Message-ID: <1316425810-21621-1-git-send-email-kth3321@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds WIZnet W5300E01-ARM board support.
Signed-off-by: Taehun Kim <kth3321@gmail.com>
---
 arch/arm/configs/w5300e01_defconfig   | 1355 +++++++++++++++++++++++++++++++++
 arch/arm/mach-s3c2410/Kconfig         |    6 +
 arch/arm/mach-s3c2410/Makefile        |    1 +
 arch/arm/mach-s3c2410/mach-w5300e01.c |  198 +++++
 4 files changed, 1560 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/configs/w5300e01_defconfig
 create mode 100644 arch/arm/mach-s3c2410/mach-w5300e01.c

diff --git a/arch/arm/configs/w5300e01_defconfig b/arch/arm/configs/w5300e01_defconfig
new file mode 100644
index 0000000..981784f
--- /dev/null
+++ b/arch/arm/configs/w5300e01_defconfig
@@ -0,0 +1,1355 @@
+#
+# Automatically generated make config: don't edit
+# Linux/arm 3.0.0 Kernel Configuration
+#
+CONFIG_ARM=y
+CONFIG_HAVE_PWM=y
+CONFIG_SYS_SUPPORTS_APM_EMULATION=y
+CONFIG_GENERIC_GPIO=y
+CONFIG_ARCH_USES_GETTIMEOFFSET=y
+CONFIG_KTIME_SCALAR=y
+CONFIG_HAVE_PROC_CPU=y
+CONFIG_NO_IOPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_HAVE_LATENCYTOP_SUPPORT=y
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
+CONFIG_HARDIRQS_SW_RESEND=y
+CONFIG_GENERIC_IRQ_PROBE=y
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_ARCH_HAS_CPUFREQ=y
+CONFIG_ARCH_HAS_CPU_IDLE_WAIT=y
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_NEED_DMA_MAP_STATE=y
+CONFIG_VECTORS_BASE=0xffff0000
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+CONFIG_HAVE_IRQ_WORK=y
+
+#
+# General setup
+#
+# CONFIG_EXPERIMENTAL is not set
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_CROSS_COMPILE=""
+CONFIG_LOCALVERSION=""
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_HAVE_KERNEL_GZIP=y
+CONFIG_HAVE_KERNEL_LZMA=y
+CONFIG_HAVE_KERNEL_LZO=y
+CONFIG_KERNEL_GZIP=y
+# CONFIG_KERNEL_LZMA is not set
+# CONFIG_KERNEL_LZO is not set
+CONFIG_DEFAULT_HOSTNAME="W5300E01"
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_FHANDLE is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_AUDIT is not set
+CONFIG_HAVE_GENERIC_HARDIRQS=y
+
+#
+# IRQ subsystem
+#
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_HAVE_SPARSE_IRQ=y
+CONFIG_GENERIC_IRQ_SHOW=y
+CONFIG_GENERIC_IRQ_CHIP=y
+# CONFIG_SPARSE_IRQ is not set
+
+#
+# RCU Subsystem
+#
+CONFIG_TINY_RCU=y
+# CONFIG_PREEMPT_RCU is not set
+# CONFIG_RCU_TRACE is not set
+# CONFIG_TREE_RCU_TRACE is not set
+# CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=16
+# CONFIG_CGROUPS is not set
+# CONFIG_NAMESPACES is not set
+# CONFIG_SCHED_AUTOGROUP is not set
+# CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
+CONFIG_RD_GZIP=y
+# CONFIG_RD_BZIP2 is not set
+# CONFIG_RD_LZMA is not set
+# CONFIG_RD_XZ is not set
+# CONFIG_RD_LZO is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_ANON_INODES=y
+CONFIG_EXPERT=y
+CONFIG_UID16=y
+CONFIG_KALLSYMS=y
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
+CONFIG_EMBEDDED=y
+CONFIG_HAVE_PERF_EVENTS=y
+CONFIG_PERF_USE_VMALLOC=y
+
+#
+# Kernel Performance Events And Counters
+#
+# CONFIG_PERF_EVENTS is not set
+# CONFIG_PERF_COUNTERS is not set
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_COMPAT_BRK is not set
+# CONFIG_SLAB is not set
+# CONFIG_SLUB is not set
+CONFIG_SLOB=y
+# CONFIG_PROFILING is not set
+CONFIG_HAVE_OPROFILE=y
+# CONFIG_KPROBES is not set
+CONFIG_HAVE_KPROBES=y
+CONFIG_HAVE_KRETPROBES=y
+CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
+CONFIG_HAVE_CLK=y
+CONFIG_HAVE_DMA_API_DEBUG=y
+
+#
+# GCOV-based kernel profiling
+#
+CONFIG_HAVE_GENERIC_DMA_COHERENT=y
+CONFIG_RT_MUTEXES=y
+CONFIG_BASE_SMALL=0
+CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_BLOCK=y
+# CONFIG_LBDAF is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_BLK_DEV_INTEGRITY is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_DEADLINE=y
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
+CONFIG_INLINE_SPIN_UNLOCK=y
+# CONFIG_INLINE_SPIN_UNLOCK_BH is not set
+CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
+# CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE is not set
+# CONFIG_INLINE_READ_TRYLOCK is not set
+# CONFIG_INLINE_READ_LOCK is not set
+# CONFIG_INLINE_READ_LOCK_BH is not set
+# CONFIG_INLINE_READ_LOCK_IRQ is not set
+# CONFIG_INLINE_READ_LOCK_IRQSAVE is not set
+CONFIG_INLINE_READ_UNLOCK=y
+# CONFIG_INLINE_READ_UNLOCK_BH is not set
+CONFIG_INLINE_READ_UNLOCK_IRQ=y
+# CONFIG_INLINE_READ_UNLOCK_IRQRESTORE is not set
+# CONFIG_INLINE_WRITE_TRYLOCK is not set
+# CONFIG_INLINE_WRITE_LOCK is not set
+# CONFIG_INLINE_WRITE_LOCK_BH is not set
+# CONFIG_INLINE_WRITE_LOCK_IRQ is not set
+# CONFIG_INLINE_WRITE_LOCK_IRQSAVE is not set
+CONFIG_INLINE_WRITE_UNLOCK=y
+# CONFIG_INLINE_WRITE_UNLOCK_BH is not set
+CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
+# CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE is not set
+# CONFIG_MUTEX_SPIN_ON_OWNER is not set
+CONFIG_FREEZER=y
+
+#
+# System Type
+#
+CONFIG_MMU=y
+# CONFIG_ARCH_INTEGRATOR is not set
+# CONFIG_ARCH_REALVIEW is not set
+# CONFIG_ARCH_VERSATILE is not set
+# CONFIG_ARCH_VEXPRESS is not set
+# CONFIG_ARCH_AT91 is not set
+# CONFIG_ARCH_BCMRING is not set
+# CONFIG_ARCH_CLPS711X is not set
+# CONFIG_ARCH_CNS3XXX is not set
+# CONFIG_ARCH_GEMINI is not set
+# CONFIG_ARCH_EBSA110 is not set
+# CONFIG_ARCH_EP93XX is not set
+# CONFIG_ARCH_FOOTBRIDGE is not set
+# CONFIG_ARCH_MXC is not set
+# CONFIG_ARCH_MXS is not set
+# CONFIG_ARCH_NETX is not set
+# CONFIG_ARCH_H720X is not set
+# CONFIG_ARCH_IOP13XX is not set
+# CONFIG_ARCH_IOP32X is not set
+# CONFIG_ARCH_IOP33X is not set
+# CONFIG_ARCH_IXP23XX is not set
+# CONFIG_ARCH_IXP2000 is not set
+# CONFIG_ARCH_IXP4XX is not set
+# CONFIG_ARCH_DOVE is not set
+# CONFIG_ARCH_KIRKWOOD is not set
+# CONFIG_ARCH_LOKI is not set
+# CONFIG_ARCH_LPC32XX is not set
+# CONFIG_ARCH_MV78XX0 is not set
+# CONFIG_ARCH_ORION5X is not set
+# CONFIG_ARCH_MMP is not set
+# CONFIG_ARCH_KS8695 is not set
+# CONFIG_ARCH_W90X900 is not set
+# CONFIG_ARCH_NUC93X is not set
+# CONFIG_ARCH_TEGRA is not set
+# CONFIG_ARCH_PNX4008 is not set
+# CONFIG_ARCH_PXA is not set
+# CONFIG_ARCH_MSM is not set
+# CONFIG_ARCH_SHMOBILE is not set
+# CONFIG_ARCH_RPC is not set
+# CONFIG_ARCH_SA1100 is not set
+CONFIG_ARCH_S3C2410=y
+# CONFIG_ARCH_S3C64XX is not set
+# CONFIG_ARCH_S5P64X0 is not set
+# CONFIG_ARCH_S5PC100 is not set
+# CONFIG_ARCH_S5PV210 is not set
+# CONFIG_ARCH_EXYNOS4 is not set
+# CONFIG_ARCH_SHARK is not set
+# CONFIG_ARCH_TCC_926 is not set
+# CONFIG_ARCH_U300 is not set
+# CONFIG_ARCH_U8500 is not set
+# CONFIG_ARCH_NOMADIK is not set
+# CONFIG_ARCH_DAVINCI is not set
+# CONFIG_ARCH_OMAP is not set
+# CONFIG_PLAT_SPEAR is not set
+# CONFIG_ARCH_VT8500 is not set
+CONFIG_PLAT_SAMSUNG=y
+
+#
+# Boot options
+#
+# CONFIG_S3C_BOOT_WATCHDOG is not set
+CONFIG_S3C_BOOT_ERROR_RESET=y
+CONFIG_S3C_BOOT_UART_FORCE_FIFO=y
+CONFIG_S3C_LOWLEVEL_UART_PORT=0
+CONFIG_S3C_GPIO_CFG_S3C24XX=y
+CONFIG_S3C_GPIO_PULL_UP=y
+CONFIG_SAMSUNG_GPIO_EXTRA=0
+CONFIG_S3C_GPIO_SPACE=0
+CONFIG_S3C_ADC=y
+CONFIG_S3C_DEV_WDT=y
+CONFIG_S3C_DEV_NAND=y
+CONFIG_SAMSUNG_DEV_PWM=y
+CONFIG_S3C24XX_PWM=y
+
+#
+# Power management
+#
+# CONFIG_SAMSUNG_PM_DEBUG is not set
+# CONFIG_SAMSUNG_PM_CHECK is not set
+
+#
+# Power Domain
+#
+# CONFIG_SAMSUNG_PD is not set
+CONFIG_PLAT_S3C24XX=y
+CONFIG_CPU_LLSERIAL_S3C2410_ONLY=y
+CONFIG_CPU_LLSERIAL_S3C2410=y
+CONFIG_S3C2410_CLOCK=y
+CONFIG_S3C24XX_GPIO_EXTRA=0
+# CONFIG_S3C2410_DMA is not set
+
+#
+# System MMU
+#
+
+#
+# S3C2400 Machines
+#
+CONFIG_CPU_S3C2410=y
+CONFIG_S3C2410_PM=y
+CONFIG_S3C2410_GPIO=y
+
+#
+# S3C2410 Machines
+#
+# CONFIG_ARCH_SMDK2410 is not set
+# CONFIG_ARCH_H1940 is not set
+# CONFIG_MACH_N30 is not set
+# CONFIG_ARCH_BAST is not set
+# CONFIG_MACH_OTOM is not set
+# CONFIG_MACH_AML_M5900 is not set
+# CONFIG_MACH_TCT_HAMMER is not set
+# CONFIG_MACH_VR1000 is not set
+# CONFIG_MACH_QT2410 is not set
+CONFIG_MACH_W5300E01=y
+
+#
+# S3C2412 Machines
+#
+# CONFIG_MACH_JIVE is not set
+# CONFIG_MACH_SMDK2413 is not set
+# CONFIG_MACH_SMDK2412 is not set
+# CONFIG_MACH_VSTMS is not set
+
+#
+# S3C2416 Machines
+#
+# CONFIG_MACH_SMDK2416 is not set
+
+#
+# S3C2440 and S3C2442 Machines
+#
+# CONFIG_MACH_ANUBIS is not set
+# CONFIG_MACH_NEO1973_GTA02 is not set
+# CONFIG_MACH_OSIRIS is not set
+# CONFIG_MACH_RX3715 is not set
+# CONFIG_ARCH_S3C2440 is not set
+# CONFIG_MACH_NEXCODER_2440 is not set
+# CONFIG_SMDK2440_CPU2440 is not set
+# CONFIG_SMDK2440_CPU2442 is not set
+# CONFIG_MACH_AT2440EVB is not set
+# CONFIG_MACH_MINI2440 is not set
+# CONFIG_MACH_RX1950 is not set
+
+#
+# S3C2443 Machines
+#
+# CONFIG_MACH_SMDK2443 is not set
+
+#
+# Processor Type
+#
+CONFIG_CPU_ARM920T=y
+CONFIG_CPU_32v4T=y
+CONFIG_CPU_ABRT_EV4T=y
+CONFIG_CPU_PABRT_LEGACY=y
+CONFIG_CPU_CACHE_V4WT=y
+CONFIG_CPU_CACHE_VIVT=y
+CONFIG_CPU_COPY_V4WB=y
+CONFIG_CPU_TLB_V4WBI=y
+CONFIG_CPU_CP15=y
+CONFIG_CPU_CP15_MMU=y
+CONFIG_CPU_USE_DOMAINS=y
+
+#
+# Processor Features
+#
+# CONFIG_ARM_THUMB is not set
+# CONFIG_CPU_ICACHE_DISABLE is not set
+# CONFIG_CPU_DCACHE_DISABLE is not set
+# CONFIG_CPU_DCACHE_WRITETHROUGH is not set
+CONFIG_ARM_L1_CACHE_SHIFT=5
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
+CONFIG_VMSPLIT_3G=y
+# CONFIG_VMSPLIT_2G is not set
+# CONFIG_VMSPLIT_1G is not set
+CONFIG_PAGE_OFFSET=0xC0000000
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+CONFIG_HZ=200
+# CONFIG_AEABI is not set
+# CONFIG_ARCH_SPARSEMEM_DEFAULT is not set
+# CONFIG_ARCH_SELECT_MEMORY_MODEL is not set
+CONFIG_HAVE_ARCH_PFN_VALID=y
+# CONFIG_HIGHMEM is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+CONFIG_HAVE_MEMBLOCK=y
+CONFIG_PAGEFLAGS_EXTENDED=y
+CONFIG_SPLIT_PTLOCK_CPUS=999999
+# CONFIG_COMPACTION is not set
+# CONFIG_PHYS_ADDR_T_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=0
+CONFIG_VIRT_TO_BUS=y
+# CONFIG_KSM is not set
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
+CONFIG_NEED_PER_CPU_KM=y
+# CONFIG_CLEANCACHE is not set
+CONFIG_FORCE_MAX_ZONEORDER=11
+CONFIG_ALIGNMENT_TRAP=y
+# CONFIG_SECCOMP is not set
+# CONFIG_DEPRECATED_PARAM_STRUCT is not set
+
+#
+# Boot options
+#
+# CONFIG_USE_OF is not set
+CONFIG_ZBOOT_ROM_TEXT=0x0
+CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_CMDLINE="mem=64M console=ttySAC0,115200 root=/dev/ram0 rw initrd=0x31000000,12M"
+CONFIG_CMDLINE_FROM_BOOTLOADER=y
+# CONFIG_CMDLINE_EXTEND is not set
+# CONFIG_CMDLINE_FORCE is not set
+# CONFIG_XIP_KERNEL is not set
+# CONFIG_AUTO_ZRELADDR is not set
+
+#
+# CPU Power Management
+#
+
+#
+# CPU Frequency scaling
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
+CONFIG_FPE_NWFPE_XP=y
+
+#
+# Userspace binary formats
+#
+CONFIG_BINFMT_ELF=y
+CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
+CONFIG_HAVE_AOUT=y
+CONFIG_BINFMT_AOUT=y
+# CONFIG_BINFMT_MISC is not set
+# CONFIG_ARTHUR is not set
+
+#
+# Power management options
+#
+CONFIG_SUSPEND=y
+CONFIG_SUSPEND_FREEZER=y
+CONFIG_PM_SLEEP=y
+CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
+# CONFIG_PM_DEBUG is not set
+# CONFIG_APM_EMULATION is not set
+CONFIG_PM_RUNTIME_CLK=y
+CONFIG_ARCH_SUSPEND_POSSIBLE=y
+CONFIG_NET=y
+
+#
+# Networking options
+#
+# CONFIG_PACKET is not set
+# CONFIG_UNIX is not set
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
+# CONFIG_IP_PNP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE_DEMUX is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+# CONFIG_INET_DIAG is not set
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_IPV6 is not set
+# CONFIG_NETWORK_SECMARK is not set
+CONFIG_NETFILTER=y
+# CONFIG_NETFILTER_DEBUG is not set
+# CONFIG_NETFILTER_ADVANCED is not set
+
+#
+# Core Netfilter Configuration
+#
+CONFIG_NETFILTER_NETLINK=m
+CONFIG_NETFILTER_NETLINK_LOG=m
+CONFIG_NF_CONNTRACK=m
+CONFIG_NF_CONNTRACK_FTP=m
+CONFIG_NF_CONNTRACK_IRC=m
+CONFIG_NF_CONNTRACK_SIP=m
+CONFIG_NF_CT_NETLINK=m
+CONFIG_NETFILTER_XTABLES=m
+
+#
+# Xtables combined modules
+#
+CONFIG_NETFILTER_XT_MARK=m
+
+#
+# Xtables targets
+#
+CONFIG_NETFILTER_XT_TARGET_NFLOG=m
+CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
+
+#
+# Xtables matches
+#
+CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
+CONFIG_NETFILTER_XT_MATCH_STATE=m
+# CONFIG_IP_SET is not set
+# CONFIG_IP_VS is not set
+
+#
+# IP: Netfilter Configuration
+#
+CONFIG_NF_DEFRAG_IPV4=m
+CONFIG_NF_CONNTRACK_IPV4=m
+CONFIG_NF_CONNTRACK_PROC_COMPAT=y
+CONFIG_IP_NF_IPTABLES=m
+CONFIG_IP_NF_FILTER=m
+CONFIG_IP_NF_TARGET_REJECT=m
+CONFIG_IP_NF_TARGET_LOG=m
+CONFIG_IP_NF_TARGET_ULOG=m
+CONFIG_NF_NAT=m
+CONFIG_NF_NAT_NEEDED=y
+CONFIG_IP_NF_TARGET_MASQUERADE=m
+CONFIG_NF_NAT_FTP=m
+CONFIG_NF_NAT_IRC=m
+# CONFIG_NF_NAT_TFTP is not set
+# CONFIG_NF_NAT_AMANDA is not set
+# CONFIG_NF_NAT_PPTP is not set
+# CONFIG_NF_NAT_H323 is not set
+CONFIG_NF_NAT_SIP=m
+CONFIG_IP_NF_MANGLE=m
+# CONFIG_ATM is not set
+# CONFIG_L2TP is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_PHONET is not set
+# CONFIG_NET_SCHED is not set
+# CONFIG_DCB is not set
+# CONFIG_BATMAN_ADV is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_WIRELESS is not set
+# CONFIG_WIMAX is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
+# CONFIG_CAIF is not set
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
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+CONFIG_FW_LOADER=y
+# CONFIG_FIRMWARE_IN_KERNEL is not set
+CONFIG_EXTRA_FIRMWARE=""
+# CONFIG_SYS_HYPERVISOR is not set
+# CONFIG_CONNECTOR is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_TESTS is not set
+# CONFIG_MTD_REDBOOT_PARTS is not set
+# CONFIG_MTD_CMDLINE_PARTS is not set
+# CONFIG_MTD_AFS_PARTS is not set
+# CONFIG_MTD_AR7_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+# CONFIG_MTD_CHAR is not set
+# CONFIG_MTD_BLKDEVS is not set
+# CONFIG_MTD_BLOCK is not set
+# CONFIG_MTD_BLOCK_RO is not set
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
+CONFIG_MTD_NAND_ECC=y
+# CONFIG_MTD_NAND_ECC_SMC is not set
+CONFIG_MTD_NAND=y
+# CONFIG_MTD_NAND_VERIFY_WRITE is not set
+# CONFIG_MTD_NAND_ECC_BCH is not set
+# CONFIG_MTD_SM_COMMON is not set
+# CONFIG_MTD_NAND_MUSEUM_IDS is not set
+# CONFIG_MTD_NAND_GPIO is not set
+CONFIG_MTD_NAND_IDS=y
+CONFIG_MTD_NAND_S3C2410=y
+# CONFIG_MTD_NAND_S3C2410_DEBUG is not set
+# CONFIG_MTD_NAND_S3C2410_HWECC is not set
+# CONFIG_MTD_NAND_S3C2410_CLKSTOP is not set
+# CONFIG_MTD_NAND_NANDSIM is not set
+# CONFIG_MTD_NAND_PLATFORM is not set
+# CONFIG_MTD_ALAUDA is not set
+# CONFIG_MTD_ONENAND is not set
+
+#
+# LPDDR flash memory drivers
+#
+# CONFIG_MTD_LPDDR is not set
+# CONFIG_MTD_UBI is not set
+# CONFIG_PARPORT is not set
+CONFIG_BLK_DEV=y
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+
+#
+# DRBD disabled because PROC_FS, INET or CONNECTOR not selected
+#
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_UB is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=1
+CONFIG_BLK_DEV_RAM_SIZE=12288
+# CONFIG_BLK_DEV_XIP is not set
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_MG_DISK is not set
+# CONFIG_SENSORS_LIS3LV02D is not set
+# CONFIG_MISC_DEVICES is not set
+CONFIG_HAVE_IDE=y
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+CONFIG_SCSI_MOD=y
+# CONFIG_RAID_ATTRS is not set
+# CONFIG_SCSI is not set
+# CONFIG_SCSI_DMA is not set
+# CONFIG_SCSI_NETLINK is not set
+# CONFIG_ATA is not set
+# CONFIG_MD is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+# CONFIG_VETH is not set
+# CONFIG_MII is not set
+# CONFIG_PHYLIB is not set
+CONFIG_NET_ETHERNET=y
+# CONFIG_AX88796 is not set
+CONFIG_W5300=y
+# CONFIG_SMC91X is not set
+# CONFIG_DM9000 is not set
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
+# CONFIG_KS8851_MLL is not set
+# CONFIG_FTMAC100 is not set
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
+# CONFIG_WLAN is not set
+
+#
+# Enable WiMAX (Networking options) to see the WiMAX drivers
+#
+
+#
+# USB Network Adapters
+#
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_USBNET is not set
+# CONFIG_USB_IPHETH is not set
+# CONFIG_WAN is not set
+
+#
+# CAIF transport drivers
+#
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
+# CONFIG_INPUT_MOUSEDEV is not set
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
+# CONFIG_SERIO is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+# CONFIG_VT is not set
+# CONFIG_UNIX98_PTYS is not set
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+# CONFIG_TRACE_SINK is not set
+CONFIG_DEVKMEM=y
+
+#
+# Serial drivers
+#
+# CONFIG_SERIAL_8250 is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_SAMSUNG=y
+CONFIG_SERIAL_SAMSUNG_UARTS=3
+CONFIG_SERIAL_SAMSUNG_CONSOLE=y
+CONFIG_SERIAL_S3C2410=y
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_TIMBERDALE is not set
+# CONFIG_SERIAL_ALTERA_JTAGUART is not set
+# CONFIG_SERIAL_ALTERA_UART is not set
+# CONFIG_SERIAL_XILINX_PS_UART is not set
+# CONFIG_TTY_PRINTK is not set
+# CONFIG_HVC_DCC is not set
+# CONFIG_IPMI_HANDLER is not set
+# CONFIG_HW_RANDOM is not set
+# CONFIG_R3964 is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_RAMOOPS is not set
+# CONFIG_I2C is not set
+# CONFIG_SPI is not set
+
+#
+# PPS support
+#
+
+#
+# PPS generators support
+#
+
+#
+# PTP clock support
+#
+
+#
+# Enable Device Drivers -> PPS to see the PTP clock options.
+#
+CONFIG_ARCH_REQUIRE_GPIOLIB=y
+CONFIG_GPIOLIB=y
+
+#
+# Memory mapped GPIO drivers:
+#
+# CONFIG_GPIO_BASIC_MMIO is not set
+# CONFIG_GPIO_IT8761E is not set
+
+#
+# I2C GPIO expanders:
+#
+
+#
+# PCI GPIO expanders:
+#
+
+#
+# SPI GPIO expanders:
+#
+
+#
+# AC97 GPIO expanders:
+#
+
+#
+# MODULbus GPIO expanders:
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
+CONFIG_S3C2410_WATCHDOG=y
+# CONFIG_MAX63XX_WATCHDOG is not set
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
+CONFIG_BCMA_POSSIBLE=y
+
+#
+# Broadcom specific AMBA
+#
+# CONFIG_BCMA is not set
+# CONFIG_MFD_SUPPORT is not set
+# CONFIG_REGULATOR is not set
+# CONFIG_MEDIA_SUPPORT is not set
+
+#
+# Graphics support
+#
+# CONFIG_DRM is not set
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
+# CONFIG_FB is not set
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+# CONFIG_LCD_CLASS_DEVICE is not set
+CONFIG_BACKLIGHT_CLASS_DEVICE=m
+# CONFIG_BACKLIGHT_GENERIC is not set
+# CONFIG_BACKLIGHT_PWM is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
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
+# CONFIG_USB_DEVICEFS is not set
+# CONFIG_USB_DEVICE_CLASS is not set
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_SUSPEND is not set
+# CONFIG_USB_OTG_WHITELIST is not set
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set
+# CONFIG_USB_MON is not set
+# CONFIG_USB_WUSB_CBAF is not set
+
+#
+# USB Host Controller Drivers
+#
+# CONFIG_USB_C67X00_HCD is not set
+# CONFIG_USB_OXU210HP_HCD is not set
+# CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_ISP1362_HCD is not set
+# CONFIG_USB_OHCI_HCD is not set
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
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
+# CONFIG_USB_LIBUSUAL is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+
+#
+# USB port drivers
+#
+# CONFIG_USB_SERIAL is not set
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
+# CONFIG_USB_LED is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
+# CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
+CONFIG_USB_APPLEDISPLAY=m
+CONFIG_USB_LD=m
+CONFIG_USB_TRANCEVIBRATOR=m
+CONFIG_USB_IOWARRIOR=m
+CONFIG_USB_TEST=m
+# CONFIG_USB_ISIGHTFW is not set
+# CONFIG_USB_YUREX is not set
+# CONFIG_USB_GADGET is not set
+
+#
+# OTG and related infrastructure
+#
+# CONFIG_USB_GPIO_VBUS is not set
+# CONFIG_USB_ULPI is not set
+# CONFIG_NOP_USB_XCEIV is not set
+# CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
+# CONFIG_NEW_LEDS is not set
+# CONFIG_NFC_DEVICES is not set
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
+# CONFIG_RTC_INTF_PROC is not set
+CONFIG_RTC_INTF_DEV=y
+# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
+# CONFIG_RTC_DRV_TEST is not set
+
+#
+# SPI RTC drivers
+#
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
+CONFIG_RTC_DRV_S3C=y
+# CONFIG_DMADEVICES is not set
+# CONFIG_AUXDISPLAY is not set
+# CONFIG_UIO is not set
+# CONFIG_STAGING is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
+CONFIG_EXT3_FS=y
+# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+# CONFIG_EXT3_FS_XATTR is not set
+# CONFIG_EXT4_FS is not set
+CONFIG_JBD=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_FILE_LOCKING is not set
+# CONFIG_FSNOTIFY is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_INOTIFY_USER is not set
+# CONFIG_FANOTIFY is not set
+# CONFIG_QUOTA is not set
+# CONFIG_QUOTACTL is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# Caches
+#
+# CONFIG_FSCACHE is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+CONFIG_ISO9660_FS=y
+CONFIG_JOLIET=y
+# CONFIG_ZISOFS is not set
+CONFIG_UDF_FS=m
+CONFIG_UDF_NLS=y
+
+#
+# DOS/FAT/NT Filesystems
+#
+CONFIG_FAT_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+CONFIG_NTFS_FS=m
+# CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+# CONFIG_PROC_SYSCTL is not set
+# CONFIG_PROC_PAGE_MONITOR is not set
+# CONFIG_SYSFS is not set
+# CONFIG_TMPFS is not set
+# CONFIG_HUGETLB_PAGE is not set
+# CONFIG_CONFIGFS_FS is not set
+CONFIG_MISC_FILESYSTEMS=y
+# CONFIG_HFSPLUS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
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
+# CONFIG_PSTORE is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+CONFIG_NETWORK_FILESYSTEMS=y
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_CODEPAGE_737=m
+CONFIG_NLS_CODEPAGE_775=m
+CONFIG_NLS_CODEPAGE_850=y
+CONFIG_NLS_CODEPAGE_852=m
+CONFIG_NLS_CODEPAGE_855=m
+CONFIG_NLS_CODEPAGE_857=m
+CONFIG_NLS_CODEPAGE_860=m
+CONFIG_NLS_CODEPAGE_861=m
+CONFIG_NLS_CODEPAGE_862=m
+CONFIG_NLS_CODEPAGE_863=m
+CONFIG_NLS_CODEPAGE_864=m
+CONFIG_NLS_CODEPAGE_865=m
+CONFIG_NLS_CODEPAGE_866=m
+CONFIG_NLS_CODEPAGE_869=m
+CONFIG_NLS_CODEPAGE_936=m
+CONFIG_NLS_CODEPAGE_950=m
+CONFIG_NLS_CODEPAGE_932=m
+CONFIG_NLS_CODEPAGE_949=m
+CONFIG_NLS_CODEPAGE_874=m
+CONFIG_NLS_ISO8859_8=m
+CONFIG_NLS_CODEPAGE_1250=m
+CONFIG_NLS_CODEPAGE_1251=m
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_ISO8859_2=m
+CONFIG_NLS_ISO8859_3=m
+CONFIG_NLS_ISO8859_4=m
+CONFIG_NLS_ISO8859_5=m
+CONFIG_NLS_ISO8859_6=m
+CONFIG_NLS_ISO8859_7=m
+CONFIG_NLS_ISO8859_9=m
+CONFIG_NLS_ISO8859_13=m
+CONFIG_NLS_ISO8859_14=m
+CONFIG_NLS_ISO8859_15=m
+CONFIG_NLS_KOI8_R=m
+CONFIG_NLS_KOI8_U=m
+CONFIG_NLS_UTF8=m
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+CONFIG_DEFAULT_MESSAGE_LOGLEVEL=4
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_FRAME_WARN=1024
+# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_STRIP_ASM_SYMS is not set
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
+# CONFIG_DEBUG_SECTION_MISMATCH is not set
+# CONFIG_DEBUG_KERNEL is not set
+# CONFIG_HARDLOCKUP_DETECTOR is not set
+# CONFIG_SPARSE_RCU_POINTER is not set
+CONFIG_DEBUG_BUGVERBOSE=y
+# CONFIG_DEBUG_MEMORY_INIT is not set
+CONFIG_FRAME_POINTER=y
+CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
+CONFIG_HAVE_DYNAMIC_FTRACE=y
+CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
+CONFIG_HAVE_C_RECORDMCOUNT=y
+CONFIG_TRACING_SUPPORT=y
+# CONFIG_FTRACE is not set
+# CONFIG_DMA_API_DEBUG is not set
+# CONFIG_ATOMIC64_SELFTEST is not set
+# CONFIG_SAMPLES is not set
+CONFIG_HAVE_ARCH_KGDB=y
+# CONFIG_TEST_KSTRTOX is not set
+# CONFIG_STRICT_DEVMEM is not set
+# CONFIG_DEBUG_USER is not set
+# CONFIG_OC_ETM is not set
+CONFIG_DEBUG_S3C_UART=0
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY_DMESG_RESTRICT is not set
+# CONFIG_SECURITYFS is not set
+CONFIG_DEFAULT_SECURITY_DAC=y
+CONFIG_DEFAULT_SECURITY=""
+CONFIG_CRYPTO=m
+
+#
+# Crypto core or helper
+#
+CONFIG_CRYPTO_ALGAPI=m
+CONFIG_CRYPTO_ALGAPI2=m
+CONFIG_CRYPTO_AEAD=m
+CONFIG_CRYPTO_AEAD2=m
+CONFIG_CRYPTO_BLKCIPHER=m
+CONFIG_CRYPTO_BLKCIPHER2=m
+CONFIG_CRYPTO_HASH=m
+CONFIG_CRYPTO_HASH2=m
+CONFIG_CRYPTO_RNG2=m
+CONFIG_CRYPTO_PCOMP2=m
+CONFIG_CRYPTO_MANAGER=m
+CONFIG_CRYPTO_MANAGER2=m
+CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
+# CONFIG_CRYPTO_GF128MUL is not set
+# CONFIG_CRYPTO_NULL is not set
+CONFIG_CRYPTO_WORKQUEUE=m
+# CONFIG_CRYPTO_CRYPTD is not set
+CONFIG_CRYPTO_AUTHENC=m
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
+CONFIG_CRYPTO_CBC=m
+# CONFIG_CRYPTO_CTR is not set
+# CONFIG_CRYPTO_CTS is not set
+CONFIG_CRYPTO_ECB=m
+# CONFIG_CRYPTO_PCBC is not set
+
+#
+# Hash modes
+#
+CONFIG_CRYPTO_HMAC=m
+
+#
+# Digest
+#
+CONFIG_CRYPTO_CRC32C=m
+# CONFIG_CRYPTO_GHASH is not set
+CONFIG_CRYPTO_MD4=m
+CONFIG_CRYPTO_MD5=m
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_RMD128 is not set
+# CONFIG_CRYPTO_RMD160 is not set
+# CONFIG_CRYPTO_RMD256 is not set
+# CONFIG_CRYPTO_RMD320 is not set
+CONFIG_CRYPTO_SHA1=m
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
+CONFIG_CRYPTO_ARC4=m
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+CONFIG_CRYPTO_DES=m
+# CONFIG_CRYPTO_FCRYPT is not set
+# CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_SEED is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+
+#
+# Compression
+#
+CONFIG_CRYPTO_DEFLATE=m
+# CONFIG_CRYPTO_ZLIB is not set
+# CONFIG_CRYPTO_LZO is not set
+
+#
+# Random Number Generation
+#
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
+# CONFIG_CRYPTO_USER_API_HASH is not set
+# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
+CONFIG_CRYPTO_HW=y
+# CONFIG_BINARY_PRINTF is not set
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=y
+# CONFIG_CRC_CCITT is not set
+CONFIG_CRC16=m
+# CONFIG_CRC_T10DIF is not set
+CONFIG_CRC_ITU_T=m
+CONFIG_CRC32=y
+CONFIG_CRC7=m
+CONFIG_LIBCRC32C=m
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+# CONFIG_XZ_DEC is not set
+# CONFIG_XZ_DEC_BCJ is not set
+CONFIG_DECOMPRESS_GZIP=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_DMA=y
+CONFIG_NLATTR=y
+CONFIG_GENERIC_ATOMIC64=y
+# CONFIG_AVERAGE is not set
diff --git a/arch/arm/mach-s3c2410/Kconfig b/arch/arm/mach-s3c2410/Kconfig
index 7245a55..2d5c1b3 100644
--- a/arch/arm/mach-s3c2410/Kconfig
+++ b/arch/arm/mach-s3c2410/Kconfig
@@ -178,4 +178,10 @@ config MACH_QT2410
 	help
 	   Say Y here if you are using the Armzone QT2410
 
+config MACH_W5300E01
+	bool "W5300E01-ARM Board"
+	select CPU_S3C2410
+	help
+	  Say Y here if you are using the W5300E01-ARM board
+
 endmenu
diff --git a/arch/arm/mach-s3c2410/Makefile b/arch/arm/mach-s3c2410/Makefile
index 8169535..f603edd 100644
--- a/arch/arm/mach-s3c2410/Makefile
+++ b/arch/arm/mach-s3c2410/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_BAST_PC104_IRQ)	+= bast-irq.o
 obj-$(CONFIG_MACH_TCT_HAMMER)	+= mach-tct_hammer.o
 obj-$(CONFIG_MACH_VR1000)	+= mach-vr1000.o usb-simtec.o
 obj-$(CONFIG_MACH_QT2410)	+= mach-qt2410.o
+obj-$(CONFIG_MACH_QT2410)	+= mach-w5300e01.o
 
 # Common bits of machine support
 
diff --git a/arch/arm/mach-s3c2410/mach-w5300e01.c b/arch/arm/mach-s3c2410/mach-w5300e01.c
new file mode 100644
index 0000000..9d57c3a
--- /dev/null
+++ b/arch/arm/mach-s3c2410/mach-w5300e01.c
@@ -0,0 +1,198 @@
+/* linux/arch/arm/mach-s3c2410/mach-w5300e01.c
+ *
+ * Copyright (C) 2011 WIZnet, Inc.
+ * Authors: Taehun Kim <kth3321@gmail.com>, Suhwan Kim <suhwan@wiznet.co.kr>
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ *
+ * @History:
+ * derived from linux/arch/arm/mach-s3c2410/mach-bast.c, written by
+ * Ben Dooks <ben@simtec.co.uk>
+ *
+ ***********************************************************************/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/timer.h>
+#include <linux/init.h>
+#include <linux/serial_core.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/map.h>
+#include <linux/mtd/partitions.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/irq.h>
+#include <asm/mach-types.h>
+
+#include <mach/regs-gpio.h>
+#include <plat/gpio-cfg.h>
+#include <plat/cpu.h>
+#include <plat/devs.h>
+#include <plat/regs-serial.h>
+#include <plat/nand.h>
+#include <plat/pm.h>
+
+static struct map_desc w5300e01_iodesc[] __initdata = {
+	/* Character LCD register map. */
+	{ 0xf8000000, __phys_to_pfn(S3C2410_CS3), SZ_1M, MT_DEVICE }
+};
+
+#define UCON S3C2410_UCON_DEFAULT
+#define ULCON (S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB)
+#define UFCON (S3C2410_UFCON_RXTRIG8 | S3C2410_UFCON_FIFOMODE)
+
+static struct s3c2410_uartcfg w5300e01_uartcfgs[] __initdata = {
+	[0] = {
+		.hwport	     = 0,
+		.flags	     = 0,
+		.ucon	     = UCON,
+		.ulcon	     = ULCON,
+		.ufcon	     = UFCON,
+	},
+	[1] = {
+		.hwport	     = 1,
+		.flags	     = 0,
+		.ucon	     = UCON,
+		.ulcon	     = ULCON,
+		.ufcon	     = UFCON,
+	},
+	[2] = {
+		.hwport	     = 2,
+		.flags	     = 0,
+		.ucon	     = UCON,
+		.ulcon	     = ULCON,
+		.ufcon	     = UFCON,
+	}
+};
+
+static struct mtd_partition w5300e01_mtd_partitions[] = {
+	[0] = {
+		.name	= "Bootloader",
+		.size	= 0x20000,
+		.offset	= 0,
+		.mask_flags = MTD_WRITEABLE,
+	},
+	[1] = {
+		.name	= "Boot Param",
+		.size	= 0x20000,
+		.offset	= MTDPART_OFS_APPEND,
+	},
+	[2] = {
+		.name	= "Kernel",
+		.size	= 0x3C0000,
+		.offset	= MTDPART_OFS_APPEND,
+	},
+	[3] = {
+		.name	= "Ramdisk",
+		.size	= 0x1000000,
+		.offset	= MTDPART_OFS_APPEND,
+	},
+	[4] = {
+		.name	= "JFFS2 FileSystem",
+		.size	= MTDPART_SIZ_FULL,
+		.offset	= MTDPART_OFS_APPEND,
+	},
+};
+
+static struct resource w5300_resources[] = {
+	[0] = {
+		.start  = S3C2410_CS2,
+		.end    = S3C2410_CS2 + SZ_1M,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = IRQ_EINT0,
+		.end    = IRQ_EINT0,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device w5300_device = {
+	.name       = "w5300",
+	.num_resources  = ARRAY_SIZE(w5300_resources),
+	.resource   = w5300_resources,
+};
+
+static struct s3c2410_nand_set w5300e01_nand_sets[] = {
+	[0] = {
+		.name		    = "W5300E01",
+		.nr_chips	    = 1,
+		.nr_partitions	= ARRAY_SIZE(w5300e01_mtd_partitions),
+		.partitions	    = w5300e01_mtd_partitions,
+	},
+};
+
+static struct s3c2410_platform_nand w5300e01_nand_info = {
+	.tacls		    = 20,
+	.twrph0		    = 60,
+	.twrph1		    = 30,
+	.nr_sets	    = ARRAY_SIZE(w5300e01_nand_sets),
+	.sets		    = w5300e01_nand_sets,
+};
+
+static struct platform_device *w5300e01_devices[] __initdata = {
+	&s3c_device_nand,
+	&s3c_device_usbgadget,
+	&s3c_device_wdt,
+	&s3c_device_i2c0,
+	&s3c_device_iis,
+	&w5300_device,
+};
+
+static void __init w5300e01_map_io(void)
+{
+	s3c24xx_init_io(w5300e01_iodesc, ARRAY_SIZE(w5300e01_iodesc));
+	s3c24xx_init_clocks(0);
+	s3c24xx_init_uarts(w5300e01_uartcfgs, ARRAY_SIZE(w5300e01_uartcfgs));
+}
+
+static void __init w5300e01_init(void)
+{
+	s3c_nand_set_platdata(&w5300e01_nand_info);
+	platform_add_devices(w5300e01_devices, ARRAY_SIZE(w5300e01_devices));
+
+	/* W5300 interrupt pin. */
+	s3c2410_gpio_cfgpin(S3C2410_GPF(0), S3C2410_GPIO_IRQ);
+
+	s3c2410_gpio_cfgpin(S3C2410_GPF(4), S3C2410_GPIO_OUTPUT);
+	s3c2410_gpio_cfgpin(S3C2410_GPF(5), S3C2410_GPIO_OUTPUT);
+	s3c2410_gpio_cfgpin(S3C2410_GPF(6), S3C2410_GPIO_OUTPUT);
+	s3c2410_gpio_cfgpin(S3C2410_GPF(7), S3C2410_GPIO_OUTPUT);
+
+	s3c2410_gpio_setpin(S3C2410_GPF(0), 1);
+	s3c2410_gpio_setpin(S3C2410_GPF(4), 1);
+	s3c2410_gpio_setpin(S3C2410_GPF(5), 1);
+	s3c2410_gpio_setpin(S3C2410_GPF(6), 1);
+	s3c2410_gpio_setpin(S3C2410_GPF(7), 1);
+
+	s3c_pm_init();
+}
+
+MACHINE_START(W5300E01, "WIZnet W5300E01-ARM")
+	.boot_params	= S3C2410_SDRAM_PA + 0x100,
+	.map_io		= w5300e01_map_io,
+	.init_irq	= s3c24xx_init_irq,
+	.init_machine	= w5300e01_init,
+	.timer		= &s3c24xx_timer,
+MACHINE_END
-- 
1.7.1
