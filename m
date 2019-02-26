Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57224C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:03:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25981213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VNjXqPNG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="C3FGAZLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25981213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aXwgvBHy+TT2bhCJm8HUiHB/uZg0r0Yfym7SU/nBUAU=; b=VNjXqPNGMlFSw8
	njpBotFPv720M4OIFsZ68m6bvJQZMeH3jbzPndYwpcMV4TMrNzOPy1CaJLRxwsSGQb3NSMrIx7+u/
	GWCK16doTVFjZjV5vV+sTrGjoWS4kCSOhGXA/lA0MURtWwr3gG6DO8O9nxKqYC0sZU+N3VYrJnCUL
	L/cqX6sWiZenIUyk7zy7k7dP7O1tMxIOJVTf9IMCQKLU3oYrnFSYqHb1VcqxBB25Om4jKtB+qqFN4
	ujAwTCcKeOMC6b1wsBZsS56a1J7EKlzqKG2jN8TeO/E18ZG/27GCWy9OmO73V0I7TByoc9PsYFDbE
	SaUHT7bjjqviFHB5i8BQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyVpf-0002jc-JL; Tue, 26 Feb 2019 06:03:11 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyVpV-0002XG-Kb
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 06:03:05 +0000
Received: by mail-pl1-x643.google.com with SMTP id q3so5696277pll.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 22:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AoctKyKOJPjwr3EAkL6gWK5ijQTvzyYNQS64venG094=;
 b=C3FGAZLPzmAjF1ZcQOyqCoWyAcb6dBdTeYSzX/AAqbkxy2Sdc7JcovaXc0w4ClNSjC
 ACfBpypzdAHiD9j/AFoRIlymqdwtBqZwO9M9IMcG5EKJTDG2iyLNlfkD/QeF857ojckO
 cEA/LSlDvtOUAMvnwyRuu8o2yWBEpICJs5tws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AoctKyKOJPjwr3EAkL6gWK5ijQTvzyYNQS64venG094=;
 b=pLiq+9c1hyAkMJm+U8Ymjzevgx+BRtcZ0q2wFGs/zRPLAoo53jqpvQqVR2l53SDT7v
 Ua1W252REcL4jH0/2YuxKNAZGHeUD27+A9yyJlFMHiHW3uIz2X1lBt3U4omfX1YR+gnX
 BZ6Wlc5mFfRZX66DE0jrJI+CTE2tH/tu4W82ZMBzTWz7ruQQ7M5KLljtbisit/NKiAKN
 2tLslf9Pm28KYUHAN9fTHf4hDm/DWZgsr5BLm3smU5RSw2mG1SvOehxEP8WJ42SQHGyT
 RDagSTRC7Yqyw3DEhnx8WcPlLmj7JYFaAnhvsUi//mnhmdYIMo/wuWCeA27vKpsjz1F0
 oU2A==
X-Gm-Message-State: AHQUAuZT/JE2gx/d2TEgj4upkp8UwJdA8BEK+W13AOHdlnCxn/OqHiUU
 1yyDV5+L3foP9G88xCTBOHkBoQ==
X-Google-Smtp-Source: AHgI3IZmbI+ZRwN2agqDLCvvlLp3XMhd2DbP985ztD4qjH2c2Ceu0PgTtEPBLlEMuJiQ8Uip/LcDuQ==
X-Received: by 2002:a17:902:7e49:: with SMTP id
 a9mr23212416pln.303.1551160980968; 
 Mon, 25 Feb 2019 22:03:00 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
 by smtp.gmail.com with ESMTPSA id v15sm18976940pfa.75.2019.02.25.22.02.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 22:03:00 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/2] arm64: allwinner: a64: Add Oceanic A64-5inMFD initial
 support
Date: Tue, 26 Feb 2019 11:32:40 +0530
Message-Id: <20190226060240.8783-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190226060240.8783-1-jagan@amarulasolutions.com>
References: <20190226060240.8783-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_220301_935880_C7AC9649 
X-CRM114-Status: GOOD (  14.95  )
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
Cc: devicetree@vger.kernel.org, Ryan Pannell <ryan@osukl.com>,
 linux-kernel@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Oceanic A64-5inMFD is a 5 inch Multi function display baseboard
designed to mount SoPine SOM.

Key features:
- Allwinner A64 Cortex-A53
- Mali-400MP2 GPU
- AXP803 PMIC
- 2GB DDR3 RAM
- SD Slot
- SPI-NOR flash
- EMAC, RTL8211E
- MCP2515 CAN
- MIPI-DSI
- Goodix 911 CTP
- USB Host
- 12V DC power supply

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/allwinner/Makefile        |  1 +
 .../allwinner/sun50i-a64-oceanic-5inmfd.dts   | 46 +++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5inmfd.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index a5fb1eaa8acf..ec39fe856117 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -2,6 +2,7 @@
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-amarula-relic.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-bananapi-m64.dtb sun50i-a64-bananapi-m64-icn6211.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-nanopi-a64.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-oceanic-5inmfd.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-olinuxino.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-orangepi-win.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pine64-lts.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5inmfd.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5inmfd.dts
new file mode 100644
index 000000000000..d73d1f55acb9
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5inmfd.dts
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2019 Oceanic Systems (UK) Ltd.
+ * Copyright (C) 2019 Amarula Solutions B.V.
+ * Author: Jagan Teki <jagan@amarulasolutions.com>
+ */
+
+/dts-v1/;
+
+#include "sun50i-a64-sopine.dtsi"
+
+/ {
+	model = "Oceanic A64-5inMFD";
+	compatible = "oceanic,a64-5inmfd", "allwinner,sun50i-a64";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pb_pins>;
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbphy {
+	status = "okay";
+};
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
