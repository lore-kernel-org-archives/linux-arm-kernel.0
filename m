Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CEFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:59:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55ABD2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VLOujf1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55ABD2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=3QzMX/g7ZOw6rYpt4Sk7N/ryS8f3RbC6OkmXEzkSZpY=; b=VLO
	ujf1fH6OwHz27h1Y7ZEbUUVyeYdQNEYjST+rEQGWbXiFdf++5Qqz6BRRaRCclufbb53k1PxK1BZID
	pkpUFtmvhizq2AgkODHATtlbeslA2OSeaprjS/xoA0WuWoI9TVe2FlY8nhCpOrAj8o87fLuWiid/a
	i4XQW1wBSui5otVbSqELaNL9H8ZMWKI+UIM3q+s7J3aqS8sq+6prKQ80znoAe9rHpNJ/WaTAYhVx8
	5sMqOnGD2ZiUnyDUCLx/ctnv6J/B4AtvsbT97mex9HdAuViKyC7/1VIOa3YYUCaW46dk80h3nLTUG
	8LEkm7WujMvhaM8vOnSZCMyxy0nqutg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWYe-0004n7-Sx; Fri, 18 Jan 2019 15:59:48 +0000
Received: from laurent.telenet-ops.be ([2a02:1800:110:4::f00:19])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWYa-0004mX-Sx
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 15:59:46 +0000
Received: from ramsan ([84.194.111.163]) by laurent.telenet-ops.be with bizsmtp
 id Rrzf1z00e3XaVaC01rzfYb; Fri, 18 Jan 2019 16:59:40 +0100
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1gkWYV-0008Ln-NZ; Fri, 18 Jan 2019 16:59:39 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1gkWYV-0003AI-Ln; Fri, 18 Jan 2019 16:59:39 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] ARM: shmobile: defconfig: Refresh for v5.0-rc2
Date: Fri, 18 Jan 2019 16:59:38 +0100
Message-Id: <20190118155938.12124-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_075945_165777_EBAFF753 
X-CRM114-Status: UNSURE (   8.96  )
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
Cc: linux-renesas-soc@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

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
---
 arch/arm/configs/shmobile_defconfig | 45 ++++++++++++++---------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index fdac4e4ca04d7380..14e9255e48c3184e 100644
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
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
