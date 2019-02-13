Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98AFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:41:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7971A222CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hzG7EBPx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSmuiGaL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7971A222CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Cn41d7P70tyy4Z0PLht48TfrLb4nIt0ql9IR6ztq8h0=; b=hzG7EBPxikhWhQ
	qrGZ7ZwnAxD7SmEDzTMzdVmKtu3+ZQ5GuJ4Z0bbmCK4feIZ6PnTReoWymQ/+phMsJpVWQuxCb7vfh
	eFZWC9ELeLiV9Q1RN9yrpsY5zA8qv1/v8wGjukKxsNzkZY6s9Yw/lUafxlV7Fu/4kWiaGnKUEdEpQ
	dwOTigD9REtA8wN/fWLVT5nuxJ5GfoNhrYNmJRR/r2avsnOXl5YT3lj7iqLhlxXLUY1c1DZAd5YZo
	Ke8bMpffIKS9ktknuLl+YochQ1byiSD61GLSmkaw95qW8ycbVbX7n+cIo4ikwtDzgvNp0lKbfaGq4
	81fATMwzBzifF1y6FBcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu2HQ-00058Z-Ue; Wed, 13 Feb 2019 21:41:20 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu2HN-00056d-8N
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 21:41:19 +0000
Received: by mail-pg1-x542.google.com with SMTP id y1so1776021pgk.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 13:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=irYv0xqfxLq9eyi1hZL6+OFFikwsolagLNKzHmLmsDI=;
 b=fSmuiGaLyJQY2gMc8QKrxHYpM/QBJuMTPyej4qwJ4LBaAEOrEQixJ/O93WT+TdRN4C
 QNHGo79Rc6gvUeSHCJlns1okxy7sFWx/UG3XrPUq46OlI0C9jhOlaQkr7wALsOV9RWe0
 ZresE/vLbLm+8+CU88rXXKJSroDhs43s46dM9SLR9jj3qmXYl3RAocpv7FzOX337ArAO
 we1RulDUcgyMWmmeCcB0pQ9KcvaXlCXVquoENEXkQASGxupARbDvojUR4A1o3qXpOt+x
 RF1ThrQPvmIuL1hoj2xunaNUzvf3W53ewlA8u/TlRgdIID3ntd3ivs+iFjcKV0bb0Iss
 Zicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=irYv0xqfxLq9eyi1hZL6+OFFikwsolagLNKzHmLmsDI=;
 b=bmNzrqJGnMtYlY799iavnGENPmGrMDV/Qm/qDDuaQK/x7JvyiMCrxODvWcvivj5M8P
 c8Ax9l2m3boyhxUsYupnFFK/b/2HMo2hiEbts25j5I1LgGQWgETnJoNWhob3RsKajLpQ
 aDKmTngwMJLAR0FmEVNN+FZbagdLoiVZbUgpCCZKs4E/l2fQiBIAGgVHxU9PdqU1C1uD
 IUkVpHjRmCi6GyePyhVZbxcEGSxLHyQrI/iacRRvONIfarO0/ZCgDudejGWwBALiewMc
 98vepKivCRiK8pmYfCmIruwyz2nIyPRA9p/hPfLRxCMr6n/sAYpS2r2xFlUnDqS9Phoj
 vSZQ==
X-Gm-Message-State: AHQUAuZ/CSsoE0TEJszPNlapi2kHKJtyrv1qyZhMQEJf3UenWPm8k8X3
 7UMTnnSpapfrHyuZ8v+S2bw=
X-Google-Smtp-Source: AHgI3IYyzFpAT4H0kv5rJUFUvP0YLTaqWAkByRWTtEuPVJlryBPzkD7gPOtHjQ9fKGj9WkLAw979Qw==
X-Received: by 2002:a65:5c4b:: with SMTP id v11mr253368pgr.333.1550094076803; 
 Wed, 13 Feb 2019 13:41:16 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.137])
 by smtp.gmail.com with ESMTPSA id w128sm335321pfw.79.2019.02.13.13.41.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Feb 2019 13:41:16 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 1/2] ARM: dts: exynos: Add proper regulator states for
 suspend-to-mem for odroid-u3
