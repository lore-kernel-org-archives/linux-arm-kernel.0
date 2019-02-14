Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57828C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:10:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25D83222D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MjMqYQgC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vrxqex71"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D83222D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=rgIssZx/lfDk1oOyNFzv1Hn4bxFiMa+vRmEagBIxC4Q=; b=MjMqYQgCzRF+odilzQgc7V0FdJ
	eEIGi1q+SkfPZGrrnXppA/dSWY8Uh1ojPYEFOCHVCc49E710f2IWmRTmf0QYKfN+NXIEkg9wIXoLe
	DLVos/N1VTWDnxngVS4a5kymQT3aYkIZ5pA2X6+XKrdsAJYz6rPWT7E7WfUbWYOAKDD+Sf5qh9+my
	F87xDh4yu67WiUHIiKxR4EaYYMsfbsAfleLiBJPEMDx3P5bD9FQ6TtOR9hr79nc/lLqLLiswhKEhw
	KvTNqTliKDG/NpurGvm8jC3pg7F+symOdy1khHySvywmD0HM5CDttGs1y27KJwnn+pznNQzuLqjGM
	Rxo8K6/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guGmQ-0003Qr-15; Thu, 14 Feb 2019 13:10:18 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guGlj-0001f8-Ra
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 13:09:40 +0000
Received: by mail-pl1-x641.google.com with SMTP id o6so3136748pls.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 05:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ofA8+5OQRWMQvRz/8D4Xr5InC1D52UQFLM4xDydHYFs=;
 b=Vrxqex71isZH7GRRW9BY6yHvd50IjDOjwgwxImUDtgkxn++JflpMl0l0dEC/hAKngc
 vMC064RwxVzhgdExZCCBopR80w/3pPKQqhGt9gd2oVwFLY8cDU98FvA6AAJTRtNR1KJH
 aVZeKe+wpl+U6eiPuhojdUqhUSXkzpqS3uP6HWN3HYkDR4T3y1xV+E0Nz/K24BEnTPXm
 cRG1KnTMCJQEUWyldNwiXrEWGdbOf1gxzH3t5sTUeem3sQxpIfAp9YNyJAPX71SDPwUK
 fY/wac7iVWBYc2pkUFGKn/3HOAYOjvNNlDVP9RH9GyuJZArpwSEw4vVdfUL2fKjYIqik
 0S2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ofA8+5OQRWMQvRz/8D4Xr5InC1D52UQFLM4xDydHYFs=;
 b=Kt2lND3hhTDKzmrBKGLV4o5mDUpe0IeXx3a/hPf0+7SkySkar61iQQk2uNbhdCnOsw
 PgjLYr4QwIpHw5kSaSxwZP6eKOER7qM10wYvtZe47owF20Zhl6HqzmH357HhLsz/I1N8
 jyE8s4Vjn5t3f6mHXiqc16dpM4EleWOXplcrGTGk840BwykyfnVuHYXggRMreh/ZrHam
 VzJebQDEk3ZUDGtKgXmc/fAWTUnAVf/3ZSqLafMTMLR0Cnk8lJrI/LWru2N6f7XPziRz
 DKznaBod/4wAfFhMDki4Lfog2mMm0ZIkXDPzCXeuFDbg+ZN1JRb6YTEENXXeih1Vlu9e
 SXwg==
X-Gm-Message-State: AHQUAuZp/tw3r25pBNLUsqZxpBiX8FRD57iPZCHrIqDZRyainfHOrzUw
 4PD0MVs6tgLtmYj+LG83TKM=
X-Google-Smtp-Source: AHgI3IbX91T+syXYN7LWYJkdosLGW6PfkvSFvASEsnDCCb8pcgVeBNx9t2ByfEwgSO1gcfezi+bSng==
X-Received: by 2002:a17:902:129:: with SMTP id
 38mr4110852plb.140.1550149775352; 
 Thu, 14 Feb 2019 05:09:35 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id b15sm8159128pfj.44.2019.02.14.05.09.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Feb 2019 05:09:34 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: maxime.ripard@bootlin.com,
	wens@csie.org,
	robh+dt@kernel.org
Subject: [PATCH 4/4] arm64: dts: allwinner: h6: Add CPU Operating Performance
 Points table
Date: Thu, 14 Feb 2019 08:09:10 -0500
Message-Id: <20190214130910.9201-5-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190214130910.9201-1-tiny.windzz@gmail.com>
References: <20190214130910.9201-1-tiny.windzz@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_050936_596780_B5D1FA39 
X-CRM114-Status: GOOD (  10.84  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Yangtao Li <tiny.windzz@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add an OPP (Operating Performance Points) table for the CPU cores to
enable DVFS (Dynamic Voltage & Frequency Scaling) on the H6. This
information comes from github.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 61 ++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 57a1390ecdc2..46a4a69eb38f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -28,6 +28,8 @@
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>; 
 			clock-latency-ns = <244144>; /* 8 32k periods */
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
@@ -37,6 +39,8 @@
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>; 
 			clock-latency-ns = <244144>; /* 8 32k periods */
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@2 {
@@ -46,6 +50,8 @@
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>; 
 			clock-latency-ns = <244144>; /* 8 32k periods */
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@3 {
@@ -55,6 +61,61 @@
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>; 
 			clock-latency-ns = <244144>; /* 8 32k periods */
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
+		};
+	};
+
+	cpu_opp_table: opp_table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@480000000 {
+			opp-hz = /bits/ 64 <480000000>;
+			opp-microvolt = <800000 800000 880000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@720000000 {
+			opp-hz = /bits/ 64 <720000000>;
+			opp-microvolt = <800000 800000 880000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@816000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <800000 800000 880000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@888000000 {
+			opp-hz = /bits/ 64 <888000000>;
+			opp-microvolt = <800000 800000 940000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@1080000000 {
+			opp-hz = /bits/ 64 <1080000000>;
+			opp-microvolt = <840000 840000 1060000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@1320000000 {
+			opp-hz = /bits/ 64 <1320000000>;
+			opp-microvolt = <900000 900000 1160000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@1488000000 {
+			opp-hz = /bits/ 64 <1488000000>;
+			opp-microvolt = <960000 960000 1160000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1060000 1060000 1160000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 	};
 
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
