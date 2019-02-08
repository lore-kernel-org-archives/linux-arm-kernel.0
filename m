Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B55AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:24:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 289FF20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UfL1UMsX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="JShbsJUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289FF20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=HHBM0hxg/FYX7X5ipQr3UQ16Do9LTyNU2hjOOcAqOE4=; b=UfL1UMsX5Iewn7u3R4d/diZxnF
	2a00ewPIeG38jutqwLtXADhDmgrSiWfaXt3dB3s0vgB7NeNpHYGO+A4c6slN7InsvsVS194s2tkJ1
	4/TBsXCCv/0ZQWyAlKhO7bxUGmYgs51VLlT/JHheGVUP7BR7tLVYQNZSEUX4LdFuNEJX0uPsIyHpb
	Yxhsgu3zfZz8EogOZzx3NC0r1DUtaqfD5Qv5mSL/ubiUOWdzALt+tMvArWuBaCWXbkHT4XxOE7o3F
	KchtvEb8QdlKm8t6RD6PWqApe2knoae4qLP8luXVXizCC/Hl1r6gcka23N4BE1xoOcFJpgti9HFNe
	LiCiMtfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs4GF-0002XM-Jc; Fri, 08 Feb 2019 11:23:59 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs4Fp-0005IB-Or
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 11:23:53 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 7DDA425BF17;
 Fri,  8 Feb 2019 22:14:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1549624459; bh=sLuZy0QzFzPVBjcncmY9BFc44cxWx8KnghUYUKtF36w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JShbsJUo7GRwfcIMHTIMdjQUUgIpFQsGlEqMKiWzSWjezFg8jwIacP2MYhfp/ueIS
 kSCfmWRExb5j95ZAFHtBwj7scRpzSY2dtprrY1yWOGUUhRBQgFCriavmYtwrt9jtg/
 dNtb65Xwhn4CJQwqhimI+TNVCZSFX65RG4NF+yjI=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id EE1C1940A31; Fri,  8 Feb 2019 12:14:15 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 10/12] ARM: dts: r7s9210-rza2mevb: Add support for RZ/A2M EVB
Date: Fri,  8 Feb 2019 12:14:11 +0100
Message-Id: <3a62c2d2581497de89abbb2d7e0d2ade9b39433e.1549623128.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1549623128.git.horms+renesas@verge.net.au>
References: <cover.1549623128.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_032334_166567_80666F5F 
X-CRM114-Status: GOOD (  13.73  )
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
 Chris Brandt <chris.brandt@renesas.com>, Magnus Damm <magnus.damm@gmail.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Chris Brandt <chris.brandt@renesas.com>

Add support for Renesas RZ/A2M evaluation board.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile             |  1 +
 arch/arm/boot/dts/r7s9210-rza2mevb.dts | 82 ++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100644 arch/arm/boot/dts/r7s9210-rza2mevb.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index bd40148a15b2..3a3a931b431e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -843,6 +843,7 @@ dtb-$(CONFIG_ARCH_RENESAS) += \
 	r7s72100-genmai.dtb \
 	r7s72100-gr-peach.dtb \
 	r7s72100-rskrza1.dtb \
+	r7s9210-rza2mevb.dtb \
 	r8a73a4-ape6evm.dtb \
 	r8a7740-armadillo800eva.dtb \
 	r8a7743-iwg20d-q7.dtb \
diff --git a/arch/arm/boot/dts/r7s9210-rza2mevb.dts b/arch/arm/boot/dts/r7s9210-rza2mevb.dts
new file mode 100644
index 000000000000..991e09de1219
--- /dev/null
+++ b/arch/arm/boot/dts/r7s9210-rza2mevb.dts
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the RZA2MEVB board
+ *
+ * Copyright (C) 2018 Renesas Electronics
+ *
+ */
+
+/dts-v1/;
+#include "r7s9210.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/r7s9210-pinctrl.h>
+
+/ {
+	model = "RZA2MEVB";
+	compatible = "renesas,rza2mevb", "renesas,r7s9210";
+
+	aliases {
+		serial0 = &scif4;
+	};
+
+	chosen {
+		bootargs = "ignore_loglevel";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x40000000 0x00800000>;	 /* HyperRAM */
+	};
+
+	lbsc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		red {
+			gpios = <&pinctrl RZA2_PIN(PORT6, 0) GPIO_ACTIVE_HIGH>;
+		};
+		green {
+			gpios = <&pinctrl RZA2_PIN(PORTC, 1) GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+/* EXTAL */
+&extal_clk {
+	clock-frequency = <24000000>;	/* 24MHz */
+};
+
+/* RTC_X1 */
+&rtc_x1_clk {
+	clock-frequency = <32768>;
+};
+
+&pinctrl {
+	/* Serial Console */
+	scif4_pins: serial4 {
+		pinmux = <RZA2_PINMUX(PORT9, 0, 4)>,	/* TxD4 */
+			 <RZA2_PINMUX(PORT9, 1, 4)>;	/* RxD4 */
+	};
+};
+
+/* High resolution System tick timers */
+&ostm0 {
+	status = "okay";
+};
+
+&ostm1 {
+	status = "okay";
+};
+
+/* Serial Console */
+&scif4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&scif4_pins>;
+
+	status = "okay";
+};
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