Date: Wed, 13 Feb 2019 21:40:51 +0000
Message-Id: <20190213214052.2427-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213214052.2427-1-linux.amoon@gmail.com>
References: <20190213214052.2427-1-linux.amoon@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_134117_337871_3025A346 
X-CRM114-Status: GOOD (  14.75  )
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
Cc: Pankaj Dubey <pankaj.dubey@samsung.com>,
 Tomasz Figa <tomasz.figa@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>,
 Kukjin Kim <kgene@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add suspend-to-mem node to regulator core to be enabled or disabled
during system suspend and also support changing the regulator operating
mode during runtime and when the system enter sleep mode.

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---

Changes from previos patch
[0] https://patchwork.kernel.org/patch/10712549/

Set all the WAKEUP source regulator in suspend-on state.
LD04, LD012, LD015, LD020, LD022
Set all the non used regulator in suspend-odd state
LD02, LD03, LD05, LD06, LD07, LD011, LD013, LDO14, LD016

BUCK5, BUCK6, BUCK7 and not confirable as per driver max77686-regulator

Tested on microSD card and it resumes correcly after suspend.
eMMC is not able to resume after entering into suspend state,
which need to be investigated and how to debug more.
---
 .../boot/dts/exynos4412-odroid-common.dtsi    | 63 +++++++++++++++++++
 arch/arm/boot/dts/exynos4412-odroidu3.dts     |  3 +
 2 files changed, 66 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 08d3a0a7b4eb..e984461c37d9 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -288,6 +288,9 @@
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo3_reg: LDO3 {
@@ -295,6 +298,9 @@
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo4_reg: LDO4 {
@@ -302,6 +308,9 @@
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			ldo5_reg: LDO5 {
@@ -310,6 +319,9 @@
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo6_reg: LDO6 {
@@ -317,6 +329,9 @@
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo7_reg: LDO7 {
@@ -324,18 +339,27 @@
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo8_reg: LDO8 {
 				regulator-name = "VDD10_HDMI_1.0V";
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			ldo10_reg: LDO10 {
 				regulator-name = "VDDQ_MIPIHSI_1.8V";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			ldo11_reg: LDO11 {
@@ -343,6 +367,9 @@
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo12_reg: LDO12 {
@@ -351,6 +378,9 @@
 				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo13_reg: LDO13 {
@@ -359,6 +389,9 @@
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo14_reg: LDO14 {
@@ -367,6 +400,9 @@
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo15_reg: LDO15 {
@@ -375,6 +411,9 @@
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo16_reg: LDO16 {
@@ -383,6 +422,9 @@
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo20_reg: LDO20 {
@@ -396,6 +438,9 @@
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			ldo22_reg: LDO22 {
@@ -405,6 +450,9 @@
 				 */
 				regulator-name = "LDO22";
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			ldo25_reg: LDO25 {
@@ -413,6 +461,9 @@
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck1_reg: BUCK1 {
@@ -421,6 +472,9 @@
 				regulator-max-microvolt = <1100000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck2_reg: BUCK2 {
@@ -429,6 +483,9 @@
 				regulator-max-microvolt = <1350000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			buck3_reg: BUCK3 {
@@ -437,6 +494,9 @@
 				regulator-max-microvolt = <1050000>;
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck4_reg: BUCK4 {
@@ -444,6 +504,9 @@
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1100000>;
 				regulator-microvolt-offset = <50000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck5_reg: BUCK5 {
diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index 2bdf899df436..4ebde09fc51d 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -82,6 +82,9 @@
 	regulator-name = "LDO22_VDDQ_MMC4_2.8V";
 	regulator-min-microvolt = <2800000>;
 	regulator-max-microvolt = <2800000>;
+	regulator-state-mem {
+		regulator-on-in-suspend;
+	};
 };
 
 &mshc_0 {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
