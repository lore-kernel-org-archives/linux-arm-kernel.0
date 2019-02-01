Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41754C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:37:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F5D221872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F+buOH8y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Wid9L+pH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5D221872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=rz3rCTbi46xm2t66SZAPcJ07n5aJf0UAxP6wYmDmoGk=; b=F+buOH8yqs5Hub
	uWlRGWV6lcdTQlHtLrsIxjRb7VxFzNEwtQ/zaTDWn7EmNU76LZ0pl0W9M4hVX5HTR4DilpFjUv3HV
	nrzyXdbLC44wp2jxX6s2T47KddMOg/YyAqmb0fJ5cA2JFHfRAp0Ia1esxdUwJEuHhsPRtWPukKfBB
	OYonDhHdm0UMr293kjvDgExpcazwGdPaEgSAlbdfn1k90Mont3yQ+qt142LI3RCMLMs51Qle+0FSo
	tHy1PvCKMwqWgTIDWKVsQvOPNbCRWDkLN4NTwgCbMT1qk1kePREnNMkm+ShY8OqcSnheZvFdvs97c
	1CcOIpSJaDqAiDnfftdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpZ0x-00047z-4j; Fri, 01 Feb 2019 13:37:51 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpZ0t-00046m-1Z
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 13:37:48 +0000
Received: by mail-wm1-x344.google.com with SMTP id y8so6217804wmi.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 05:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gw96D6lV5nc8LJ7jKMUnW98xIShzXHekWm2ox2FWIVg=;
 b=Wid9L+pHvaaHAfpsgoZ/3ly0MWxK8r5mRgIPwOoTM+yHT35p3JBUQ/ldrB/FiCb2EQ
 0qFTJ7z5Aw0KhwLgncT97tLtp1qjmoJ2+L+GoI7D6b5vRUc7XdRTQy3K6dLBWaCRv1lA
 PD95aK27Us9FwsH1nnNKMQB15WLiJ7sWq+K5SEUfb4+M8ea/f1WL1rP29YB4ZJh5tk1i
 EyRTyuR8AUCEzXcydDnndzs97wTTydgNFM9wGQqGPDp6md29YOaxBtQ3YvMln5al66/8
 /sLC3MUIuFMdiMHphaH4eqauMPwFsp9JOKelL6Ra9mSQPNxdvH4MQvQUI84XsESp4JZa
 es4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gw96D6lV5nc8LJ7jKMUnW98xIShzXHekWm2ox2FWIVg=;
 b=noL0i6hnwOEH16s9aqPrFPILEc0X7bk5JT8BeTgKs0V+vFKljMb98Mfz3pn0gKksGt
 F2tGvJ38PiU2Tx2YHQUilFxDEth4vSQJELdmWbp/9OvLOe546RjcQ9eDfmkLPeMS7GgX
 tnabDHr2tOmbxcyW3RKweSAb5lIkG+5m9NCLXIgbY7xzNqE5eQQaK0zCS/6Ij18GMI3O
 fA5avbIYR/QAZZrndrFwjQxucZXvGi9zsDvSS2c2kp2Yy6MG7osq/zbeDkOMGwkYAOEy
 75rAJFP8H1k+BNW7VGRWebMBbjta+oLzabahPWiSodaDWQIDakW+QzxlJAlXgYa2tBAZ
 hO+g==
X-Gm-Message-State: AHQUAuZBLvBIyv8V2ih6mN0anYaYv4C2bO6HdrB1BvH/39dlJWQgGJdQ
 vfP0z9j5qPY9H6uosre7TPI3Bg==
X-Google-Smtp-Source: AHgI3IbbdUp+oxkOdwmY9/1FF9IHCXtidg+4OnhPcnx6Co7Dd6tFTD8eW1N2+pM53HfTYlhVGaOKhQ==
X-Received: by 2002:a1c:a00f:: with SMTP id j15mr2398672wme.84.1549028264176; 
 Fri, 01 Feb 2019 05:37:44 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.googlemail.com with ESMTPSA id 125sm3298669wmm.26.2019.02.01.05.37.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Feb 2019 05:37:43 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v2] arm64: dts: meson: fix g12a buses
