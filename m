Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5DBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:34:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AC5B20838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tE8HOqAr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xNOTl7HW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC5B20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=0PPJYfTm4G08jA73yeJCzOBvuLD07kEdyjahHF3GCgM=; b=tE8HOqArY56CgJLLDJuirppk/X
	NDzc0oulWaeFLU1JuLp+iGB1+zs43aQmEK7j5qrHuJL5+z9mfd/iIgMf2VqjE7M4JeW91SQ3Q1De8
	l8+R6gO0aUb4miAG70iv+lSuGLkplNXXNmnwZH/I6YiA/YmcJRW3u8hBgrZjZ9EhmYDp0NXXYfCUx
	egFYuR9HmbhNWTY7fxCKJJH/YccXWlObKsH0mmhqiYxPXel6wiz5I6jG4nJHLHVGy1tg0BFwK8mkr
	2DSfCzNb513XxfNgeJXLmcJ4fgGd1j6XTu8eiebr59Fn1YBAdOGI8r1D6j+VYBCXR5X6PyO2OGwsr
	oUaZfCYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvmnm-00029q-8U; Mon, 18 Feb 2019 17:33:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvmna-0001va-Nu
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 17:33:48 +0000
Received: from localhost.localdomain (unknown [194.230.155.153])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 254FE217F5;
 Mon, 18 Feb 2019 17:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550511226;
 bh=Z0Ah1bzAtSTk6QmnAo4lDyi6ia6LZcfqWbU6RHGBKaQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=xNOTl7HWr6m3jWizSTQ2r2qFl0luMhmtLxjoIjyhIxE6Vbpx35Te5jsvM9C5nCSNL
 IABeg25RxmxHgCx9L2s1Lz8kQ1keWa7B0qVYluuapm88+Rjz2NrfHEMm20i9UkHgfc
 iTTAn/XqYlpD8U7qXRz7yRoji9qltcJtmYy8GFT4=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ARM: dts: exynos: Add unused PMIC regulators on Arndale
 Octa board
Date: Mon, 18 Feb 2019 18:32:57 +0100
Message-Id: <20190218173258.7071-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190218173258.7071-1-krzk@kernel.org>
References: <20190218173258.7071-1-krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_093346_934074_66C2E185 
X-CRM114-Status: GOOD (  10.69  )
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
Cc: Markus Reichl <reichl@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Define the LDO14, LDO17, LDO22, LDO25, LDO30, LDO34, LDO36 and LDO37
unused regulators to describe the hardware.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 832757999e4f..308c74ebeacd 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -180,6 +180,13 @@
 				regulator-max-microvolt = <2800000>;
 			};
 
+			ldo14_reg: LDO14 {
+				/* Unused */
+				regulator-name = "PVDD_LDO14";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
 			ldo15_reg: LDO15 {
 				regulator-name = "PVDD_PERI_2V8";
 				regulator-min-microvolt = <3300000>;
@@ -192,6 +199,13 @@
 				regulator-max-microvolt = <2200000>;
 			};
 
+			ldo17_reg: LDO17 {
+				/* Unused */
+				regulator-name = "PVDD_LDO17";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
 			ldo18_reg: LDO18 {
 				regulator-name = "PVDD_EMMC_1V8";
 				regulator-min-microvolt = <1800000>;
@@ -216,6 +230,13 @@
 				regulator-max-microvolt = <1800000>;
 			};
 
+			ldo22_reg: LDO22 {
+				/* Unused */
+				regulator-name = "PVDD_LDO22";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <2375000>;
+			};
+
 			ldo23_reg: LDO23 {
 				regulator-name = "PVDD_MIFS_1V1";
 				regulator-min-microvolt = <1200000>;
@@ -229,6 +250,13 @@
 				regulator-max-microvolt = <2800000>;
 			};
 
+			ldo25_reg: LDO25 {
+				/* Unused */
+				regulator-name = "PVDD_LDO25";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
 			ldo26_reg: LDO26 {
 				regulator-name = "PVDD_CAM0_AF_2V8";
 				regulator-min-microvolt = <3000000>;
@@ -253,6 +281,13 @@
 				regulator-max-microvolt = <1800000>;
 			};
 
+			ldo30_reg: LDO30 {
+				/* Unused */
+				regulator-name = "PVDD_LDO30";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
 			ldo31_reg: LDO31 {
 				regulator-name = "PVDD_PERI_1V8";
 				regulator-min-microvolt = <1800000>;
@@ -271,12 +306,33 @@
 				regulator-max-microvolt = <1800000>;
 			};
 
+			ldo34_reg: LDO34 {
+				/* Unused */
+				regulator-name = "PVDD_LDO34";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
 			ldo35_reg: LDO35 {
 				regulator-name = "PVDD_CAM0_DVDD_1V2";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1200000>;
 			};
 
+			ldo36_reg: LDO36 {
+				/* Unused */
+				regulator-name = "PVDD_LDO36";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
+			ldo37_reg: LDO37 {
+				/* Unused */
+				regulator-name = "PVDD_LDO37";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
 			ldo38_reg: LDO38 {
 				regulator-name = "PVDD_CAM0_AVDD_2V8";
 				regulator-min-microvolt = <2800000>;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
