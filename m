Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9DAC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:17:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C4C62184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o8zpOESo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="NEjsnYt1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C4C62184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=AtGnOHkG3OsXIOoXkt43p2uKjP+nDMLls17hu4QqlL8=; b=o8zpOESomPe4ul+ykUgU3UzX/H
	zp+ckMrqlNC2fyl8dmkq4YN+XCHfPk8YndGwYjEuxZUNt5Az7ws7jewbM10cric0D+69GgLH47a6o
	UySw8HSbmvM3/hNLz1EORQhuAbboNy08MlqgpAxTs+bVAdSqa0ysxc3h6lFJKOnHoxbB9ZjuIqORt
	BsjjieA1qARkdFAQBT/COaZjQPh1McDX/pXdMy8YYwv9LQz97LsRowU7jjn0EvNtF18E2istDjeFV
	ZBMfrkiT43GrGi9WtIlTTzN7XOrpAU5pEHOIjvt3mlfmEDxa2DBng6ccvioctQ7PG6O2vLoelyfkf
	7B9vgw6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmgkV-0005ih-7D; Thu, 24 Jan 2019 15:16:59 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmgj9-0001GQ-Do
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 15:15:36 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 9A40525BEEC;
 Fri, 25 Jan 2019 02:12:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1548342763; bh=V8NkbyeT0VINMjZWa9e+5++LTyHXyDPcFomF9awOFis=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NEjsnYt1tiYJ7hZ5l6isddmHR44oEXZ4w39i6bKZp5Qzzq8loFY25nUJ2l67HUxGV
 V/p3MdAGkachGmggKEsGR5dBU86jvy45vMPYJ2qs6vdsJ7/LjB9XwBim7bN9UaSmkO
 Q4o2bZ8/SXJ7H+xrpFXXx70LGtmYCPOmIbNPru+c=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id D37F0940B7D; Thu, 24 Jan 2019 16:12:39 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 12/44] arm64: dts: renesas: r8a774c0: Add secondary CA53 CPU
 core
Date: Thu, 24 Jan 2019 16:12:06 +0100
Message-Id: <9b55a05ebfbe41bfb4c2aa98a81a46f2031e599f.1548233325.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1548233325.git.horms+renesas@verge.net.au>
References: <cover.1548233325.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_071535_610953_EBA072C6 
X-CRM114-Status: GOOD (  11.86  )
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
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
 Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Add a device node for the second Cortex-A53 CPU core on the Renesas
RZ/G2E (a.k.a r8a774c0) SoC, and adjust the interrupt delivery masks
for the ARM Generic Interrupt Controller and Architectured Timer.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index a51b6d37f0cb..83db7c740481 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -48,7 +48,6 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		/* 1 core only at this point */
 		a53_0: cpu@0 {
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0>;
@@ -58,6 +57,15 @@
 			enable-method = "psci";
 		};
 
+		a53_1: cpu@1 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <1>;
+			device_type = "cpu";
+			power-domains = <&sysc R8A774C0_PD_CA53_CPU1>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+		};
+
 		L2_CA53: cache-controller-0 {
 			compatible = "cache";
 			power-domains = <&sysc R8A774C0_PD_CA53_SCU>;
@@ -82,8 +90,9 @@
 
 	pmu_a53 {
 		compatible = "arm,cortex-a53-pmu";
-		interrupts-extended = <&gic GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-affinity = <&a53_0>;
+		interrupts-extended = <&gic GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&a53_0>, <&a53_1>;
 	};
 
 	psci {
@@ -604,7 +613,7 @@
 			      <0x0 0xf1040000 0 0x20000>,
 			      <0x0 0xf1060000 0 0x20000>;
 			interrupts = <GIC_PPI 9
-					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
+					(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&cpg CPG_MOD 408>;
 			clock-names = "clk";
 			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
@@ -619,10 +628,10 @@
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
 	/* External USB clocks - can be overridden by the board */
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
