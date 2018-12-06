Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBA0C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:11:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 468A02082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RrbbMKhe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="LDUO9ONg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 468A02082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=JD2xRDmtx2mEUL92z+MPH89D4UN4h9G4c2bBflO5ixk=; b=RrbbMKhepz/KDNm7DKR6288dQx
	b0mhIdvGuhD+zKAc23JqaxEKYGpxF+Zcn568NUHQDOnVXMdKNW/ov+VSMo8dfEl3xM9JM2X0txNai
	WMTHdkvKhMaSu+AYAI2wGN5rFm96FOM8F8/BEc72bsZQUUnYt6OfAaUwcCCqllUy3wscjVMEuniiw
	Km3lm3brYJjNLLmQ4RsLMNCxOQCUMLcteFNZo/R6QlRhUedoJF3x20qP95g0Ap0PZuIIevRfq486L
	/N5KViTdvtLlCbWuIptPb7LgWFkczXX0xKcGZPVg1SVl8Bkstg8Jj7VdBHN7BvZX82oSZLYZ+vUk7
	IhxNmTEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1s7-0006y3-8C; Thu, 06 Dec 2018 22:11:51 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1iB-00077Q-TO
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:01:54 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 1FC8525BEE9;
 Fri,  7 Dec 2018 08:58:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133514; bh=b72uM2mtyAQUax5gv3+DW+FAf3RreFyuGyZFdii+vmE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LDUO9ONg392bdX31PWnOoxFraoGJiMVSr5L9dNvpWmbCxRk4ndV8BSpjqhqyEggiW
 B6m/PUgO/Shhyw7UBR/O9a3Tlfzxg65HVJwCDsyhgxugpTxbVr8c/FBovINzrTFimG
 HtIn5eSMazv1xJoeN0j06TiwHpcGkZbgoNGr0oWw=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 43039E23297; Thu,  6 Dec 2018 13:58:31 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 12/34] ARM: dts: r8a7744: Add MMC node
Date: Thu,  6 Dec 2018 13:58:07 -0800
Message-Id: <d9e792206d2101de871ea99220b59fe2930ebbcc.1544125558.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1544125558.git.horms+renesas@verge.net.au>
References: <cover.1544125558.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_140136_520053_672863B3 
X-CRM114-Status: GOOD (  10.70  )
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

Add MMC node to the DT of the r8a7744 SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7744.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7744.dtsi b/arch/arm/boot/dts/r8a7744.dtsi
index 97b417c1b5f9..3f7674b2aac5 100644
--- a/arch/arm/boot/dts/r8a7744.dtsi
+++ b/arch/arm/boot/dts/r8a7744.dtsi
@@ -911,6 +911,22 @@
 			status = "disabled";
 		};
 
+		mmcif0: mmc@ee200000 {
+			compatible = "renesas,mmcif-r8a7744",
+				     "renesas,sh-mmcif";
+			reg = <0 0xee200000 0 0x80>;
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 315>;
+			dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
+			       <&dmac1 0xd1>, <&dmac1 0xd2>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7744_PD_ALWAYS_ON>;
+			resets = <&cpg 315>;
+			reg-io-width = <4>;
+			max-frequency = <97500000>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@f1001000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
