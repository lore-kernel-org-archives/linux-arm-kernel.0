Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866A3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:02:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51BBD2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DlO2EBZJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H/8m92RV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51BBD2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=4uPC9M2jVlPit3AZ85qmVssZAGIGOfiZjbjK31Dhub8=; b=DlO
	2EBZJyhY5iifLHoRkzfEAJwibEe8G8YKkE8q9xygtDqJX01dj1gvddHwJGdNJA0BkWtqnASr6D5tC
	uutihlU53oG9GXPsah1HmiJ/DyRGIb9UUs3liEhSEkgyIkkAkPr68AqAhpkCg4yj+eGtd1HNFWRxM
	EwcSnkRH7JbXmv2C2Z5Z57+Oupj+6uq4bfqq5/HUOMah3J0E/WNm9dSCO65ClDwcPdsxuuV6oPl9a
	cAZqPzzBvjmV5bv9STiCZQKaQNYjgMbuCwdOPrx7cNe1uma0XFByyC+zGUpTnVREcsjHcZHbHHscL
	Q3feqyZEmBx782GeMFFrSMwOT1Af+Lg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giz4P-0007FQ-AN; Mon, 14 Jan 2019 10:02:13 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giz2j-0005hH-Un
 for linux-arm-kernel@bombadil.infradead.org; Mon, 14 Jan 2019 10:00:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Message-Id:Date:Subject:Cc:To:From:
 Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TKDcZ5iSuXokTA4fnli/1W1idO50/UtuuI34BcUGaGE=; b=H/8m92RVm5Br8nQNxFHYPu57K
 O0eObUCwnf13HcSsQ6GMqpzYzgb8oAVHxCpdffIaV4aoyr+Sn4QN/+6P15X19V9GZuJDYfDyrn7Gs
 W8WKDnwcu6drEN1QmmFHA3HJhXb08g8jIsF290UiXcMAsdxy9zk+I684pSMzvMYVp/mPyhl1Biae/
 VmuyNIDcymE+QamkhRbtdZ5C2t1qMZ/5bAj5MHcwWcWky1AAy92Lr4R8B750pGD/ie4wgdqVzmfg3
 vTFdW7KUR8OGbHvVH0vefNx93qC9hwRtvdD87cMAGdme9TTeEIVPNYh/IkT7UfNZEHmnyAh40qBg4
 ro1VGBYDg==;
Received: from inva021.nxp.com ([92.121.34.21])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giz2f-0003sd-KS
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 10:00:27 +0000
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4F762200318;
 Mon, 14 Jan 2019 11:00:21 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 68C32200327;
 Mon, 14 Jan 2019 11:00:17 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 960F1402BE;
 Mon, 14 Jan 2019 18:00:12 +0800 (SGT)
From: Peng Ma <peng.ma@nxp.com>
To: shawnguo@kernel.org
Subject: [v2] arm64: dts: lx2160a: add sata node support
Date: Mon, 14 Jan 2019 09:55:00 +0000
Message-Id: <20190114095500.1600-1-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_050025_775006_E8B0160C 
X-CRM114-Status: UNSURE (   9.71  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Peng Ma <peng.ma@nxp.com>,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add sata node support and Enable sata support

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
changed for V2:
	- put the 'status' at the end of property list
	- add lx2160aqds sata support

 arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts |   16 +++++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |   16 +++++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    |   44 +++++++++++++++++++++
 3 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
index 99a22ab..0289955 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
@@ -110,3 +110,19 @@
 &usb1 {
 	status = "okay";
 };
+
+&sata0 {
+	status = "okay";
+};
+
+&sata1 {
+	status = "okay";
+};
+
+&sata2 {
+	status = "okay";
+};
+
+&sata3 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 6481e5f..aacca27 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -117,3 +117,19 @@
 &usb1 {
 	status = "okay";
 };
+
+&sata0 {
+	status = "okay";
+};
+
+&sata1 {
+	status = "okay";
+};
+
+&sata2 {
+	status = "okay";
+};
+
+&sata3 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index a79f5c1..4390aea 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -762,5 +762,49 @@
 				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
 			dma-coherent;
 		};
+
+		sata0: sata@3200000 {
+			compatible = "fsl,lx2160a-ahci";
+			reg = <0x0 0x3200000 0x0 0x10000>,
+			      <0x7 0x100520 0x0 0x4>;
+			reg-names = "ahci", "sata-ecc";
+			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 3>;
+			dma-coherent;
+			status = "disabled";
+		};
+
+		sata1: sata@3210000 {
+			compatible = "fsl,lx2160a-ahci";
+			reg = <0x0 0x3210000 0x0 0x10000>,
+			      <0x7 0x100520 0x0 0x4>;
+			reg-names = "ahci", "sata-ecc";
+			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 3>;
+			dma-coherent;
+			status = "disabled";
+		};
+
+		sata2: sata@3220000 {
+			compatible = "fsl,lx2160a-ahci";
+			reg = <0x0 0x3220000 0x0 0x10000>,
+			      <0x7 0x100520 0x0 0x4>;
+			reg-names = "ahci", "sata-ecc";
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 3>;
+			dma-coherent;
+			status = "disabled";
+		};
+
+		sata3: sata@3230000 {
+			compatible = "fsl,lx2160a-ahci";
+			reg = <0x0 0x3230000 0x0 0x10000>,
+			      <0x7 0x100520 0x0 0x4>;
+			reg-names = "ahci", "sata-ecc";
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 3>;
+			dma-coherent;
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
