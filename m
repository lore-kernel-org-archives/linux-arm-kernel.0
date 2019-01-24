Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96850C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:27:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6746C218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ijU/3uXy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="WXRXKWf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6746C218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=QBb6QvAvl0w7yrWKqVjS2+SR3gTjS5Ed9cAZ6jajonM=; b=ijU/3uXydvqT3FBwYID7JuNtj4
	mznM6lS1wbol9KqK1QaVXOB3ox142R9XohxNfa+kg/YBhAt4TWgOT+pZL0wFRWGBjl2s+e5aw2uAp
	Zl+YJC8Edb2bRyf9oC0WdD0xVmZY+JkZm2b4g8IAW58J1Fc+GU8Uhl+cYbLnZJXV+P0WkdDJdri0L
	YYlxxcI7W1BrfPMqwGbvHoDKJvfiAGz+Pd3bCPDhLWElVi0BPyYXFkgkCshcN1gIEpFxItsdf7WGd
	cbntskf5M4n2YKWlLtoqLj6B4nuMRKfvQiHD4v/sCJn+rRu0oeAvWnkjMVxix4wTdON0LkjUnYKhm
	l2bn7tFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmguP-0000Lu-EN; Thu, 24 Jan 2019 15:27:13 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmgqL-0007Ii-AI
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 15:23:03 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id F202725BF17;
 Fri, 25 Jan 2019 02:12:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1548342769; bh=8Wd5h+RytnvQJtsGa1SIcironRsx61VKGcsR6oj7bG0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WXRXKWf/sYWvy5By5EhCcaBsIOOICUz9EISDsURqnifobns2XwHJWRL0ZlVDFDC/Q
 9rnKHUrWMHNNAvzQXaV7+YK2LvTLRQeX40wS7sssouFWn6q6mk5cA9zpLvsssxkg3+
 NJjRUEv3CrQXKFhR8MQA1lSpLIn/doSMdQxxo3Oc=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id E737F940D4F; Thu, 24 Jan 2019 16:12:40 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 31/44] arm64: dts: renesas: r8a77990: sort pciec0 node within
 soc node
Date: Thu, 24 Jan 2019 16:12:25 +0100
Message-Id: <003233351d4411caf993267f407b5c0a0ae76dd3.1548233325.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1548233325.git.horms+renesas@verge.net.au>
References: <cover.1548233325.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_072302_322113_8708CC65 
X-CRM114-Status: GOOD (  10.77  )
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
 Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Move the pciec0 node so that sub-nodes of the soc node are
sorted by bus address.

This change has no run-time affect.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a77990.dtsi | 54 +++++++++++++++----------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77990.dtsi b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
index b2f606e286ce..bdc7f7d39820 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
@@ -1526,6 +1526,33 @@
 			resets = <&cpg 408>;
 		};
 
+		pciec0: pcie@fe000000 {
+			compatible = "renesas,pcie-r8a77990",
+				     "renesas,pcie-rcar-gen3";
+			reg = <0 0xfe000000 0 0x80000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			bus-range = <0x00 0xff>;
+			device_type = "pci";
+			ranges = <0x01000000 0 0x00000000 0 0xfe100000 0 0x00100000
+				  0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000
+				  0x02000000 0 0x30000000 0 0x30000000 0 0x08000000
+				  0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
+			/* Map all possible DDR as inbound ranges */
+			dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000>;
+			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &gic GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 319>, <&pcie_bus_clk>;
+			clock-names = "pcie", "pcie_bus";
+			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
+			resets = <&cpg 319>;
+			status = "disabled";
+		};
+
 		vspb0: vsp@fe960000 {
 			compatible = "renesas,vsp2";
 			reg = <0 0xfe960000 0 0x8000>;
@@ -1724,33 +1751,6 @@
 			};
 		};
 
-		pciec0: pcie@fe000000 {
-			compatible = "renesas,pcie-r8a77990",
-				     "renesas,pcie-rcar-gen3";
-			reg = <0 0xfe000000 0 0x80000>;
-			#address-cells = <3>;
-			#size-cells = <2>;
-			bus-range = <0x00 0xff>;
-			device_type = "pci";
-			ranges = <0x01000000 0 0x00000000 0 0xfe100000 0 0x00100000
-				0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000
-				0x02000000 0 0x30000000 0 0x30000000 0 0x08000000
-				0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
-			/* Map all possible DDR as inbound ranges */
-			dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000>;
-			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
-				<GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
-				<GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
-			#interrupt-cells = <1>;
-			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &gic GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 319>, <&pcie_bus_clk>;
-			clock-names = "pcie", "pcie_bus";
-			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
-			resets = <&cpg 319>;
-			status = "disabled";
-		};
-
 		prr: chipid@fff00044 {
 			compatible = "renesas,prr";
 			reg = <0 0xfff00044 0 4>;
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
