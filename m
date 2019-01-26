Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C98CC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 04:12:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F35AC218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 04:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i6xH5XEP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lraksk99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F35AC218A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Xj/L5TMqfaJbR+VbBYUWFDhs27dExprS/XoVBNP0MMw=; b=i6xH5XEPNUFZpzBEUlZo2O/lFZ
	58RLUqBFa4JOrIUA7tEkueayx290ott8VmAvLLUSMZSJnEBr5YXJmAjohhltFhtvzsjvh6dvGQpOp
	QsJH0OhTi2q/BrxvPB5pQmRRqVAuI7mhdKUsGFaywp/GoQUqKHevqFgfoCUMR8bilh00ejpZ/cYOS
	ewdzyiNMlfV9tFcZqkpR5uITtqlm/+NZCZc0PObn2BMGFYUAoNk6rvriLmGpLuwt31xZvrY3lI6of
	ZOQrMrxEftIY7FE+Y5Pq1OXtUjTN8fr0lugQraKPHU4qrv23z9Ba+8YTMyHsMYsacHgXckoV8oAsj
	fcDc1TLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnFKL-00045j-2m; Sat, 26 Jan 2019 04:12:17 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnFJQ-0003I8-4p
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 04:11:23 +0000
Received: by mail-pf1-x441.google.com with SMTP id b7so5639345pfi.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 20:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6n/1pZVNoLogyX+K/gR163sI6cwrL7Mu1c32gRBtLNk=;
 b=Lraksk99Qc/bC8ojQxeOsDr8dDsOFF+pmDXRQUpvi12Kr9E6bWep1TFsPLaWPqhx9s
 ivZL7SjJWV5VdhtUO7vMvFO9Vi29dYJD6pe3xG32YMUrVAYt8NQ/jzmTqezEdRc5dJtP
 puGEn7GNNh45dQMYt1hk71cj1+VGU0Ky+tbBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6n/1pZVNoLogyX+K/gR163sI6cwrL7Mu1c32gRBtLNk=;
 b=RHujxe81tdzOipaX295ACF9IFBr+jm9ijTnrWJlL/MPns/Y5wQUObAymWZqDbLixf+
 2mViLUNG8BiNgvRi0HOvtCrQpb+z1qjoinVDUVxD/CvoPxUgT6cy0YeX06o4x/W1eshp
 MdeArpHs7JpDlYqdQgDurcpKby0SzuFnMDcBPLim1TprafZ5F735sOjMSStF1GPFpA5u
 HsPcReypbA73ZI8hwWDFaU+x7dExYEhDVaIq3/TOmpj4CTVBHQ5iDfII7UtaIdXFhvpP
 +klQjIWeigkmu3fGwgwlSzgUQSe57TV7H0TQeAgJkHQjWw1DVXHJdyJ1dNFqCziYBfU0
 QzNQ==
X-Gm-Message-State: AJcUukdt3Lm8u1nc+OqHCmv8gFSmOj7A/n5yOP3ubK0frpgtqMWr366C
 R9LXl8WPO0zJ3deA91qtIIsH
X-Google-Smtp-Source: ALg8bN5cwSYVgL/82NOA6+KtHdjnHiUFUCZBeId1ZrqYuzrssOF4FZUYzIvzwWyxOAj0iOdZNKMyiw==
X-Received: by 2002:a63:f615:: with SMTP id m21mr12605200pgh.428.1548475879189; 
 Fri, 25 Jan 2019 20:11:19 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:905:e69d:b1bd:9891:c622:302d])
 by smtp.gmail.com with ESMTPSA id h129sm75099676pfb.110.2019.01.25.20.11.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 20:11:18 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: robh+dt@kernel.org,
	arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/5] arm64: dts: bitmain: Add BM1880 SoC support
Date: Sat, 26 Jan 2019 09:40:39 +0530
Message-Id: <20190126041041.13173-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
References: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_201120_503984_885FB788 
X-CRM114-Status: GOOD (  15.08  )
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

Add devicetree support for Bitmain BM1880 SoC, consisting of a Dual
core ARM Cortex A53 subsystem, a Single core RISC-V subsystem and a Tensor
Processor subsystem. Only ARM Cortex A53 Application processor subsystem
support is enabled for now.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/Makefile            |   1 +
 arch/arm64/boot/dts/bitmain/bm1880.dtsi | 119 ++++++++++++++++++++++++
 2 files changed, 120 insertions(+)
 create mode 100644 arch/arm64/boot/dts/bitmain/bm1880.dtsi

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 4690364d584b..5bc7533a12c7 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -7,6 +7,7 @@ subdir-y += amd
 subdir-y += amlogic
 subdir-y += apm
 subdir-y += arm
+subdir-y += bitmain
 subdir-y += broadcom
 subdir-y += cavium
 subdir-y += exynos
diff --git a/arch/arm64/boot/dts/bitmain/bm1880.dtsi b/arch/arm64/boot/dts/bitmain/bm1880.dtsi
new file mode 100644
index 000000000000..55a4769e0de2
--- /dev/null
+++ b/arch/arm64/boot/dts/bitmain/bm1880.dtsi
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Linaro Ltd.
+ * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "bitmain,bm1880";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0>;
+			enable-method = "psci";
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x1>;
+			enable-method = "psci";
+		};
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		secmon@100000000 {
+			reg = <0x1 0x00000000 0x0 0x20000>;
+			no-map;
+		};
+
+		jpu@130000000 {
+			reg = <0x1 0x30000000 0x0 0x08000000>; // 128M
+			no-map;
+		};
+
+		vpu@138000000 {
+			reg = <0x1 0x38000000 0x0 0x08000000>; // 128M
+			no-map;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gic: interrupt-controller@50001000 {
+			compatible = "arm,gic-400";
+			reg = <0x0 0x50001000 0x0 0x1000>,
+			      <0x0 0x50002000 0x0 0x2000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+
+		uart0: serial@58018000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x58018000 0x0 0x2000>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart1: serial@5801A000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x5801a000 0x0 0x2000>;
+			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart2: serial@5801C000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x5801c000 0x0 0x2000>;
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart3: serial@5801E000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x5801e000 0x0 0x2000>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
