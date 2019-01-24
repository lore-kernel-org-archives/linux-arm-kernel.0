Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52E8C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:19:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 671722184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eJihwwc5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="HpFDGS77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 671722184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=F+8j4QfdihWs3QgD9+hspKfcPVQcrZwt4yB5IHw52W4=; b=eJihwwc5QEX/mFs38RGIF2GDbo
	9WWCimHsuMhDuoodKGQ/Cdtfq+fApqf7Djgu5KYxsYkwwWefTzEX8c3uiq2Hy0isz2Z0fLfb8IHLU
	2DdIWSPImv3N0a7fW1dXhZqAlMuq+pYJPxisOvoi8giwPADqKAnjLBvB5IuyunOCdDjw8H6/+hIYK
	ZeM3nwHpyhVkeLp+9T5h/+P7XQz0Na/TVO0vltaSgvTFpCyNxoSDC8XsNyy+sqdiNO80JVgn0ZGcz
	4PbYTHrg4G/TSdUj/Y9RNRh7fjFbIrqcdFmsCplO8FDLWUd+haY0AmeR8Fbo99wjH/9SLf1YklqoO
	h/uexVzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmgmT-0007dn-NO; Thu, 24 Jan 2019 15:19:01 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmgjF-0001GQ-4v
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 15:15:43 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id BC61825BEF0;
 Fri, 25 Jan 2019 02:12:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1548342764; bh=cF36TjUN6XHH6Nc0U0VXLEPyBbOasQW/znUEQXc+uwU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HpFDGS77dTufnIJfsP0TBzoWpnNo5nNpZgVutOV+92zeF3fJHkw9plslEGaZ1fsPw
 9dUesZjlrzjxYgKP4zMeIt01EXxymjfdjU8xyvf24x8N3jenFuJ567RIg8kOjeV+Zb
 Vp+E5E7GIfvfCfRGLEnAkRmiE3Nep6G5vgxE49jw=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 411A0940C5F; Thu, 24 Jan 2019 16:12:40 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 19/44] arm64: dts: renesas: r8a774c0: Add audio support
Date: Thu, 24 Jan 2019 16:12:13 +0100
Message-Id: <cf8f74d6587d96abf746041d4df1425715f69c85.1548233325.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1548233325.git.horms+renesas@verge.net.au>
References: <cover.1548233325.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_071541_484800_8A6D3260 
X-CRM114-Status: GOOD (  13.05  )
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

Add sound support for the RZ/G2E SoC (a.k.a. R8A774C0).

This work is based on similar work done on the R8A77990 SoC
by Yoshihiro Kaneko <ykaneko0929@gmail.com>.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 241 ++++++++++++++++++++++++++++++
 1 file changed, 241 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index 9bd66b1474d5..35b27b81bcd4 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -917,6 +917,247 @@
 			status = "disabled";
 		};
 
