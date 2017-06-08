From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu,  8 Jun 2017 18:10:13 +0200
Subject: [PATCH 02/35] MIPS: defconfig: Cleanup from old Kconfig options
In-Reply-To: <20170608160836.12196-1-krzk@kernel.org>
References: <20170608160836.12196-1-krzk@kernel.org>
Message-ID: <20170608161049.12421-2-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove old, dead Kconfig options (in order appearing in this commit):
 - EXPERIMENTAL is gone since v3.9;
 - INET_LRO: commit 7bbf3cae65b6 ("ipv4: Remove inet_lro library");
 - MTD_CONCAT: commit f53fdebcc3e1 ("mtd: drop MTD_CONCAT from Kconfig
   entirely");
 - MTD_CHAR: commit 660685d9d1b4 ("mtd: merge mtdchar module with
   mtdcore");
 - NETDEV_1000 and NETDEV_10000: commit f860b0522f65 ("drivers/net:
   Kconfig and Makefile cleanup"); NET_ETHERNET should be replaced with
   just ETHERNET but that is separate change;
 - MISC_DEVICES: commit 7c5763b8453a ("drivers: misc: Remove
   MISC_DEVICES config option");
 - HID_SUPPORT: commit 1f41a6a99476 ("HID: Fix the generic Kconfig
   options");
 - BT_L2CAP and BT_SCO: commit f1e91e1640d8 ("Bluetooth: Always compile
   SCO and L2CAP in Bluetooth Core");
 - DEBUG_ERRORS: commit b025a3f836d1 ("ARM: 6876/1: Kconfig.debug:
   Remove unused CONFIG_DEBUG_ERRORS");
 - USB_DEVICE_CLASS: commit 007bab91324e ("USB: remove
   CONFIG_USB_DEVICE_CLASS");
 - RCU_CPU_STALL_DETECTOR: commit a00e0d714fbd ("rcu: Remove conditional
   compilation for RCU CPU stall warnings");
 - IP_NF_QUEUE: commit 3dd6664fac7e ("netfilter: remove unused "config
   IP_NF_QUEUE"");
 - IP_NF_TARGET_ULOG: commit d4da843e6fad ("netfilter: kill remnants of
   ulog targets");
 - IP6_NF_QUEUE: commit d16cf20e2f2f ("netfilter: remove ip_queue
   support");
 - IP6_NF_TARGET_LOG: commit 6939c33a757b ("netfilter: merge ipt_LOG and
   ip6_LOG into xt_LOG");
 - USB_LED: commit a335aaf3125c ("usb: misc: remove outdated USB LED
   driver");
 - MMC_UNSAFE_RESUME: commit 2501c9179dff ("mmc: core: Use
   MMC_UNSAFE_RESUME as default behavior");
 - AUTOFS_FS: commit 561c5cf9236a ("staging: Remove autofs3");
 - VIDEO_OUTPUT_CONTROL: commit f167a64e9d67 ("video / output: Drop
   display output class support");
 - USB_LIBUSUAL: commit f61870ee6f8c ("usb: remove libusual");
 - CRYPTO_ZLIB: 110492183c4b ("crypto: compress - remove unused pcomp
   interface");
 - BLK_DEV_UB: commit 68a5059ecf82 ("block: remove the deprecated ub
   driver");

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/mips/configs/ar7_defconfig             |  6 ------
 arch/mips/configs/ath79_defconfig           |  2 --
 arch/mips/configs/bcm63xx_defconfig         |  7 -------
 arch/mips/configs/bigsur_defconfig          |  4 ----
 arch/mips/configs/bmips_be_defconfig        |  1 -
 arch/mips/configs/capcella_defconfig        |  4 ----
 arch/mips/configs/cavium_octeon_defconfig   |  1 -
 arch/mips/configs/ci20_defconfig            |  1 -
 arch/mips/configs/cobalt_defconfig          |  8 --------
 arch/mips/configs/decstation_defconfig      |  1 -
 arch/mips/configs/e55_defconfig             |  2 --
 arch/mips/configs/fuloong2e_defconfig       | 11 -----------
 arch/mips/configs/gpr_defconfig             |  8 --------
 arch/mips/configs/ip22_defconfig            | 11 -----------
 arch/mips/configs/ip27_defconfig            |  5 -----
 arch/mips/configs/ip28_defconfig            |  5 -----
 arch/mips/configs/ip32_defconfig            |  8 --------
 arch/mips/configs/jazz_defconfig            |  6 ------
 arch/mips/configs/jmr3927_defconfig         |  7 -------
 arch/mips/configs/lasat_defconfig           |  5 -----
 arch/mips/configs/lemote2f_defconfig        | 12 ------------
 arch/mips/configs/loongson3_defconfig       |  3 ---
 arch/mips/configs/malta_kvm_defconfig       |  1 -
 arch/mips/configs/malta_kvm_guest_defconfig |  1 -
 arch/mips/configs/malta_qemu_32r6_defconfig |  1 -
 arch/mips/configs/maltaaprp_defconfig       |  2 --
 arch/mips/configs/maltasmvp_defconfig       |  1 -
 arch/mips/configs/maltasmvp_eva_defconfig   |  2 --
 arch/mips/configs/maltaup_defconfig         |  2 --
 arch/mips/configs/markeins_defconfig        |  4 ----
 arch/mips/configs/mips_paravirt_defconfig   |  1 -
 arch/mips/configs/mpc30x_defconfig          |  5 -----
 arch/mips/configs/msp71xx_defconfig         |  2 --
 arch/mips/configs/mtx1_defconfig            | 11 -----------
 arch/mips/configs/nlm_xlp_defconfig         |  5 -----
 arch/mips/configs/nlm_xlr_defconfig         |  9 ---------
 arch/mips/configs/pnx8335_stb225_defconfig  |  7 -------
 arch/mips/configs/qi_lb60_defconfig         |  3 ---
 arch/mips/configs/rb532_defconfig           |  6 ------
 arch/mips/configs/rbtx49xx_defconfig        |  7 -------
 arch/mips/configs/rm200_defconfig           |  8 --------
 arch/mips/configs/rt305x_defconfig          |  2 --
 arch/mips/configs/sb1250_swarm_defconfig    |  1 -
 arch/mips/configs/tb0219_defconfig          |  6 ------
 arch/mips/configs/tb0226_defconfig          |  7 -------
 arch/mips/configs/tb0287_defconfig          |  5 -----
 arch/mips/configs/workpad_defconfig         |  4 ----
 47 files changed, 221 deletions(-)

diff --git a/arch/mips/configs/ar7_defconfig b/arch/mips/configs/ar7_defconfig
index 320772caf054..92fca3c42eac 100644
--- a/arch/mips/configs/ar7_defconfig
+++ b/arch/mips/configs/ar7_defconfig
@@ -3,7 +3,6 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_HZ_100=y
 CONFIG_KEXEC=y
 # CONFIG_SECCOMP is not set
-CONFIG_EXPERIMENTAL=y
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_KERNEL_LZMA=y
 CONFIG_SYSVIPC=y
@@ -41,7 +40,6 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_INET_DIAG is not set
 CONFIG_TCP_CONG_ADVANCED=y
 # CONFIG_TCP_CONG_BIC is not set
@@ -86,7 +84,6 @@ CONFIG_MAC80211_RC_DEFAULT_PID=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FIRMWARE_IN_KERNEL is not set
 CONFIG_MTD=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
@@ -99,8 +96,6 @@ CONFIG_FIXED_PHY=y
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
 CONFIG_CPMAC=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
 CONFIG_PPP=m
 CONFIG_PPP_MULTILINK=y
 CONFIG_PPP_FILTER=y
@@ -142,7 +137,6 @@ CONFIG_BSD_DISKLABEL=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
-CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="rootfstype=squashfs,jffs2"
 CONFIG_CRYPTO=y
diff --git a/arch/mips/configs/ath79_defconfig b/arch/mips/configs/ath79_defconfig
index 134879c1310a..25ed914933e5 100644
--- a/arch/mips/configs/ath79_defconfig
+++ b/arch/mips/configs/ath79_defconfig
@@ -7,7 +7,6 @@ CONFIG_ATH79_MACH_PB44=y
 CONFIG_ATH79_MACH_UBNT_XM=y
 CONFIG_HZ_100=y
 # CONFIG_SECCOMP is not set
-CONFIG_EXPERIMENTAL=y
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -35,7 +34,6 @@ CONFIG_IP_ADVANCED_ROUTER=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_CFG80211=m
 CONFIG_MAC80211=m
diff --git a/arch/mips/configs/bcm63xx_defconfig b/arch/mips/configs/bcm63xx_defconfig
index 5599a9f1e3c6..131b350f014f 100644
--- a/arch/mips/configs/bcm63xx_defconfig
+++ b/arch/mips/configs/bcm63xx_defconfig
@@ -5,7 +5,6 @@ CONFIG_BCM63XX_CPU_6348=y
 CONFIG_BCM63XX_CPU_6358=y
 CONFIG_NO_HZ=y
 # CONFIG_SECCOMP is not set
-CONFIG_EXPERIMENTAL=y
 # CONFIG_LOCALVERSION_AUTO is not set
 # CONFIG_SWAP is not set
 CONFIG_TINY_RCU=y
@@ -33,7 +32,6 @@ CONFIG_INET=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_CFG80211=y
@@ -50,13 +48,10 @@ CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP=y
 # CONFIG_BLK_DEV is not set
-# CONFIG_MISC_DEVICES is not set
 CONFIG_NETDEVICES=y
 CONFIG_BCM63XX_PHY=y
 CONFIG_NET_ETHERNET=y
 CONFIG_BCM63XX_ENET=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
 CONFIG_B43=y
 # CONFIG_B43_PHY_LP is not set
 # CONFIG_INPUT is not set
@@ -70,7 +65,6 @@ CONFIG_SERIAL_BCM63XX_CONSOLE=y
 # CONFIG_HWMON is not set
 # CONFIG_VGA_ARB is not set
 CONFIG_USB=y
-# CONFIG_USB_DEVICE_CLASS is not set
 CONFIG_USB_EHCI_HCD=y
 # CONFIG_USB_EHCI_TT_NEWSCHED is not set
 CONFIG_USB_OHCI_HCD=y
@@ -84,7 +78,6 @@ CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_PROC_KCORE=y
 # CONFIG_NETWORK_FILESYSTEMS is not set
 CONFIG_MAGIC_SYSRQ=y
-CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="console=ttyS0,115200"
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/mips/configs/bigsur_defconfig b/arch/mips/configs/bigsur_defconfig
index d20b09d77b53..a55009edbb29 100644
--- a/arch/mips/configs/bigsur_defconfig
+++ b/arch/mips/configs/bigsur_defconfig
@@ -4,7 +4,6 @@ CONFIG_SMP=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_HZ_1000=y
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_BSD_PROCESS_ACCT=y
@@ -60,7 +59,6 @@ CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
 CONFIG_INET_XFRM_MODE_TRANSPORT=m
 CONFIG_INET_XFRM_MODE_TUNNEL=m
-# CONFIG_INET_LRO is not set
 CONFIG_TCP_MD5SIG=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_IPV6_ROUTE_INFO=y
@@ -182,7 +180,6 @@ CONFIG_QUOTA=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
 # CONFIG_PRINT_QUOTA_WARNING is not set
 CONFIG_QFMT_V2=m
-CONFIG_AUTOFS_FS=m
 CONFIG_AUTOFS4_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_ISO9660_FS=m
@@ -284,7 +281,6 @@ CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
-CONFIG_CRYPTO_ZLIB=m
 CONFIG_CRYPTO_LZO=m
 CONFIG_CRC_T10DIF=m
 CONFIG_CRC7=m
diff --git a/arch/mips/configs/bmips_be_defconfig b/arch/mips/configs/bmips_be_defconfig
index acf7785c4cdb..a7072a14d396 100644
--- a/arch/mips/configs/bmips_be_defconfig
+++ b/arch/mips/configs/bmips_be_defconfig
@@ -23,7 +23,6 @@ CONFIG_INET=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_INET_DIAG is not set
 CONFIG_CFG80211=y
 CONFIG_NL80211_TESTMODE=y
diff --git a/arch/mips/configs/capcella_defconfig b/arch/mips/configs/capcella_defconfig
index 2924ba34a01b..bd80b5c852dd 100644
--- a/arch/mips/configs/capcella_defconfig
+++ b/arch/mips/configs/capcella_defconfig
@@ -1,6 +1,5 @@
 CONFIG_MACH_VR41XX=y
 CONFIG_ZAO_CAPCELLA=y
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
@@ -46,8 +45,6 @@ CONFIG_SMSC_PHY=m
 CONFIG_NET_ETHERNET=y
 CONFIG_NET_PCI=y
 CONFIG_8139TOO=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
@@ -59,7 +56,6 @@ CONFIG_SERIAL_VR41XX_CONSOLE=y
 CONFIG_GPIO_VR41XX=y
 # CONFIG_HWMON is not set
 # CONFIG_VGA_CONSOLE is not set
-# CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_VR41XX=y
diff --git a/arch/mips/configs/cavium_octeon_defconfig b/arch/mips/configs/cavium_octeon_defconfig
index d4fda41f00ba..e5b18f1a31a0 100644
--- a/arch/mips/configs/cavium_octeon_defconfig
+++ b/arch/mips/configs/cavium_octeon_defconfig
@@ -42,7 +42,6 @@ CONFIG_IP_MROUTE=y
 CONFIG_IP_PIMSM_V1=y
 CONFIG_IP_PIMSM_V2=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 CONFIG_IPV6=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
index 43e0ba24470c..b42cfa7865f9 100644
--- a/arch/mips/configs/ci20_defconfig
+++ b/arch/mips/configs/ci20_defconfig
@@ -41,7 +41,6 @@ CONFIG_INET=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
diff --git a/arch/mips/configs/cobalt_defconfig b/arch/mips/configs/cobalt_defconfig
index 23b66934e18d..a9066f300665 100644
--- a/arch/mips/configs/cobalt_defconfig
+++ b/arch/mips/configs/cobalt_defconfig
@@ -1,5 +1,4 @@
 CONFIG_MIPS_COBALT=y
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_RELAY=y
@@ -15,17 +14,14 @@ CONFIG_XFRM_USER=y
 CONFIG_NET_KEY=y
 CONFIG_NET_KEY_MIGRATE=y
 CONFIG_INET=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLKDEVS=y
 CONFIG_MTD_JEDECPROBE=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_BLK_DEV_LOOP=y
-# CONFIG_MISC_DEVICES is not set
 CONFIG_RAID_ATTRS=y
 CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_LOWLEVEL is not set
@@ -36,8 +32,6 @@ CONFIG_NET_ETHERNET=y
 CONFIG_NET_TULIP=y
 CONFIG_DE2104X=y
 CONFIG_TULIP=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
 # CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_KEYBOARD is not set
@@ -56,7 +50,6 @@ CONFIG_FB_COBALT=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_HID=m
 CONFIG_USB=m
-# CONFIG_USB_DEVICE_CLASS is not set
 CONFIG_USB_EHCI_HCD=m
 # CONFIG_USB_EHCI_TT_NEWSCHED is not set
 CONFIG_USB_OHCI_HCD=m
@@ -84,6 +77,5 @@ CONFIG_NFS_V3_ACL=y
 CONFIG_NFSD=y
 CONFIG_NFSD_V3=y
 CONFIG_NFSD_V3_ACL=y
-CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_CRC16=y
 CONFIG_LIBCRC32C=y
diff --git a/arch/mips/configs/decstation_defconfig b/arch/mips/configs/decstation_defconfig
index 2b6cb41d5715..e149f78901f8 100644
--- a/arch/mips/configs/decstation_defconfig
+++ b/arch/mips/configs/decstation_defconfig
@@ -1,6 +1,5 @@
 CONFIG_MACH_DECSTATION=y
 CONFIG_CPU_R3000=y
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
diff --git a/arch/mips/configs/e55_defconfig b/arch/mips/configs/e55_defconfig
index e94d266c4b97..c3ac0209457c 100644
--- a/arch/mips/configs/e55_defconfig
+++ b/arch/mips/configs/e55_defconfig
@@ -1,6 +1,5 @@
 CONFIG_MACH_VR41XX=y
 CONFIG_CASIO_E55=y
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
@@ -28,7 +27,6 @@ CONFIG_SERIAL_VR41XX_CONSOLE=y
 CONFIG_GPIO_VR41XX=y
 # CONFIG_HWMON is not set
 # CONFIG_VGA_CONSOLE is not set
-# CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_VR41XX=y
diff --git a/arch/mips/configs/fuloong2e_defconfig b/arch/mips/configs/fuloong2e_defconfig
index 87435897fd50..499f51498ecb 100644
--- a/arch/mips/configs/fuloong2e_defconfig
+++ b/arch/mips/configs/fuloong2e_defconfig
@@ -3,7 +3,6 @@ CONFIG_64BIT=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT_VOLUNTARY=y
-CONFIG_EXPERIMENTAL=y
 CONFIG_LOCALVERSION="-fuloong2e"
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
@@ -47,7 +46,6 @@ CONFIG_NET_IPGRE=m
 CONFIG_NET_IPGRE_BROADCAST=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_NETFILTER=y
@@ -79,7 +77,6 @@ CONFIG_NETFILTER_XT_MATCH_STRING=m
 CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
 CONFIG_NETFILTER_XT_MATCH_TIME=m
 CONFIG_NETFILTER_XT_MATCH_U32=m
-CONFIG_IP_NF_QUEUE=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_ADDRTYPE=m
 CONFIG_IP_NF_MATCH_AH=m
@@ -88,7 +85,6 @@ CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IP_NF_TARGET_LOG=m
-CONFIG_IP_NF_TARGET_ULOG=m
 CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
@@ -101,7 +97,6 @@ CONFIG_NET_9P=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_FW_LOADER=m
 CONFIG_MTD=m
-CONFIG_MTD_CHAR=m
 CONFIG_MTD_BLOCK=m
 CONFIG_MTD_CFI=m
 CONFIG_MTD_JEDECPROBE=m
@@ -163,7 +158,6 @@ CONFIG_I2C=m
 CONFIG_I2C_CHARDEV=m
 CONFIG_I2C_VIAPRO=m
 # CONFIG_HWMON is not set
-CONFIG_VIDEO_OUTPUT_CONTROL=m
 CONFIG_FB=y
 CONFIG_FB_RADEON=y
 # CONFIG_FB_RADEON_I2C is not set
@@ -184,7 +178,6 @@ CONFIG_USB_KBD=y
 CONFIG_USB_MOUSE=y
 CONFIG_USB=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
-# CONFIG_USB_DEVICE_CLASS is not set
 CONFIG_USB_OTG_WHITELIST=y
 CONFIG_USB_WUSB_CBAF=m
 CONFIG_USB_C67X00_HCD=m
@@ -201,7 +194,6 @@ CONFIG_USB_TMC=m
 CONFIG_USB_STORAGE=y
 CONFIG_USB_STORAGE_ONETOUCH=y
 CONFIG_USB_STORAGE_CYPRESS_ATACB=y
-CONFIG_USB_LIBUSUAL=y
 CONFIG_USB_SEVSEG=m
 CONFIG_USB_ISIGHTFW=m
 CONFIG_UIO=m
@@ -215,7 +207,6 @@ CONFIG_EXT4_FS=m
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
 CONFIG_REISERFS_FS=m
-CONFIG_AUTOFS_FS=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_FUSE_FS=y
 CONFIG_ISO9660_FS=m
@@ -256,8 +247,6 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
-CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_CRYPTO_FIPS=y
 CONFIG_CRYPTO_AUTHENC=m
 CONFIG_CRYPTO_CCM=m
diff --git a/arch/mips/configs/gpr_defconfig b/arch/mips/configs/gpr_defconfig
index e24feb0633aa..b1911816337c 100644
--- a/arch/mips/configs/gpr_defconfig
+++ b/arch/mips/configs/gpr_defconfig
@@ -2,7 +2,6 @@ CONFIG_MIPS_ALCHEMY=y
 CONFIG_MIPS_GPR=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT_VOLUNTARY=y
-CONFIG_EXPERIMENTAL=y
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
@@ -59,7 +58,6 @@ CONFIG_NETFILTER_XT_MATCH_REALM=m
 CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
 CONFIG_NETFILTER_XT_MATCH_STRING=m
 CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
-CONFIG_IP_NF_QUEUE=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_ADDRTYPE=m
 CONFIG_IP_NF_MATCH_AH=m
@@ -68,7 +66,6 @@ CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IP_NF_TARGET_LOG=m
-CONFIG_IP_NF_TARGET_ULOG=m
 CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
@@ -166,7 +163,6 @@ CONFIG_YAM=m
 CONFIG_CFG80211=y
 CONFIG_MAC80211=y
 CONFIG_MTD=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
@@ -200,8 +196,6 @@ CONFIG_SMSC_PHY=m
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
 CONFIG_MIPS_AU1X00_ENET=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
 CONFIG_ATH_COMMON=y
 CONFIG_ATH_DEBUG=y
 CONFIG_ATH5K=y
@@ -286,14 +280,12 @@ CONFIG_USB_HIDDEV=y
 CONFIG_USB_KBD=m
 CONFIG_USB_MOUSE=m
 CONFIG_USB=y
-# CONFIG_USB_DEVICE_CLASS is not set
 CONFIG_USB_MON=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=m
-CONFIG_USB_LIBUSUAL=y
 CONFIG_USB_SERIAL=y
 CONFIG_USB_EZUSB=y
 CONFIG_USB_SERIAL_GENERIC=y
diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_defconfig
index ec8e9684296d..83e8fe2064aa 100644
--- a/arch/mips/configs/ip22_defconfig
+++ b/arch/mips/configs/ip22_defconfig
@@ -4,7 +4,6 @@ CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_HZ_1000=y
 CONFIG_PREEMPT_VOLUNTARY=y
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
@@ -46,7 +45,6 @@ CONFIG_INET_IPCOMP=m
 CONFIG_INET_XFRM_MODE_TRANSPORT=m
 CONFIG_INET_XFRM_MODE_TUNNEL=m
 CONFIG_INET_XFRM_MODE_BEET=m
-# CONFIG_INET_LRO is not set
 CONFIG_TCP_MD5SIG=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_IPV6_ROUTE_INFO=y
@@ -139,7 +137,6 @@ CONFIG_IP_VS_SED=m
 CONFIG_IP_VS_NQ=m
 CONFIG_IP_VS_FTP=m
 CONFIG_NF_CONNTRACK_IPV4=m
-CONFIG_IP_NF_QUEUE=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_ADDRTYPE=m
 CONFIG_IP_NF_MATCH_AH=m
@@ -148,7 +145,6 @@ CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IP_NF_TARGET_LOG=m
-CONFIG_IP_NF_TARGET_ULOG=m
 CONFIG_NF_NAT=m
 CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_NETMAP=m
@@ -163,7 +159,6 @@ CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NF_CONNTRACK_IPV6=m
-CONFIG_IP6_NF_QUEUE=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
@@ -174,7 +169,6 @@ CONFIG_IP6_NF_MATCH_IPV6HEADER=m
 CONFIG_IP6_NF_MATCH_MH=m
 CONFIG_IP6_NF_MATCH_RT=m
 CONFIG_IP6_NF_TARGET_HL=m
-CONFIG_IP6_NF_TARGET_LOG=m
 CONFIG_IP6_NF_FILTER=m
 CONFIG_IP6_NF_TARGET_REJECT=m
 CONFIG_IP6_NF_MANGLE=m
@@ -215,7 +209,6 @@ CONFIG_RFKILL=m
 CONFIG_CONNECTOR=m
 CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
-# CONFIG_MISC_DEVICES is not set
 CONFIG_RAID_ATTRS=m
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
@@ -245,8 +238,6 @@ CONFIG_MDIO_BITBANG=m
 CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=m
 CONFIG_SGISEEQ=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
 CONFIG_HOSTAP=m
 CONFIG_INPUT_MOUSEDEV=m
 CONFIG_MOUSE_PS2=m
@@ -286,7 +277,6 @@ CONFIG_QUOTA=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
 # CONFIG_PRINT_QUOTA_WARNING is not set
 CONFIG_QFMT_V2=m
-CONFIG_AUTOFS_FS=m
 CONFIG_AUTOFS4_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_ISO9660_FS=m
@@ -355,7 +345,6 @@ CONFIG_NLS_KOI8_U=m
 CONFIG_NLS_UTF8=m
 CONFIG_DLM=m
 CONFIG_DEBUG_MEMORY_INIT=y
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_KEYS=y
 CONFIG_CRYPTO_FIPS=y
 CONFIG_CRYPTO_NULL=m
diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index e582069b44fd..a0d593248668 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -5,7 +5,6 @@ CONFIG_SMP=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_HZ_1000=y
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_IKCONFIG=y
@@ -104,7 +103,6 @@ CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_OSD=m
 CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
-# CONFIG_MISC_DEVICES is not set
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=y
@@ -325,7 +323,6 @@ CONFIG_XFS_POSIX_ACL=y
 CONFIG_BTRFS_FS=m
 CONFIG_BTRFS_FS_POSIX_ACL=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
-CONFIG_AUTOFS_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_CUSE=m
 CONFIG_FSCACHE=m
@@ -342,7 +339,6 @@ CONFIG_NFS_V3=y
 CONFIG_RPCSEC_GSS_KRB5=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_DLM=m
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_KEYS=y
 CONFIG_SECURITYFS=y
 CONFIG_CRYPTO_FIPS=y
@@ -378,7 +374,6 @@ CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
-CONFIG_CRYPTO_ZLIB=m
 CONFIG_CRYPTO_LZO=m
 CONFIG_CRYPTO_DEV_HIFN_795X=m
 CONFIG_CRC_T10DIF=m
diff --git a/arch/mips/configs/ip28_defconfig b/arch/mips/configs/ip28_defconfig
index 4dbf6269b3f9..d0a4c2cfacf8 100644
--- a/arch/mips/configs/ip28_defconfig
+++ b/arch/mips/configs/ip28_defconfig
@@ -1,7 +1,6 @@
 CONFIG_SGI_IP28=y
 CONFIG_ARC_CONSOLE=y
 CONFIG_PREEMPT_VOLUNTARY=y
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
@@ -35,10 +34,8 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 CONFIG_TCP_MD5SIG=y
 # CONFIG_IPV6 is not set
-# CONFIG_MISC_DEVICES is not set
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
@@ -48,8 +45,6 @@ CONFIG_NETDEVICES=y
 CONFIG_DUMMY=m
 CONFIG_NET_ETHERNET=y
 CONFIG_SGISEEQ=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
 # CONFIG_MOUSE_PS2_ALPS is not set
 # CONFIG_MOUSE_PS2_SYNAPTICS is not set
 CONFIG_VT_HW_CONSOLE_BINDING=y
diff --git a/arch/mips/configs/ip32_defconfig b/arch/mips/configs/ip32_defconfig
index f9af98f63cff..1e26e58b9dc3 100644
--- a/arch/mips/configs/ip32_defconfig
+++ b/arch/mips/configs/ip32_defconfig
@@ -1,6 +1,5 @@
 CONFIG_SGI_IP32=y
 # CONFIG_SECCOMP is not set
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_BSD_PROCESS_ACCT=y
@@ -38,7 +37,6 @@ CONFIG_NET_IPGRE=m
 CONFIG_INET_AH=m
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
-# CONFIG_INET_LRO is not set
 CONFIG_TCP_CONG_ADVANCED=y
 CONFIG_TCP_MD5SIG=y
 CONFIG_INET6_AH=m
@@ -76,8 +74,6 @@ CONFIG_NET_TULIP=y
 CONFIG_DE2104X=m
 CONFIG_TULIP=m
 CONFIG_TULIP_MMIO=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
 CONFIG_INPUT_EVDEV=m
 # CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_MACEPS2=y
@@ -87,7 +83,6 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_WATCHDOG=y
-CONFIG_VIDEO_OUTPUT_CONTROL=y
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_GBE=y
@@ -117,7 +112,6 @@ CONFIG_EXT3_FS_SECURITY=y
 CONFIG_QUOTA=y
 CONFIG_QFMT_V1=m
 CONFIG_QFMT_V2=m
-CONFIG_AUTOFS_FS=m
 CONFIG_AUTOFS4_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_ISO9660_FS=m
@@ -178,8 +172,6 @@ CONFIG_NLS_KOI8_R=m
 CONFIG_NLS_KOI8_U=m
 CONFIG_NLS_UTF8=m
 CONFIG_MAGIC_SYSRQ=y
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
-CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_KEYS=y
 CONFIG_CRYPTO_NULL=y
 CONFIG_CRYPTO_CBC=y
diff --git a/arch/mips/configs/jazz_defconfig b/arch/mips/configs/jazz_defconfig
index 3019fce63cd3..9ad1c94376c8 100644
--- a/arch/mips/configs/jazz_defconfig
+++ b/arch/mips/configs/jazz_defconfig
@@ -1,7 +1,6 @@
 CONFIG_MACH_JAZZ=y
 CONFIG_OLIVETTI_M700=y
 CONFIG_PREEMPT_VOLUNTARY=y
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_BSD_PROCESS_ACCT=y
@@ -85,7 +84,6 @@ CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
 CONFIG_NETFILTER_XT_MATCH_STRING=m
 CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
 CONFIG_NF_CONNTRACK_IPV4=m
-CONFIG_IP_NF_QUEUE=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_ADDRTYPE=m
 CONFIG_IP_NF_MATCH_AH=m
@@ -94,7 +92,6 @@ CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IP_NF_TARGET_LOG=m
-CONFIG_IP_NF_TARGET_ULOG=m
 CONFIG_NF_NAT=m
 CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_NETMAP=m
@@ -109,7 +106,6 @@ CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NF_CONNTRACK_IPV6=m
-CONFIG_IP6_NF_QUEUE=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
@@ -120,7 +116,6 @@ CONFIG_IP6_NF_MATCH_IPV6HEADER=m
 CONFIG_IP6_NF_MATCH_MH=m
 CONFIG_IP6_NF_MATCH_RT=m
 CONFIG_IP6_NF_TARGET_HL=m
-CONFIG_IP6_NF_TARGET_LOG=m
 CONFIG_IP6_NF_FILTER=m
 CONFIG_IP6_NF_TARGET_REJECT=m
 CONFIG_IP6_NF_MANGLE=m
@@ -276,7 +271,6 @@ CONFIG_REISERFS_FS_POSIX_ACL=y
 CONFIG_REISERFS_FS_SECURITY=y
 CONFIG_XFS_FS=m
 CONFIG_XFS_QUOTA=y
-CONFIG_AUTOFS_FS=m
 CONFIG_AUTOFS4_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_ISO9660_FS=m
diff --git a/arch/mips/configs/jmr3927_defconfig b/arch/mips/configs/jmr3927_defconfig
index 9bc08f275120..af12281a5c33 100644
--- a/arch/mips/configs/jmr3927_defconfig
+++ b/arch/mips/configs/jmr3927_defconfig
@@ -18,23 +18,18 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_JEDECPROBE=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP=y
-# CONFIG_MISC_DEVICES is not set
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
 CONFIG_NET_PCI=y
 CONFIG_TC35815=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
@@ -58,5 +53,3 @@ CONFIG_PROC_KCORE=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
-CONFIG_SYSCTL_SYSCALL_CHECK=y
diff --git a/arch/mips/configs/lasat_defconfig b/arch/mips/configs/lasat_defconfig
index e620a2c3eba4..947a35c7c46c 100644
--- a/arch/mips/configs/lasat_defconfig
+++ b/arch/mips/configs/lasat_defconfig
@@ -5,7 +5,6 @@ CONFIG_DS1603=y
 CONFIG_LASAT_SYSCTL=y
 CONFIG_HZ_1000=y
 # CONFIG_SECCOMP is not set
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_EXPERT=y
@@ -31,7 +30,6 @@ CONFIG_INET=y
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_MTD=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_AMDSTD=y
@@ -44,8 +42,6 @@ CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
 CONFIG_NET_PCI=y
 CONFIG_PCNET32=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
@@ -56,7 +52,6 @@ CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_SERIAL_8250_PCI is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
-# CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
diff --git a/arch/mips/configs/lemote2f_defconfig b/arch/mips/configs/lemote2f_defconfig
index 8df80c6383f2..1ec8ed8d05d1 100644
--- a/arch/mips/configs/lemote2f_defconfig
+++ b/arch/mips/configs/lemote2f_defconfig
@@ -7,7 +7,6 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT=y
 CONFIG_KEXEC=y
 # CONFIG_SECCOMP is not set
-CONFIG_EXPERIMENTAL=y
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_BSD_PROCESS_ACCT=y
@@ -83,8 +82,6 @@ CONFIG_NET_SCHED=y
 CONFIG_NET_EMATCH=y
 CONFIG_NET_CLS_ACT=y
 CONFIG_BT=m
-CONFIG_BT_L2CAP=y
-CONFIG_BT_SCO=y
 CONFIG_BT_RFCOMM=m
 CONFIG_BT_RFCOMM_TTY=y
 CONFIG_BT_BNEP=m
@@ -142,7 +139,6 @@ CONFIG_8139TOO=y
 # CONFIG_8139TOO_PIO is not set
 CONFIG_R8169=y
 CONFIG_R8169_VLAN=y
-# CONFIG_NETDEV_10000 is not set
 CONFIG_USB_USBNET=m
 CONFIG_USB_NET_CDC_EEM=m
 CONFIG_NETCONSOLE=m
@@ -205,7 +201,6 @@ CONFIG_USB_ZR364XX=m
 CONFIG_USB_STKWEBCAM=m
 CONFIG_USB_S2255=m
 # CONFIG_RADIO_ADAPTERS is not set
-CONFIG_VIDEO_OUTPUT_CONTROL=y
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y
@@ -290,7 +285,6 @@ CONFIG_HID_WACOM=m
 CONFIG_HID_ZEROPLUS=m
 CONFIG_ZEROPLUS_FF=y
 CONFIG_USB=y
-# CONFIG_USB_DEVICE_CLASS is not set
 CONFIG_USB_DYNAMIC_MINORS=y
 CONFIG_USB_OTG_WHITELIST=y
 CONFIG_USB_MON=y
@@ -313,10 +307,8 @@ CONFIG_USB_STORAGE_SDDR09=m
 CONFIG_USB_STORAGE_SDDR55=m
 CONFIG_USB_STORAGE_JUMPSHOT=m
 CONFIG_USB_STORAGE_ALAUDA=m
-CONFIG_USB_LIBUSUAL=y
 CONFIG_USB_SERIAL=m
 CONFIG_USB_SERIAL_GENERIC=y
-CONFIG_USB_LED=m
 CONFIG_USB_GADGET=m
 CONFIG_USB_GADGET_M66592=y
 CONFIG_MMC=m
@@ -341,7 +333,6 @@ CONFIG_XFS_POSIX_ACL=y
 CONFIG_BTRFS_FS=m
 CONFIG_QUOTA=y
 CONFIG_QFMT_V2=m
-CONFIG_AUTOFS_FS=m
 CONFIG_AUTOFS4_FS=m
 CONFIG_FSCACHE=m
 CONFIG_CACHEFILES=m
@@ -407,8 +398,6 @@ CONFIG_PRINTK_TIME=y
 CONFIG_FRAME_WARN=1024
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
-CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_KEYS=y
 CONFIG_CRYPTO_FIPS=y
 CONFIG_CRYPTO_NULL=m
@@ -446,6 +435,5 @@ CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_DEFLATE=m
-CONFIG_CRYPTO_ZLIB=m
 CONFIG_CRYPTO_LZO=m
 CONFIG_CRC_T10DIF=y
diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
index 7f95c4b3ab2c..324dfee23dfb 100644
--- a/arch/mips/configs/loongson3_defconfig
+++ b/arch/mips/configs/loongson3_defconfig
@@ -95,7 +95,6 @@ CONFIG_IP_NF_MATCH_ECN=m
 CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
-CONFIG_IP_NF_TARGET_ULOG=m
 CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
@@ -252,7 +251,6 @@ CONFIG_MEDIA_USB_SUPPORT=y
 CONFIG_USB_VIDEO_CLASS=m
 CONFIG_DRM=y
 CONFIG_DRM_RADEON=y
-CONFIG_VIDEO_OUTPUT_CONTROL=y
 CONFIG_FB_RADEON=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_PLATFORM=m
@@ -335,7 +333,6 @@ CONFIG_STRIP_ASM_SYMS=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_DEBUG_PREEMPT is not set
-# CONFIG_RCU_CPU_STALL_VERBOSE is not set
 # CONFIG_FTRACE is not set
 CONFIG_SECURITY=y
 CONFIG_SECURITYFS=y
diff --git a/arch/mips/configs/malta_kvm_defconfig b/arch/mips/configs/malta_kvm_defconfig
index e233f878afef..80ecd94ed126 100644
--- a/arch/mips/configs/malta_kvm_defconfig
+++ b/arch/mips/configs/malta_kvm_defconfig
@@ -133,7 +133,6 @@ CONFIG_IP_NF_MATCH_ECN=m
 CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
-CONFIG_IP_NF_TARGET_ULOG=m
 CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
diff --git a/arch/mips/configs/malta_kvm_guest_defconfig b/arch/mips/configs/malta_kvm_guest_defconfig
index fbe085c328ab..35ad1f8d1a79 100644
--- a/arch/mips/configs/malta_kvm_guest_defconfig
+++ b/arch/mips/configs/malta_kvm_guest_defconfig
@@ -132,7 +132,6 @@ CONFIG_IP_NF_MATCH_ECN=m
 CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
-CONFIG_IP_NF_TARGET_ULOG=m
 CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
diff --git a/arch/mips/configs/malta_qemu_32r6_defconfig b/arch/mips/configs/malta_qemu_32r6_defconfig
index cbf37dd0c490..77145ecaa23b 100644
--- a/arch/mips/configs/malta_qemu_32r6_defconfig
+++ b/arch/mips/configs/malta_qemu_32r6_defconfig
@@ -42,7 +42,6 @@ CONFIG_SYN_COOKIES=y
 CONFIG_INET_AH=m
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
-# CONFIG_INET_LRO is not set
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
diff --git a/arch/mips/configs/maltaaprp_defconfig b/arch/mips/configs/maltaaprp_defconfig
index 35f6ba260df8..cc2687cfdc13 100644
--- a/arch/mips/configs/maltaaprp_defconfig
+++ b/arch/mips/configs/maltaaprp_defconfig
@@ -43,7 +43,6 @@ CONFIG_SYN_COOKIES=y
 CONFIG_INET_AH=m
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
-# CONFIG_INET_LRO is not set
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
@@ -135,7 +134,6 @@ CONFIG_HW_RANDOM=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
-CONFIG_VIDEO_OUTPUT_CONTROL=m
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MATROX=y
diff --git a/arch/mips/configs/maltasmvp_defconfig b/arch/mips/configs/maltasmvp_defconfig
index 900f14543eeb..55b68b981b05 100644
--- a/arch/mips/configs/maltasmvp_defconfig
+++ b/arch/mips/configs/maltasmvp_defconfig
@@ -46,7 +46,6 @@ CONFIG_SYN_COOKIES=y
 CONFIG_INET_AH=m
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
-# CONFIG_INET_LRO is not set
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
diff --git a/arch/mips/configs/maltasmvp_eva_defconfig b/arch/mips/configs/maltasmvp_eva_defconfig
index 8e2738b5e180..5ca590cf1635 100644
--- a/arch/mips/configs/maltasmvp_eva_defconfig
+++ b/arch/mips/configs/maltasmvp_eva_defconfig
@@ -47,7 +47,6 @@ CONFIG_SYN_COOKIES=y
 CONFIG_INET_AH=m
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
-# CONFIG_INET_LRO is not set
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
@@ -140,7 +139,6 @@ CONFIG_HW_RANDOM=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
-CONFIG_VIDEO_OUTPUT_CONTROL=m
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MATROX=y
diff --git a/arch/mips/configs/maltaup_defconfig b/arch/mips/configs/maltaup_defconfig
index 6dc4e309a691..7ea7c0ba2666 100644
--- a/arch/mips/configs/maltaup_defconfig
+++ b/arch/mips/configs/maltaup_defconfig
@@ -42,7 +42,6 @@ CONFIG_SYN_COOKIES=y
 CONFIG_INET_AH=m
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
-# CONFIG_INET_LRO is not set
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
@@ -134,7 +133,6 @@ CONFIG_HW_RANDOM=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
-CONFIG_VIDEO_OUTPUT_CONTROL=m
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MATROX=y
diff --git a/arch/mips/configs/markeins_defconfig b/arch/mips/configs/markeins_defconfig
index 0f08e4623ee4..43ce6576ab1c 100644
--- a/arch/mips/configs/markeins_defconfig
+++ b/arch/mips/configs/markeins_defconfig
@@ -1,7 +1,6 @@
 CONFIG_NEC_MARKEINS=y
 CONFIG_HZ_1000=y
 CONFIG_PREEMPT=y
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_BSD_PROCESS_ACCT=y
@@ -92,7 +91,6 @@ CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IP_NF_TARGET_LOG=m
-CONFIG_IP_NF_TARGET_ULOG=m
 CONFIG_NF_NAT=m
 CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_NETMAP=m
@@ -117,7 +115,6 @@ CONFIG_IP6_NF_MATCH_IPV6HEADER=m
 CONFIG_IP6_NF_MATCH_MH=m
 CONFIG_IP6_NF_MATCH_RT=m
 CONFIG_IP6_NF_TARGET_HL=m
-CONFIG_IP6_NF_TARGET_LOG=m
 CONFIG_IP6_NF_FILTER=m
 CONFIG_IP6_NF_TARGET_REJECT=m
 CONFIG_IP6_NF_MANGLE=m
@@ -125,7 +122,6 @@ CONFIG_IP6_NF_RAW=m
 CONFIG_FW_LOADER=m
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_AMDSTD=y
diff --git a/arch/mips/configs/mips_paravirt_defconfig b/arch/mips/configs/mips_paravirt_defconfig
index 84cfcb4bf2ea..accf0db1dc6f 100644
--- a/arch/mips/configs/mips_paravirt_defconfig
+++ b/arch/mips/configs/mips_paravirt_defconfig
@@ -39,7 +39,6 @@ CONFIG_IP_MROUTE=y
 CONFIG_IP_PIMSM_V1=y
 CONFIG_IP_PIMSM_V2=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
 CONFIG_IPV6=y
 # CONFIG_WIRELESS is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
diff --git a/arch/mips/configs/mpc30x_defconfig b/arch/mips/configs/mpc30x_defconfig
index a2c045fab6c5..3486b034f726 100644
--- a/arch/mips/configs/mpc30x_defconfig
+++ b/arch/mips/configs/mpc30x_defconfig
@@ -1,6 +1,5 @@
 CONFIG_MACH_VR41XX=y
 CONFIG_VICTOR_MPC30X=y
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_RELAY=y
@@ -31,8 +30,6 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 CONFIG_PATA_LEGACY=y
 CONFIG_NETDEVICES=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
 CONFIG_USB_PEGASUS=m
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
@@ -45,13 +42,11 @@ CONFIG_SERIAL_VR41XX_CONSOLE=y
 CONFIG_GPIO_VR41XX=y
 # CONFIG_HWMON is not set
 # CONFIG_VGA_CONSOLE is not set
-# CONFIG_HID_SUPPORT is not set
 CONFIG_USB=m
 CONFIG_USB_OHCI_HCD=m
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_VR41XX=y
 CONFIG_EXT2_FS=y
-CONFIG_AUTOFS_FS=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_CONFIGFS_FS=m
diff --git a/arch/mips/configs/msp71xx_defconfig b/arch/mips/configs/msp71xx_defconfig
index 201edfb2637d..3c8c16b10732 100644
--- a/arch/mips/configs/msp71xx_defconfig
+++ b/arch/mips/configs/msp71xx_defconfig
@@ -2,7 +2,6 @@ CONFIG_PMC_MSP=y
 CONFIG_PMC_MSP7120_GW=y
 CONFIG_CPU_MIPS32_R2=y
 CONFIG_PREEMPT=y
-CONFIG_EXPERIMENTAL=y
 CONFIG_LOCALVERSION="-pmc"
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
@@ -38,7 +37,6 @@ CONFIG_BRIDGE=y
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 # CONFIG_FW_LOADER is not set
 CONFIG_MTD=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_AMDSTD=y
diff --git a/arch/mips/configs/mtx1_defconfig b/arch/mips/configs/mtx1_defconfig
index f3f60056bc27..4011f1869e72 100644
--- a/arch/mips/configs/mtx1_defconfig
+++ b/arch/mips/configs/mtx1_defconfig
@@ -1,7 +1,6 @@
 CONFIG_MIPS_ALCHEMY=y
 CONFIG_MIPS_MTX1=y
 CONFIG_PREEMPT_VOLUNTARY=y
-CONFIG_EXPERIMENTAL=y
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
@@ -81,7 +80,6 @@ CONFIG_NETFILTER_XT_MATCH_REALM=m
 CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
 CONFIG_NETFILTER_XT_MATCH_STRING=m
 CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
-CONFIG_IP_NF_QUEUE=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_ADDRTYPE=m
 CONFIG_IP_NF_MATCH_AH=m
@@ -90,7 +88,6 @@ CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IP_NF_TARGET_LOG=m
-CONFIG_IP_NF_TARGET_ULOG=m
 CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
@@ -98,7 +95,6 @@ CONFIG_IP_NF_RAW=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
-CONFIG_IP6_NF_QUEUE=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
@@ -108,7 +104,6 @@ CONFIG_IP6_NF_MATCH_HL=m
 CONFIG_IP6_NF_MATCH_IPV6HEADER=m
 CONFIG_IP6_NF_MATCH_RT=m
 CONFIG_IP6_NF_TARGET_HL=m
-CONFIG_IP6_NF_TARGET_LOG=m
 CONFIG_IP6_NF_FILTER=m
 CONFIG_IP6_NF_TARGET_REJECT=m
 CONFIG_IP6_NF_MANGLE=m
@@ -225,8 +220,6 @@ CONFIG_TOSHIBA_FIR=m
 CONFIG_VLSI_FIR=m
 CONFIG_MCS_FIR=m
 CONFIG_BT=m
-CONFIG_BT_L2CAP=y
-CONFIG_BT_SCO=y
 CONFIG_BT_RFCOMM=m
 CONFIG_BT_RFCOMM_TTY=y
 CONFIG_BT_BNEP=m
@@ -246,7 +239,6 @@ CONFIG_BT_HCIBTUART=m
 CONFIG_BT_HCIVHCI=m
 CONFIG_CONNECTOR=m
 CONFIG_MTD=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
@@ -257,7 +249,6 @@ CONFIG_MTD_PHYSMAP=y
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=65536
-# CONFIG_MISC_DEVICES is not set
 CONFIG_SCSI=m
 CONFIG_BLK_DEV_SD=m
 CONFIG_CHR_DEV_SG=m
@@ -596,7 +587,6 @@ CONFIG_USB_STORAGE_SDDR55=m
 CONFIG_USB_STORAGE_JUMPSHOT=m
 CONFIG_USB_STORAGE_ALAUDA=m
 CONFIG_USB_STORAGE_KARMA=m
-CONFIG_USB_LIBUSUAL=y
 CONFIG_USB_MDC800=m
 CONFIG_USB_MICROTEK=m
 CONFIG_USB_SERIAL=m
@@ -640,7 +630,6 @@ CONFIG_USB_ADUTUX=m
 CONFIG_USB_RIO500=m
 CONFIG_USB_LEGOTOWER=m
 CONFIG_USB_LCD=m
-CONFIG_USB_LED=m
 CONFIG_USB_CYPRESS_CY7C63=m
 CONFIG_USB_CYTHERM=m
 CONFIG_USB_IDMOUSE=m
diff --git a/arch/mips/configs/nlm_xlp_defconfig b/arch/mips/configs/nlm_xlp_defconfig
index 07d01827a973..5720ce23e9aa 100644
--- a/arch/mips/configs/nlm_xlp_defconfig
+++ b/arch/mips/configs/nlm_xlp_defconfig
@@ -6,7 +6,6 @@ CONFIG_KSM=y
 CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
 CONFIG_SMP=y
 # CONFIG_SECCOMP is not set
-CONFIG_EXPERIMENTAL=y
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
@@ -183,14 +182,12 @@ CONFIG_IP_VS_SED=m
 CONFIG_IP_VS_NQ=m
 CONFIG_IP_VS_FTP=m
 CONFIG_NF_CONNTRACK_IPV4=m
-CONFIG_IP_NF_QUEUE=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
 CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
-CONFIG_IP_NF_TARGET_ULOG=m
 CONFIG_NF_NAT=m
 CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_NETMAP=m
@@ -317,7 +314,6 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_CONNECTOR=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_ADV_OPTIONS=y
@@ -607,7 +603,6 @@ CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
-CONFIG_CRYPTO_ZLIB=m
 CONFIG_CRYPTO_LZO=m
 CONFIG_CRC_CCITT=m
 CONFIG_CRC7=m
diff --git a/arch/mips/configs/nlm_xlr_defconfig b/arch/mips/configs/nlm_xlr_defconfig
index f59969acb724..fea56c535d92 100644
--- a/arch/mips/configs/nlm_xlr_defconfig
+++ b/arch/mips/configs/nlm_xlr_defconfig
@@ -7,7 +7,6 @@ CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_KEXEC=y
-CONFIG_EXPERIMENTAL=y
 CONFIG_CROSS_COMPILE=""
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
@@ -163,7 +162,6 @@ CONFIG_IP_VS_SED=m
 CONFIG_IP_VS_NQ=m
 CONFIG_IP_VS_FTP=m
 CONFIG_NF_CONNTRACK_IPV4=m
-CONFIG_IP_NF_QUEUE=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
@@ -171,7 +169,6 @@ CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IP_NF_TARGET_LOG=m
-CONFIG_IP_NF_TARGET_ULOG=m
 CONFIG_NF_NAT=m
 CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_NETMAP=m
@@ -186,7 +183,6 @@ CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NF_CONNTRACK_IPV6=m
-CONFIG_IP6_NF_QUEUE=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
@@ -197,7 +193,6 @@ CONFIG_IP6_NF_MATCH_IPV6HEADER=m
 CONFIG_IP6_NF_MATCH_MH=m
 CONFIG_IP6_NF_MATCH_RT=m
 CONFIG_IP6_NF_TARGET_HL=m
-CONFIG_IP6_NF_TARGET_LOG=m
 CONFIG_IP6_NF_FILTER=m
 CONFIG_IP6_NF_TARGET_REJECT=m
 CONFIG_IP6_NF_MANGLE=m
@@ -308,7 +303,6 @@ CONFIG_BLK_DEV_OSD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=65536
 CONFIG_CDROM_PKTCDVD=y
-CONFIG_MISC_DEVICES=y
 CONFIG_RAID_ATTRS=m
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
@@ -369,7 +363,6 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1374=y
 # CONFIG_HWMON is not set
 # CONFIG_VGA_CONSOLE is not set
-# CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_UIO=y
 CONFIG_UIO_PDRV=m
@@ -522,7 +515,6 @@ CONFIG_SCHEDSTATS=y
 CONFIG_TIMER_STATS=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_MEMORY_INIT=y
-CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_SCHED_TRACER=y
 CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_KGDB=y
@@ -568,7 +560,6 @@ CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
-CONFIG_CRYPTO_ZLIB=m
 CONFIG_CRYPTO_LZO=m
 CONFIG_CRC_CCITT=m
 CONFIG_CRC7=m
diff --git a/arch/mips/configs/pnx8335_stb225_defconfig b/arch/mips/configs/pnx8335_stb225_defconfig
index c887066ecc2a..81b5eb89446c 100644
--- a/arch/mips/configs/pnx8335_stb225_defconfig
+++ b/arch/mips/configs/pnx8335_stb225_defconfig
@@ -5,7 +5,6 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_HZ_128=y
 CONFIG_PREEMPT_VOLUNTARY=y
 # CONFIG_SECCOMP is not set
-CONFIG_EXPERIMENTAL=y
 # CONFIG_LOCALVERSION_AUTO is not set
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
@@ -27,12 +26,10 @@ CONFIG_IP_MULTICAST=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_INET_AH=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_ADV_OPTIONS=y
@@ -41,15 +38,12 @@ CONFIG_MTD_CFI_GEOMETRY=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_BLK_DEV_LOOP=y
-# CONFIG_MISC_DEVICES is not set
 CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_ATA=y
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
 # CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=m
 CONFIG_INPUT_EVBUG=m
@@ -94,4 +88,3 @@ CONFIG_NLS_ASCII=m
 CONFIG_NLS_ISO8859_1=m
 CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_UTF8=m
-CONFIG_SYSCTL_SYSCALL_CHECK=y
diff --git a/arch/mips/configs/qi_lb60_defconfig b/arch/mips/configs/qi_lb60_defconfig
index d7bb8cce1068..3f1333517405 100644
--- a/arch/mips/configs/qi_lb60_defconfig
+++ b/arch/mips/configs/qi_lb60_defconfig
@@ -34,7 +34,6 @@ CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_INET_DIAG is not set
 CONFIG_TCP_CONG_ADVANCED=y
 # CONFIG_TCP_CONG_BIC is not set
@@ -109,7 +108,6 @@ CONFIG_USB_GADGET_DEBUG=y
 CONFIG_USB_ETH=y
 # CONFIG_USB_ETH_RNDIS is not set
 CONFIG_MMC=y
-CONFIG_MMC_UNSAFE_RESUME=y
 # CONFIG_MMC_BLOCK_BOUNCE is not set
 CONFIG_MMC_JZ4740=y
 CONFIG_RTC_CLASS=y
@@ -183,7 +181,6 @@ CONFIG_PANIC_ON_OOPS=y
 # CONFIG_FTRACE is not set
 CONFIG_KGDB=y
 CONFIG_RUNTIME_DEBUG=y
-CONFIG_CRYPTO_ZLIB=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_FONTS=y
 CONFIG_FONT_SUN8x16=y
diff --git a/arch/mips/configs/rb532_defconfig b/arch/mips/configs/rb532_defconfig
index 5d9d708e12e5..6fa56c6e53f5 100644
--- a/arch/mips/configs/rb532_defconfig
+++ b/arch/mips/configs/rb532_defconfig
@@ -3,7 +3,6 @@ CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_HZ_100=y
 # CONFIG_SECCOMP is not set
-CONFIG_EXPERIMENTAL=y
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_BSD_PROCESS_ACCT=y
@@ -39,7 +38,6 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 CONFIG_INET_DIAG=m
 CONFIG_TCP_CONG_ADVANCED=y
 CONFIG_TCP_CONG_CUBIC=m
@@ -114,7 +112,6 @@ CONFIG_NET_CLS_IND=y
 CONFIG_HAMRADIO=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_BLOCK2MTD=y
 CONFIG_MTD_NAND=y
@@ -129,8 +126,6 @@ CONFIG_NET_ETHERNET=y
 CONFIG_KORINA=y
 CONFIG_NET_PCI=y
 CONFIG_VIA_RHINE=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
 CONFIG_ATMEL=m
 CONFIG_PPP=m
 CONFIG_PPP_MULTILINK=y
@@ -183,7 +178,6 @@ CONFIG_BSD_DISKLABEL=y
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_TEST=m
-CONFIG_CRYPTO_ZLIB=y
 # CONFIG_CRYPTO_HW is not set
 CONFIG_CRC16=m
 CONFIG_LIBCRC32C=m
diff --git a/arch/mips/configs/rbtx49xx_defconfig b/arch/mips/configs/rbtx49xx_defconfig
index 43d55e5abacb..fb195e29e449 100644
--- a/arch/mips/configs/rbtx49xx_defconfig
+++ b/arch/mips/configs/rbtx49xx_defconfig
@@ -31,12 +31,10 @@ CONFIG_IP_PNP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=m
 CONFIG_MTD_BLOCK_RO=m
 CONFIG_MTD_CFI=y
@@ -50,7 +48,6 @@ CONFIG_MTD_NAND_TXX9NDFMC=m
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
-# CONFIG_MISC_DEVICES is not set
 CONFIG_IDE=y
 CONFIG_BLK_DEV_IDE_TX4938=y
 CONFIG_BLK_DEV_IDE_TX4939=y
@@ -60,8 +57,6 @@ CONFIG_SMC91X=y
 CONFIG_NE2000=y
 CONFIG_NET_PCI=y
 CONFIG_TC35815=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
 # CONFIG_WLAN is not set
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
@@ -108,5 +103,3 @@ CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
-CONFIG_SYSCTL_SYSCALL_CHECK=y
diff --git a/arch/mips/configs/rm200_defconfig b/arch/mips/configs/rm200_defconfig
index c2b4e3f33a73..99679e514042 100644
--- a/arch/mips/configs/rm200_defconfig
+++ b/arch/mips/configs/rm200_defconfig
@@ -3,7 +3,6 @@ CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_ARC_CONSOLE=y
 CONFIG_HZ_1000=y
 CONFIG_PREEMPT_VOLUNTARY=y
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_BSD_PROCESS_ACCT=y
@@ -94,7 +93,6 @@ CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
 CONFIG_NETFILTER_XT_MATCH_STRING=m
 CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
 CONFIG_NF_CONNTRACK_IPV4=m
-CONFIG_IP_NF_QUEUE=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_ADDRTYPE=m
 CONFIG_IP_NF_MATCH_AH=m
@@ -103,7 +101,6 @@ CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IP_NF_TARGET_LOG=m
-CONFIG_IP_NF_TARGET_ULOG=m
 CONFIG_NF_NAT=m
 CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_NETMAP=m
@@ -118,7 +115,6 @@ CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NF_CONNTRACK_IPV6=m
-CONFIG_IP6_NF_QUEUE=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
@@ -129,7 +125,6 @@ CONFIG_IP6_NF_MATCH_IPV6HEADER=m
 CONFIG_IP6_NF_MATCH_MH=m
 CONFIG_IP6_NF_MATCH_RT=m
 CONFIG_IP6_NF_TARGET_HL=m
-CONFIG_IP6_NF_TARGET_LOG=m
 CONFIG_IP6_NF_FILTER=m
 CONFIG_IP6_NF_TARGET_REJECT=m
 CONFIG_IP6_NF_MANGLE=m
@@ -214,7 +209,6 @@ CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_SX8=m
-CONFIG_BLK_DEV_UB=m
 CONFIG_BLK_DEV_RAM=m
 CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
@@ -353,7 +347,6 @@ CONFIG_USB_SERIAL_OMNINET=m
 CONFIG_USB_RIO500=m
 CONFIG_USB_LEGOTOWER=m
 CONFIG_USB_LCD=m
-CONFIG_USB_LED=m
 CONFIG_USB_CYTHERM=m
 CONFIG_USB_SISUSBVGA=m
 CONFIG_USB_LD=m
@@ -366,7 +359,6 @@ CONFIG_REISERFS_FS_POSIX_ACL=y
 CONFIG_REISERFS_FS_SECURITY=y
 CONFIG_XFS_FS=m
 CONFIG_XFS_QUOTA=y
-CONFIG_AUTOFS_FS=m
 CONFIG_AUTOFS4_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_ISO9660_FS=m
diff --git a/arch/mips/configs/rt305x_defconfig b/arch/mips/configs/rt305x_defconfig
index d14ae2fa7d13..c695b7b1c4ae 100644
--- a/arch/mips/configs/rt305x_defconfig
+++ b/arch/mips/configs/rt305x_defconfig
@@ -5,7 +5,6 @@ CONFIG_CPU_MIPS32_R2=y
 # CONFIG_CROSS_MEMORY_ATTACH is not set
 CONFIG_HZ_100=y
 # CONFIG_SECCOMP is not set
-CONFIG_EXPERIMENTAL=y
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -44,7 +43,6 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_INET_DIAG is not set
 CONFIG_TCP_CONG_ADVANCED=y
 # CONFIG_TCP_CONG_BIC is not set
diff --git a/arch/mips/configs/sb1250_swarm_defconfig b/arch/mips/configs/sb1250_swarm_defconfig
index 7fca09fedb59..c724bdd6a7e6 100644
--- a/arch/mips/configs/sb1250_swarm_defconfig
+++ b/arch/mips/configs/sb1250_swarm_defconfig
@@ -4,7 +4,6 @@ CONFIG_64BIT=y
 CONFIG_SMP=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_HZ_1000=y
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=15
 CONFIG_CGROUPS=y
diff --git a/arch/mips/configs/tb0219_defconfig b/arch/mips/configs/tb0219_defconfig
index 11f51505d562..4041597e3170 100644
--- a/arch/mips/configs/tb0219_defconfig
+++ b/arch/mips/configs/tb0219_defconfig
@@ -1,6 +1,5 @@
 CONFIG_MACH_VR41XX=y
 CONFIG_TANBAC_TB0219=y
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED_V2=y
@@ -31,7 +30,6 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_NETWORK_SECMARK=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
@@ -40,7 +38,6 @@ CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_XIP=y
-# CONFIG_MISC_DEVICES is not set
 CONFIG_NETDEVICES=y
 CONFIG_PHYLIB=m
 CONFIG_MARVELL_PHY=m
@@ -57,7 +54,6 @@ CONFIG_VIA_RHINE=y
 CONFIG_VIA_RHINE_MMIO=y
 CONFIG_R8169=y
 CONFIG_VIA_VELOCITY=y
-# CONFIG_NETDEV_10000 is not set
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
@@ -70,7 +66,6 @@ CONFIG_SERIAL_VR41XX_CONSOLE=y
 CONFIG_GPIO_TB0219=y
 # CONFIG_HWMON is not set
 # CONFIG_VGA_CONSOLE is not set
-# CONFIG_HID_SUPPORT is not set
 CONFIG_USB=m
 CONFIG_USB_MON=m
 CONFIG_USB_EHCI_HCD=m
@@ -91,6 +86,5 @@ CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
 CONFIG_NFSD_V3=y
-CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="cca=3 mem=64M console=ttyVR0,115200 ip=any root=/dev/nfs"
diff --git a/arch/mips/configs/tb0226_defconfig b/arch/mips/configs/tb0226_defconfig
index 9327b3af32cd..565f0441c50d 100644
--- a/arch/mips/configs/tb0226_defconfig
+++ b/arch/mips/configs/tb0226_defconfig
@@ -1,6 +1,5 @@
 CONFIG_MACH_VR41XX=y
 CONFIG_TANBAC_TB0226=y
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED_V2=y
@@ -29,7 +28,6 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_NETWORK_SECMARK=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
@@ -37,7 +35,6 @@ CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_XIP=y
-# CONFIG_MISC_DEVICES is not set
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_MULTI_LUN=y
@@ -49,8 +46,6 @@ CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
 CONFIG_NET_PCI=y
 CONFIG_E100=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
 CONFIG_USB_CATC=m
 CONFIG_USB_KAWETH=m
 CONFIG_USB_PEGASUS=m
@@ -66,7 +61,6 @@ CONFIG_SERIAL_VR41XX_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
 # CONFIG_VGA_CONSOLE is not set
-# CONFIG_HID_SUPPORT is not set
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 # CONFIG_USB_EHCI_TT_NEWSCHED is not set
@@ -87,7 +81,6 @@ CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3=y
-CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="cca=3 mem=32M console=ttyVR0,115200"
 CONFIG_CRC32=m
diff --git a/arch/mips/configs/tb0287_defconfig b/arch/mips/configs/tb0287_defconfig
index a967289b7970..a702be602fb9 100644
--- a/arch/mips/configs/tb0287_defconfig
+++ b/arch/mips/configs/tb0287_defconfig
@@ -1,5 +1,4 @@
 CONFIG_MACH_VR41XX=y
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED_V2=y
@@ -31,7 +30,6 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 CONFIG_TCP_CONG_ADVANCED=y
 CONFIG_TCP_CONG_BIC=y
 CONFIG_TCP_CONG_CUBIC=m
@@ -43,7 +41,6 @@ CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_XIP=y
-# CONFIG_MISC_DEVICES is not set
 CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_SCAN_ASYNC=y
 # CONFIG_SCSI_LOWLEVEL is not set
@@ -64,7 +61,6 @@ CONFIG_VIA_RHINE=y
 CONFIG_VIA_RHINE_MMIO=y
 CONFIG_R8169=y
 CONFIG_VIA_VELOCITY=y
-# CONFIG_NETDEV_10000 is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
@@ -76,7 +72,6 @@ CONFIG_SERIAL_VR41XX_CONSOLE=y
 CONFIG_GPIO_VR41XX=y
 # CONFIG_HWMON is not set
 CONFIG_MFD_SM501=y
-CONFIG_VIDEO_OUTPUT_CONTROL=m
 CONFIG_FB=y
 CONFIG_FB_SM501=y
 # CONFIG_VGA_CONSOLE is not set
diff --git a/arch/mips/configs/workpad_defconfig b/arch/mips/configs/workpad_defconfig
index ee4b2be43c44..a84eac409c9c 100644
--- a/arch/mips/configs/workpad_defconfig
+++ b/arch/mips/configs/workpad_defconfig
@@ -1,6 +1,5 @@
 CONFIG_MACH_VR41XX=y
 CONFIG_IBM_WORKPAD=y
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
@@ -28,13 +27,10 @@ CONFIG_IP_MULTICAST=y
 # CONFIG_IPV6 is not set
 CONFIG_NETWORK_SECMARK=y
 CONFIG_BLK_DEV_RAM=m
-# CONFIG_MISC_DEVICES is not set
 CONFIG_IDE=y
 CONFIG_BLK_DEV_IDECS=m
 CONFIG_IDE_GENERIC=y
 CONFIG_NETDEVICES=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
 CONFIG_NET_PCMCIA=y
 CONFIG_PCMCIA_3C589=m
 CONFIG_PCMCIA_3C574=m
-- 
2.9.3
