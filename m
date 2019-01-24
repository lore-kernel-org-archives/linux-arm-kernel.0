Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A72C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:18:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D916F2184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XXmYXtnt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="Cy6Oglcq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D916F2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=wxvcomVOZqmdJxkSy0wrquOiiatJDn2y0N4rCycRvDo=; b=XXmYXtntXaMtkKnRy0k9B/mXTG
	14x2tXbntu4p6+Hv8ktzZM47HZ0OYsjq0p0EADLNx0XAOZimQaQxqsj/VIjgpFTeGLzv7s2SsMXI/
	TcoV/ZUHCoPT8GQIXprDwaW1XJlZSRUGh5/diCbA01pcir4wABS6FVhgjp0RyEDiPtWCl98trwejs
	YsaFl3NnNd1pZ0yl9z0YF8dfpPHvLxsRY3QB5IgZW77Lke6ibD8pNqKXLyqkflgAUiG3Qc1JF+FSA
	6XTtCRmfS0GXCCDGHjeEJc2VQN+96Os5eDlv4KfWFiLVfV3Wd+fRxQDPAfniEUqxauu9UlbGHItJm
	PkWJ4YiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmglt-0006zC-UU; Thu, 24 Jan 2019 15:18:25 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmgjB-0001GQ-8s
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 15:15:38 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id AF23B25BEEE;
 Fri, 25 Jan 2019 02:12:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1548342764; bh=cdMWnTH9TSANg/vwMmHL8W3ZMOYD56AJpDA+GJ7/TAM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Cy6OglcqLA1GhX19pqcCwt6NzqkJRpFfhF4U6wdGTCx5MqEQkhTuo7tyJ2KXFOQ8I
 bAu+R7ANxa2HzimFlRykalqj0vWkqOu1307Dnmf+EqFW/1y+7/RWcfELnpxuzcAtx8
 2VXfgeKZbkTPLSKfUVaWgLT/Byzx5SlkMKQTAPLI=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id E046A940BB2; Thu, 24 Jan 2019 16:12:39 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 13/44] arm64: dts: renesas: r8a774c0: Add SDHI nodes
Date: Thu, 24 Jan 2019 16:12:07 +0100
Message-Id: <77223211f44db5b35541f4cc1fe48cdee21a85b2.1548233325.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1548233325.git.horms+renesas@verge.net.au>
References: <cover.1548233325.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_071537_454286_4A6D7526 
X-CRM114-Status: GOOD (  10.04  )
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

Add SDHI nodes to the DT of the r8a774c0 SoC.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 36 +++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index 83db7c740481..96a71e3f9fe4 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -603,6 +603,42 @@
 			status = "disabled";
 		};
 
+		sdhi0: sd@ee100000 {
+			compatible = "renesas,sdhi-r8a774c0",
+				     "renesas,rcar-gen3-sdhi";
+			reg = <0 0xee100000 0 0x2000>;
+			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 314>;
+			max-frequency = <200000000>;
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			resets = <&cpg 314>;
+			status = "disabled";
+		};
+
+		sdhi1: sd@ee120000 {
+			compatible = "renesas,sdhi-r8a774c0",
+				     "renesas,rcar-gen3-sdhi";
+			reg = <0 0xee120000 0 0x2000>;
+			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 313>;
+			max-frequency = <200000000>;
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			resets = <&cpg 313>;
+			status = "disabled";
+		};
+
+		sdhi3: sd@ee160000 {
+			compatible = "renesas,sdhi-r8a774c0",
+				     "renesas,rcar-gen3-sdhi";
+			reg = <0 0xee160000 0 0x2000>;
+			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 311>;
+			max-frequency = <200000000>;
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			resets = <&cpg 311>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@f1010000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
