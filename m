Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49076C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:38:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E942E206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gQ20TEJt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="t45TfQUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E942E206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=KUaV8WEPQ8QIlnHqWdCYO8wXlX+OB9tRJPdWlzvoOyM=; b=gQ20TEJtpNUHrK
	c/60VgFVhRY+pGbVlIuZxGR8oSqDREiPTOkVj41rDBuYko9m5DfnHZbQP0gyBmEtG1Zn0U3pWdm3L
	6MQi+RplDSO+8xvDhBO+Vn0+MMYVsMAfHCoTT6xMSf3W+bSOcHfXXVFPPdxatZUIGh/ZlQr+tZw1R
	7cTD39ygyRnXNII6pbIuYvUI2MHmV42jFolYNMsCLsnFE/H+qPCbYfzPeFN+0lzyF5tgIFSLnn6YP
	yAqVc2rcxQrNigahJYshyJ+QMKTre+H5O4ZGLor/+81zZvTVjNSzuT7zDwSVqn7YREnGtJmEhRXAO
	eTf4eaLVY1Ai2nmAH0sA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtb58-00032e-8E; Tue, 12 Feb 2019 16:38:50 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtb54-00031V-4b
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 16:38:48 +0000
Received: by mail-wr1-x444.google.com with SMTP id o17so3428521wrw.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 08:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ClTUzezi3cfuWIoAAbFTrjOhNUbiBoeL1rpDXNmQzB4=;
 b=t45TfQUBTPQ+9tg2cFrO4qK/7DJLyUHFwlXzvpynxsp4PrnN/0h9ZjidtgSuF1xuMw
 i1WmiU+eQLrvqbJfTBEWVEJ+jxcJu44n3Qkefc07sC/pzAePq+zIYieXrUksRb30gNqb
 wy6gNLVd+YQXMFP1jIXR92XeoNcZ8xL6KK7olZp+VeYeWn2jiseLnDdKXDm33nmm0p5D
 OaU2xUthA+UJjSJ0UINM7zU7SVUmtkS/kF/6jwjs2NZddUQtk2RmHu+f+YMOg7bBLfW0
 0S3mvIimyaHiU/Jwo72ANMpoXlfhKUolmRnbqZx3RKiH07eBYl7q3sIhYEapz9wGwi/6
 iKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ClTUzezi3cfuWIoAAbFTrjOhNUbiBoeL1rpDXNmQzB4=;
 b=fZ0fYLUGfJxHz4gE/+aTHRcIfAHaZA5A9iZkzrGmsNrH2wAajSk7f/80dYbLcHQYFU
 KG5R+h2Tmpr1pTxiuN/mAq5WcYuKLVBehlH1tZDeMFokOuA4Tzc+r/JU5KNgpSJqZvWh
 p+RCvCVAMsBpMI7FY5Y3gceit7BiesXcPETViU8atL5CkGjcPyfVQGLHWbzPBKb6066V
 ZCezNtatXYVbT8t9jE9yLaYChieStCqd7de8hH9pvNbeDB2aWGDvid6yB5T95UNoU0mf
 haHX1M+0Ssk2Y3q4nyfZ4gO8h1qaHlh7tDhRBukw5r1vBuWHAPQ/KLfKYDHCCDiSX0jE
 nSBw==
X-Gm-Message-State: AHQUAuZ4xG8GaR5B6VMs5YaIft8WWe2jgSsrYybsb9OJzCpgNLVdHJ3U
 bx+F0EeZGC/7QCIbPI6oztxh/Q==
X-Google-Smtp-Source: AHgI3IYKvyjBpIFDL2NL4yYJsmSAtaHCmuisSBlNRPvAGGCeHH/otyUc+Rht553ENztIiMblhDsiZQ==
X-Received: by 2002:adf:eb07:: with SMTP id s7mr3670318wrn.158.1549989524502; 
 Tue, 12 Feb 2019 08:38:44 -0800 (PST)
