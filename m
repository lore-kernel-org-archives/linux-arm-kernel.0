Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8687C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:54:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B99552190C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ucNqZrOv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfgTGXGN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B99552190C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=oXEObjJA7ELdTXL2Ezshw9BhWYBYYFsfK3/FooeULhc=; b=ucNqZrOvJ+Y29FAi50aKm3B5F8
	wtbl/7KWAUUogrKWjZ3R/8FBsliYtO7dPPfSLt2Ou/G8HyE9B+cufL4ZC4F7XpbyvK+dKRZycfMsA
	YyhlrlvA8jaVO2KjxNvJCjX8FyjKfkR0NxVGx5B6BWtWtgPgXndhhzmyj0Jlvuwr2kSDHiuBczODB
	+tFniWhZH26cqWKG+qwurkZJX9PuuScQq5y63pHTPE4nJ0bHoKb9w2QOWG9eCEtFxmZa42/N9uP8o
	FtoNH6F52B0fk80M/vq1ozWS7xl2y2Vsu4Aztm3RsgMiBQAf0LLrv9Qs87lXwEmR4SAW6GAbLMvCW
	lY+frZDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufp4-0007GN-V9; Fri, 15 Feb 2019 15:54:42 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufoZ-0006f8-7E
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:54:20 +0000
Received: by mail-pg1-x542.google.com with SMTP id h11so2630315pgl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lmPr0f7y3m5+PsytZvDuOz52e0HbFaKrkiyNn/QTcv0=;
 b=LfgTGXGNz4XzA7myb/CJBlRgbI9FYUnrZGUY31wHWnDKeMnkeVMt/pEbj+lZv0cto/
 XVvqsoE1QawsMZrFzQbWe/oxetlwuDALWeM394LIdUFDpzDmYtCkFvFa3rnCQA6xMd6K
 //iRzR40DgXg0ekCM18vY7PYRSVmApSYQ+s1t187bOm4bpl1Zo9Nk7kgwxqaYydNHEtO
 JQU2hqGunWs6IiRrk0nUZPmiTso++EnbwuTuUWU34cv+rPq/pCbydxXvWqatLK8rf+iH
 beHo5zrUHjsGezCT+xItEhXvgv1GVvkpYmKu73zJAekOqU677wbpZCQ3+urKEVKEhLaO
 KWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=lmPr0f7y3m5+PsytZvDuOz52e0HbFaKrkiyNn/QTcv0=;
 b=NiGKbgZfv4LkeLiS/5qrY7L0iSW68iELk/COhcpjHGYOXjY2gOYqNu3MOHyMEWR5s2
 lwotByLsYDGQHKfTMLlSdvtyD35JlOOCoMXmB96DHx2oyMZm/JSSfPl5cHZt+iD3weer
 loBC0xs67dIRi3uQNGLduvTO3vqObH4tw+89WDzfpX3WFoRyQ1wkMbF0e5D0otowK7Ad
 LIWSNoVpxl0hmPp3Y3vuGUVFZ0S7zR1/hfJVafWSHu34H2MKMJsV3ErniL4O2DTvHRRC
 syqQ+fCk7NXZuyB61QAvF2HJ+/KkGDNeAJ8QhqEG/3rJQ4JT0s2Q2iFxtYJVNa8JQTVC
 XN3g==
X-Gm-Message-State: AHQUAubX8zpbgy26+x6pb2VUoZVxf/NIZbKTk+s4kDi8JPg0YTkbTy4k
 UIv4OFAfwFk+s6SF6vV6kkb2YfMkdsI=
X-Google-Smtp-Source: AHgI3IZC/YMxbW52MymaCchdH5AtkZkpgsGvF+MvLIKCfxV1rCXjwN2BXW6AXUfIJ5ZH11vVSIN6OQ==
X-Received: by 2002:a62:ee0e:: with SMTP id e14mr10498438pfi.201.1550246050734; 
 Fri, 15 Feb 2019 07:54:10 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id m20sm6256084pgv.93.2019.02.15.07.54.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 15 Feb 2019 07:54:09 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
 mark.rutland@arm.com
Subject: [PATCH v3 4/4] arm64: dts: allwinner: h6: Add CPU Operating
 Performance Points table
Date: Fri, 15 Feb 2019 10:53:38 -0500
Message-Id: <20190215155338.10564-5-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190215155338.10564-1-tiny.windzz@gmail.com>
References: <20190215155338.10564-1-tiny.windzz@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_075411_700807_639C0892 
X-CRM114-Status: GOOD (  13.52  )
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
Cc: Yangtao Li <tiny.windzz@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add an OPP (Operating Performance Points) table for the CPU cores to
enable DVFS (Dynamic Voltage & Frequency Scaling) on the H6. This
information comes from github.

When the four CPUs are running at 1.8 GHz, 100% busy, it is easy to heat
up and make the system restart. And currently H6 does not support the
thermal driver, can not get the temperature information of the cpu to
control the highest frequency. So temporarily remove the opp of 1.8GHz.

When the four CPUs operate at 1.4 GHz, 100% busy, the temperature is
stable at about 90 degrees, and the system can still operate normally.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 55 ++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 723f5d991a74..84fb47062fe6 100644
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
@@ -55,6 +61,55 @@
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
 		};
 	};
 
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
