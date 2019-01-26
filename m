Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98466C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 04:12:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CBB6218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 04:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HEDl1fc1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R18l4W5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CBB6218A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=yAkArzw5mBeeIIr1MKiQEd9WLRbqVOfpY2Sf/iLNAL4=; b=HEDl1fc1Ri6CxFGYMHV787TfXP
	0LPqpn3tpKJ19VpcH8z1C1DyBaUVOOn7+osCIuD+AiDUf1zoprnmtUp/6IcLbM9jaYKijg1/hdKRy
	TWJVrUVI5NYPeEuxkh88sJ5R/0qCRJKDz8pVw2ekeQRfnJqFR/5vUblJxhYORG9/XG7gZpRKY5HHe
	C0qoOkFqknzPK03Emliwg4i71TLCGX8HDxm/2YWhd7viaZtt5yHP7isWryBIAFyZKH74ct3ZMRSgS
	W5tugHpxiDvvU5SOGZdEMLm3PuT0t1XNenNGyU10mLyca13/ZFMgClKhNzotBCv0ujA0Kt7XlyLt+
	lc4JDhPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnFK7-0003tx-Fx; Sat, 26 Jan 2019 04:12:03 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnFJX-0003No-Cl
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 04:11:36 +0000
Received: by mail-pg1-x544.google.com with SMTP id n2so5018321pgm.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 20:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/Dlsm30B9KuTOu0GLcpGbceT3Bf9eF5q8ffkTHhPK10=;
 b=R18l4W5OI7MT0OK4nLJAsmi8khYt/36YKWTv5ckk2NTnitUlKl72fIqBCfmvsQN3as
 qBR872ibrOcIUJkPaiTAlt4BjlDOY+cc0IPemlJn5jr5bNKFoFI2i3DEvowPRV6Qsw34
 e8SNnZ7+l3wPAp8E9Q3H1rDVkLzcNZCCB7cSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/Dlsm30B9KuTOu0GLcpGbceT3Bf9eF5q8ffkTHhPK10=;
 b=L8HI6fft2a4n0Ibsp8RnZAMnJaRZFXamtXuV1UeGAdUCQ1l9b/1elg1UvYB/p91xOz
 I/POsdt3iTGXAXcxrHP+URYUShlBvS0law1fr613rct9SxQnQJBPdxDb2PDmeWAdBLhQ
 xvmt5yZVgeA/danAJk1fQWXDrdTzp444uRjA+TT4Nch88CHwkq7D71+yI1Le9M8p99Pg
 3f1EzteUtvkNKt776vekr1tCPwFxxsExniafMObrD1A/mflMlWxUh4JohsnciicXyui2
 NVKqjuVZiOPEI8ezxWfOmVHMWhsiSQH/J5Ap+p22dgayR2XXTnP7Nf8iUwYw2imAk2xO
 WTEw==
X-Gm-Message-State: AJcUukd9hqDKdt3AppyV86UnuyHdXnBJgFE8jvYwj+e7gKFK7rD7+Q2Y
 qkRPH2tWzzvVrQ+tb2jhGQHr
X-Google-Smtp-Source: ALg8bN4JSzb6u5ERSDZfaPGotK5jNqyeieNtXwX7Y4wLRt4M8ZupFvHXqLZoqM/vdUeYYooFMWBe0w==
X-Received: by 2002:a63:4b60:: with SMTP id k32mr12318387pgl.186.1548475885231; 
 Fri, 25 Jan 2019 20:11:25 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:905:e69d:b1bd:9891:c622:302d])
 by smtp.gmail.com with ESMTPSA id h129sm75099676pfb.110.2019.01.25.20.11.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 20:11:24 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: robh+dt@kernel.org,
	arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/5] arm64: dts: bitmain: Add Sophon Egde board support
Date: Sat, 26 Jan 2019 09:40:40 +0530
Message-Id: <20190126041041.13173-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
References: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_201127_793116_44EFC9A4 
X-CRM114-Status: GOOD (  13.43  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, darren.tsao@bitmain.com,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 haitao.suo@bitmain.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add devicetree support for Sophon Edge board from Bitmain based on
BM1880 SoC. This board is one of the 96Boards Consumer and AI platform.
More information about this board can be found in 96Boards product page:

https://www.96boards.org/documentation/consumer/sophon-edge/

Only UART peripheral support is enabled for now.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/bitmain/Makefile          |  3 ++
 .../boot/dts/bitmain/bm1880-sophon-edge.dts   | 50 +++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 arch/arm64/boot/dts/bitmain/Makefile
 create mode 100644 arch/arm64/boot/dts/bitmain/bm1880-sophon-edge.dts

diff --git a/arch/arm64/boot/dts/bitmain/Makefile b/arch/arm64/boot/dts/bitmain/Makefile
new file mode 100644
index 000000000000..be90a6071be0
--- /dev/null
+++ b/arch/arm64/boot/dts/bitmain/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+dtb-$(CONFIG_ARCH_BITMAIN) += bm1880-sophon-edge.dtb
diff --git a/arch/arm64/boot/dts/bitmain/bm1880-sophon-edge.dts b/arch/arm64/boot/dts/bitmain/bm1880-sophon-edge.dts
new file mode 100644
index 000000000000..6a3255597138
--- /dev/null
+++ b/arch/arm64/boot/dts/bitmain/bm1880-sophon-edge.dts
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Linaro Ltd.
+ * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ */
+
+/dts-v1/;
+
+#include "bm1880.dtsi"
+
+/ {
+	compatible = "bitmain,sophon-edge", "bitmain,bm1880";
+	model = "Sophon Edge";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart2;
+		serial2 = &uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x1 0x00000000 0x0 0x40000000>; // 1GB
+	};
+
+	uart_clk: uart-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <500000000>;
+		#clock-cells = <0>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+	clocks = <&uart_clk>;
+};
+
+&uart1 {
+	status = "okay";
+	clocks = <&uart_clk>;
+};
+
+&uart2 {
+	status = "okay";
+	clocks = <&uart_clk>;
+};
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
