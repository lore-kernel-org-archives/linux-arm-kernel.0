Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85978C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:11:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 489212082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p2lxAsDM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="c2USu1ip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 489212082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=O6YkiM3dAORAMA0TABUHq+9ohQ0uyiMn1pd7xy0hvaw=; b=p2lxAsDM4bS3WGGGuINBzd/OIm
	nRVLs/K3XDsRMEYmR7XKYYxNDZuqU0mMYdcZLO1M/dbijek69yi0h4chq2iOgISM7onPILdTNSroz
	4DmagSBhsPvwfX0VSyTjOH54E3p5p4XKNT4xjLBMfG6GUgmx2NMJTBPF+wzDK6BMoRngkvpXjFHIf
	/+MUhHf+0v9nrJpNqIddfB3WC36zJLDPG2ReByWVPbe4rWg7dw3FrJ21yjubrxL7O5CoALyQwTXuj
	ElaBLrCp2uu1Dx7dMGaxIPq+lZdVXW1qb2I7jFjBpRArOkf5sdaE1Ge1rJuQlIBQlevKUQZ96ox4P
	KYQI371g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1rm-0006ej-LI; Thu, 06 Dec 2018 22:11:30 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1el-00077Q-7Z
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 21:58:27 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id E87FE25BEE3;
 Fri,  7 Dec 2018 08:57:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133457; bh=nJql4rwWb/0I6DxIokoquNpiNpJ74wUEmKXhRkc4Ptk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=c2USu1ipOIPRo0sLUVogOuug8WcM4tLeyeCZgcvXRO081DVQEnFM5alBQZCu8a98d
 N4NgBiJ0220wY5NOYiVcc7CTR3BwgXMBYud9zFo1YchjvND5ZrW4uUMfFT6Fcw+94V
 q3a+4ySJZew77Z1IkvSk2UwYyKPeIRN6X+xeORjs=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 73937E21709; Thu,  6 Dec 2018 13:57:33 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: renesas: r8a77965: Remove non-existent
 IPMMU-IR
Date: Thu,  6 Dec 2018 13:57:30 -0800
Message-Id: <d8c6557bc93be73ed1abe5b13fa1e46e59da028b.1544126426.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1544126426.git.horms+renesas@verge.net.au>
References: <cover.1544126426.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_135803_767996_FB165D3B 
X-CRM114-Status: UNSURE (   8.60  )
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
 Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The R-Car Gen3 HardWare Manual Errata for Rev. 1.00 (Aug 24, 2018)
removed the IPMMU-IR IOMMU instance on R-Car M3-N, as this SoC does not
have an Image Processing Unit (IMP-X5) nor the A3IR power domain.

Fixes: 55697cbb44e4f7ea ("arm64: dts: renesas: r8a779{65,80,90}: Add IPMMU devices nodes")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 1c86e6f4dc71..6dc9b1fef830 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -795,14 +795,6 @@
 			#iommu-cells = <1>;
 		};
 
-		ipmmu_ir: mmu@ff8b0000 {
-			compatible = "renesas,ipmmu-r8a77965";
-			reg = <0 0xff8b0000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 3>;
-			power-domains = <&sysc R8A77965_PD_A3IR>;
-			#iommu-cells = <1>;
-		};
-
 		ipmmu_mm: mmu@e67b0000 {
 			compatible = "renesas,ipmmu-r8a77965";
 			reg = <0 0xe67b0000 0 0x1000>;
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
