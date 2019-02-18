Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46238C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:48:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1645F2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tk+XWPFR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="cgl0n33c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1645F2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=M+sU9Ar89iJuNDEsmup++ECOFLUqFN6kpMWwyihwX7I=; b=tk+XWPFRrCnajfcPta1r1EdO08
	0pbeDf3r7uEuWlath6FJXAIuBxjnxiQj5PZsrj27F3xdBaLqQ3jreuB0RU1y9wx5p0rVii4pnO5fe
	zynimPkYo5c/268hjWFz63LBq8qMF+uOKY/16ycmS9ooATtHtrGnedKF/+6QN2AdTCZXtmnNX0Kvw
	TREtkVahPDxEFDB/AEspSekICZ1ohP8LX6LrDsXi1USzQKC2M8QFe1P2S4ZbQydPg0QqTJmdNXj5I
	KoIwCmumiZEMSbHE03Ar/AuXd5XiHZRyPM61f6y4osWDg7Z8eMShnlHscDUddCqXnZN7gwhmLtRX6
	wsDBBkrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvgTN-0007UB-G6; Mon, 18 Feb 2019 10:48:29 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvgTK-0007Tb-Dt
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 10:48:28 +0000
Received: from penelope.horms.nl (unknown [62.119.166.9])
 by kirsty.vergenet.net (Postfix) with ESMTPA id F100025BE5E;
 Mon, 18 Feb 2019 21:48:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1550486901; bh=32uaDT+PiOq+2YKnV/pfLTweW+XBn0+t82ttKLcKpWQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cgl0n33ci4ua7NrjKg1l0VXINkVOxQl49vpZxeRLlvQJ5HKDRmuAcbaGsM/vRtFks
 FVEgoAxHGhVTZbMKmmx+Jar0+34Um6u91ouD6Z4WMRgaIJljqTezNsP4mU3yPuqZB3
 nkFsw/yLzRG1yZG70zcz8d8DtTeCPv0qM2UJXEPM=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id C8838E218D5; Mon, 18 Feb 2019 11:48:07 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 4/4] dt-bindings: arm: renesas: Fix SoC mismatch for Stout
Date: Mon, 18 Feb 2019 11:48:06 +0100
Message-Id: <c051dc5e3cea482ceb019028ddde67b7cb921e85.1549624030.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1549624030.git.horms+renesas@verge.net.au>
References: <cover.1549624030.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_024826_687138_EB874B1A 
X-CRM114-Status: GOOD (  10.62  )
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

make dtbs_check:

    arch/arm/boot/dts/r8a7790-stout.dt.yaml: compatible: ['renesas,stout', 'renesas,r8a7790'] is not valid under any of the given schemas

The Stout development board has an R-Car H2 (r8a7790) SoC, not an R-Car
H1 (r8a7779).

Fixes: 12749350567c819d ("dt-bindings: arm: Convert Renesas board/soc bindings to json-schema")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/renesas.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/arm/renesas.yaml
index cb9b4417e8a1..19f379863d50 100644
--- a/Documentation/devicetree/bindings/arm/renesas.yaml
+++ b/Documentation/devicetree/bindings/arm/renesas.yaml
@@ -130,13 +130,13 @@ properties:
         items:
           - enum:
               - renesas,marzen # Marzen (R0P7779A00010S)
-              - renesas,stout # Stout (ADAS Starterkit, Y-R-CAR-ADAS-SKH2-BOARD)
           - const: renesas,r8a7779
 
       - description: R-Car H2 (R8A77900)
         items:
           - enum:
               - renesas,lager # Lager (RTP0RC7790SEB00010S)
+              - renesas,stout # Stout (ADAS Starterkit, Y-R-CAR-ADAS-SKH2-BOARD)
           - const: renesas,r8a7790
 
       - description: R-Car M2-W (R8A77910)
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
