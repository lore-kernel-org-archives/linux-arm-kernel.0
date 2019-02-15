Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36B9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:51:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9416D2192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IuOngB+D";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYtk3b6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9416D2192D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=oXEObjJA7ELdTXL2Ezshw9BhWYBYYFsfK3/FooeULhc=; b=IuOngB+DsxIDX37EdvD4X0RdA+
	6qM85VZOoeAOnZvwAI9KAM25qw33GDLHGFLM/W5/kjdr6Dsk9Cta09xSzjUjftLHX6AfDjVypLMW2
	4XVKWdDAe5MnCpvHJfxOrMXY05uNVR+0/pVl6W+Y65aw+5tZTxRdkh6XudaeOPgSP7duO5xa8juyo
	6cwY2uRKCvR5bUoQIly86GSqrfzFzAzGhJnF2Mj7kPLoyUx5PCP/UbgaREWhFNiazUc1CB96G4uIo
	9Bb7+P2fKiBhPvoyj/r9lTICe8WxEdYPrw2Hb196wAnO7cr7byKk4lXYN11K7a26a/uExq284EiCZ
	e5sBT7Mg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gudtH-00059L-91; Fri, 15 Feb 2019 13:50:55 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gudsL-000310-G8
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 13:50:19 +0000
Received: by mail-pf1-x442.google.com with SMTP id n74so4868681pfi.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 05:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lmPr0f7y3m5+PsytZvDuOz52e0HbFaKrkiyNn/QTcv0=;
 b=rYtk3b6yXh3QjciyPCKhT/XhQJlnGpaykwgjpFwiLRAYm40PsxbBKy0yPYVhoJ2bje
 7GXwcjQLLkCQ6xmOyo823Getk6KGWMEsFdBE8K9PuRj3XwqJQJOZgHlByl4hm/Ze8lC8
 AKGs9/78KhWgyiSTtzR/UsSOWgSXcVqVRNsgvlmnbwE+X8HLMzD7ZEFi0GrR3UXVFlmf
 9d/mImnSXYvaplQkTOO6/LpWiNZunpkVBb6Ts7yuv/bBhYUvClnSKG3K/3w/ox1XuVFn
 lGjQlQqlrFgOn91Cy20zuqBIHaGE1DFyfZNmHrVn/izVOI4LguqHAli95oe7EyUB69rB
 aGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=lmPr0f7y3m5+PsytZvDuOz52e0HbFaKrkiyNn/QTcv0=;
 b=q6wjrEkST7AsTvG+Fjg5h4BlPCj3aPLkOJUFbx8uHHXtiWJOTtFa5YVdaR1r7nVpjA
 nRORio7IohAWDZXucNqJ9pIMeS7fBqTbfq4dYZGOfn5LS+4zoWvwqdEg42n7dX7bpZXx
 ++gZ8bGjcmiWCSNz17OUob70CHwvoFsUM7AYgFNMjPMx93/L6tPSjw5glA/46nj2X/l9
 74IDWv3j0Rqltkeyt9ZRm83mykzy7IhwvZlc3PMKpWHt/WweFw890YXGkE0YP6fy8Juv
 sNvq5RTgiwHvLixR0Yy+QlksdJ/fjCwFeQG0c6UcpoSUoll3OxZ8JFNtLJJlAYVtdTC3
 dDPA==
X-Gm-Message-State: AHQUAubPlLn/CJoNeZrxTQUxjzYm/FoZKLJ1CgJDf/kCQ+7DBPl0TnLi
 HiUCtM0JKSv96+af+0MuO/c=
X-Google-Smtp-Source: AHgI3IbNk3I5+OCPsiR4MT7lg4rskqavJlLuodBpXsexgfJQ+vhB2leyMMcL5uSa/a769rP32BGtkg==
X-Received: by 2002:a65:490e:: with SMTP id p14mr5464986pgs.373.1550238596863; 
 Fri, 15 Feb 2019 05:49:56 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id j5sm6871172pfe.84.2019.02.15.05.49.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 15 Feb 2019 05:49:56 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
 mark.rutland@arm.com
Subject: [PATVH v2 4/4] arm64: dts: allwinner: h6: Add CPU Operating
 Performance Points table
Date: Fri, 15 Feb 2019 08:49:37 -0500
Message-Id: <20190215134937.10259-5-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190215134937.10259-1-tiny.windzz@gmail.com>
References: <20190215134937.10259-1-tiny.windzz@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_054957_856369_72485B2B 
X-CRM114-Status: GOOD (  13.21  )
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
