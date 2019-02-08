Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_75_100,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B3BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:44:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B9D720857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ikVRkhtr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jl5xwBPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9D720857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=nq+YfyKJCT7/1svQ3z4blANCGcKJd1GmN65J16Z5aS0=; b=ikV
	RkhtrlFcJ12gXiLKdHv+pDm3AEP+28lMjvbAeJ48KI5xlXIvr5KZRJ+q3lb9JDYX4bl+z86FrgK+L
	a1JxjVpaCKHVjh6HeUzPWQJiYqK2jMwG9Gy+lb3Dsvhm6rTXcTUaYzQ+3x0tM3PPVpzWBBBbTjBe8
	8hXElwHzt0w9F0jXQ6J1Kh9M33oExxbNbTu1tK23rLpEKexG60czEADs6GMxlNlXudiWyGr26j4QA
	UV9xxe+Hw5M/DLmUCCqABccjiRF3DpDRMs/M+nfa8C+xI5vCn0NivxCurwexlzSx6IM6oVEi7siW+
	zeFNGbJlJaO83OKwTOpx3tg6fLVaKhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs5Vg-0002w0-0P; Fri, 08 Feb 2019 12:44:00 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs5VC-0002L7-Lj
 for linux-arm-kernel@bombadil.infradead.org; Fri, 08 Feb 2019 12:43:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Message-Id:Date:Subject:Cc:To:From:
 Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d+mpOhkTwrbIm4yIBQYZvCvzissfNIhnDQxMZm6VoeA=; b=Jl5xwBPLWjrgNWOpWBeqG592r
 UMuc+WXNo6jJdA4UQznMUDLRKjTc4xd3ADuLEf2ouXfuHTobxsV57jamsOiIlrONAd+BbLuPDhxe6
 rxoe+JUPr+QDxVhmyQQV4DUkZ0Zo7nu6qrsU6As7VHOefyjyRAvtS1b3iE93yuphQHV0eVeiTqJ0M
 p/EAWbeKKW/ZtkPKSeS7mWw+AO2Vrcb2gRWkip9oTn4zyAhCJ3Dfu4WPaTrPrC2aLvoHj1E7jkmEx
 ZQddSXevfDNPGwFD3CVmifXnoSpfB/ijKY/5+VkxD+f0K8R7nC2lEaAcNMWDDKdCos0+M3y+pREqM
 DuvcF/uPw==;
Received: from mx.socionext.com ([202.248.49.38])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs5GQ-0001xx-3Q
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 12:28:16 +0000
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 08 Feb 2019 21:28:13 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
 by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 66BC260062;
 Fri,  8 Feb 2019 21:28:13 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP;
 Fri, 8 Feb 2019 21:28:13 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by kinkan.css.socionext.com (Postfix) with ESMTP id DB6AC1A0508;
 Fri,  8 Feb 2019 21:28:12 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
 by yuzu.css.socionext.com (Postfix) with ESMTP id BCE6D1202F1;
 Fri,  8 Feb 2019 21:28:12 +0900 (JST)
