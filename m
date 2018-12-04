Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEBBC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:41:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD9CD2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WSj5QEQD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5XIAotS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD9CD2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=/5F54PYjOjwteLmZsDFDrvgJQFhSUebkDpPQSHR83Mg=; b=WSj5QEQDztSuIT
	sVOnT5JMdQlR5WZrQiddV5wbuWP2gg+wMYNu2t9CbqiW3k9GtX1pu2sqUBJK7W/nrH8oi1lhFpQt5
	yAeM+Bl1IWozz/8DHLF0KUZqgmcKEXdGsewzYwx1Ozts59W5GOoI0Xi7Vn26YPhu8TGx/+P1BQFBD
	kanSZsozb6Rk75G5IG8oxdw1hS/OW4Lsp3NCiWpmFx3hsmrRxHMWjOTYOl/i1iTestWdSjkRc3csn
	RxN+BrfgZNQKV6WBnuBLY/MpjILhDRagoHUs0viKqnkeSUhKbn/2oGM4yjcxVUlxwdu1OMaqxlf9u
	WzDqVWT+RV0JHmSTq95g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUGZ2-00012m-Ez; Tue, 04 Dec 2018 19:41:00 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUGYn-0000cB-IT
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 19:40:55 +0000
Received: by mail-pl1-x642.google.com with SMTP id k8so8786677pls.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 11:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LD9RiW/w/AsFU5z2eVVV/9ELhBDspcusWDXKoRIDE+8=;
 b=C5XIAotSFsUpeFjn0oACPmsEbp51GG/lP+lorXbEurmk7KRpgRIC2LWPV/+BuHytFV
 whvhOjSiEdR3MmlvI7LILK/jlNO0V0FKp6Ju8u2wwZJwJ7bNP+jrjGYoXrZ5Df+b94w3
 IjrwBltbuXpOs7j+3RoES5390kUp7BapHDjCwm/CjUM1cPndhPv97mL/lKkRknaOHCRX
 kOrYLZYU5v+TWowwy9+2nvzcHcKtr5K+3r3X+26QF+Q5zR29PJCRZDJ1nR/jnReX1hwK
 EyVgOuN563m11r+t21dSbpRDNtt6Gz7DocgmDm7LujA6OtvGcK/iLKgM5Y7I4cyJJHFA
 E+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LD9RiW/w/AsFU5z2eVVV/9ELhBDspcusWDXKoRIDE+8=;
 b=eYTVrlRAaKzHkKw6QjajRO+uKOfcmdITOg4a+N8nZ+xsFE0CiWyW0yfw9kHkNQEat3
 154ja5tTb+/IEVYlKMpoiAVGdjKaZ/hhyGUD8xBGRM6BLUwKvIss/wksL5ZZEi4gd0cd
 qYfuqNBQpQxduwGioz6olYXDrIXMWkdFIO4Oh/mUizu96/GLLGgM1ulDwoVQ5BC7t1pw
 +KRYBzXsywT/ESiIdZibRjfoZ9XByEvicgrTecrlYN30nuTm1KHrZ/Ez6cE+Ll5YZURc
 Zr0QuJLZHLIWn0B5TGsNKLbnWPnBUjcC3hlkwIdrxUwC642NaWf3UfrUM7HNO2xUZy8s
 4wVA==
X-Gm-Message-State: AA+aEWbngK3PK7eFU/m+canGvIVBlg1puH5Lzp8SeB3kvbS+aLQ9mwMK
 t9g+5Xtwbn0USdmNdpb9r2qDGwhx
X-Google-Smtp-Source: AFSGD/U9j/H3zTbdJWvfJwZ8vKn8aNPLVBAttjL6pyHgJqY975wBKlpoxF7fJvi/Ds2I3MDDs2HnDw==
X-Received: by 2002:a17:902:8e8a:: with SMTP id
 bg10mr21398195plb.192.1543952434181; 
 Tue, 04 Dec 2018 11:40:34 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.91])
 by smtp.gmail.com with ESMTPSA id u137sm36108381pfc.140.2018.12.04.11.40.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 11:40:33 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: exynos: Add proper regulator states for
 suspend-to-mem for odroid-u3
Date: Tue,  4 Dec 2018 19:40:25 +0000
Message-Id: <20181204194025.2719-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_114046_471482_F2B78CA6 
X-CRM114-Status: GOOD (  13.25  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Kukjin Kim <kgene@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add suspend-to-mem node to regulator core to be enabled or disabled
during system suspend and also support changing the regulator operating
mode during runtime and when the system enter sleep mode.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Tested on Odroid U3+
---
 .../boot/dts/exynos4412-odroid-common.dtsi    | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 2caa3132f34e..837713a2ec3b 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -285,6 +285,9 @@
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			ldo3_reg: LDO3 {
@@ -292,6 +295,9 @@
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo4_reg: LDO4 {
@@ -299,6 +305,9 @@
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			ldo5_reg: LDO5 {
@@ -307,6 +316,9 @@
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			ldo6_reg: LDO6 {
@@ -314,6 +326,9 @@
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			ldo7_reg: LDO7 {
@@ -321,18 +336,27 @@
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			ldo8_reg: LDO8 {
 				regulator-name = "VDD10_HDMI_1.0V";
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo10_reg: LDO10 {
 				regulator-name = "VDDQ_MIPIHSI_1.8V";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo11_reg: LDO11 {
@@ -340,6 +364,9 @@
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo12_reg: LDO12 {
@@ -348,6 +375,9 @@
 				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo13_reg: LDO13 {
@@ -356,6 +386,9 @@
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo14_reg: LDO14 {
@@ -364,6 +397,9 @@
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo15_reg: LDO15 {
@@ -372,6 +408,9 @@
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo16_reg: LDO16 {
@@ -380,6 +419,9 @@
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			ldo20_reg: LDO20 {
@@ -387,6 +429,9 @@
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo21_reg: LDO21 {
@@ -394,6 +439,9 @@
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			ldo22_reg: LDO22 {
@@ -411,6 +459,9 @@
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck1_reg: BUCK1 {
@@ -419,6 +470,9 @@
 				regulator-max-microvolt = <1100000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck2_reg: BUCK2 {
@@ -427,6 +481,9 @@
 				regulator-max-microvolt = <1350000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			buck3_reg: BUCK3 {
@@ -435,6 +492,9 @@
 				regulator-max-microvolt = <1050000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck4_reg: BUCK4 {
@@ -442,6 +502,9 @@
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1100000>;
 				regulator-microvolt-offset = <50000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck5_reg: BUCK5 {
@@ -450,6 +513,9 @@
 				regulator-max-microvolt = <1200000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck6_reg: BUCK6 {
@@ -458,6 +524,9 @@
 				regulator-max-microvolt = <1350000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck7_reg: BUCK7 {
@@ -465,6 +534,9 @@
 				regulator-min-microvolt = <2000000>;
 				regulator-max-microvolt = <2000000>;
 				regulator-always-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck8_reg: BUCK8 {
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