Received: from bender.baylibre.local
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id v6sm10325610wro.57.2019.02.12.08.38.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 12 Feb 2019 08:38:43 -0800 (PST)
From: Neil Armstrong <narmstrong@baylibre.com>
To: daniel@ffwll.ch
Subject: [PATCH v2] dt-bindings: gpu: add bindings for the ARM Mali Bifrost GPU
Date: Tue, 12 Feb 2019 17:38:38 +0100
Message-Id: <20190212163838.22644-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_083846_188293_C09DA8D8 
X-CRM114-Status: GOOD (  13.67  )
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
Cc: devicetree@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the bindings for the Bifrost family of ARM Mali GPUs.

The Bifrost GPU architecture is similar to the Midgard family,
but with a different Shader Core & Execution Engine structures.

Bindings are based on the Midgard family bindings, but the inner
architectural changes makes it a separate family needing separate
bindings.

The Bifrost GPUs are present in a number of recent SoCs, like the
Amlogic G12A Family, and many other vendors.
The Amlogic vendor specific compatible is added to handle the
specific IP integration differences and dependencies.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
Changes since v1:
- adding missing G31 and G52
- fixed example

 .../bindings/gpu/arm,mali-bifrost.txt         | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
new file mode 100644
index 000000000000..04a1d63ee578
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
@@ -0,0 +1,96 @@
+ARM Mali Bifrost GPU
+====================
+
+Required properties:
+
+- compatible :
+  * Must contain one of the following:
+    + "arm,mali-g31"
+    + "arm,mali-g51"
+    + "arm,mali-g52"
+    + "arm,mali-g71"
+    + "arm,mali-g72"
+    + "arm,mali-g76"
+  * which must be preceded by one of the following vendor specifics:
+    + "amlogic,meson-g12a-mali"
+
+- reg : Physical base address of the device and length of the register area.
+
+- interrupts : Contains the three IRQ lines required by Mali Bifrost devices.
+
+- interrupt-names : Contains the names of IRQ resources in the order they were
+  provided in the interrupts property. Must contain: "job", "mmu", "gpu".
+
+
+Optional properties:
+
+- clocks : Phandle to clock for the Mali Bifrost device.
+
+- mali-supply : Phandle to regulator for the Mali device. Refer to
+  Documentation/devicetree/bindings/regulator/regulator.txt for details.
+
+- operating-points-v2 : Refer to Documentation/devicetree/bindings/opp/opp.txt
+  for details.
+
+- resets : Phandle of the GPU reset line.
+
+Vendor-specific bindings
+------------------------
+
+The Mali GPU is integrated very differently from one SoC to
+another. In order to accomodate those differences, you have the option
+to specify one more vendor-specific compatible, among:
+
+- "amlogic,meson-g12a-mali"
+  Required properties:
+  - resets : Should contain phandles of :
+    + GPU reset line
+    + GPU APB glue reset line
+
+Example for a Mali-G31:
+
+gpu@ffa30000 {
+	compatible = "amlogic,meson-g12a-mali", "arm,mali-g31";
+	reg = <0xffe40000 0x10000>;
+	interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "job", "mmu", "gpu";
+	clocks = <&clk CLKID_MALI>;
+	mali-supply = <&vdd_gpu>;
+	operating-points-v2 = <&gpu_opp_table>;
+	resets = <&reset RESET_DVALIN_CAPB3>, <&reset RESET_DVALIN>;
+};
+
+gpu_opp_table: opp_table0 {
+	compatible = "operating-points-v2";
+
+	opp@533000000 {
+		opp-hz = /bits/ 64 <533000000>;
+		opp-microvolt = <1250000>;
+	};
+	opp@450000000 {
+		opp-hz = /bits/ 64 <450000000>;
+		opp-microvolt = <1150000>;
+	};
+	opp@400000000 {
+		opp-hz = /bits/ 64 <400000000>;
+		opp-microvolt = <1125000>;
+	};
+	opp@350000000 {
+		opp-hz = /bits/ 64 <350000000>;
+		opp-microvolt = <1075000>;
+	};
+	opp@266000000 {
+		opp-hz = /bits/ 64 <266000000>;
+		opp-microvolt = <1025000>;
+	};
+	opp@160000000 {
+		opp-hz = /bits/ 64 <160000000>;
+		opp-microvolt = <925000>;
+	};
+	opp@100000000 {
+		opp-hz = /bits/ 64 <100000000>;
+		opp-microvolt = <912500>;
+	};
+};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
