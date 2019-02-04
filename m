Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713E6C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:14:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3232C217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sr3LVS/j";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZzaVL1Ck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3232C217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FJhETtVbJqr3EHDTTrgKebmnueRd479bD19yHu3CbjA=; b=Sr3LVS/jE8L8WP
	VNRm/mkUhcuqGbKsxCDWHinC0rdep3CtuVlxAgsknWb/XVcLDfLdD6CGgILB3ZwUFacZAQqOalDNd
	fhQ4tBb7fKep6yb6ePd+zSuCA3QMsuk+bQXGLxYIc2nINIPZ5wN9L0g1oH6gyvdF2CJTuhEq1QFSD
	wlXUBeQo5md69ip72sdbXPt2Ev8yDyknEATmcB9iKO8M4ZVCAqRO9ESGMFJUF1ViOLZXW7hKhrDq4
	1PVVI5h10WdlH6IsJeX9CfAZ4K1MU0JlbChqXRqdzVB8woODIzMbqFtKO7HrQhIa3J0UxspHrPcah
	FmBCTqlQIJFdQKsLKV1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqaKI-0006Ps-E9; Mon, 04 Feb 2019 09:14:02 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqaJt-00062Q-OL
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 09:13:40 +0000
Received: by mail-wm1-x344.google.com with SMTP id t200so12592014wmt.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 01:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qRFps4rTH6IlI/m1hA3k1VKN65sKr7puuSoPmKtgNnI=;
 b=ZzaVL1CkKf/ybzZ9MIH47q7+b+mk11B4FoLWsbiPdYGLA9b3qP2E3yRPSZVwDvCNtG
 qtcFOt79pFjaL/PhO1v3+ul/LoyPwBABuyivCJskeqSRwT3RVEu1jnFiRNBdWh7skcjT
 yAR1lCgtFrr/1PWxLQ0TlDM5bZmFxaiiQSXh/fqnW4/+MBYNaCCJPyaTqJiIV5Uijm+8
 P2P5FHBzyNMwCo0D8iGV+ON8KavtumkzUYaBUxH0vOtSfb5pxPcWlV+KZLimCTdA/qiT
 gq8sKgEyJN8fwRb065ip7lr5h89lcwsYFrRJknjNt7HJmfOUsjL3W/+RC2SOLBlPgWDf
 VyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qRFps4rTH6IlI/m1hA3k1VKN65sKr7puuSoPmKtgNnI=;
 b=msrSODcEO/1vOA0iBPfTtXvkodEFXtikCWGh+xF9otANbfVyov5a/B8LjRaLgu0ySQ
 zIZH9GXFLOIBVNZYNwTwONzx7O0juu25OUm3HFZtiY2CK6UTJ7kpbGGKbEoyAYI7y3br
 /SgI0PGnWJIpsULyRC0/9GbWQG7hsI/mzaPWB6ONzcETV2RlO4X97KB9uw3ssCxSEX+F
 kOuaFnDO8bjTIRGUmtMC5bsp0yP5YPK45GCT5rB1hzZ8rs52Xa24D+6rVJFjjBusXAyy
 GjoZxy5xPEwS1MCaIfaWzypMGf6BIrlcWPKMgG4xKmGOmzmIeLK3wYuaMdoJoO3KUVln
 Vudw==
X-Gm-Message-State: AHQUAuZ8bkjUw0zPWdNHSml38Lt5+eEcA3rKkRkCcN6SSPtWrL634eFv
 DMTxtlmjl4f8LeaABw4HKGzCAA==
X-Google-Smtp-Source: AHgI3IaX3vwTt3RLGEf/fWsY40o2IkqawBgxFlQUfKncDMRVm8ZvnxgmYFe1Z3OGt/2XQHlPjDHmeA==
X-Received: by 2002:a1c:35ca:: with SMTP id
 c193mr12192319wma.146.1549271615609; 
 Mon, 04 Feb 2019 01:13:35 -0800 (PST)
Received: from bender.baylibre.local
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id m21sm9371390wmi.43.2019.02.04.01.13.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 04 Feb 2019 01:13:35 -0800 (PST)
From: Neil Armstrong <narmstrong@baylibre.com>
To: jbrunet@baylibre.com,
	devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: clk: add G12A AO Clock and Reset Bindings