From: Sugaya Taichi <sugaya.taichi@socionext.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/15] ARM: configs: Add Milbeaut M10V defconfig
Date: Fri,  8 Feb 2019 21:28:57 +0900
Message-Id: <1549628937-363-1-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_122814_941312_749787F1 
X-CRM114-Status: GOOD (  20.06  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Sugaya Taichi <sugaya.taichi@socionext.com>,
 Russell King <linux@armlinux.org.uk>, Jassi Brar <jaswinder.singh@linaro.org>,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds the minimal defconfig for the Milbeaut M10V.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 arch/arm/configs/milbeaut_m10v_defconfig | 366 +++++++++++++++++++++++++++++++
 1 file changed, 366 insertions(+)
 create mode 100644 arch/arm/configs/milbeaut_m10v_defconfig

diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/configs/milbeaut_m10v_defconfig
new file mode 100644
index 0000000..c67c87f
--- /dev/null
+++ b/arch/arm/configs/milbeaut_m10v_defconfig
@@ -0,0 +1,366 @@
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_DEBUG_SEMIHOSTING=y
+CONFIG_DEFAULT_HOSTNAME="mlbel"
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_FHANDLE=y
+CONFIG_NO_HZ_FULL=y
+CONFIG_NO_HZ_FULL_ALL=y
+CONFIG_NO_HZ_FULL_SYSIDLE=y
+CONFIG_NO_HZ_FULL_SYSIDLE_SMALL=4
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_BSD_PROCESS_ACCT_V3=y
+CONFIG_TASKSTATS=y
+CONFIG_TASK_DELAY_ACCT=y
+CONFIG_TASK_XACCT=y
+CONFIG_TASK_IO_ACCOUNTING=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_CGROUPS=y
+CONFIG_CGROUP_DEBUG=y
+CONFIG_CPUSETS=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_CFS_BANDWIDTH=y
+CONFIG_RT_GROUP_SCHED=y
+CONFIG_NAMESPACES=y
+CONFIG_USER_NS=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_EMBEDDED=y
+# CONFIG_COMPAT_BRK is not set
+CONFIG_SLAB=y
+CONFIG_PROFILING=y
+CONFIG_OPROFILE=m
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_ARCH_MILBEAUT=y
+CONFIG_ARCH_MILBEAUT_M10V=y
+# CONFIG_CACHE_L2X0 is not set
+CONFIG_ARM_ERRATA_754322=y
+CONFIG_ARM_ERRATA_775420=y
+# CONFIG_PCI is not set
+# CONFIG_PCI_DEBUG is not set
+# CONFIG_PCI_HOST_GENERIC is not set
+# CONFIG_PCIE_SN_DW_PLAT is not set
+# CONFIG_PCI_MSI is not set
+# CONFIG_PCIEPORTBUS is not set
+# CONFIG_PCIEAER is not set
+# CONFIG_PCIEASPM is not set
+CONFIG_SMP=y
+# CONFIG_ARM_CPU_TOPOLOGY is not set
+CONFIG_HAVE_ARM_ARCH_TIMER=y
+CONFIG_VMSPLIT_2G=y
+CONFIG_PREEMPT=y
+CONFIG_THUMB2_KERNEL=y
+CONFIG_HIGHMEM=y
+# CONFIG_COMPACTION is not set
+CONFIG_CMA=y
+# CONFIG_ATAGS is not set
+CONFIG_ZBOOT_ROM_TEXT=0x0
+CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_ARM_APPENDED_DTB=y
+CONFIG_KEXEC=y
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
+CONFIG_CPUFREQ_DT=y
+CONFIG_CPU_IDLE=y
+CONFIG_VFP=y
+CONFIG_NEON=y
+CONFIG_KERNEL_MODE_NEON=y
+CONFIG_PM_RUNTIME=y
+CONFIG_PM_DEBUG=y
+CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_PACKET_DIAG=m
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_MROUTE=y
+CONFIG_IP_PIMSM_V1=y
+CONFIG_IP_PIMSM_V2=y
+CONFIG_SYN_COOKIES=y
+CONFIG_NET_IPVTI=m
+CONFIG_INET_AH=y
+CONFIG_INET_ESP=y
+CONFIG_INET_IPCOMP=y
+CONFIG_INET_XFRM_MODE_TRANSPORT=m
+CONFIG_INET_XFRM_MODE_TUNNEL=m
+CONFIG_INET_XFRM_MODE_BEET=m
+CONFIG_INET_UDP_DIAG=m
+CONFIG_TCP_CONG_ADVANCED=y
+CONFIG_IP_SCTP=m
+CONFIG_SCTP_COOKIE_HMAC_SHA1=y
+CONFIG_TIPC=y
+CONFIG_L2TP=m
+CONFIG_L2TP_DEBUGFS=m
+CONFIG_L2TP_V3=y
+CONFIG_L2TP_IP=y
+CONFIG_L2TP_ETH=y
+CONFIG_IPX=m
+CONFIG_NETLINK_MMAP=y
+CONFIG_NETLINK_DIAG=y
+CONFIG_CFG80211=y
+CONFIG_NL80211_TESTMODE=y
+CONFIG_CFG80211_DEVELOPER_WARNINGS=y
+CONFIG_CFG80211_REG_DEBUG=y
+CONFIG_CFG80211_INTERNAL_REGDB=y
+CONFIG_CFG80211_WEXT=y
+CONFIG_MAC80211=y
+# CONFIG_MAC80211_RC_MINSTREL is not set
+CONFIG_MAC80211_LEDS=y
+CONFIG_RFKILL=y
+CONFIG_RFKILL_INPUT=y
+CONFIG_RFKILL_REGULATOR=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_DMA_CMA=y
+CONFIG_CMA_SIZE_MBYTES=16
+CONFIG_MTD=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_M25P80=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_CDN_HPNFC=y
+CONFIG_MTD_NAND_CDN_HPNFC_DT=y
+CONFIG_MTD_NAND_PLATFORM=y
+CONFIG_MTD_SPI_NOR=y
+CONFIG_MTD_UBI=y
+CONFIG_MTD_UBI_BEB_LIMIT=3
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_LOOP_MIN_COUNT=2
+CONFIG_BLK_DEV_RAM=y
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_NETDEVICES=y
+CONFIG_MACVLAN=y
+CONFIG_TUN=y
+CONFIG_VETH=y
+# CONFIG_NET_CADENCE is not set
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_CIRRUS is not set
+# CONFIG_NET_VENDOR_FARADAY is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+CONFIG_R8169=y
+# CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_SMSC is not set
+# CONFIG_NET_SOCIONEXT_OGMA=y
+# CONFIG_NET_VENDOR_STMICRO is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
+CONFIG_REALTEK_PHY=y
+CONFIG_MWIFIEX=m
+CONFIG_MWIFIEX_SDIO=m
+CONFIG_INPUT_POLLDEV=y
+# CONFIG_INPUT_MOUSEDEV is not set
+CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+CONFIG_SERIO_LIBPS2=y
+CONFIG_LEGACY_PTY_COUNT=4
+# CONFIG_DEVKMEM is not set
+#CONFIG_SERIAL_8250=y
+# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
+#CONFIG_SERIAL_8250_CONSOLE=y
+# CONFIG_SERIAL_8250_DMA is not set
+#CONFIG_SERIAL_8250_EXTENDED=y
+#CONFIG_SERIAL_8250_DW=y
+CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_SERIAL_MILBEAUT_USIO=y
+CONFIG_SERIAL_MILBEAUT_USIO_CONSOLE=y
+# CONFIG_HW_RANDOM is not set
+# CONFIG_I2C is not set
+# CONFIG_I2C_BOARDINFO is not set
+# CONFIG_I2C_COMPAT is not set
+# CONFIG_I2C_CHARDEV is not set
+# CONFIG_I2C_MUX is not set
+# CONFIG_I2C_HELPER_AUTO is not set
+# CONFIG_I2C_ALGOBIT is not set
+# CONFIG_I2C_SNI_M10V is not set
+CONFIG_SPI=y
+# CONFIG_SPI_SN_USIO=y
+#CONFIG_SPI_SNI is not set
+#CONFIG_SPI_SPIDEV is not set
+CONFIG_GPIOLIB=y
+CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_PCA953X=y
+CONFIG_GPIO_PCA953X_IRQ=y
+# CONFIG_HWMON is not set
+CONFIG_WATCHDOG=y
+CONFIG_SOFT_WATCHDOG=m
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_DEBUG=y
+CONFIG_REGULATOR_S6AP412=y
+CONFIG_MEDIA_SUPPORT=y
+CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_MEDIA_CONTROLLER=y
+CONFIG_VIDEO_V4L2_SUBDEV_API=y
+CONFIG_VIDEO_ADV_DEBUG=y
+CONFIG_MEDIA_USB_SUPPORT=y
+CONFIG_USB_VIDEO_CLASS=y
+# CONFIG_USB_GSPCA is not set
+CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_SOC_CAMERA=y
+CONFIG_SOC_CAMERA_PLATFORM=y
+CONFIG_V4L_MEM2MEM_DRIVERS=y
+CONFIG_V4L_TEST_DRIVERS=y
+CONFIG_VIDEO_VIVID=m
+CONFIG_VIDEO_VIVID_MAX_DEVS=64
+CONFIG_FB=y
+# CONFIG_VGA_ARB is not set
+# CONFIG_USB is not set
+# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
+# CONFIG_USB_MON is not set
+# CONFIG_USB_XHCI_HCD is not set
+# CONFIG_USB_EHCI_HCD is not set
+# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
+# CONFIG_USB_EHCI_HCD_PLATFORM is not set
+# CONFIG_USB_OHCI_HCD is not set
+# CONFIG_USB_OHCI_HCD_PCI is not set
+# CONFIG_USB_OHCI_HCD_PLATFORM is not set
+# CONFIG_USB_STORAGE is not set
+# CONFIG_USB_SERIAL is not set
+# CONFIG_USB_SERIAL_GENERIC is not set
+# CONFIG_USB_SERIAL_CP210X is not set
+# CONFIG_USB_SERIAL_FTDI_SIO is not set
+# CONFIG_USB_SERIAL_PL2303 is not set
+# CONFIG_USB_ULPI is not set
+# CONFIG_USB_GADGET is not set
+# CONFIG_USB_DWC3 is not set
+# CONFIG_USB_DWC3_PCI is not set
+# CONFIG_USB_DWC3_OTG is not set
+# CONFIG_USB_DWC3_SN is not set
+# CONFIG_USB_DWC3_OF_SIMPLE is not set
+# CONFIG_USB_GADGET_SN_LAP is not set
+# CONFIG_USB_CONFIGFS is not set
+# CONFIG_USB_CONFIGFS_ACM is not set
+# CONFIG_USB_CONFIGFS_MASS_STORAGE is not set
+# CONFIG_USB_CONFIGFS_F_MTP is not set
+# CONFIG_USB_CONFIGFS_F_UVC is not set
+# CONFIG_USB_CONFIGFS_UEVENT is not set
+# CONFIG_MMC is not set
+# CONFIG_MMC_SDHCI is not set
+# CONFIG_MMC_SDHCI_PLTFM is not set
+# CONFIG_MMC_SDHCI_F_SDH30 is not set
+# CONFIG_MMC_SDHCI_F_EMMC50 is not set
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGER_TIMER=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_RTC_CLASS=y
+# CONFIG_RTC_HCTOSYS is not set
+# CONFIG_RTC_SYSTOHC is not set
+CONFIG_RTC_DEBUG=y
+CONFIG_RTC_DRV_RX8025=y
+CONFIG_DMADEVICES=y
+CONFIG_MB86S7X_HDMAC=y
+CONFIG_MB8AC0300_XDMAC=y
+CONFIG_UIO=y
+CONFIG_UIO_SNI=y
+# CONFIG_IOMMU_SUPPORT is not set
+#CONFIG_PWM=y is not set
+# CONFIG_PWM_SYSFS is not set
+#CONFIG_PWM_M10V=y is not set
+CONFIG_RESET_CONTROLLER=y
+CONFIG_EXFAT=y
+CONFIG_EXT4_FS=y
+# CONFIG_EXT4_USE_FOR_EXT23 is not set
+# CONFIG_XFS_FS is not set
+CONFIG_FANOTIFY=y
+CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
+CONFIG_QUOTA=y
+CONFIG_AUTOFS4_FS=y
+# CONFIG_FUSE_FS is not set
+CONFIG_FSCACHE=y
+CONFIG_FSCACHE_STATS=y
+CONFIG_FSCACHE_HISTOGRAM=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=932
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_UBIFS_FS=y
+CONFIG_UBIFS_FS_ADVANCED_COMPR=y
+CONFIG_ROMFS_FS=y
+CONFIG_ROMFS_BACKED_BY_BOTH=y
+CONFIG_NFS_FS=m
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_CODEPAGE_737=y
+CONFIG_NLS_CODEPAGE_775=y
+CONFIG_NLS_CODEPAGE_850=y
+CONFIG_NLS_CODEPAGE_852=y
+CONFIG_NLS_CODEPAGE_855=y
+CONFIG_NLS_CODEPAGE_857=y
+CONFIG_NLS_CODEPAGE_860=y
+CONFIG_NLS_CODEPAGE_861=y
+CONFIG_NLS_CODEPAGE_862=y
+CONFIG_NLS_CODEPAGE_863=y
+CONFIG_NLS_CODEPAGE_864=y
+CONFIG_NLS_CODEPAGE_865=y
+CONFIG_NLS_CODEPAGE_866=y
+CONFIG_NLS_CODEPAGE_869=y
+CONFIG_NLS_CODEPAGE_936=y
+CONFIG_NLS_CODEPAGE_950=y
+CONFIG_NLS_CODEPAGE_932=y
+CONFIG_NLS_CODEPAGE_949=y
+CONFIG_NLS_CODEPAGE_874=y
+CONFIG_NLS_ISO8859_8=y
+CONFIG_NLS_CODEPAGE_1250=y
+CONFIG_NLS_CODEPAGE_1251=y
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_ISO8859_2=y
+CONFIG_NLS_ISO8859_3=y
+CONFIG_NLS_ISO8859_4=y
+CONFIG_NLS_ISO8859_5=y
+CONFIG_NLS_ISO8859_6=y
+CONFIG_NLS_ISO8859_7=y
+CONFIG_NLS_ISO8859_9=y
+CONFIG_NLS_ISO8859_13=y
+CONFIG_NLS_ISO8859_14=y
+CONFIG_NLS_ISO8859_15=y
+CONFIG_NLS_KOI8_R=y
+CONFIG_NLS_KOI8_U=y
+CONFIG_NLS_MAC_ROMAN=y
+CONFIG_NLS_MAC_CELTIC=y
+CONFIG_NLS_MAC_CENTEURO=y
+CONFIG_NLS_MAC_CROATIAN=y
+CONFIG_NLS_MAC_CYRILLIC=y
+CONFIG_NLS_MAC_GAELIC=y
+CONFIG_NLS_MAC_GREEK=y
+CONFIG_NLS_MAC_ICELAND=y
+CONFIG_NLS_MAC_INUIT=y
+CONFIG_NLS_MAC_ROMANIAN=y
+CONFIG_NLS_MAC_TURKISH=y
+CONFIG_NLS_UTF8=y
+CONFIG_IPCU_FS=y
+# CONFIG_TEST_IPCU_FS is not set
+CONFIG_PRINTK_TIME=y
+CONFIG_DYNAMIC_DEBUG=y
+CONFIG_DEBUG_INFO=y
+#CONFIG_DEBUG_INFO_REDUCED is not set
+CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_GIC_BL=y
+CONFIG_HEADERS_CHECK=y
+CONFIG_DEBUG_SECTION_MISMATCH=y
+CONFIG_DEBUG_MEMORY_INIT=y
+# CONFIG_DEBUG_PREEMPT is not set
+CONFIG_RCU_TORTURE_TEST=m
+CONFIG_RCU_CPU_STALL_TIMEOUT=60
+CONFIG_KGDB=y
+CONFIG_DEBUG_USER=y
+#CONFIG_DEBUG_LL=y
+#CONFIG_DEBUG_LL_MILBEAUT_UART=y
+#CONFIG_EARLY_PRINTK=y
+CONFIG_SERIAL_EARLYCON=y
+# CONFIG_EARLY_PRINTK_DIRECT is not set
+CONFIG_KEYS=y
+CONFIG_ENCRYPTED_KEYS=y
+CONFIG_SECURITY=y
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
+# CONFIG_CRYPTO_HW is not set
+CONFIG_FONTS=y
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
