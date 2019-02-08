Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968F9C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:20:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6701A20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lLYog6BP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="NI8UQtq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6701A20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=2QoT3p1AyNMkbWUgyd4pJT/QKkCjPOmJWo+N7gwGfFc=; b=lLYog6BPj0GNaqaPBPr92jGUSU
	Kg2B5963lTwUsgsWhTxM6YSsWlGVU6Rvdie/KwI18OqxDaQpui2CNNDCbZ/U9jSAPLqK8RG8RAcDO
	QTWrqJDe/TVe71S6ys4k6AGkTRdOozb0OON96XZd+pVNZYiIkE5uT0YJEIJFVTIIFoofZ7c9HtEVD
	kj7stY8SPYeYPzu8ot6CPfOA3LXkW8rnojNHxun8Wq1BQtBgdmHT7Ts/3ombQas4z8UcZEWNTvq2n
	B30jr+tDLM3IdxQasuz3aHXWWOAOe9pxKmKC8Jp4Q90V651YvyLJq5BoHc2H1DHOZ6XeIRJp58BU2
	3PkGnJAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs4D4-0008C6-Sw; Fri, 08 Feb 2019 11:20:42 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs4CM-0005IB-42
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 11:20:33 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 0DEFE25BEF0;
 Fri,  8 Feb 2019 22:14:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1549624457; bh=XBgYxl9ekAggW8AFJqjyLiKAmMpMA0hfZtpsw2aEPls=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NI8UQtq+C+q4fuHBKXMzDlW3j11wD86iHlTO/GMfNW19/N4RtS1OhuMoIUzwSNZek
 wGh7vZhdaXPJRoeU1+zlTqpNiE6cYrwbsO6Wq/8CsDihD27JY/OtSmmSFE6l/MFGQp
 amtofEELqEQsMkD1qOC3Nml4dgiLFx2CydWKxfc4=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 5B9FB9402EE; Fri,  8 Feb 2019 12:14:15 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 01/12] ARM: dts: stout: Convert to new LVDS DT bindings
Date: Fri,  8 Feb 2019 12:14:02 +0100
Message-Id: <7aa69a47ecedb5368d862d0d8a2d6537b48e5501.1549623128.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1549623128.git.horms+renesas@verge.net.au>
References: <cover.1549623128.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_031958_774480_753D7294 
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

As of commit 6d2ca85279becdff ("dt-bindings: display: renesas: Deprecate
LVDS support in the DU bindings"), the internal LVDS encoder has DT
bindings separate from the DU.  The Lager device tree was ported over to
the new model, but the Stout device tree was forgotten.

Fixes: 15a1ff30d8f9bd83 ("ARM: dts: r8a7790: Convert to new LVDS DT bindings")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Marek Vasut <marek.vasut@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-stout.dts | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-stout.dts b/arch/arm/boot/dts/r8a7790-stout.dts
index 629da4cee1b9..7a7d3b84d1a6 100644
--- a/arch/arm/boot/dts/r8a7790-stout.dts
+++ b/arch/arm/boot/dts/r8a7790-stout.dts
@@ -94,9 +94,8 @@
 	status = "okay";
 
 	clocks = <&cpg CPG_MOD 724>, <&cpg CPG_MOD 723>, <&cpg CPG_MOD 722>,
-		 <&cpg CPG_MOD 726>, <&cpg CPG_MOD 725>,
 		 <&osc1_clk>;
-	clock-names = "du.0", "du.1", "du.2", "lvds.0", "lvds.1", "dclkin.0";
+	clock-names = "du.0", "du.1", "du.2", "dclkin.0";
 
 	ports {
 		port@0 {
@@ -104,11 +103,21 @@
 				remote-endpoint = <&adv7511_in>;
 			};
 		};
+	};
+};
+
+&lvds0 {
+	ports {
 		port@1 {
 			lvds_connector0: endpoint {
 			};
 		};
-		port@2 {
+	};
+};
+
+&lvds1 {
+	ports {
+		port@1 {
 			lvds_connector1: endpoint {
 			};
 		};
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
