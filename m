Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B7DC5AE5E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:53:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B7620823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NgsAZJwN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="pzZL7ZNt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B7620823
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DFy38ek2fo3vWNb+TUD54qywpwPfuv9ddzFkI+MKVUE=; b=NgsAZJwN52iAOW
	YpEzVIrAG1aAn35XrJtUrhvrvG4dXaKo8k2oSzG4LOXXAC+IJ3B8S66qhrEaelAQQ0yTRp4hr//C9
	LBu8jhbeR5cVoUU9U9G4/LlJjge14h5LaCV/87eKwNMstdTa8JQg5YSvFV6gfSGnXoKqj3dV87g8T
	vK/72llnCPFrOo+NDhXNvIZOBKR0XXVWcmB6Kffs/dmZSyiM+VtHcLj8gnl4V4Y7nU+trBidKdO9+
	ZABT2LI5SRl01FG83U1KZmI+Lt4QcsF8/vNhv1OYX+D1BGSvvKIi2fGLoICBWYWtsNNnG/MxPLLum
	zyeAny5Mf5ODtdv1QBAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkd0o-000139-SE; Fri, 18 Jan 2019 22:53:18 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkd0V-0000nc-FC; Fri, 18 Jan 2019 22:53:00 +0000
Received: by mail-wm1-x342.google.com with SMTP id y8so5916075wmi.4;
 Fri, 18 Jan 2019 14:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LV+y+UpHX9FeIZtZHWd/evuufcRscKJVbJ2RwwXxQPM=;
 b=pzZL7ZNt9u6bmL3/3BjOTXM3b2jHFnFqkUqqPUBOiQp/vy6sLqRmmzhTIn1SXuYqxl
 2tkBC/X6AEwB5/ktBUfMoRFD9CYANBLWN2FLGPFeRzUa+4GsC+Aw6pwqyyrKFRXrtA5K
 SjiHnVyRodk6wleHwO5ygboxyUr/FhfTz1K6RB++av/vWXE3nUmPG0pnvo1yIp38zz7K
 YadipCLWhOQOc2evYad9scx46AhiJtcu2h7s3IYPCSUdU1YTP2yEE2rgEzpSarkiCqz9
 YYG+G+3ANvzYTL9vX3jmZrhHaCXpISdGgWxDuMb/k6qTX8DDt/TvBpMVpXXV00rGy1hR
 F/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LV+y+UpHX9FeIZtZHWd/evuufcRscKJVbJ2RwwXxQPM=;
 b=ny9KWZEt5PcwJAgD5el2c6nVgzQXG/7ZacBgzpwXbBlmS2Ez3fLxCZ2TeBFgL80uao
 9lB9gkHpaAH5/ZZk3BsQ+iuRvAlV1Cxg2vKve/o++RBpg0vz7stx1VPjLfUGE8LSS+YO
 1p2u5+GXQA5mqQgMoZChIo+HXSmDSLB9RXf+lg/fz/Zx2febfj7c9hh3qfQROFEzS7om
 Tcrtr33sSArvZXl9LHzKReuJGnG36GcWDvZt83DfcT1COlawLhMP6KZcKkUD/ezzMTXH
 1+7vTfnu6DxiirwXxvO2AAwcXB5hpLf0ncQz5UUIcTPfL+6AGPcBbDAjWmdskIRaIxam
 dVAg==
X-Gm-Message-State: AJcUukedv3VamsZ56Xjgw01P5nvIk0+q1y54KikUi1lWqbaSXFufnwFu
 Q+tYl8EgvkKFscE5TfM1IIhoX/Yi
X-Google-Smtp-Source: ALg8bN6MmlJcNtUsMaN+yz3jO+4reckkyzHvE3QfUYFgBlWA5UvDA3cTPMgLNR5P2ZOhqA7hkhACag==
X-Received: by 2002:a1c:2501:: with SMTP id l1mr17817293wml.102.1547851977684; 
 Fri, 18 Jan 2019 14:52:57 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73A810039E290CB771389D7.dip0.t-ipconnect.de.
 [2003:dc:d73a:8100:39e2:90cb:7713:89d7])
 by smtp.googlemail.com with ESMTPSA id
 x186sm51197352wmg.41.2019.01.18.14.52.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 14:52:56 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	khilman@baylibre.com
Subject: [PATCH v2 1/7] ARM: dts: meson: switch the clock controller to the
 HHI register area
Date: Fri, 18 Jan 2019 23:52:21 +0100
Message-Id: <20190118225227.6516-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118225227.6516-1-martin.blumenstingl@googlemail.com>
References: <20190118225227.6516-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_145259_536444_9238F151 
X-CRM114-Status: GOOD (  11.54  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-arm-kernel@lists.infradead.org, Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The clock controller on Meson8/Meson8m2 and Meson8b is part of a
register region called "HHI". This register area contains more
functionality than just a clock controller:
- the clock controller
- some reset controller bits
- temperature sensor calibration data (on Meson8b and Meson8m2 only)
- HDMI controller

Allow access to this HHI register area as "system controller". Also
migrate the Meson8 and Meson8b clock controllers to this new node.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/meson.dtsi   |  7 +++++++
 arch/arm/boot/dts/meson8.dtsi  | 15 ++++++++-------
 arch/arm/boot/dts/meson8b.dtsi | 15 ++++++++-------
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index 2ab74860d962..61486a7402f9 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -72,6 +72,13 @@
 			#size-cells = <1>;
 			ranges = <0x0 0xc1100000 0x200000>;
 
+			hhi: system-controller@4000 {
+				compatible = "amlogic,meson-hhi-sysctrl",
+					     "simple-mfd",
+					     "syscon";
+				reg = <0x4000 0x400>;
+			};
+
 			assist: assist@7c00 {
 				compatible = "amlogic,meson-mx-assist", "syscon";
 				reg = <0x7c00 0x200>;
diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 83ed92dae892..829984be4ed8 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -327,13 +327,6 @@
 };
 
 &cbus {
-	clkc: clock-controller@4000 {
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-		compatible = "amlogic,meson8-clkc";
-		reg = <0x8000 0x4>, <0x4000 0x400>;
-	};
-
 	reset: reset-controller@4404 {
 		compatible = "amlogic,meson8b-reset";
 		reg = <0x4404 0x9c>;
@@ -468,6 +461,14 @@
 	status = "okay";
 };
 
+&hhi {
+	clkc: clock-controller {
+		compatible = "amlogic,meson8-clkc";
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
+};
+
 &hwrng {
 	compatible = "amlogic,meson8-rng", "amlogic,meson-rng";
 	clocks = <&clkc CLKID_RNG0>;
diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 57c2a3678110..aa798259bf88 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -276,13 +276,6 @@
 };
 
 &cbus {
-	clkc: clock-controller@4000 {
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-		compatible = "amlogic,meson8b-clkc";
-		reg = <0x8000 0x4>, <0x4000 0x400>;
-	};
-
 	reset: reset-controller@4404 {
 		compatible = "amlogic,meson8b-reset";
 		reg = <0x4404 0x9c>;
@@ -437,6 +430,14 @@
 	status = "okay";
 };
 
+&hhi {
+	clkc: clock-controller {
+		compatible = "amlogic,meson8-clkc";
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
+};
+
 &hwrng {
 	compatible = "amlogic,meson8b-rng", "amlogic,meson-rng";
 	clocks = <&clkc CLKID_RNG0>;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
