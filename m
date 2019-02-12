Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00B9C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:29:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DE0820842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e+BOamOJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BDCr7HLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE0820842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jYp9ihts3Rtd7dTz0rEDtAvQ1Hupmjrd8EqBv8V3P38=; b=e+BOamOJvNvKus
	pHQ5wnlDvLKHodpWas8IIBBmWY8XmeZG2PG8JoCk1ZOJ6vplW6kfGI6Nt/R/abhsUSKBAcFNhfNjk
	uRm3bvMdyAlGvcxeLTWdddEx1aYgXvL049+m7ipo2XAya4qnLKTmuiKna1Soto2YBGjLWQgnddNE7
	G6W754k1cXn/pX3yNz0BotIA27hjddzHMIq/TH2BkDeDSV0RewXGHMU2Re24v/+c2CrWo+OefhjR0
	gWn6abO9nrtDcBNJaIBbo6TxgcIOtv/T8tRSXVTtaiWBU7W7Z/iSBrw9BTLjxEHdLEraud2XJWMGo
	TievB/Ljr+wTdGXcxREg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtawI-0007Wt-1Z; Tue, 12 Feb 2019 16:29:42 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtavh-00070C-2A
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 16:29:08 +0000
Received: by mail-wr1-x442.google.com with SMTP id o17so3389304wrw.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 08:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b17QC1yK688ZWb10QT74DyiITU1l1NF57mYQWB4mILg=;
 b=BDCr7HLaHSqb428CRXZ/Z9TcOnEG95cpoVfxWv8J25RgsnhRbyTYrc+3Gqvue2yt5o
 OtjNL4O3IqninjuwGjxt3T8jQTSCATXqRPIoXTeuIBgCzGHFDZueLdHGdHeASD9P1gQb
 p9wLKnWshLm5O8OONHhdJphcHA69/mZmCqnIGbopu5RySfaTH9sF5J+pzMyb/yulX3Yo
 5d30M66PMQaflm/RHMM3CDl7PeN5GmsTu0fVm8jM5xEzA1EU5KCIV9dpSNVm+EBwNG6/
 9kJTCd3yucJayEP57E9yBSKPYqo0xwXmjasszjfDgbg2PfRTry8Utl+QT+iy1JqzL6W+
 29fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b17QC1yK688ZWb10QT74DyiITU1l1NF57mYQWB4mILg=;
 b=q5zqVxZmKEk+PngNwL3rdo9tRoek5WuCeRDuHH7Y6Ll2EKVFW15QAxNPOCZXT4CQk9
 Jj1HwgK0/9FV2JbPx5tkW0uI53Htt52gLAAzFdGQQuuLhva77y337Xn8GXKXyFMdgva4
 VslSxaP2zAyjwOfcShIgIzvR6c8O/WoAZGoh+HOO+9M8hdewxHT/ejeRUr2uZ6Y7gbXv
 jjTyTkY8OABn1dCHUVDbE7r6Ree7Fjo57I1etvvgEtTyVKC4vE+AeowESgTmro0uV34c
 bgXPYWzxPdguVVzOC300L2AkxcTvxlm87fa4wsGCgEjitpTcyeXvezHQfLE0Beg3NK/R
 U4Vw==
X-Gm-Message-State: AHQUAuZjLB4SiFy3M3jYTXRGj8wCqbsdbc5WqLemPz7LVqDE1ujfkrL7
 R/bnJeV/G1W8kdGgQoU8hc+BZQ==
X-Google-Smtp-Source: AHgI3IY8s6GmdUBtOUQFfSkBuVkNgpDYcmzMLfGgo/WKJn9PPQyGz1Cr8YNYgitIJ2HzRlcK6Sit8Q==
X-Received: by 2002:adf:91a7:: with SMTP id 36mr3352120wri.77.1549988942155;
 Tue, 12 Feb 2019 08:29:02 -0800 (PST)
Received: from bender.baylibre.local
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id z1sm7800876wrw.28.2019.02.12.08.29.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 12 Feb 2019 08:29:01 -0800 (PST)
From: Neil Armstrong <narmstrong@baylibre.com>
To: jbrunet@baylibre.com,
	devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: clk: add G12A AO Clock and Reset Bindings
Date: Tue, 12 Feb 2019 17:28:58 +0100
Message-Id: <20190212162859.20743-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212162859.20743-1-narmstrong@baylibre.com>
References: <20190212162859.20743-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_082905_119499_00646444 
X-CRM114-Status: GOOD (  14.47  )
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
 include/dt-bindings/clock/g12a-aoclkc.h       | 34 +++++++++++++++++++
 include/dt-bindings/reset/g12a-aoclkc.h       | 18 ++++++++++
 3 files changed, 53 insertions(+)
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
index 000000000000..8db01ffbeb06
--- /dev/null
+++ b/include/dt-bindings/clock/g12a-aoclkc.h
@@ -0,0 +1,34 @@
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
+#define CLKID_AO_SAR_ADC_CLK	18
+#define CLKID_AO_32K		23
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
