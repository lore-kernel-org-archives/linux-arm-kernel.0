Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6B8C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:33:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C8EF217FA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IPWu5r64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C8EF217FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=HzTTIICGEw6ir9VgfdHBcBs+3fCo1iCOn0cnMhGhc98=; b=IPW
	u5r643rVky+kUKa+jlpV5Ngt3HdcF07WrDjR+tWK3Wa5F+kvph806TtLsc7WJBfomE1Gfugj/v6KU
	B5F0S2uhthN+FDbqRH68V1rh/8wZjQp/BvODbzLytuu/pDA1nWqrQunOYrMTpVhDGw9s9FPo/RvEq
	nUGxQwPp+d0mn4W2LNIpBI5lMMuOY1e0HGceilcGpmVaN31qSwlNjJbrWTPSPbp3SLGeF4Hen/1wc
	nYHZO0ORX1UdcBopEeIoHBTWkqThr7p7wLVlJCmG8uWMoKU2DXGigGp79Ad8aqe5Hmi5Ci7TweKgB
	hTQadSbYhGrChU5pZ/ELpR/0qosrQlA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gta3d-0001QS-2r; Tue, 12 Feb 2019 15:33:13 +0000
Received: from albert.telenet-ops.be ([2a02:1800:110:4::f00:1a])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gta3Y-0001Pl-Kn
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 15:33:10 +0000
Received: from ramsan ([84.194.111.163]) by albert.telenet-ops.be with bizsmtp
 id brZ21z00A3XaVaC06rZ2S2; Tue, 12 Feb 2019 16:33:02 +0100
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1gta3P-0005xD-Vp; Tue, 12 Feb 2019 16:32:59 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1gta3P-0003Hz-T9; Tue, 12 Feb 2019 16:32:59 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
 Marek Vasut <marek.vasut+renesas@gmail.com>
Subject: [PATCH/RFC] arm64: dts: renesas: r8a77990: Add Ebisu-4D board support
Date: Tue, 12 Feb 2019 16:32:59 +0100
Message-Id: <20190212153259.12601-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_073308_840354_DC0CA64E 
X-CRM114-Status: GOOD (  14.57  )
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
 Takeshi Kihara <takeshi.kihara.df@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

Add initial support for the Renesas Ebisu-4D development board.

The Ebisu-4D board is very similar to the Ebisu board, but the memory
configuration is different.

  - The memory map of Ebisu-4D board is as follows:
      Bank0: 2 GiB RAM : 0x000048000000 -> 0x000bfffffff

  - The memory map of Ebisu board is as follows:
      Bank0: 1 GiB RAM : 0x000048000000 -> 0x0007fffffff

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Do we need this patch?

ATF v2.0-763-ga45ccf135e48 sees the full 2 GiB, but U-Boot
2019.01-00523-ge5fd39c88648 still sees only 896 MiB of RAM, and this
patch is needed to let Linux use the additional 1 GiB of RAM.

If U-Boot could see all RAM, it could update:
  1. the reg property in the memory node, and
  2. the dma-ranges property in the pcie node[*],
depending on the board, and we won't need separate DTSes for Ebisu and
Ebisu-4D.

[*] Looks like fdt_pci_dma_ranges() is called on Freescale platforms
    only?
---
 arch/arm64/boot/dts/renesas/Makefile          |  1 +
 .../boot/dts/renesas/r8a77990-ebisu-4d.dts    | 25 +++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77990-ebisu-4d.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 36c0429f62c7b7f7..b6630ffd0cbb255c 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -14,6 +14,7 @@ dtb-$(CONFIG_ARCH_R8A77965) += r8a77965-m3nulcb-kf.dtb
 dtb-$(CONFIG_ARCH_R8A77970) += r8a77970-eagle.dtb r8a77970-v3msk.dtb
 dtb-$(CONFIG_ARCH_R8A77980) += r8a77980-condor.dtb r8a77980-v3hsk.dtb
 dtb-$(CONFIG_ARCH_R8A77990) += r8a77990-ebisu.dtb
+dtb-$(CONFIG_ARCH_R8A77990) += r8a77990-ebisu-4d.dtb
 dtb-$(CONFIG_ARCH_R8A77995) += r8a77995-draak.dtb
 
 # SoCs lacking upstream board support
diff --git a/arch/arm64/boot/dts/renesas/r8a77990-ebisu-4d.dts b/arch/arm64/boot/dts/renesas/r8a77990-ebisu-4d.dts
new file mode 100644
index 0000000000000000..9f5bc7a7734f5fb8
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu-4d.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the Ebisu-4D board
+ *
+ * Copyright (C) 2018 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r8a77990-ebisu.dts"
+
+/ {
+	model = "Renesas Ebisu-4D board based on r8a77990";
+	compatible = "renesas,ebisu", "renesas,r8a77990";
+
+	memory@48000000 {
+		device_type = "memory";
+		/* first 128MB is reserved for secure area. */
+		reg = <0x0 0x48000000 0x0 0x78000000>;
+	};
+};
+
+&pciec0 {
+	/* Map all possible DDR as inbound ranges */
+	dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000>;
+};
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
