From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 27 Jun 2012 06:49:41 +0300
Subject: [PATCH v11 0/4] MTD: at91: Add PMECC support for at91 nand
 flash driver
In-Reply-To: <1340618866-28776-1-git-send-email-josh.wu@atmel.com>
References: <1340618866-28776-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1340768981.2317.7.camel@koala>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-06-25 at 18:07 +0800, Josh Wu wrote:
> Those patches is based on v3.5-rc4
> 
> Changes since v10,
> 	add one more patch in this patch set, which add 'int' return value for write_page()/write_page_raw() functions in structure of nand_ecc_ctrl.
> 	Instead of calling BUG(), atmel_nand_pmecc_write_page() will return -EIO when time out to read the pmecc status register.
> 	increase the time-out duration to 100ms, which has more toleration.
> 	add oob_required argument for pmecc read/write functions to align with v3.5-rc4.

I have issues compiling l2-mtd.git tree (based on 3.5-rc5) with the
attached defconfig. Probably not your fault, but may be you have a
fix/suggestion? I did not have time to look closer. Aiaiai reports:

Failed to build the following commit for configuration "arm-at91cap9_defconfig" (architecture arm)":

bb6ac5c Quick fixes - applied by aiaiai

include/linux/math64.h:55:15: note: each undeclared identifier is reported only once for each function it appears in
In file included from include/linux/mm_types.h:16:0,
                 from include/linux/sched.h:64,
                 from arch/arm/kernel/asm-offsets.c:13:
arch/arm/include/asm/page.h: At top level:
arch/arm/include/asm/page.h:107:2: error: #error Unknown user operations model
In file included from include/linux/mm.h:44:0,
                 from arch/arm/kernel/asm-offsets.c:14:
arch/arm/include/asm/pgtable.h:198:5: warning: "__LINUX_ARM_ARCH__" is not defined [-Wundef]
In file included from arch/arm/include/asm/cacheflush.h:15:0,
                 from arch/arm/kernel/asm-offsets.c:16:
arch/arm/include/asm/glue-cache.h:129:2: error: #error Unknown cache maintenance model
In file included from arch/arm/include/asm/cacheflush.h:17:0,
                 from arch/arm/kernel/asm-offsets.c:16:
arch/arm/include/asm/cachetype.h:28:5: warning: "__LINUX_ARM_ARCH__" is not defined [-Wundef]
arch/arm/include/asm/cachetype.h:33:7: warning: "__LINUX_ARM_ARCH__" is not defined [-Wundef]
In file included from arch/arm/kernel/asm-offsets.c:16:0:
arch/arm/include/asm/cacheflush.h:194:7: warning: "__LINUX_ARM_ARCH__" is not defined [-Wundef]
arch/arm/include/asm/cacheflush.h:196:7: warning: "__LINUX_ARM_ARCH__" is not defined [-Wundef]
In file included from arch/arm/kernel/asm-offsets.c:17:0:
arch/arm/include/asm/glue-df.h:99:2: error: #error Unknown data abort handler type
In file included from arch/arm/kernel/asm-offsets.c:18:0:
arch/arm/include/asm/glue-pf.h:54:2: error: #error Unknown prefetch abort handler type
make[2]: *** [arch/arm/kernel/asm-offsets.s] Error 1



