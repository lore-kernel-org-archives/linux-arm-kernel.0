Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73901C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:04:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A26F2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H5A2hkMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A26F2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k2RcQgx5KrWs/UUc5/2DWuZX0kGKEUNnFPM82Z8w6SM=; b=H5A2hkMKeTnPu8
	Kqo3Otr2nUxatlsHcPTyvJtuyn1tcojmCU3c+9881NLHrGcsgfIaJORZ1U3IEP62SlyDO49USQGgM
	g2Z4ehaHSB328K8hwzql3Ck7oeMqkYAmnDy2rS5ND3vmfWzMl9T6Xog5aPXdbTAqYSTJYQehLt1Uu
	jr3EukFzr7LZ6KgiMUaDy9GdFRasSNn7R2YDyB7rWB2/BTaMll2kLoa5/K+HCXz8+8TNOj/DsYZPo
	4mwGbs0WdOTk3gb5ylEphvIlw2o+xyNs98YX4M8sRB24RvQybOKg/6aCIUU3ZhpwETMHmEpKwh8PZ
	6otvonaRwDe3eB6gLgqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXa24-0008Vh-SW; Thu, 13 Dec 2018 23:04:40 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXa1s-0008MD-Et
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 23:04:29 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id 0F4228176;
 Thu, 13 Dec 2018 23:04:19 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Subject: [PATCH 3/3] ARM: dts: omap4-droid4: Configure wlcore wakeirq
Date: Thu, 13 Dec 2018 15:04:11 -0800
Message-Id: <20181213230411.5009-3-tony@atomide.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181213230411.5009-1-tony@atomide.com>
References: <20181213230411.5009-1-tony@atomide.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_150428_547479_44A634EC 
X-CRM114-Status: UNSURE (   9.27  )
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
Cc: devicetree@vger.kernel.org,
 =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

With wlcore supporting optional wakeirqs, we can configure it
for pandaboard. This makes ssh connection usable with the SoC
entering deeper idle states.

Let's configure a wakeirq both for the wlcore GPIO and the SDIO
dat1 pin in case wlcore starts supporting SDIO dat1 interrupt at
some point.

And let's also add the missing keep-power-in-suspend while at it.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -359,20 +359,24 @@
 
 &mmc3 {
 	vmmc-supply = <&wl12xx_vmmc>;
+	/* uart2_tx.sdmmc3_dat1 pad as wakeirq */
 	interrupts-extended = <&wakeupgen GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH
 			       &omap4_pmx_core 0xde>;
-
+	interrupt-names = "irq", "wakeup";
 	non-removable;
 	bus-width = <4>;
 	cap-power-off-card;
+	keep-power-in-suspend;
 
 	#address-cells = <1>;
 	#size-cells = <0>;
 	wlcore: wlcore@2 {
 		compatible = "ti,wl1285", "ti,wl1283";
 		reg = <2>;
-		interrupt-parent = <&gpio4>;
-		interrupts = <4 IRQ_TYPE_EDGE_RISING>; /* gpio100 */
+		/* gpio_100 with gpmc_wait2 pad as wakeirq */
+		interrupts-extended = <&gpio4 4 IRQ_TYPE_EDGE_RISING>,
+				      <&omap4_pmx_core 0x4e>;
+		interrupt-names = "irq", "wakeup";
 		ref-clock-frequency = <26000000>;
 		tcxo-clock-frequency = <26000000>;
 	};
-- 
2.19.2

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
