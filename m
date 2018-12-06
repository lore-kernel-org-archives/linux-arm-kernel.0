Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14044C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:09:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5E642082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YzUDoYBR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="Q4nZdUXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E642082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=JD//ml4CtgAnVVFtNJMrAf3I9X2FtgA1zJL9r3qku4k=; b=YzUDoYBRlmSa3CJF/xzJPu1PD0
	40GwyRxYmrp2D0kcYeQuq/wrJWSdtAQD1q5EPUR+QJ92r9ASZDqDOWTBdxarQGipctUkbjSshotZr
	snGrwyqfwSqaxpmTflDoJWcqdv6ft2JHUErQp97b81zcd2e6Dxy5tGzWt539L1CovLlVd70v+xyju
	jrtkIcSWZ+PAjkKElkACJ7DZwVDrdfzRLfkLayMTzEv2/d38BGcKufSTnm7wklUqy9AEgdEUGie0M
	0tUiLYoYIyff4X/9CLHMVsYpbIvhS6aDagpksT8hMUBXgiidNiMmjIXoN8nmB3z83oYv0uJkjvs/r
	GxpPp/2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1qD-0003xs-Mp; Thu, 06 Dec 2018 22:09:53 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1pe-00021y-18
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:09:51 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id AEFE125BF10;
 Fri,  7 Dec 2018 08:58:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133518; bh=3vXPaBkztbfuEo0NkyNok/TDChF9buksdQLqy7Ndxtk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Q4nZdUXEPp+5l2iePbI48xCgFdD8a/yKR/3oV+Bgj99+btzAElAmNfA0kWyvkdBJn
 O4gsmIa2rnFpNu9FswusiyWCmjIz2SWG/LiOdb9NVc+e57speXJdjCd+DEV1LkUTWB
 Zys1wlFUETMLxuJ0DB/YyOtcIPQ+FvvX3od/gqo8=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 98380E232B8; Thu,  6 Dec 2018 13:58:31 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 31/34] ARM: dts: r8a7744: Add xhci support
Date: Thu,  6 Dec 2018 13:58:26 -0800
Message-Id: <54234e80858cf3730917d71af80a13ac4b8f26dc.1544125558.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1544125558.git.horms+renesas@verge.net.au>
References: <cover.1544125558.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_140918_698869_E6FA0E95 
X-CRM114-Status: GOOD (  11.08  )
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
 Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org,
 Biju Das <biju.das@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Add a device node for the xhci controller on the Renesas
RZ/G1N (r8a7744) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7744.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7744.dtsi b/arch/arm/boot/dts/r8a7744.dtsi
index 992d622b5393..33e15c5f21c9 100644
--- a/arch/arm/boot/dts/r8a7744.dtsi
+++ b/arch/arm/boot/dts/r8a7744.dtsi
@@ -1424,6 +1424,26 @@
 			dma-channels = <13>;
 		};
 
+		/*
+		 * pci1 and xhci share the same phy, therefore only one of them
+		 * can be active at any one time. If both of them are enabled,
+		 * a race condition will determine who'll control the phy.
+		 * A firmware file is needed by the xhci driver in order for
+		 * USB 3.0 to work properly.
+		 */
+		xhci: usb@ee000000 {
+			compatible = "renesas,xhci-r8a7744",
+				     "renesas,rcar-gen2-xhci";
+			reg = <0 0xee000000 0 0xc00>;
+			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 328>;
+			power-domains = <&sysc R8A7744_PD_ALWAYS_ON>;
+			resets = <&cpg 328>;
+			phys = <&usb2 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
 		pci0: pci@ee090000 {
 			compatible = "renesas,pci-r8a7744",
 				     "renesas,pci-rcar-gen2";
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
