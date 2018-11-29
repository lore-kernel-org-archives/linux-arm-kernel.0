Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A667C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:02:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CFB021019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X+KpCj3m";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="pItSnKxM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFB021019
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pRMv4GK/YUjMJ1npGQ5xlsaJEn6geRTJUhnUUi6cm+4=; b=X+KpCj3mlDEEtG
	yodC8cbJBkOxmg8pyPpiZe55m2o852TiWJlIYuwY1CVISqsfGpnBXR7mDMKucPFi51eDmaDrwI23A
	m7CYgLyzYyeRevCfgVhYWfWdO/qy550L4VqjbRofk2c6jiW6bbLMeuvkCqPQnD66QGCNbyqEu8QPP
	DKV0YHYiHl5ebDL8JmEd1QFvjPbvk6uN8FH8SizH+wZ/7EMXqERSi/Tmy27CMW0YeRKesKnud2TlV
	7MJco7QgBpOd6/HyKVkb3mNImU13PHCZXVItierRgV96ZKWY5nKcPqwmWd0fgl/9LZXoM6LANcOsr
	g3PwbpIeZXv4x+elANSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSVK8-0004c9-Ph; Thu, 29 Nov 2018 23:02:20 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSVJX-00041h-6w; Thu, 29 Nov 2018 23:01:44 +0000
Received: by mail-wr1-x444.google.com with SMTP id t27so3524416wra.6;
 Thu, 29 Nov 2018 15:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=x60dMx3jfS/+K4+Fte7zGi8OxAkRlgfpiIzqxvvlhvo=;
 b=pItSnKxM/BM6HVHlH1hnP+8VFSMd1WSdqKj65OwMeZoUmIwBNsNZu9XHOr7P3t7fMA
 F8u+Zs7Qes6ck6K5eejuXdQKMmG/d4CZ9CWtomzs+zcdlhv+3b+8EAdZgzLPr7sjg+6D
 6YlK3JaBsYkrrAFBm/sWUovcRPjoI81uiLd/QaXIViu0duvs8lcTOsayYJASDgDxmaOX
 GE4w9/2IbR4Vy1ssbrDAfHS+j9Nho8Ghqjnw5pvTrMuCuA1D481oaAyjeqyMGgoGn1ZK
 PecLpd95yaac5gG4uXvlBooOehs8KzyHjUJVViMLytr3CK3ucFVgQChCkxFd7MIQodMz
 Cl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x60dMx3jfS/+K4+Fte7zGi8OxAkRlgfpiIzqxvvlhvo=;
 b=DJULV4Oio8a4ohmyVNGDy5H3VDghwJtyTnm9aSt4J5H4fxtjX5J5TWwRBoL7K5fOM9
 6wivBYM83mhWQ29364OWzYjgC2PSDz9DxUPawopydV+rM6fPYun2MJ3Amofqw+Z/ZtTn
 OI5N97Q/8bjXtk/BzDt2O+JhJtKC3FLx2CI7grNQS8r8ezt+mZjxyjR1K5udxX53fO5G
 RXTlpaf0n7PKSN+uqMvHcQ+PK1KrPpmeMKHmkjNf9LbWXWiaH87aiRN0+jmtRKhd9/i6
 sTG3zwU+ttgrqScZD8hXdIgNtAbpEilaUugSDa+iVOqZd6xkCFV9a9s/LN/F6ZUJEVB/
 tykA==
X-Gm-Message-State: AA+aEWbeK7vHBdb/p6Pb1DN6rZNGKBwNSCz3du8comEDhrsHUuk6U89L
 8PL4bCpqyh/b2GJIbICBMrS5t3yR
X-Google-Smtp-Source: AFSGD/WhWLKo0Ulym3Cy/xWTVO0euAiSBKVg5mPllKfqAFOyQqULhambdX0yPQnUiD2JdZmPwZb0bg==
X-Received: by 2002:adf:a743:: with SMTP id e3mr2876592wrd.56.1543532491098;
 Thu, 29 Nov 2018 15:01:31 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de.
 [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
 by smtp.googlemail.com with ESMTPSA id k15sm2944895wru.8.2018.11.29.15.01.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 15:01:30 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, khilman@baylibre.com, carlo@caione.org
Subject: [PATCH 2/2] ARM: dts: meson: meson8b: add the CPU OPP tables
Date: Fri, 30 Nov 2018 00:00:44 +0100
Message-Id: <20181129230044.21358-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129230044.21358-1-martin.blumenstingl@googlemail.com>
References: <20181129230044.21358-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_150143_250748_22F226E4 
X-CRM114-Status: GOOD (  10.76  )
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
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The values are taken from Amlogic's 3.10 kernel sources.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 66 ++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index a38d187d3d6e..22d775460767 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -62,6 +62,8 @@
 			reg = <0x200>;
 			enable-method = "amlogic,meson8b-smp";
 			resets = <&clkc CLKC_RESET_CPU0_SOFT_RESET>;
+			operating-points-v2 = <&cpu_opp_table>;
+			clocks = <&clkc CLKID_CPUCLK>;
 		};
 
 		cpu1: cpu@201 {
@@ -71,6 +73,8 @@
 			reg = <0x201>;
 			enable-method = "amlogic,meson8b-smp";
 			resets = <&clkc CLKC_RESET_CPU1_SOFT_RESET>;
+			operating-points-v2 = <&cpu_opp_table>;
+			clocks = <&clkc CLKID_CPUCLK>;
 		};
 
 		cpu2: cpu@202 {
@@ -80,6 +84,8 @@
 			reg = <0x202>;
 			enable-method = "amlogic,meson8b-smp";
 			resets = <&clkc CLKC_RESET_CPU2_SOFT_RESET>;
+			operating-points-v2 = <&cpu_opp_table>;
+			clocks = <&clkc CLKID_CPUCLK>;
 		};
 
 		cpu3: cpu@203 {
@@ -89,6 +95,66 @@
 			reg = <0x203>;
 			enable-method = "amlogic,meson8b-smp";
 			resets = <&clkc CLKC_RESET_CPU3_SOFT_RESET>;
+			operating-points-v2 = <&cpu_opp_table>;
+			clocks = <&clkc CLKID_CPUCLK>;
+		};
+	};
+
+	cpu_opp_table: opp-table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-96000000 {
+			opp-hz = /bits/ 64 <96000000>;
+			opp-microvolt = <860000>;
+		};
+		opp-192000000 {
+			opp-hz = /bits/ 64 <192000000>;
+			opp-microvolt = <860000>;
+		};
+		opp-312000000 {
+			opp-hz = /bits/ 64 <312000000>;
+			opp-microvolt = <860000>;
+		};
+		opp-408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <860000>;
+		};
+		opp-504000000 {
+			opp-hz = /bits/ 64 <504000000>;
+			opp-microvolt = <860000>;
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <860000>;
+		};
+		opp-720000000 {
+			opp-hz = /bits/ 64 <720000000>;
+			opp-microvolt = <860000>;
+		};
+		opp-816000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <900000>;
+		};
+		opp-1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <1140000>;
+		};
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1140000>;
+		};
+		opp-1320000000 {
+			opp-hz = /bits/ 64 <1320000000>;
+			opp-microvolt = <1140000>;
+		};
+		opp-1488000000 {
+			opp-hz = /bits/ 64 <1488000000>;
+			opp-microvolt = <1140000>;
+		};
+		opp-1536000000 {
+			opp-hz = /bits/ 64 <1536000000>;
+			opp-microvolt = <1140000>;
 		};
 	};
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
