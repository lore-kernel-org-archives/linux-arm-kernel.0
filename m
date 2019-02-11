Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C55DC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 05:56:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04EC52070C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 05:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dlvwqv6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04EC52070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilka.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8A1c1J+wmso2/Co7E7qlWbthz9gfYvcL+UkZQVn2SJI=; b=Dlvwqv6HwMImpp
	aMsJ0HtuKvAkmvYArd9RqUBobA3fr/wxduhKDSJeYovU6md1AO/M02o4CPMpx7H8HY7vEdbk91O7/
	8MN3yTQZNHCjY2AeZNN2L5lqYP7OghAN3AMjrJju3CXjEW9xB4fVIIqjzX7jqe4Vuac9J0LSJttnB
	dcmxZSaudD6tOZiV81TQvKhaWc9G9dafPhFLEEVOf41/Wl7IBzKLasZB61IQx0RwNpjbsb4tsE0Q0
	E+luMhbm4TLtTT0vYLwWm0f9d62qh9SmXZ28be6j37bP4qVXQcwvdEe8JYNvM8uwaq5dET2+BegZO
	sVUQvBCeahA03pMbFA3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt4a1-0004Ma-S0; Mon, 11 Feb 2019 05:56:33 +0000
Received: from bbb.xilka.com ([2001:470:1f11:5a5:16da:e9ff:fe11:e54b]
 helo=xilka.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt4ZX-0002R1-MH
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 05:56:05 +0000
Received: from bbb.internal (localhost.localdomain [IPv6:0:0:0:0:0:0:0:1])
 by xilka.com (8.15.2/8.15.2) with ESMTP id x1B5rteb022225;
 Sun, 10 Feb 2019 22:53:59 -0700
From: Kelly Anderson <kelly@xilka.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] add armada-3720-expressobin-v7.dts,
 overlays armada-3720-expressobin.dts with changes for new model
Date: Sun, 10 Feb 2019 22:53:50 -0700
Message-Id: <20190211055350.22181-3-kelly@xilka.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211055350.22181-1-kelly@xilka.com>
References: <20190211055350.22181-1-kelly@xilka.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_215603_992007_5BB6872F 
X-CRM114-Status: GOOD (  10.84  )
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
Cc: Kelly Anderson <kelly@xilka.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Signed-off-by: Kelly Anderson <kelly@xilka.com>
---
 arch/arm64/boot/dts/marvell/Makefile          |  1 +
 .../marvell/armada-3720-espressobin-v7.dts    | 42 +++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 2eff1f927471..f5feaea4db53 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -2,6 +2,7 @@
 # Mvebu SoC Family
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-v7.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-7040-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-clearfog-gt-8k.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-db.dtb
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
new file mode 100644
index 000000000000..583db1f5ffa3
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree file for Globalscale Marvell ESPRESSOBin Board
+ * Copyright (C) 2016 Marvell
+ *
+ * Kelly Anderson <kelly@xilka.com>
+ *
+ */
+/*
+ * Schematic available at http://wiki.espressobin.net/tiki-download_file.php?fileId=200
+ */
+
+#include "armada-3720-espressobin.dts"
+
+/ {
+	model = "Globalscale Marvell ESPRESSOBin Board rev.7";
+	compatible = "globalscale,espressobin-rev7", "globalscale,espressobin", "marvell,armada3720", "marvell,armada3710";
+};
+
+&spi0 {
+	flash@0 {
+		compatible = "mxicy,mx25u3235f", "jedec,spi-nor";
+	};
+};
+
+&mdio {
+	/* for ESPRESSObin HW rev.7, we swapped the wan and lan1 port */
+	switch0: switch0@1 {
+		ports {
+			port@1 {
+				reg = <1>;
+				label = "lan1";
+				phy-handle = <&switch0phy0>;
+			};
+			port@3 {
+				reg = <3>;
+				label = "wan";
+				phy-handle = <&switch0phy2>;
+			};
+		};
+	};
+};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
