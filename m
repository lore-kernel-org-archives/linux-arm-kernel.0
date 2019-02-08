Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01B2C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:24:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A87720863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SJn5JJyZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="GaV1qr7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A87720863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=L2RLlw10+2eYTjmEzVua3wGwljg1cswV2iME0+P3wus=; b=SJn5JJyZJmkDhXtmKhNPfUpJ/f
	N0b1TxIPOSFFMJLUVCNN87FCtCLgOkWgXXPcIjVGiqV9+08zSVKzwkOA4kEpSeJvwZdP4kFM0JY4V
	ese/hOsXuMMo9bb7GHpqstobOEICbxVnMh5tdQwqYlPdN2iLE+S48Vg0DuAuZgAVJ8mwDeE4yFP1a
	uL5dzHoj8YOUpsPDLwxDEE5tlQu1ESYLwu4Q3s2pYgtwl2C6ZEJmGDF2f3fOQyDGaZWO79qqhJ4sR
	5BY4VfcmBQMefSS6eDlSJRVdVtZiWm+JKCTRGGheN6LjlN8Q0GvjypNCrhwG5aIAQhF6b1ajuMi3Q
	d8/qoiqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs4Gc-00038I-Ql; Fri, 08 Feb 2019 11:24:22 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs4GA-0002SP-OB
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 11:24:19 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 8919C25BF18;
 Fri,  8 Feb 2019 22:14:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1549624459; bh=j7pP+VBqzyrrCvznaj39wn226oDz22U7SQqAl1N+kqQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GaV1qr7+6AfEG1VNDdUYDs4P2hmDA+wjV687cxvb+X6biyDYXCRlgwDqvy/PH89lO
 rcrzFl+0ok9GVneDbjrGVbYHGQbB8daQK0TSJnv8oXUA0IYd9EpYb1zBkR8jGTTtz3
 T93xafCvUd2zfNrAhr8SID9qg1kHbIq2L7hjAjQw=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 0F41C940A91; Fri,  8 Feb 2019 12:14:16 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 11/12] ARM: dts: r8a7744: Add DU support
Date: Fri,  8 Feb 2019 12:14:12 +0100
Message-Id: <5f152018d340d90c185ced8ef6230b7044ea5540.1549623128.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1549623128.git.horms+renesas@verge.net.au>
References: <cover.1549623128.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_032355_468883_7E532DE4 
X-CRM114-Status: GOOD (  10.52  )
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

Add du node to r8a7744 SoC DT. Boards that want to enable the DU
need to specify the output topology.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7744.dtsi | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7744.dtsi b/arch/arm/boot/dts/r8a7744.dtsi
index 8d25a0a0594a..83804aa042c6 100644
--- a/arch/arm/boot/dts/r8a7744.dtsi
+++ b/arch/arm/boot/dts/r8a7744.dtsi
@@ -1645,8 +1645,14 @@
 		};
 
 		du: display@feb00000 {
-			reg = <0 0xfeb00000 0 0x40000>,
-			      <0 0xfeb90000 0 0x1c>;
+			compatible = "renesas,du-r8a7744";
+			reg = <0 0xfeb00000 0 0x40000>;
+			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 724>,
+				 <&cpg CPG_MOD 723>;
+			clock-names = "du.0", "du.1";
+			status = "disabled";
 
 			ports {
 				#address-cells = <1>;
@@ -1663,7 +1669,6 @@
 					};
 				};
 			};
-			/* placeholder */
 		};
 
 		prr: chipid@ff000044 {
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
