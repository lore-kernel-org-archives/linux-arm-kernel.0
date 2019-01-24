Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42E6C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:24:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8128021855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A2UrJZGa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="iQjDVHcN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8128021855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=9wnUmx6kaNmcrfMgrznZDY/jXMOPhxzyb18/kjcficA=; b=A2UrJZGa+CzcqiKLOBrreQBUkA
	19/YPRkTkn91jdEcx1MOmZ1kYvbEBINxGHucCOCb3ys2Xrn7g7lWgOZkkqQv6Oy8h1oMTDU4ch7x8
	knS3Tqo0fSQ0Ffvj38SGvUnVcBmTYqxJpRV0kCmSg0iK24+i9gsPXUGrQ/hYlIwkmj+euRG3fKJx/
	uKSx8tubZMLS+qqSygs25XPYBLmuN9lt0ZymB5b05QVSC45t4G1XkRLnWI7HLcRwLn9nh3PtovrOi
	dKOO7OIMEpJeCebWbd55Rm5MAMq019VvsbM+ZAmSo1pWCoe3DGQUvWaQF8IqgJkm9Ib6BQfH7UG43
	iSdVKijA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmgrh-0004oG-L2; Thu, 24 Jan 2019 15:24:25 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmglZ-0001GQ-55
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 15:18:41 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id A965825BF03;
 Fri, 25 Jan 2019 02:12:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1548342764; bh=8sbaQCJhR0VzRyurxl5IxN/WDY6Fz+ss4EGtxtEmBY0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iQjDVHcNEq+ELOSzLyg0+wyVt9as+u0b1cIfKiiEeBm0dDBCGLH7z7n/OOqkIWpO8
 JLyR1F84XK9iG0JnVFR9UJuy0K+89/FwbES51A182uG2hy7HodQvD4jloi26qg/VdY
 5ElwmUaLFjssK2BTtOiTbcN7uUOVNecTMp02ja2M=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 43D64940DF8; Thu, 24 Jan 2019 16:12:41 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 37/44] arm64: dts: renesas: r8a7795: remove BUSIF0 settings
 from rcar_sound, ssi
Date: Thu, 24 Jan 2019 16:12:31 +0100
Message-Id: <0ec8e0a879b8d7eacbfbed9a7face8f97f9493a8.1548233325.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1548233325.git.horms+renesas@verge.net.au>
References: <cover.1548233325.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_071805_962359_29CECC14 
X-CRM114-Status: UNSURE (   8.84  )
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
Cc: Simon Horman <horms+renesas@verge.net.au>,
 Magnus Damm <magnus.damm@gmail.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Before, BUSIF which is needed for DMA transfer was automatically handled
via SSI, but it cared BUSIF0 only.
Now, rsnd driver can handle BUSIF0-7 (= for Gen3) BUSIF0-3 (= for Gen2)
via SSIU, and it is keeping compatibility.
Thus, BUSIF0 settings via SSI had been kept to avoid git merge timing
issue / git bisect issue, but it is no longer needed.
This patch removes it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 40 ++++++++++++++++----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index af9605d5db27..a81ed2ba63e7 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -2174,53 +2174,53 @@
 			rcar_sound,ssi {
 				ssi0: ssi-0 {
 					interrupts = <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x01>, <&audma1 0x02>, <&audma0 0x15>, <&audma1 0x16>;
-					dma-names = "rx", "tx", "rxu", "txu";
+					dmas = <&audma0 0x01>, <&audma1 0x02>;
+					dma-names = "rx", "tx";
 				};
 				ssi1: ssi-1 {
 					 interrupts = <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x03>, <&audma1 0x04>, <&audma0 0x49>, <&audma1 0x4a>;
-					dma-names = "rx", "tx", "rxu", "txu";
+					dmas = <&audma0 0x03>, <&audma1 0x04>;
+					dma-names = "rx", "tx";
 				};
 				ssi2: ssi-2 {
 					interrupts = <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x05>, <&audma1 0x06>, <&audma0 0x63>, <&audma1 0x64>;
-					dma-names = "rx", "tx", "rxu", "txu";
+					dmas = <&audma0 0x05>, <&audma1 0x06>;
+					dma-names = "rx", "tx";
 				};
 				ssi3: ssi-3 {
 					interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x07>, <&audma1 0x08>, <&audma0 0x6f>, <&audma1 0x70>;
-					dma-names = "rx", "tx", "rxu", "txu";
+					dmas = <&audma0 0x07>, <&audma1 0x08>;
+					dma-names = "rx", "tx";
 				};
 				ssi4: ssi-4 {
 					interrupts = <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x09>, <&audma1 0x0a>, <&audma0 0x71>, <&audma1 0x72>;
-					dma-names = "rx", "tx", "rxu", "txu";
+					dmas = <&audma0 0x09>, <&audma1 0x0a>;
+					dma-names = "rx", "tx";
 				};
 				ssi5: ssi-5 {
 					interrupts = <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x0b>, <&audma1 0x0c>, <&audma0 0x73>, <&audma1 0x74>;
-					dma-names = "rx", "tx", "rxu", "txu";
+					dmas = <&audma0 0x0b>, <&audma1 0x0c>;
+					dma-names = "rx", "tx";
 				};
 				ssi6: ssi-6 {
 					interrupts = <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x0d>, <&audma1 0x0e>, <&audma0 0x75>, <&audma1 0x76>;
-					dma-names = "rx", "tx", "rxu", "txu";
+					dmas = <&audma0 0x0d>, <&audma1 0x0e>;
+					dma-names = "rx", "tx";
 				};
 				ssi7: ssi-7 {
 					interrupts = <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x0f>, <&audma1 0x10>, <&audma0 0x79>, <&audma1 0x7a>;
-					dma-names = "rx", "tx", "rxu", "txu";
+					dmas = <&audma0 0x0f>, <&audma1 0x10>;
+					dma-names = "rx", "tx";
 				};
 				ssi8: ssi-8 {
 					interrupts = <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x11>, <&audma1 0x12>, <&audma0 0x7b>, <&audma1 0x7c>;
-					dma-names = "rx", "tx", "rxu", "txu";
+					dmas = <&audma0 0x11>, <&audma1 0x12>;
+					dma-names = "rx", "tx";
 				};
 				ssi9: ssi-9 {
 					interrupts = <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x13>, <&audma1 0x14>, <&audma0 0x7d>, <&audma1 0x7e>;
-					dma-names = "rx", "tx", "rxu", "txu";
+					dmas = <&audma0 0x13>, <&audma1 0x14>;
+					dma-names = "rx", "tx";
 				};
 			};
 		};
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
