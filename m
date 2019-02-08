Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444F9C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:23:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DFA820863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="REljgnJ5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="Uo7rOeG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DFA820863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=TLz/RSeJiK8t/Ct6bb2fC5MQYkdtyM4FXhtHR+KaNcE=; b=REljgnJ5lszhB2GGDmid5pqU7F
	Ue27GNmrOM4GzLbr5U7XrUUmlv2dvDm5gKuf9Pbeu6k6pBJWlPl+o89/LU63JQlRpHCJcUweQxdJI
	kWb8h0NgJ8SoQnekoDoLq1lurXEOO2Dp0YHzsDSmAvaOB+DgqB3lunCzhYOuAg1A/qcc5/8PNoWuw
	bb2y/Je8aGGwOw1tGPuz/kM0F/JAV2+5EETS5aMQDeZIBHDoWhJWXvw/z4N4ZmaXfaWLyjBmWGyIu
	g12Qy2/tNnWJuSt1OUm93dBSpm1VEgURWoxwYuYys7Yh3fWghh0NTqPe65hRGjzRSQo/EVPIYFrrK
	qaReRmvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs4FW-0001un-Na; Fri, 08 Feb 2019 11:23:14 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs4F2-0005IB-3v
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 11:23:11 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 6EC4125BF15;
 Fri,  8 Feb 2019 22:14:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1549624459; bh=gQd1cvnM9Qeq98jZOuayM3zo37fJvTCm/wxKxu365W0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Uo7rOeG/1L7bAcScRVUKWrTrH5n+MzNGLQIbJDSn+1OXSCNI5wQtSSbzN4/Lcz49N
 ESC+mtNPH0spv7Tp3GS6kNkywQgCh/bLV7KcXEbzeY3mbygZtETHTGw5MENRLxsq+t
 9/mUdAPY+SDVwhczrc3tX4xnM9FE6c450yOUR1No=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id B480494088D; Fri,  8 Feb 2019 12:14:15 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 07/12] ARM: dts: r8a7778: Add HSCIF0/1 support
Date: Fri,  8 Feb 2019 12:14:08 +0100
Message-Id: <adbb78e1104a006275e0e8e37526f617bb2a3d91.1549623128.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1549623128.git.horms+renesas@verge.net.au>
References: <cover.1549623128.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_032245_038795_0B22CED4 
X-CRM114-Status: UNSURE (   9.68  )
X-CRM114-Notice: Please train this message.
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
Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>,
 Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Add HSCIF0/1 clocks and device nodes, based on Rev. 1.00 of the R-Car
M1A datasheet.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
[geert: Squashed two patches]
[geert: Correct HSCIF1 module clock index]
[geert: Correct reg properties for non-LPAE]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778.dtsi            | 28 ++++++++++++++++++++++++++++
 include/dt-bindings/clock/r8a7778-clock.h |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 05db0ccad7a6..10d996d2941f 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -367,6 +367,30 @@
 		status = "disabled";
 	};
 
+	hscif0: serial@ffe48000 {
+		compatible = "renesas,hscif-r8a7778",
+			     "renesas,rcar-gen1-hscif", "renesas,hscif";
+		reg = <0xffe48000 96>;
+		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7778_CLK_HSCIF0>,
+			 <&cpg_clocks R8A7778_CLK_S>, <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	hscif1: serial@ffe49000 {
+		compatible = "renesas,hscif-r8a7778",
+			     "renesas,rcar-gen1-hscif", "renesas,hscif";
+		reg = <0xffe49000 96>;
+		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7778_CLK_HSCIF1>,
+			 <&cpg_clocks R8A7778_CLK_S>, <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
 	mmcif: mmc@ffe4e000 {
 		compatible = "renesas,mmcif-r8a7778", "renesas,sh-mmcif";
 		reg = <0xffe4e000 0x100>;
@@ -535,6 +559,8 @@
 				 <&cpg_clocks R8A7778_CLK_P>,
 				 <&cpg_clocks R8A7778_CLK_P>,
 				 <&cpg_clocks R8A7778_CLK_P>,
+				 <&cpg_clocks R8A7778_CLK_S>,
+				 <&cpg_clocks R8A7778_CLK_S>,
 				 <&cpg_clocks R8A7778_CLK_P>,
 				 <&cpg_clocks R8A7778_CLK_P>,
 				 <&cpg_clocks R8A7778_CLK_P>,
@@ -551,6 +577,7 @@
 				R8A7778_CLK_SCIF0 R8A7778_CLK_SCIF1
 				R8A7778_CLK_SCIF2 R8A7778_CLK_SCIF3
 				R8A7778_CLK_SCIF4 R8A7778_CLK_SCIF5
+				R8A7778_CLK_HSCIF0 R8A7778_CLK_HSCIF1
 				R8A7778_CLK_TMU0 R8A7778_CLK_TMU1
 				R8A7778_CLK_TMU2 R8A7778_CLK_SSI0
 				R8A7778_CLK_SSI1 R8A7778_CLK_SSI2
@@ -560,6 +587,7 @@
 			clock-output-names =
 				"i2c0", "i2c1", "i2c2", "i2c3", "scif0",
 				"scif1", "scif2", "scif3", "scif4", "scif5",
+				"hscif0", "hscif1",
 				"tmu0", "tmu1", "tmu2", "ssi0", "ssi1",
 				"ssi2", "ssi3", "sru", "hspi";
 		};
diff --git a/include/dt-bindings/clock/r8a7778-clock.h b/include/dt-bindings/clock/r8a7778-clock.h
index f6b07c5399de..d0bff9ec5c66 100644
--- a/include/dt-bindings/clock/r8a7778-clock.h
+++ b/include/dt-bindings/clock/r8a7778-clock.h
@@ -30,6 +30,8 @@
 #define R8A7778_CLK_SCIF3	23
 #define R8A7778_CLK_SCIF4	22
 #define R8A7778_CLK_SCIF5	21
+#define R8A7778_CLK_HSCIF0	19
+#define R8A7778_CLK_HSCIF1	18
 #define R8A7778_CLK_TMU0	16
 #define R8A7778_CLK_TMU1	15
 #define R8A7778_CLK_TMU2	14
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
