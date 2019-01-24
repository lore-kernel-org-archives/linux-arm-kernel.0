Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25078C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:23:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF3021855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CtzougJy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="pwt35HRA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF3021855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=zXln1krNyDB0ZoTReVIqKe1zWQ/w9f3SZl5iHF42DLU=; b=CtzougJytFmpQ3DNVEbthAYZBg
	UHx9xJwZlxYH5Uvq9m4wF/Zx6iA04qPlDzcsfRUQBxVBTxZ+CGuL5GrKTAtVU46YVYQDI6lJuNxnz
	zsHK3QZg+/GhX8V7GLdeo6Si2OzM570AnPKpCV0GqYqqMklMh3ua6JHIeahfmJaS9YC4bknTjRzqY
	ij0vhtuL15H/HAvr5pYST4p1IaCfiFUeUb1efqzT8WN2Xj1unmmSmW14gsZX4HvOtwDNDxzKt8exe
	fbEhsupsm+7XdbN8LPQ/KWGbewxp8u4D8k3HasxPPFIz/m1IvyhNKJF8F0fky1fKUuV1G7Dw3ecrh
	VMW9O3vA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmgr8-0004Iv-Eq; Thu, 24 Jan 2019 15:23:50 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmgkl-0001GQ-7p
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 15:17:30 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 8E48625BF00;
 Fri, 25 Jan 2019 02:12:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1548342764; bh=qX9IulV3oia5ZE7Z04lEVFjAVdpZHrt/pOcAH5dkHr8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pwt35HRA/b5F/xG123U7qVFCy/7Z48n5IGa6Mhrf7vHd5d5i31pEmroWVpVvMMBEn
 jxnqTSS0nVAYhNGKrlJHeijXd4fHsGKQEQaaP0qE1Pcq+hD4NSKJ+BXukAKtiahcui
 0wIIkp7yCvRps8deNAVp7jGgOn+mmzpomRrdlX1A=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 0DF9C940D52; Thu, 24 Jan 2019 16:12:41 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 33/44] arm64: dts: renesas: r8a7796: salvator-xs: Convert to
 new LVDS DT bindings
Date: Thu, 24 Jan 2019 16:12:27 +0100
Message-Id: <2e0e5b1685b708297b8ace867eacb0d692a2b7cf.1548233325.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1548233325.git.horms+renesas@verge.net.au>
References: <cover.1548233325.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_071715_923022_4ABF91F0 
X-CRM114-Status: GOOD (  11.78  )
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
 Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

As of commit 6d2ca85279becdff ("dt-bindings: display: renesas: Deprecate
LVDS support in the DU bindings"), the internal LVDS encoder has DT
bindings separate from the DU.  The device trees for all R-Car H3 and
M3-W development boards were ported over to the new model, but
Salvator-XS boards equipped with an R-Car M3-W SoC were forgotten.

Fixes: 58e8ed2ee9abe718 ("arm64: dts: renesas: Convert to new LVDS DT bindings")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dts
index 8860be65342e..31f12059355e 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dts
@@ -29,11 +29,10 @@
 	clocks = <&cpg CPG_MOD 724>,
 		 <&cpg CPG_MOD 723>,
 		 <&cpg CPG_MOD 722>,
-		 <&cpg CPG_MOD 727>,
 		 <&versaclock6 1>,
 		 <&x21_clk>,
 		 <&versaclock6 2>;
-	clock-names = "du.0", "du.1", "du.2", "lvds.0",
+	clock-names = "du.0", "du.1", "du.2",
 		      "dclkin.0", "dclkin.1", "dclkin.2";
 };
 
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
