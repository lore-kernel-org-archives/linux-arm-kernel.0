Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B03C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:50:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7272C206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GRPN3OtS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfhAA62V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7272C206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=gyBRlhNC0U3meQgm9S7oWvUKe5lWVlGCS5WREyz3hLI=; b=GRPN3OtS7cILL0
	i5F3je405gjT5UC9os1+5qdHjnUHS5BOj3S8geD9BvDjD6fDUK2qcWq0/eosW10cjnpX3W+HEkXx0
	Xq/J7kB+yszKwNTyeFqd5Lw2siSaVOUa/2aNcqfOLig6dkexqfiiKZfnT0myl8NxDIAFjaD/7ZLup
	ZehJ0+KH221C+Y3VrrCJNwc5BSD/5/X3vZ1Aznt3GPCnaY8B3Kf+jdsrRc7UBsaLGI7r5tyV9kQI8
	nQu8zbLB3i9mvII4vzULdKpDLc1qhSmx3gogK41g9nSS93CIBFm0CuEEVMxi6xpBBgP7WoGWum8WT
	kiw+e6n8G8ocFgyPi9wQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghG7n-0005Kj-Ae; Wed, 09 Jan 2019 15:50:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghG7g-0005KN-U9
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 15:50:34 +0000
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com
 [70.114.128.244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DAE61206BA;
 Wed,  9 Jan 2019 15:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547049028;
 bh=GL2XC2R+FVwTYqgpKeU7nLkYUzZiVeUmm/SJRFCLHTk=;
 h=From:To:Cc:Subject:Date:From;
 b=jfhAA62VoyMdSfw5US4LTNiAGTxve47qe6aPrx0ywpeLuvkx6ndTR1Q1Cc/UgYssU
 KIAsBb6XkqH088iPoLIo1GF7K5ZEqrABVgJH6SU1dxhh56iP+gcGbf+5MO+OFHFTXd
 Kj3WQwzdD/NikLmuth1VXXZ5vifAYXhwJ6mLMM2w=
From: Dinh Nguyen <dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: socfpga_defconfig: enable BLK_DEV_LOOP config option
Date: Wed,  9 Jan 2019 09:50:18 -0600
Message-Id: <20190109155018.14789-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_075028_987775_CD617E0E 
X-CRM114-Status: UNSURE (   8.63  )
X-CRM114-Notice: Please train this message.
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
Cc: dinguyen@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add CONFIG_BLK_DEV_LOOP and clean up socfpga_defconfig by mak
savedefconfig.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm/configs/socfpga_defconfig | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 371fca4e1ab7..08d1b3e11d68 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -9,27 +9,20 @@ CONFIG_NAMESPACES=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EMBEDDED=y
 CONFIG_PROFILING=y
-CONFIG_OPROFILE=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_LBDAF is not set
-# CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_SOCFPGA=y
 CONFIG_ARM_THUMBEE=y
-CONFIG_PCI=y
-CONFIG_PCI_MSI=y
-CONFIG_PCIE_ALTERA=y
-CONFIG_PCIE_ALTERA_MSI=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
-CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_VFP=y
 CONFIG_NEON=y
+CONFIG_OPROFILE=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_LBDAF is not set
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -48,6 +41,10 @@ CONFIG_CAN=y
 CONFIG_CAN_C_CAN=y
 CONFIG_CAN_C_CAN_PLATFORM=y
 CONFIG_CAN_DEBUG_DEVICES=y
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCIE_ALTERA=y
+CONFIG_PCIE_ALTERA_MSI=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
@@ -60,7 +57,7 @@ CONFIG_MTD_SPI_NOR=y
 # CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
 CONFIG_SPI_CADENCE_QUADSPI=y
 CONFIG_OF_OVERLAY=y
-CONFIG_OF_CONFIGFS=y
+CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=2
 CONFIG_BLK_DEV_RAM_SIZE=8192
@@ -131,12 +128,12 @@ CONFIG_DMADEVICES=y
 CONFIG_PL330_DMA=y
 CONFIG_DMATEST=m
 CONFIG_FPGA=y
-CONFIG_FPGA_REGION=y
 CONFIG_FPGA_MGR_SOCFPGA=y
 CONFIG_FPGA_MGR_SOCFPGA_A10=y
 CONFIG_FPGA_BRIDGE=y
 CONFIG_SOCFPGA_FPGA_BRIDGE=y
 CONFIG_ALTERA_FREEZE_BRIDGE=y
+CONFIG_FPGA_REGION=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
