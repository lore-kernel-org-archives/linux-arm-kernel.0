Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75B7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:44:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 839A62183F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oKBqFDQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839A62183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=YEc1/JxrW6JXG8gublKxoGK0akbn9Kn9OlFKjjZMKjY=; b=oKB
	qFDQ0UoJyB33kj4OZV3hkWjr/cIMIZzcdQMdeDLq9sMEZyiM1y2oIGboS7UvJ+zIMoU91pD+A6Eu4
	agoCQ9WO7ahcfwFl8CbEuDTrZbvH9ezU8K0QmFqDpLjx2TcdmLo2WHepKsH1sLlWAyuDI1cwUIvkC
	0EeNHc0ahCn9+qxwhFH94q4hwQJdn5rK0/nLR1YO6A/FPzjcMUNIyf2mrYoRS0baFVk6t/vsr5U3a
	CDSVM6Ubf07/QILt2O9oMWuW41Cv/l2FgqBnpQTyuhSP+2zhgQwqR5cU1LBWUaNehGhznce/FVPRf
	f0Ugxry0i80XTPuUIsnMxPiLtFYDUqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwMYe-00038k-94; Wed, 20 Feb 2019 07:44:44 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwMYM-0002qy-9k
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 07:44:34 +0000
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
 by mx.socionext.com with ESMTP; 20 Feb 2019 16:44:25 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
 by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 87A5D180097;
 Wed, 20 Feb 2019 16:44:25 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP;
 Wed, 20 Feb 2019 16:44:25 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by kinkan.css.socionext.com (Postfix) with ESMTP id EC6DD1A04E0;
 Wed, 20 Feb 2019 16:44:24 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
 by yuzu.css.socionext.com (Postfix) with ESMTP id CF95E120459;
 Wed, 20 Feb 2019 16:44:24 +0900 (JST)
From: Sugaya Taichi <sugaya.taichi@socionext.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 soc@kernel.org
Subject: [PATCH v3 9/9] ARM: configs: Add Milbeaut M10V defconfig
Date: Wed, 20 Feb 2019 16:45:04 +0900
Message-Id: <1550648704-11545-1-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_234426_983104_F8671CD2 
X-CRM114-Status: GOOD (  17.75  )
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
 Arnd Bergmann <arnd@arndb.de>, Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Sugaya Taichi <sugaya.taichi@socionext.com>,
 Jassi Brar <jaswinder.singh@linaro.org>,
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
 arch/arm/configs/milbeaut_m10v_defconfig | 175 +++++++++++++++++++++++++++++++
 arch/arm/configs/multi_v7_defconfig      |   2 +
 2 files changed, 177 insertions(+)
 create mode 100644 arch/arm/configs/milbeaut_m10v_defconfig

diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/configs/milbeaut_m10v_defconfig
new file mode 100644
index 0000000..a263211
--- /dev/null
+++ b/arch/arm/configs/milbeaut_m10v_defconfig
@@ -0,0 +1,175 @@
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
+# CONFIG_COMPAT_BRK is not set
+CONFIG_SLAB=y
+CONFIG_PROFILING=y
+# CONFIG_OPROFILE=m
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_ARCH_MILBEAUT=y
+CONFIG_ARCH_MILBEAUT_M10V=y
+# CONFIG_CACHE_L2X0 is not set
+CONFIG_ARM_ERRATA_754322=y
+CONFIG_ARM_ERRATA_775420=y
+CONFIG_SMP=y
+# CONFIG_ARM_CPU_TOPOLOGY is not set
+CONFIG_HAVE_ARM_ARCH_TIMER=y
+CONFIG_PREEMPT=y
+CONFIG_THUMB2_KERNEL=y
+CONFIG_HIGHMEM=y
+# CONFIG_COMPACTION is not set
+CONFIG_CMA=y
+# CONFIG_ATAGS is not set
+CONFIG_ZBOOT_ROM_TEXT=0x0
+CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_KEXEC=y
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
+CONFIG_CPUFREQ_DT=y
+CONFIG_CPU_IDLE=y
+CONFIG_VFP=y
+CONFIG_NEON=y
+CONFIG_KERNEL_MODE_NEON=y
+CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
+CONFIG_UNIX=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_DMA_CMA=y
+CONFIG_CMA_SIZE_MBYTES=16
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_LOOP_MIN_COUNT=2
+CONFIG_BLK_DEV_RAM=y
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_VETH=y
+CONFIG_INPUT_POLLDEV=y
+# CONFIG_INPUT_MOUSEDEV is not set
+CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+CONFIG_SERIO_LIBPS2=y
+CONFIG_LEGACY_PTY_COUNT=4
+CONFIG_GPIOLIB=y
+CONFIG_GPIO_SYSFS=y
+# CONFIG_HWMON is not set
+CONFIG_WATCHDOG=y
+CONFIG_SOFT_WATCHDOG=m
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_DEBUG=y
+CONFIG_REGULATOR_S6AP412=y
+CONFIG_MEDIA_SUPPORT=y
+CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_MEDIA_CONTROLLER=y
+CONFIG_VIDEO_ADV_DEBUG=y
+CONFIG_SOC_CAMERA=y
+CONFIG_SOC_CAMERA_PLATFORM=y
+# CONFIG_VGA_ARB is not set
+CONFIG_DMADEVICES=y
+CONFIG_UIO=y
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_RESET_CONTROLLER=y
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
+CONFIG_PRINTK_TIME=y
+CONFIG_HEADERS_CHECK=y
+CONFIG_RCU_TORTURE_TEST=m
+CONFIG_RCU_CPU_STALL_TIMEOUT=60
+CONFIG_KGDB=y
+CONFIG_KEYS=y
+CONFIG_ENCRYPTED_KEYS=y
+CONFIG_SECURITY=y
+CONFIG_FONTS=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 5bee34a..6753805 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -54,6 +54,8 @@ CONFIG_SOC_VF610=y
 CONFIG_ARCH_KEYSTONE=y
 CONFIG_ARCH_MEDIATEK=y
 CONFIG_ARCH_MESON=y
+CONFIG_ARCH_MILBEAUT=y
+CONFIG_ARCH_MILBEAUT_M10V=y
 CONFIG_ARCH_MVEBU=y
 CONFIG_MACH_ARMADA_370=y
 CONFIG_MACH_ARMADA_375=y
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
