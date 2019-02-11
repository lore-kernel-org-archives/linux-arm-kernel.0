Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD898C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:06:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 985E3217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MKlrx4T2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985E3217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MsuhlFcSeMFoYWiwrFFJChHrkxnpAqxkvN+lomTKT2I=; b=MKlrx4T2we2YzK
	I+9Lx61pEpMZVcjWD2GJalQYBiyGOGA/aTuXmCOHMhX1rZksFVvY08TyclYf/GiceKTMh9/HzFHV2
	qEz80zvt4fgEOlxvVdqT6yJRbprYR+hIwKGS+UQ8HRqEQKpH9VUTKvdjK72cbz5R0as5FxkPnXgG/
	9jsR4YKfxbg7q70hC5CIWcfBGwruNs3GAhOp54hlv4/NHN4jy1k1zYN1fioIi4EejkjnMrhBCjuK2
	0kVRufIE44RuYfkxmfXgpQaQWNELgtqz+/ZC+3X7gmDCnjE5pTG3Xjeda0y2EJ6dRePFKfBtp59qp
	eFefXbMXd/W5A1A6wVsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtDAa-0003m8-QM; Mon, 11 Feb 2019 15:06:52 +0000
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtD7P-0000dJ-8I
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 15:03:48 +0000
X-Originating-IP: 185.94.189.187
Received: from localhost (unknown [185.94.189.187])
 (Authenticated sender: maxime.ripard@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 41D431BF20A;
 Mon, 11 Feb 2019 15:03:29 +0000 (UTC)
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v3 7/7] ARM: dts: sun5i: Add the MBUS controller
Date: Mon, 11 Feb 2019 16:02:55 +0100
Message-Id: <edf5e68d0dbb25877d2867554a5a19de1bf01236.1549897336.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.f2e5fbb4d21384168973fa32377a33d627768146.1549897336.git-series.maxime.ripard@bootlin.com>
References: <cover.f2e5fbb4d21384168973fa32377a33d627768146.1549897336.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_070335_925412_4827E752 
X-CRM114-Status: GOOD (  12.06  )
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
Cc: devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org,
 Georgi Djakov <georgi.djakov@linaro.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Yong Deng <yong.deng@magewell.com>, Robin Murphy <robin.murphy@arm.com>,
 Dave Martin <dave.martin@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The MBUS (and its associated controller) is the bus in the Allwinner SoCs
that DMA devices use in the system to access the memory.

Among other things (and depending on the SoC generation), it can also
enforce priorities or report bandwidth usages on a per-master basis.

One of the most notable thing is that instead of having the same mapping
for the RAM than the CPU, it maps it at address 0, which means we'll have
to do address translation thanks to the dma-ranges property.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun5i.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 5497d985c54a..a29203b7661d 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -127,6 +127,7 @@
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
+		dma-ranges;
 		ranges;
 
 		system-control@1c00000 {
@@ -181,6 +182,14 @@
 			};
 		};
 
+		mbus: dram-controller@1c01000 {
+			compatible = "allwinner,sun5i-a13-mbus";
+			reg = <0x01c01000 0x1000>;
+			clocks = <&ccu CLK_MBUS>;
+			dma-ranges = <0x00000000 0x40000000 0x20000000>;
+			#interconnect-cells = <1>;
+		};
+
 		dma: dma-controller@1c02000 {
 			compatible = "allwinner,sun4i-a10-dma";
 			reg = <0x01c02000 0x1000>;
@@ -727,6 +736,8 @@
 			clock-names = "ahb", "mod",
 				      "ram";
 			resets = <&ccu RST_DE_FE>;
+			interconnects = <&mbus 19>;
+			interconnect-names = "dma";
 			status = "disabled";
 
 			ports {
@@ -755,6 +766,8 @@
 			clock-names = "ahb", "mod",
 				      "ram";
 			resets = <&ccu RST_DE_BE>;
+			interconnects = <&mbus 18>;
+			interconnect-names = "dma";
 			status = "disabled";
 
 			assigned-clocks = <&ccu CLK_DE_BE>;
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
