Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9392AC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:03:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6299A20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="llvWDyyU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xwTOHJme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6299A20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eQl1yemA8XoEZnwoVZiuHw1A+8JD0GFhXGys8cAbd6Q=; b=llvWDyyUhF9ckW
	2arqOnYnYTERHpv7PenI6QfGs4vWKhcWDq1mmM/Q8Q9cqis0XSS9tFyx1JblP5qFh7l7xuZDU8pLN
	F2B3QJX0QULQXOeYaT8U32UH8GH0JE9E7IdR6sdy41a66YVFAAyoTo1dTg3kpa/gCnzBIEEoNUhoo
	sTLlCF/SDV8maHBExBl0nfEsP6/VtvNWvdMECpFJvwcDeE+qWIB2DklkKvuCALhySkVkibQKsmVPf
	tLHFBqCRUSYW8RM8MnQSxu7cLSVvbhrNUQXKxuXeJGdJahlt4xx+QKnn6ZxAUGVOLjivo0T+Mz6of
	45Beay8M3mXeCZgbTnMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtYel-0003w0-Ti; Tue, 12 Feb 2019 14:03:27 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtYeP-0003ZB-T9
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 14:03:07 +0000
Received: by mail-wr1-x441.google.com with SMTP id x10so2784947wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 06:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jN5KUzfKX2ndr6TNL6ZWjgGyp82IoCOhgEMTMPUGQYI=;
 b=xwTOHJmeN1oYM8JlE57RDbdCpUcSAWOeO9lHTdXDTKiVHQiIa+5MBD5cuOrtV+0BHf
 mMQbWeeGTZpryJnbTRQvgb8Dd0l4MIxbnkR/BtWzOsXqqPf9ZYD8dVToUAz04ksTJnwr
 HlwbJRaQTmmZHasPLGYwDUVxMsFJ2HNQqTJKc38+zJmF+q+5dWh0IEvOo9/ilMYqiHRh
 abPQ79/KOJz3yNucAqOb59c76LpLe5kMbO6nBh6TsVbXKHXlgrNr1fqwyhhAMiRkpGM4
 Mp5tPJ/Ow2L5EcksZWxkKAtCSO4qN6OCeGdkck59td7MhioNMYzAN71KbGTfY7XKgMa7
 GBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jN5KUzfKX2ndr6TNL6ZWjgGyp82IoCOhgEMTMPUGQYI=;
 b=nejn+CUq9TccEOdEWC1zpaFfBsPG79wu5oHIHIzV9B3AlhaZ7MbmOXOeltgD0UJ5Tb
 MK320U+RVBjGd0orIUt9NOe8PYkehMj0LdLm81mIvoUfoPZU6JSfXUovqx+EpNPt6tPY
 K88AINzEUks6IopuswUJU/wAxZQAFvoRxXLXcOxM4dBfAiY61VnNeElTMaZjTsVSAEbx
 +9ZpXFOVfrwE65/7+52xcUEXf1MPGTOF6xFvH8i5zjHcbkn+RqeeDY+bVZ5Aj3vrMmxK
 HsQs329RmZgiTDdna/kI/63TpA3CdGvpi49AU2Jtaahl/Wo04NRuUvja2kXX7/79Umcm
 7skg==
X-Gm-Message-State: AHQUAuZy0fAx79k1YUdxQ2324BtSYjX4jEEze6D11tc2CQiB+6rHKxkI
 U0ydBWL/5MkGa76Io/SMGFEnDg==
X-Google-Smtp-Source: AHgI3IZX1WfsdFtWbVrcdrN2oLFP3xvftMrl/I8QnMfuGABwxEYTBvnxag+iyshx+3R1mAnqm4jStA==
X-Received: by 2002:adf:9083:: with SMTP id i3mr3030823wri.124.1549980184261; 
 Tue, 12 Feb 2019 06:03:04 -0800 (PST)
Received: from bender.baylibre.local
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id g10sm23435678wrq.81.2019.02.12.06.03.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 12 Feb 2019 06:03:03 -0800 (PST)
From: Neil Armstrong <narmstrong@baylibre.com>
To: khilman@baylibre.com
Subject: [PATCH 2/2] arm64: dts: Add SEI Robotics SEI510 Board
Date: Tue, 12 Feb 2019 15:02:59 +0100
Message-Id: <20190212140259.9537-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212140259.9537-1-narmstrong@baylibre.com>
References: <20190212140259.9537-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_060305_937161_522F7660 
X-CRM114-Status: GOOD (  15.30  )
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
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The SEI Robotics SEI510 Board is based on the Amlogic G12A S905X2
and has the following features :
- Amlogic G12A S905X2 SoC
- 10/100 Ethernet
- USB2 + USB3 ports
- Micro SDCard Port
- Audio + CVBS AV Jack port
- HDMI 2.1 + CEC Port
- ADC Touch Button
- Far-Field Microphone Array + Mono HP
- IR Sensor
- IR Emmiter LED Array
- RGB Led

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/arm/amlogic.txt       |  1 +
 arch/arm64/boot/dts/amlogic/Makefile          |  1 +
 .../boot/dts/amlogic/meson-g12a-sei510.dts    | 38 +++++++++++++++++++
 3 files changed, 40 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index 7f40cb5f490b..061f7b98a07f 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -110,6 +110,7 @@ Board compatible values (alphabetically, grouped by SoC):
 
   - "amlogic,u200" (Meson g12a s905d2)
   - "amediatech,x96-max" (Meson g12a s905x2)
+  - "seirobotics,sei510" (Meson g12a s905x2)
 
 Amlogic Meson Firmware registers Interface
 ------------------------------------------
diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 0821fed4c074..2709f7ede908 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_MESON) += meson-axg-s400.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-u200.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-g12a-sei510.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-x96-max.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nanopi-k2.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nexbox-a95x.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
new file mode 100644
index 000000000000..6a7c3241862a
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre SAS. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "meson-g12a.dtsi"
+
+/ {
+	compatible = "seirobotics,sei510", "amlogic,g12a";
+	model = "SEI Robotics SEI510";
+
+	aliases {
+		serial0 = &uart_AO;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x40000000>;
+	};
+
+	reserved-memory {
+		/* TEE Reserved Memory */
+		bl32_reserved: bl32@5000000 {
+			reg = <0x0 0x05300000 0x0 0x2000000>;
+			no-map;
+		};
+	};
+};
+
+&uart_AO {
+	status = "okay";
+};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
