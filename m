Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5D1C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:19:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D7EA20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hJVoOCeh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="ILSDlce4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7EA20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=VEUSGD+mhfiTGYnbciaJCdcUtDSbPq9LMSKNmTah0ok=; b=hJVoOCeh9RMJTByHpfLR/RK6xQ
	SVj7tcmyBNhRvkYeYMcwXzTMC/DuKNJ7t5XdMxLGeCAM1UBJKgJxMBgo2y561190C3EfDobTgATa9
	3M4V7vTu6qrDKsu2xZpkpabU6D/VSABhErPTa4XrJEUJF2WZK7dpwgtbf+3xfI+SYdcSSA1vZ3Z0u
	SQokUUVlkyqTy/obngcAXQiItuIc3PpBNW9jYbxgshfvjUgKn36DIiFZWMmy4pViprcdtdKulPPOw
	OJ7x/LwKSFf8Vd0IjieU0Ke25jh0fHLTsgQLXem92foW9WtXnqCvg3mdtEcAUbaSXFM5WQ0kFyuzi
	iC4fWaeQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs4Bx-0005pt-PK; Fri, 08 Feb 2019 11:19:33 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs4Ba-0005IB-I0
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 11:19:31 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 0F9A525BF03;
 Fri,  8 Feb 2019 22:13:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1549624430; bh=Zm5aNypMPiaPyAeO7lyV3W5bMvv6g2OwgbkINaXMjBQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ILSDlce4Czc9cMUyhXXaBGDFew058M7xwLye3m/getQrbAath8Cndh1DmjSy9GWcI
 eyS4uDRXyp8V6uNyuOKK1Xk4LX5WpWl1YY+L7EK/GTw2tv6a5ukfuuCO3+PE2loED7
 Urf7ZdMfh7/vmPtH2GumP8X8BxUfG/MnITGmB5v8=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 5A880940461; Fri,  8 Feb 2019 12:13:48 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 3/5] ARM: shmobile: defconfig: Refresh for v5.0-rc1
Date: Fri,  8 Feb 2019 12:13:45 +0100
Message-Id: <4162325afd0d553c26fd06089b04e123699cf893.1549621233.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1549621233.git.horms+renesas@verge.net.au>
References: <cover.1549621233.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_031910_975123_15D598F2 
X-CRM114-Status: GOOD (  10.16  )
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
Cc: Simon Horman <horms+renesas@verge.net.au>,
 Magnus Damm <magnus.damm@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

- Move SoC config options (moved in commit 062887bf5ef73313 ("ARM:
    shmobile: Move SoC Kconfig symbols to drivers/soc/renesas/")),
  - Move PCI config options (moved in commit eb01d42a77785ff9 ("PCI:
    consolidate PCI config entry in drivers/pci")),
  - Drop CONFIG_I2C_MUX=y (auto-enabled since commit ea6b13e9fed0fda9
    ("drm/bridge/sii902x: Add missing dependency on I2C_MUX")),
  - Drop CONFIG_SH_DMAE=y (no longer selectable since commit
    a19788612f51b787 ("dmaengine: sh: Remove R-Mobile APE6 support")),
  - Drop CONFIG_ARM_UNWIND (auto-enabled since commit f9b58e8c7d031b0d
    ("ARM: 8800/1: use choice for kernel unwinders")).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 45 +++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index fdac4e4ca04d..14e9255e48c3 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -8,29 +8,8 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_PERF_EVENTS=y
 CONFIG_SLAB=y
 CONFIG_ARCH_RENESAS=y
-CONFIG_ARCH_EMEV2=y
-CONFIG_ARCH_R7S72100=y
-CONFIG_ARCH_R8A73A4=y
-CONFIG_ARCH_R8A7740=y
-CONFIG_ARCH_R8A7743=y
-CONFIG_ARCH_R8A7744=y
-CONFIG_ARCH_R8A7745=y
-CONFIG_ARCH_R8A77470=y
-CONFIG_ARCH_R8A7778=y
-CONFIG_ARCH_R8A7779=y
-CONFIG_ARCH_R8A7790=y
-CONFIG_ARCH_R8A7791=y
-CONFIG_ARCH_R8A7792=y
-CONFIG_ARCH_R8A7793=y
-CONFIG_ARCH_R8A7794=y
-CONFIG_ARCH_R9A06G032=y
-CONFIG_ARCH_SH73A0=y
 CONFIG_PL310_ERRATA_588369=y
 CONFIG_ARM_ERRATA_754322=y
-CONFIG_PCI=y
-CONFIG_PCI_MSI=y
-CONFIG_PCI_RCAR_GEN2=y
-CONFIG_PCIE_RCAR=y
 CONFIG_SMP=y
 CONFIG_SCHED_MC=y
 CONFIG_NR_CPUS=8
@@ -58,6 +37,10 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_CAN=y
 CONFIG_CAN_RCAR=y
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCI_RCAR_GEN2=y
+CONFIG_PCIE_RCAR=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DMA_CMA=y
@@ -91,7 +74,6 @@ CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_8250_EM=y
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_I2C_CHARDEV=y
-CONFIG_I2C_MUX=y
 CONFIG_I2C_DEMUX_PINCTRL=y
 CONFIG_I2C_EMEV2=y
 CONFIG_I2C_GPIO=y
@@ -183,12 +165,28 @@ CONFIG_RTC_DRV_S35390A=y
 CONFIG_RTC_DRV_RX8581=y
 CONFIG_RTC_DRV_DA9063=y
 CONFIG_DMADEVICES=y
-CONFIG_SH_DMAE=y
 CONFIG_RCAR_DMAC=y
 CONFIG_RENESAS_USB_DMAC=y
 CONFIG_STAGING=y
 CONFIG_STAGING_BOARD=y
 # CONFIG_IOMMU_SUPPORT is not set
+CONFIG_ARCH_EMEV2=y
+CONFIG_ARCH_R7S72100=y
+CONFIG_ARCH_R8A73A4=y
+CONFIG_ARCH_R8A7740=y
+CONFIG_ARCH_R8A7743=y
+CONFIG_ARCH_R8A7744=y
+CONFIG_ARCH_R8A7745=y
+CONFIG_ARCH_R8A77470=y
+CONFIG_ARCH_R8A7778=y
+CONFIG_ARCH_R8A7779=y
+CONFIG_ARCH_R8A7790=y
+CONFIG_ARCH_R8A7791=y
+CONFIG_ARCH_R8A7792=y
+CONFIG_ARCH_R8A7793=y
+CONFIG_ARCH_R8A7794=y
+CONFIG_ARCH_R9A06G032=y
+CONFIG_ARCH_SH73A0=y
 CONFIG_IIO=y
 CONFIG_AK8975=y
 CONFIG_PWM=y
@@ -212,4 +210,3 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
-# CONFIG_ARM_UNWIND is not set
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
