Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F39C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:19:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89EB820833
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sa4f14WM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="b4krw9o8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89EB820833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=DDU4DOi8mDx4SGPQ02eQXMqqOP6R4Y/gZYAnuD6cMFQ=; b=Sa4f14WMHNM6XVc/LHrmoT0SbG
	sfH/iLO0GM7sfyte7g3EyBH/hLfAjUQd4Vr0huXRahMGJ5MgtRDL+3LOUTS4N0hw8CX8SDGaYol/o
	+e8pqUUBpi00zDfiZnDlPo0PkctpeV8KaDTyjFo9FgJMsI2a5O/jI3YyTTDZ6jA5M7LD92/xC8mkq
	dc+D5cLZ33WpTXGRhaDGcTLotzqCklyxxt5WLidzxdU/6NHffOq3IBkClo0FPny8s3e6NxEtWCykh
	jx4tUS2mXKfyHQwKgms/8wGOlkoFMjYK/CGDX14cq2Hqy3AuF73kpvUZwvJyLmTcEZeufNsw2NfO7
	sLkl0wTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gomxX-0001rU-Od; Wed, 30 Jan 2019 10:19:07 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gomxE-0001bt-2s
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 10:18:49 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id B1C6925B74E;
 Wed, 30 Jan 2019 21:18:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1548843525; bh=JR0Zhm4yhP8i17GqLHdQ51FRm+I7Xdgag3WrEBRuKLM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=b4krw9o8ooMkg8t/07+yto/dzn1/CJBpZoaUYYP9q3ZfTUyaAgcCxl0Zpk9OU5lgg
 /CoGM2ijBU9r1VEYJQDnX0wX9zxaheM/1PCMPFhyEIJXl5IPISRZDquVcA/Vz1XPjj
 OTIEhMxwxOfSr4YjJMI59LcUIyxNmEHUmjR1LEbo=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id E76F8940461; Wed, 30 Jan 2019 11:18:42 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/1] ARM: dts: r8a7743: Convert to new LVDS DT bindings
Date: Wed, 30 Jan 2019 11:18:40 +0100
Message-Id: <6a6a797625b5fe855bf60c798561896e311d58ce.1548843393.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1548843393.git.horms+renesas@verge.net.au>
References: <cover.1548843393.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_021848_272561_B0B165CA 
X-CRM114-Status: GOOD (  10.60  )
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

The internal LVDS encoder now has DT bindings separate from the DU. Port
the device tree over to the new model.

Fixes: c6a27fa41fab ("drm: rcar-du: Convert LVDS encoder code to bridge driver")
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7743.dtsi | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 3cc33f7ff7fe..3adc158a40bb 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -1681,15 +1681,12 @@
 
 		du: display@feb00000 {
 			compatible = "renesas,du-r8a7743";
-			reg = <0 0xfeb00000 0 0x40000>,
-			      <0 0xfeb90000 0 0x1c>;
-			reg-names = "du", "lvds.0";
+			reg = <0 0xfeb00000 0 0x40000>;
 			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 724>,
-				 <&cpg CPG_MOD 723>,
-				 <&cpg CPG_MOD 726>;
-			clock-names = "du.0", "du.1", "lvds.0";
+				 <&cpg CPG_MOD 723>;
+			clock-names = "du.0", "du.1";
 			status = "disabled";
 
 			ports {
@@ -1704,6 +1701,33 @@
 				port@1 {
 					reg = <1>;
 					du_out_lvds0: endpoint {
+						remote-endpoint = <&lvds0_in>;
+					};
+				};
+			};
+		};
+
+		lvds0: lvds@feb90000 {
+			compatible = "renesas,r8a7743-lvds";
+			reg = <0 0xfeb90000 0 0x1c>;
+			clocks = <&cpg CPG_MOD 726>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 726>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					lvds0_in: endpoint {
+						remote-endpoint = <&du_out_lvds0>;
+					};
+				};
+				port@1 {
+					reg = <1>;
+					lvds0_out: endpoint {
 					};
 				};
 			};
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