Date: Mon,  4 Feb 2019 10:13:29 +0100
Message-Id: <20190204091331.9298-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204091331.9298-1-narmstrong@baylibre.com>
References: <20190204091331.9298-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_011337_798191_85F28CE1 
X-CRM114-Status: GOOD (  14.81  )
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
Cc: linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add bindings for the Amlogic G12A AO Clock and Reset controllers.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../bindings/clock/amlogic,gxbb-aoclkc.txt    |  1 +
 include/dt-bindings/clock/g12a-aoclkc.h       | 43 +++++++++++++++++++
 include/dt-bindings/reset/g12a-aoclkc.h       | 18 ++++++++
 3 files changed, 62 insertions(+)
 create mode 100644 include/dt-bindings/clock/g12a-aoclkc.h
 create mode 100644 include/dt-bindings/reset/g12a-aoclkc.h

diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
index 79511d7bb321..c41f0be5d438 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
+++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
@@ -10,6 +10,7 @@ Required Properties:
 	- GXL (S905X, S905D) : "amlogic,meson-gxl-aoclkc"
 	- GXM (S912) : "amlogic,meson-gxm-aoclkc"
 	- AXG (A113D, A113X) : "amlogic,meson-axg-aoclkc"
+	- G12A (S905X2, S905D2, S905Y2) : "amlogic,meson-g12a-aoclkc"
 	followed by the common "amlogic,meson-gx-aoclkc"
 - clocks: list of clock phandle, one for each entry clock-names.
 - clock-names: should contain the following:
diff --git a/include/dt-bindings/clock/g12a-aoclkc.h b/include/dt-bindings/clock/g12a-aoclkc.h
new file mode 100644
index 000000000000..997aca16c94f
--- /dev/null
+++ b/include/dt-bindings/clock/g12a-aoclkc.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/*
+ * Copyright (c) 2016 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * Copyright (c) 2018 Amlogic, inc.
+ * Author: Qiufang Dai <qiufang.dai@amlogic.com>
+ */
+
+#ifndef DT_BINDINGS_CLOCK_AMLOGIC_MESON_G12A_AOCLK
+#define DT_BINDINGS_CLOCK_AMLOGIC_MESON_G12A_AOCLK
+
+#define CLKID_AO_AHB		0
+#define CLKID_AO_IR_IN		1
+#define CLKID_AO_I2C_M0		2
+#define CLKID_AO_I2C_S0		3
+#define CLKID_AO_UART		4
+#define CLKID_AO_PROD_I2C	5
+#define CLKID_AO_UART2		6
+#define CLKID_AO_IR_OUT		7
+#define CLKID_AO_SAR_ADC	8
+#define CLKID_AO_MAILBOX	9
+#define CLKID_AO_M3		10
+#define CLKID_AO_AHB_SRAM	11
+#define CLKID_AO_RTI		12
+#define CLKID_AO_M4_FCLK	13
+#define CLKID_AO_M4_HCLK	14
+#define CLKID_AO_CLK81		15
+#define CLKID_AO_SAR_ADC_SEL	16
+#define CLKID_AO_SAR_ADC_DIV	17
+#define CLKID_AO_SAR_ADC_CLK	18
+#define CLKID_AO_CTS_OSCIN	19
+#define CLKID_AO_32K_PRE	20
+#define CLKID_AO_32K_DIV	21
+#define CLKID_AO_32K_SEL	22
+#define CLKID_AO_32K		23
+#define CLKID_AO_CEC_PRE	24
+#define CLKID_AO_CEC_DIV	25
+#define CLKID_AO_CEC_SEL	26
+#define CLKID_AO_CEC		27
+#define CLKID_AO_CTS_RTC_OSCIN	28
+
+#endif
diff --git a/include/dt-bindings/reset/g12a-aoclkc.h b/include/dt-bindings/reset/g12a-aoclkc.h
new file mode 100644
index 000000000000..bd2e2337135c
--- /dev/null
+++ b/include/dt-bindings/reset/g12a-aoclkc.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/*
+ * Copyright (c) 2016 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#ifndef DT_BINDINGS_RESET_AMLOGIC_MESON_G12A_AOCLK
+#define DT_BINDINGS_RESET_AMLOGIC_MESON_G12A_AOCLK
+
+#define RESET_AO_IR_IN		0
+#define RESET_AO_UART		1
+#define RESET_AO_I2C_M		2
+#define RESET_AO_I2C_S		3
+#define RESET_AO_SAR_ADC	4
+#define RESET_AO_UART2		5
+#define RESET_AO_IR_OUT		6
+
+#endif
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
