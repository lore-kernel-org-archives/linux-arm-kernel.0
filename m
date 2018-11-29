Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCC1C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:02:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3241320989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="msuyhF5E";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="aTTqA5yo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3241320989
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wvixfv10HP3ZP+tdhD83jUuIrgu+ueKm/URr1LETHWQ=; b=msuyhF5Ed8QiY+
	rN4qAf7weaPWvyfqJViWC8IwBoE83+SctVRnu/wSCTx/MabfGrymkGGPKgFazVO6JW7EPT3WG7Brr
	JL7pUHST8BivfpbPIE3XCG60NzjGKZFYVQvt7jGjXJ5uiSj0RoOvJFgXpnXvOyWxUnk2OPHPqCNZ6
	A+HBNnGkPNpzuyz9BbMq0irNELLjXF43JHolFHpZmLe1Yf/MdczlMP86cSGqwIEISVkPJW/P/oV29
	wOIeohPzs2EAdhn+xY8bWZYkhUJ89m87CDtv28PLkJr0I62FZnXnckMQ1glDnmYitz301JtebxrSe
	iJQkfq2Jh4M0LIXjeZ1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSVJq-0004Lr-MR; Thu, 29 Nov 2018 23:02:02 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSVJV-00041g-Li; Thu, 29 Nov 2018 23:01:43 +0000
Received: by mail-wr1-x441.google.com with SMTP id r10so3504175wrs.10;
 Thu, 29 Nov 2018 15:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UgEGBuoz9h2uPSAs6bKXqf+FVku1NvUv0A9IlTooBCE=;
 b=aTTqA5yoJYqeb6pa9W1pehcTqxQvd4Mi9KRnvWpd88qSjI5Xasr8F3YxjLVaRH4pmL
 L7AKeU218+qh9cAvtmkeblipzMc5nlW7ieaU6s+KZPNoYnuZr+eMD+H3hD41up0SiU7s
 YDxT0PSIy29KOi7HjDP3xcUckQvPJKjPgroFcMLmJ1gTFLmS+RuHbx9W4/TdcIUz2xRB
 fMsDtBAe7A5GuWMGXUZLQ6mRManUsdWs1F4r8NpwR0FA511lQlpstzNF/mNK0pcD4Y+E
 rfBvL+IEDTm856gKDXoCQahkrL6K9ubpCrJ98D7YuNumUuNC2paTWjNQjHuW88I7L6Y4
 6Jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UgEGBuoz9h2uPSAs6bKXqf+FVku1NvUv0A9IlTooBCE=;
 b=jfrw5wAH0790zlj81+iMgNYQt3A/dYLvWPdf8vxbypzaMP3zr7rtQOprtz5CFNLzUB
 AeXt7qvFnpAMyu5kLnq4Zc0K4lqoZRGSsUOKKcbkoDGWK5GhVCwhDBwdLsNkmYTkiDgK
 0aghcLfXhyywsyTMLyrH7P30SuZPdQ1q0FvDhOWYOsS5nd6u0yDj6J2C+ORWjRmfsZqV
 uOdlOw70BGz8I2ul92hBkZzfDTz6glR3w/DQUX8juUtbM6uIPc1YXi4BiZBmZmd8BGYs
 Aujh6A/ec8vBXZ7SXHLPEJkih464JLEwtqS+bXEQafpFTj1mGoYmF4MS7PXEvCyfLRLO
 /KYA==
X-Gm-Message-State: AA+aEWZzvKfkgiQ7GGTtOkhzSQxvtkpUTUDUp4nTNQ1rgAnwinl3l0zx
 j+8FEuu6bw32QaejxnAqpR09+6MP
X-Google-Smtp-Source: AFSGD/X97hcGVmebTFAjAYdFr3gdCh9VtOWHyhnLzvOlCOc9qsSMv4FODwhhZCJL5uGZeu6fs9sGtA==
X-Received: by 2002:a5d:6aca:: with SMTP id u10mr2841466wrw.310.1543532489548; 
 Thu, 29 Nov 2018 15:01:29 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de.
 [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
 by smtp.googlemail.com with ESMTPSA id k15sm2944895wru.8.2018.11.29.15.01.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 15:01:28 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, khilman@baylibre.com, carlo@caione.org
Subject: [PATCH 1/2] ARM: dts: meson: meson8: add the CPU OPP table
Date: Fri, 30 Nov 2018 00:00:43 +0100
Message-Id: <20181129230044.21358-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129230044.21358-1-martin.blumenstingl@googlemail.com>
References: <20181129230044.21358-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_150141_712133_46F457DC 
X-CRM114-Status: GOOD (  12.92  )
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

The values are taken from Amlogic's 3.10 kernel sources. Their sources
have a "meson8m2_n200_2G.dtd" which defines a different voltage table:
- 0.86V for 96MHz
- (values in between omitted)
- 1.14V for 1.992GHz

The reason for this is simply the hardware design because the voltage
regulator on this board is has a minimum output of 0.86V and a maximum
output of 1.14V. The recommended settings are added with this patch
instead of using the values that are only valid for one board.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 72 +++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 2575a5835567..e5cd325d7ea8 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -64,6 +64,8 @@
 			reg = <0x200>;
 			enable-method = "amlogic,meson8-smp";
 			resets = <&clkc CLKC_RESET_CPU0_SOFT_RESET>;
+			operating-points-v2 = <&cpu_opp_table>;
+			clocks = <&clkc CLKID_CPUCLK>;
 		};
 
 		cpu1: cpu@201 {
@@ -73,6 +75,8 @@
 			reg = <0x201>;
 			enable-method = "amlogic,meson8-smp";
 			resets = <&clkc CLKC_RESET_CPU1_SOFT_RESET>;
+			operating-points-v2 = <&cpu_opp_table>;
+			clocks = <&clkc CLKID_CPUCLK>;
 		};
 
 		cpu2: cpu@202 {
@@ -82,6 +86,8 @@
 			reg = <0x202>;
 			enable-method = "amlogic,meson8-smp";
 			resets = <&clkc CLKC_RESET_CPU2_SOFT_RESET>;
+			operating-points-v2 = <&cpu_opp_table>;
+			clocks = <&clkc CLKID_CPUCLK>;
 		};
 
 		cpu3: cpu@203 {
@@ -91,6 +97,72 @@
 			reg = <0x203>;
 			enable-method = "amlogic,meson8-smp";
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
+			opp-microvolt = <825000>;
+		};
+		opp-192000000 {
+			opp-hz = /bits/ 64 <192000000>;
+			opp-microvolt = <825000>;
+		};
+		opp-312000000 {
+			opp-hz = /bits/ 64 <312000000>;
+			opp-microvolt = <825000>;
+		};
+		opp-408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <825000>;
+		};
+		opp-504000000 {
+			opp-hz = /bits/ 64 <504000000>;
+			opp-microvolt = <825000>;
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <850000>;
+		};
+		opp-720000000 {
+			opp-hz = /bits/ 64 <720000000>;
+			opp-microvolt = <850000>;
+		};
+		opp-816000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <875000>;
+		};
+		opp-1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <925000>;
+		};
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <975000>;
+		};
+		opp-1416000000 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <1025000>;
+		};
+		opp-1608000000 {
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <1100000>;
+		};
+		opp-1800000000 {
+			status = "disabled";
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1125000>;
+		};
+		opp-1992000000 {
+			status = "disabled";
+			opp-hz = /bits/ 64 <1992000000>;
+			opp-microvolt = <1150000>;
 		};
 	};
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
