Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F21C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:29:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F4C821871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fOtDzQTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4C821871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tweak.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=gC02V+75w1lIGrfCagqSSZ5b8Ge+nxhCsc4IPd/8o6w=; b=fOtDzQTFn0uUGQAeoJqgZhJuUf
	SMK7r6LwJCm/RdnSMiReUgwegMwGqICycdTN+ipx9AzplpCQnuMt2KX7esMc0R1jUAliElT795fU0
	bMINQ1EkiTsGk2a/dmTr7tnShOqPfh1gZFuM1synRudcWXR4JX1BLjg5Ykg6ZjpsTSneFXBGyuyh/
	CHDoAVjg1xDbxV54ZSpSb49E/5fOwCc39RfeRtqA+w4paK38Qc6D2AVJsiFxj/x3AaAdd3EL2w51L
	uIHIHjiqYlS/ue0nCQNBB761FWle/WfknSJTgFDATcLarcxvBwt2NQOi3PFhzOTGbzpfeHwCwHt+Z
	+PEPgV3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZMvM-0000er-6M; Tue, 18 Dec 2018 21:29:08 +0000
Received: from palmtree.beeroclock.net ([178.79.160.154])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZMvI-0000dc-Tw
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 21:29:06 +0000
Received: from beros.lan (89-160-129-47.du.xdsl.is [89.160.129.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: karlp)
 by palmtree.beeroclock.net (Postfix) with ESMTPSA id F42321028D;
 Tue, 18 Dec 2018 21:28:12 +0000 (UTC)
From: Karl Palsson <karlp@tweak.net.au>
To: robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@bootlin.com,
 wens@csie.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] ARM: dts: sun8i: add FriendlyARM NanoPi Duo2-IoT Box
Date: Tue, 18 Dec 2018 21:24:57 +0000
Message-Id: <20181218212457.30382-3-karlp@tweak.net.au>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181218212457.30382-1-karlp@tweak.net.au>
References: <20181218212457.30382-1-karlp@tweak.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_132905_127959_963E4229 
X-CRM114-Status: GOOD (  12.69  )
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
Cc: Karl Palsson <karlp@tweak.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The IoT-Box is a dock for the NanoPi Duo2, adding two USB host ports, a
10/100 ethernet port, a variety of pin headers for i2c and uarts, and a
quad band 2G GSM module, a SIM800C.

Full documentation and schematics available from vendor:
http://wiki.friendlyarm.com/wiki/index.php/NanoPi_Duo2_IoT-Box

Signed-off-by: Karl Palsson <karlp@tweak.net.au>
---
 arch/arm/boot/dts/Makefile                        |  1 +
 arch/arm/boot/dts/sun8i-h3-nanopi-duo2-iotbox.dts | 45 +++++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-nanopi-duo2-iotbox.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7f296bfea94a..b62d84639c7a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1064,6 +1064,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-h3-libretech-all-h3-cc.dtb \
 	sun8i-h3-mapleboard-mp130.dtb \
 	sun8i-h3-nanopi-duo2.dtb \
+	sun8i-h3-nanopi-duo2-iotbox.dtb \
 	sun8i-h3-nanopi-m1.dtb	\
 	sun8i-h3-nanopi-m1-plus.dtb \
 	sun8i-h3-nanopi-neo.dtb \
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-duo2-iotbox.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-duo2-iotbox.dts
new file mode 100644
index 000000000000..4e7fae4046a8
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-duo2-iotbox.dts
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2018 Karl Palsson <karlp@tweak.net.au>
+ */
+
+#include "sun8i-h3-nanopi-duo2.dts"
+
+/ {
+	model = "FriendlyARM NanoPi Duo2 IoT Box";
+	compatible = "friendlyarm,nanopi-duo2-iotbox",
+		"friendlyarm,nanopi-duo2",
+		"allwinner,sun8i-h3";
+};
+
+&ehci2 {
+	status = "okay";
+};
+
+&ehci3 {
+	status = "okay";
+};
+
+&ohci2 {
+	status = "okay";
+};
+
+&ohci3 {
+	status = "okay";
+};
+
+&emac {
+	phy-handle = <&int_mii_phy>;
+	phy-mode = "mii";
+	allwinner,leds-active-low;
+	status = "okay";
+};
+
+/* Not addressed, SIM800C module on uart3 */
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>, <&uart3_rts_cts_pins>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
-- 
2.14.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