-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
CONFIG_EXPERIMENTAL=y
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_LOG_BUF_SHIFT=18
CONFIG_CGROUPS=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CPUSETS=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_RESOURCE_COUNTERS=y
CONFIG_CGROUP_SCHED=y
CONFIG_BLK_DEV_INITRD=y
# CONFIG_COMPAT_BRK is not set
CONFIG_PROFILING=y
CONFIG_KPROBES=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
CONFIG_MAC_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_SGI_PARTITION=y
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
CONFIG_ARCH_AT91=y
CONFIG_MACH_ONEARM=y
CONFIG_ARCH_AT91RM9200DK=y
CONFIG_MACH_AT91RM9200EK=y
CONFIG_MACH_CSB337=y
CONFIG_MACH_CSB637=y
CONFIG_MACH_CARMEVA=y
CONFIG_MACH_ATEB9200=y
CONFIG_MACH_KB9200=y
CONFIG_MACH_PICOTUX2XX=y
CONFIG_MACH_KAFA=y
CONFIG_MACH_ECBAT91=y
CONFIG_MACH_YL9200=y
CONFIG_MACH_CPUAT91=y
CONFIG_MACH_ECO920=y
CONFIG_MACH_RSI_EWS=y
CONFIG_MTD_AT91_DATAFLASH_CARD=y
CONFIG_AT91_PROGRAMMABLE_CLOCKS=y
CONFIG_PCCARD=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_PREEMPT_VOLUNTARY=y
CONFIG_USE_OF=y
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
CONFIG_BINFMT_MISC=y
# CONFIG_SUSPEND is not set
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_DEBUG_DEVRES=y
CONFIG_MTD=y
CONFIG_MTD_TESTS=m
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
CONFIG_MTD_REDBOOT_PARTS_READONLY=y
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_AFS_PARTS=y
CONFIG_MTD_OF_PARTS=y
CONFIG_MTD_AR7_PARTS=m
CONFIG_MTD_CHAR=y
CONFIG_MTD_BLOCK=y
CONFIG_FTL=m
CONFIG_NFTL=m
CONFIG_NFTL_RW=y
CONFIG_INFTL=m
CONFIG_RFD_FTL=m
CONFIG_SSFDC=y
CONFIG_SM_FTL=m
CONFIG_MTD_OOPS=m
CONFIG_MTD_SWAP=y
CONFIG_MTD_CFI=m
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_CFI_GEOMETRY=y
# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
CONFIG_MTD_MAP_BANK_WIDTH_16=y
# CONFIG_MTD_CFI_I1 is not set
CONFIG_MTD_CFI_I4=y
CONFIG_MTD_OTP=y
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=m
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_ROM=m
CONFIG_MTD_ABSENT=m
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=m
CONFIG_MTD_PHYSMAP_COMPAT=y
CONFIG_MTD_PHYSMAP_OF=m
CONFIG_MTD_IMPA7=m
CONFIG_MTD_PCMCIA=m
CONFIG_MTD_PCMCIA_ANONYMOUS=y
CONFIG_MTD_GPIO_ADDR=y
CONFIG_MTD_PLATRAM=y
CONFIG_MTD_LATCH_ADDR=m
CONFIG_MTD_DATAFLASH=m
CONFIG_MTD_DATAFLASH_WRITE_VERIFY=y
CONFIG_MTD_DATAFLASH_OTP=y
CONFIG_MTD_M25P80=m
CONFIG_MTD_SST25L=m
CONFIG_MTD_SLRAM=y
CONFIG_MTD_PHRAM=y
CONFIG_MTD_MTDRAM=y
CONFIG_MTD_BLOCK2MTD=m
CONFIG_MTD_DOC2000=m
CONFIG_MTD_DOC2001=m
CONFIG_MTD_DOC2001PLUS=m
CONFIG_MTD_DOCG3=m
CONFIG_MTD_DOCPROBE_ADVANCED=y
CONFIG_MTD_DOCPROBE_HIGH=y
CONFIG_MTD_NAND_ECC_SMC=y
CONFIG_MTD_NAND=y
CONFIG_MTD_NAND_VERIFY_WRITE=y
CONFIG_MTD_NAND_ECC_BCH=y
CONFIG_MTD_NAND_MUSEUM_IDS=y
CONFIG_MTD_NAND_GPIO=y
CONFIG_MTD_NAND_DISKONCHIP=m
CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y
CONFIG_MTD_NAND_DOCG4=m
CONFIG_MTD_NAND_ATMEL=m
CONFIG_MTD_NAND_NANDSIM=y
CONFIG_MTD_NAND_PLATFORM=m
CONFIG_MTD_ALAUDA=m
CONFIG_MTD_ONENAND=y
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
CONFIG_MTD_ONENAND_GENERIC=y
CONFIG_MTD_ONENAND_2X_PROGRAM=y
CONFIG_MTD_ONENAND_SIM=m
CONFIG_MTD_LPDDR=y
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_GLUEBI=m
# CONFIG_BLK_DEV is not set
CONFIG_INPUT_FF_MEMLESS=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_SERIO is not set
CONFIG_VT_HW_CONSOLE_BINDING=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_DEVKMEM is not set
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
CONFIG_SERIAL_8250_RSA=y
# CONFIG_HW_RANDOM is not set
CONFIG_SPI=y
# CONFIG_HWMON is not set
CONFIG_DRM=y
# CONFIG_HID_SUPPORT is not set
CONFIG_USB=m
# CONFIG_IOMMU_SUPPORT is not set
CONFIG_QUOTA=y
# CONFIG_PRINT_QUOTA_WARNING is not set
CONFIG_QFMT_V2=y
CONFIG_JFFS2_FS=y
# CONFIG_JFFS2_FS_WRITEBUFFER is not set
CONFIG_JFFS2_COMPRESSION_OPTIONS=y
CONFIG_JFFS2_LZO=y
CONFIG_JFFS2_RUBIN=y
CONFIG_JFFS2_CMODE_FAVOURLZO=y
CONFIG_UBIFS_FS=m
CONFIG_UBIFS_FS_ADVANCED_COMPR=y
# CONFIG_UBIFS_FS_ZLIB is not set
CONFIG_UBIFS_FS_DEBUG=y
CONFIG_LOGFS=m
CONFIG_CRAMFS=m
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_UTF8=y
CONFIG_PRINTK_TIME=y
# CONFIG_ENABLE_WARN_DEPRECATED is not set
CONFIG_FRAME_WARN=2048
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_KERNEL=y
# CONFIG_SCHED_DEBUG is not set
CONFIG_SCHEDSTATS=y
CONFIG_TIMER_STATS=y
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_CRYPTO=y
# CONFIG_CRYPTO_ANSI_CPRNG is not set
# CONFIG_CRYPTO_HW is not set
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120627/4d2aff94/attachment.sig>