+		rcar_sound: sound@ec500000 {
+			/*
+			 * #sound-dai-cells is required
+			 *
+			 * Single DAI : #sound-dai-cells = <0>;	<&rcar_sound>;
+			 * Multi  DAI : #sound-dai-cells = <1>;	<&rcar_sound N>;
+			 */
+			/*
+			 * #clock-cells is required for audio_clkout0/1/2/3
+			 *
+			 * clkout	: #clock-cells = <0>;	<&rcar_sound>;
+			 * clkout0/1/2/3: #clock-cells = <1>;	<&rcar_sound N>;
+			 */
+			compatible = "renesas,rcar_sound-r8a774c0",
+				     "renesas,rcar_sound-gen3";
+			reg =	<0 0xec500000 0 0x1000>, /* SCU */
+				<0 0xec5a0000 0 0x100>,  /* ADG */
+				<0 0xec540000 0 0x1000>, /* SSIU */
+				<0 0xec541000 0 0x280>,  /* SSI */
+				<0 0xec760000 0 0x200>;  /* Audio DMAC peri peri*/
+			reg-names = "scu", "adg", "ssiu", "ssi", "audmapp";
+
+			clocks = <&cpg CPG_MOD 1005>,
+				 <&cpg CPG_MOD 1006>, <&cpg CPG_MOD 1007>,
+				 <&cpg CPG_MOD 1008>, <&cpg CPG_MOD 1009>,
+				 <&cpg CPG_MOD 1010>, <&cpg CPG_MOD 1011>,
+				 <&cpg CPG_MOD 1012>, <&cpg CPG_MOD 1013>,
+				 <&cpg CPG_MOD 1014>, <&cpg CPG_MOD 1015>,
+				 <&cpg CPG_MOD 1022>, <&cpg CPG_MOD 1023>,
+				 <&cpg CPG_MOD 1024>, <&cpg CPG_MOD 1025>,
+				 <&cpg CPG_MOD 1026>, <&cpg CPG_MOD 1027>,
+				 <&cpg CPG_MOD 1028>, <&cpg CPG_MOD 1029>,
+				 <&cpg CPG_MOD 1030>, <&cpg CPG_MOD 1031>,
+				 <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
+				 <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
+				 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
+				 <&audio_clk_a>, <&audio_clk_b>,
+				 <&audio_clk_c>,
+				 <&cpg CPG_CORE R8A774C0_CLK_ZA2>;
+			clock-names = "ssi-all",
+				      "ssi.9", "ssi.8", "ssi.7", "ssi.6",
+				      "ssi.5", "ssi.4", "ssi.3", "ssi.2",
+				      "ssi.1", "ssi.0",
+				      "src.9", "src.8", "src.7", "src.6",
+				      "src.5", "src.4", "src.3", "src.2",
+				      "src.1", "src.0",
+				      "mix.1", "mix.0",
+				      "ctu.1", "ctu.0",
+				      "dvc.0", "dvc.1",
+				      "clk_a", "clk_b", "clk_c", "clk_i";
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			resets = <&cpg 1005>,
+				 <&cpg 1006>, <&cpg 1007>,
+				 <&cpg 1008>, <&cpg 1009>,
+				 <&cpg 1010>, <&cpg 1011>,
+				 <&cpg 1012>, <&cpg 1013>,
+				 <&cpg 1014>, <&cpg 1015>;
+			reset-names = "ssi-all",
+				      "ssi.9", "ssi.8", "ssi.7", "ssi.6",
+				      "ssi.5", "ssi.4", "ssi.3", "ssi.2",
+				      "ssi.1", "ssi.0";
+			status = "disabled";
+
+			rcar_sound,dvc {
+				dvc0: dvc-0 {
+					dmas = <&audma0 0xbc>;
+					dma-names = "tx";
+				};
+				dvc1: dvc-1 {
+					dmas = <&audma0 0xbe>;
+					dma-names = "tx";
+				};
+			};
+
+			rcar_sound,mix {
+				mix0: mix-0 { };
+				mix1: mix-1 { };
+			};
+
+			rcar_sound,ctu {
+				ctu00: ctu-0 { };
+				ctu01: ctu-1 { };
+				ctu02: ctu-2 { };
+				ctu03: ctu-3 { };
+				ctu10: ctu-4 { };
+				ctu11: ctu-5 { };
+				ctu12: ctu-6 { };
+				ctu13: ctu-7 { };
+			};
+
+			rcar_sound,src {
+				src0: src-0 {
+					interrupts = <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x85>, <&audma0 0x9a>;
+					dma-names = "rx", "tx";
+				};
+				src1: src-1 {
+					interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x87>, <&audma0 0x9c>;
+					dma-names = "rx", "tx";
+				};
+				src2: src-2 {
+					interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x89>, <&audma0 0x9e>;
+					dma-names = "rx", "tx";
+				};
+				src3: src-3 {
+					interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x8b>, <&audma0 0xa0>;
+					dma-names = "rx", "tx";
+				};
+				src4: src-4 {
+					interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x8d>, <&audma0 0xb0>;
+					dma-names = "rx", "tx";
+				};
+				src5: src-5 {
+					interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x8f>, <&audma0 0xb2>;
+					dma-names = "rx", "tx";
+				};
+				src6: src-6 {
+					interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x91>, <&audma0 0xb4>;
+					dma-names = "rx", "tx";
+				};
+				src7: src-7 {
+					interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x93>, <&audma0 0xb6>;
+					dma-names = "rx", "tx";
+				};
+				src8: src-8 {
+					interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x95>, <&audma0 0xb8>;
+					dma-names = "rx", "tx";
+				};
+				src9: src-9 {
+					interrupts = <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x97>, <&audma0 0xba>;
+					dma-names = "rx", "tx";
+				};
+			};
+
+			rcar_sound,ssi {
+				ssi0: ssi-0 {
+					interrupts = <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x01>, <&audma0 0x02>,
+					       <&audma0 0x15>, <&audma0 0x16>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi1: ssi-1 {
+					interrupts = <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x03>, <&audma0 0x04>,
+					       <&audma0 0x49>, <&audma0 0x4a>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi2: ssi-2 {
+					interrupts = <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x05>, <&audma0 0x06>,
+					       <&audma0 0x63>, <&audma0 0x64>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi3: ssi-3 {
+					interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x07>, <&audma0 0x08>,
+					       <&audma0 0x6f>, <&audma0 0x70>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi4: ssi-4 {
+					interrupts = <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x09>, <&audma0 0x0a>,
+					       <&audma0 0x71>, <&audma0 0x72>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi5: ssi-5 {
+					interrupts = <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x0b>, <&audma0 0x0c>,
+					       <&audma0 0x73>, <&audma0 0x74>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi6: ssi-6 {
+					interrupts = <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x0d>, <&audma0 0x0e>,
+					       <&audma0 0x75>, <&audma0 0x76>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi7: ssi-7 {
+					interrupts = <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x0f>, <&audma0 0x10>,
+					       <&audma0 0x79>, <&audma0 0x7a>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi8: ssi-8 {
+					interrupts = <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x11>, <&audma0 0x12>,
+					       <&audma0 0x7b>, <&audma0 0x7c>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi9: ssi-9 {
+					interrupts = <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x13>, <&audma0 0x14>,
+					       <&audma0 0x7d>, <&audma0 0x7e>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+			};
+		};
+
+		audma0: dma-controller@ec700000 {
+			compatible = "renesas,dmac-r8a774c0",
+				     "renesas,rcar-dmac";
+			reg = <0 0xec700000 0 0x10000>;
+			interrupts = <GIC_SPI 350 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					"ch0", "ch1", "ch2", "ch3",
+					"ch4", "ch5", "ch6", "ch7",
+					"ch8", "ch9", "ch10", "ch11",
+					"ch12", "ch13", "ch14", "ch15";
+			clocks = <&cpg CPG_MOD 502>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			resets = <&cpg 502>;
+			#dma-cells = <1>;
+			dma-channels = <16>;
+		};
+
 		sdhi0: sd@ee100000 {
 			compatible = "renesas,sdhi-r8a774c0",
 				     "renesas,rcar-gen3-sdhi";
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
