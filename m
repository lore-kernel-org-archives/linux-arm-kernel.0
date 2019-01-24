Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B381C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:23:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F37F8218AE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iFcQ51vx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="YWsvXIcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37F8218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=C/JxUqm9m35Q40zZdZv78+LgvgPLL3VetkNW06nR+cI=; b=iFcQ51vx7hw23KgRbxDrBoQJDj
	cJzXRupgX+0ZOaqCgYOshcHzAjg2XD9RhPyjGmHsftZ5ZGz3GGeF2g9Zimvl7RRtSKtnl2pDr7Scg
	cdcbwir53yNwgYmDALpf4QgnCZRTL5/fMhEN/normXIcPPSCoTlsKYtS98ST16uc6UM+H4K/3N0/T
	jaoxdQW0f+sLeaK9M4KN0d/RA+J212sLvm8fqEFraYaVV7CxjLjRpCWODfzxmDMUFD0KmXx+JF92H
	dcZkgBeW9uwVs6JxrEeuhBaGgSkbSQEBe72I7vHD2IulBbnCwtUbQ1xG6t+IH2+AIW0RcNMfOhBVg
	xAMkFQKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmgqi-0003tu-Ow; Thu, 24 Jan 2019 15:23:24 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmgoc-0007Ii-RW
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 15:21:50 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 410FF25BF08;
 Fri, 25 Jan 2019 02:12:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1548342765; bh=solIyGLyFPknOe7kTOoC+Fgc2mjmWGxEw4OnuZarm8o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YWsvXIcgsngEoWC5Xn6ZnZ4vY4EMqezkUx3l87SiDfEW3p6CqZD5ZYFURcr/NQyTE
 +DYMU5VKnFJFo0qZFZ/Di+PiMKrsQiqCcoHUrrqty0PYdkil+J2EzNEbH1qzH+h753
 osjygeAxmXAU3SHz5S9RxGFGTcfDugUxPLntTRBY=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 72F44940CBE; Thu, 24 Jan 2019 16:12:40 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 22/44] arm64: dts: renesas: r8a774c0: Add USB2.0 phy and host
 device nodes
Date: Thu, 24 Jan 2019 16:12:16 +0100
Message-Id: <89893580cf561fd67a3f70ee812e02eac9966096.1548233325.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1548233325.git.horms+renesas@verge.net.au>
References: <cover.1548233325.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_072116_041395_3C4B3238 
X-CRM114-Status: GOOD (  10.00  )
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

Add USB2.0 phy and host (EHCI/OHCI) device tree nodes to the RZ/G2E
SoC dtsi.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 37 +++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index f3c4910e6585..0ab3aa66354c 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -1228,6 +1228,43 @@
 			dma-channels = <16>;
 		};
 
+		ohci0: usb@ee080000 {
+			compatible = "generic-ohci";
+			reg = <0 0xee080000 0 0x100>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
+			phys = <&usb2_phy0>;
+			phy-names = "usb";
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			resets = <&cpg 703>, <&cpg 704>;
+			status = "disabled";
+		};
+
+		ehci0: usb@ee080100 {
+			compatible = "generic-ehci";
+			reg = <0 0xee080100 0 0x100>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
+			phys = <&usb2_phy0>;
+			phy-names = "usb";
+			companion = <&ohci0>;
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			resets = <&cpg 703>, <&cpg 704>;
+			status = "disabled";
+		};
+
+		usb2_phy0: usb-phy@ee080200 {
+			compatible = "renesas,usb2-phy-r8a774c0",
+				     "renesas,rcar-gen3-usb2-phy";
+			reg = <0 0xee080200 0 0x700>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			resets = <&cpg 703>, <&cpg 704>;
+			#phy-cells = <0>;
+			status = "disabled";
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
