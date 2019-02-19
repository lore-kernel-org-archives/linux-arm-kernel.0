Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62984C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:58:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E7922147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nFVMOFgh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7922147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=qRVZbh90ELZgaIzjSbT1I4BfXsNKgUBKL2YjGm5LdyM=; b=nFVMOFghRQufLHt4w/aHQogD+1
	YtO7v66dglK3WEISkTLnZ/5/PqLXt8S8kqf+LeS9GisBZs89cCN5ZYh5SSiWaSrUP8AVmJ2KewmFL
	co4+GrVeYIc5AlV0R5bzkv4GiM0BV90ic0kNYvwKC1ROv+Vg/SdwL+Oh7glva2B8XZ2RCJueH8rmB
	YNqkH7FoV8L2nNqrv1/xKv7Nh6seE3K20Oif3L53dlpsv1Om/NfgUi8vPqSSPTabkgi2Ar2qVWxwc
	xls6Vb7DsnHJi6lpYG9dftESkoyV1RLNFaEyWGxWKis6uLsAodir0nESau8qUd35+7xh0gk4PF582
	ERxY4LMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwAb1-0003Ac-DH; Tue, 19 Feb 2019 18:58:23 +0000
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwAan-0002up-9Y
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 18:58:10 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Feb 2019 10:58:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; d="scan'208";a="117434317"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
 by orsmga006.jf.intel.com with ESMTP; 19 Feb 2019 10:58:01 -0800
From: thor.thayer@linux.intel.com
To: bp@alien8.de, dinguyen@kernel.org, linux@armlinux.org.uk,
 mchehab@kernel.org, james.morse@arm.com
Subject: [PATCH 2/2] ARM: socfpga_defconfig: enable EDAC by default
Date: Tue, 19 Feb 2019 12:59:59 -0600
Message-Id: <1550602799-22737-3-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550602799-22737-1-git-send-email-thor.thayer@linux.intel.com>
References: <1550602799-22737-1-git-send-email-thor.thayer@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_105809_347142_3266665E 
X-CRM114-Status: GOOD (  10.10  )
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
Cc: thor.thayer@linux.intel.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Enable the different ECC blocks by default on Cyclone5
and Arria10.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 arch/arm/configs/socfpga_defconfig | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 371fca4e1ab7..4de21c646e5c 100644
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
@@ -60,7 +57,6 @@ CONFIG_MTD_SPI_NOR=y
 # CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
 CONFIG_SPI_CADENCE_QUADSPI=y
 CONFIG_OF_OVERLAY=y
-CONFIG_OF_CONFIGFS=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=2
 CONFIG_BLK_DEV_RAM_SIZE=8192
@@ -125,18 +121,30 @@ CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
 CONFIG_LEDS_TRIGGER_CPU=y
+CONFIG_EDAC=y
+CONFIG_EDAC_ALTERA=y
+CONFIG_EDAC_ALTERA_SDRAM=y
+CONFIG_EDAC_ALTERA_L2C=y
+CONFIG_EDAC_ALTERA_OCRAM=y
+CONFIG_EDAC_ALTERA_ETHERNET=y
+CONFIG_EDAC_ALTERA_NAND=y
+CONFIG_EDAC_ALTERA_DMA=y
+CONFIG_EDAC_ALTERA_USB=y
+CONFIG_EDAC_ALTERA_QSPI=y
+CONFIG_EDAC_ALTERA_SDMMC=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_DMADEVICES=y
 CONFIG_PL330_DMA=y
 CONFIG_DMATEST=m
+CONFIG_RAS=y
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
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