Date: Fri,  1 Feb 2019 14:37:32 +0100
Message-Id: <20190201133732.32169-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_053747_089439_FF6454F2 
X-CRM114-Status: GOOD (  10.66  )
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
Cc: devicetree@vger.kernel.org, Jianxin Pan <jianxin.pan@amlogic.com>,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Fix apb, cbus, hiu and periph regions which are not aligned
with the documentation and the information provided by Amlogic

Fixes: 9c8c52f7cb4f ("arm64: dts: meson-g12a: add initial g12a s905d2 SoC DT support")
Cc: Jianxin Pan <jianxin.pan@amlogic.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 46 +++++++++++----------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 3b82a975c663..349c4e2df1b0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -78,20 +78,28 @@
 		#size-cells = <2>;
 		ranges;
 
-		periphs: periphs@ff634000 {
+		apb: bus@ff600000 {
 			compatible = "simple-bus";
-			reg = <0x0 0xff634000 0x0 0x2000>;
+			reg = <0x0 0xff600000 0x0 0x200000>;
 			#address-cells = <2>;
 			#size-cells = <2>;
-			ranges = <0x0 0x0 0x0 0xff634000 0x0 0x2000>;
-		};
+			ranges = <0x0 0x0 0x0 0xff600000 0x0 0x200000>;
+
+			periphs: bus@34400 {
+				compatible = "simple-bus";
+				reg = <0x0 0x34400 0x0 0x400>;
+				#address-cells = <2>;
+				#size-cells = <2>;
+				ranges = <0x0 0x0 0x0 0x34400 0x0 0x400>;
+			};
 
-		hiubus: bus@ff63c000 {
-			compatible = "simple-bus";
-			reg = <0x0 0xff63c000 0x0 0x1c00>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges = <0x0 0x0 0x0 0xff63c000 0x0 0x1c00>;
+			hiu: bus@3c000 {
+				compatible = "simple-bus";
+				reg = <0x0 0x3c000 0x0 0x1400>;
+				#address-cells = <2>;
+				#size-cells = <2>;
+				ranges = <0x0 0x0 0x0 0x3c000 0x0 0x1400>;
+			};
 		};
 
 		aobus: bus@ff800000 {
@@ -102,7 +110,8 @@
 			ranges = <0x0 0x0 0x0 0xff800000 0x0 0x100000>;
 
 			uart_AO: serial@3000 {
-				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
+				compatible = "amlogic,meson-gx-uart",
+					     "amlogic,meson-ao-uart";
 				reg = <0x0 0x3000 0x0 0x18>;
 				interrupts = <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>;
 				clocks = <&xtal>, <&xtal>, <&xtal>;
@@ -111,7 +120,8 @@
 			};
 
 			uart_AO_B: serial@4000 {
-				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
+				compatible = "amlogic,meson-gx-uart",
+					     "amlogic,meson-ao-uart";
 				reg = <0x0 0x4000 0x0 0x18>;
 				interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
 				clocks = <&xtal>, <&xtal>, <&xtal>;
@@ -135,18 +145,10 @@
 
 		cbus: bus@ffd00000 {
 			compatible = "simple-bus";
-			reg = <0x0 0xffd00000 0x0 0x25000>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges = <0x0 0x0 0x0 0xffd00000 0x0 0x25000>;
-		};
-
-		apb: apb@ffe00000 {
-			compatible = "simple-bus";
-			reg = <0x0 0xffe00000 0x0 0x200000>;
+			reg = <0x0 0xffd00000 0x0 0x100000>;
 			#address-cells = <2>;
 			#size-cells = <2>;
-			ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x200000>;
+			ranges = <0x0 0x0 0x0 0xffd00000 0x0 0x100000>;
 		};
 	};
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
