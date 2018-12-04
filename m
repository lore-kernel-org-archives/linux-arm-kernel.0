Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC84C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:08:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E6722087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EiFhvOwG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6722087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jusst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IHxAVghBvexRLQmTd1i1ptNohZS1wsSmj+8NB1xuHk0=; b=EiFhvOwGx0h0Bw
	KThBUy65bHBQAYFw+/itLYd+L9EgFISfP8c5pWHzPu2D1NSHE7jTh1Gjk5XjCHUFyIzZ0IJd+j6BD
	juKgI1HCgOs7BfCBvKnXvVvwKcufxjvS2YQZ/mgXfAN5Mib3k1BeWwaDLzdecr0OuHstNJ1IYbp0z
	FKDwz/I9XKQPFtSbL2j9CIZYKn2w2slxJsZq+8tnIf8iNAPlL/todb4aSx7UZPg+YicAK2tmKTlXT
	qITnwDevmHwRidDz1mrk7KKdYvkAQmPNhOvxYN15K1TopCwdeIv7uSMt2lm295oVVkeF0ScI7UwIi
	MJtTyF3MrSox+lINbhEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU8Yk-0003op-4P; Tue, 04 Dec 2018 11:08:10 +0000
Received: from jusst.de ([188.40.114.84] helo=web01.jusst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU8YX-0003O7-Oa
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 11:07:59 +0000
Received: from hans-ole-workstation.ms.jusst.de (i577BBB33.versanet.de
 [87.123.187.51]) (Authenticated sender: hohatzel@jusst.de)
 by web01.jusst.de (Postfix) with ESMTPSA id EE33C1B01CF7;
 Tue,  4 Dec 2018 12:07:45 +0100 (CET)
From: Hans Ole Hatzel <hohatzel@jusst.de>
To: linux-arm-kernel@lists.infradead.org, ilya@compulab.co.il,
 devicetree@vger.kernel.org, linux-imx@nxp.com, fabio.estevam@nxp.com,
 shawnguo@kernel.org
Subject: [PATCH 3/4] ARM: dts: imx7d: sbc imx7: add uart2
Date: Tue,  4 Dec 2018 12:07:40 +0100
Message-Id: <20181204110741.6943-4-hohatzel@jusst.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204110741.6943-1-hohatzel@jusst.de>
References: <20181204110741.6943-1-hohatzel@jusst.de>
MIME-Version: 1.0
Authentication-Results: web01.jusst.de;
 auth=pass smtp.auth=hohatzel@jusst.de smtp.mailfrom=hohatzel@jusst.de
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_030757_980590_A1CE35A9 
X-CRM114-Status: GOOD (  10.20  )
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
Cc: Julian Scheel <jscheel@jusst.de>, Hans Ole Hatzel <hohatzel@jusst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Adds uart2 connections as used on the sbc. This uart is connected via
the soc's pins 3 (TX) and 5 (RX). On the sbc it is pinned out on P4
using pins 31 (RX) and 33 (TX).

Signed-off-by: Hans Ole Hatzel <hohatzel@jusst.de>
Signed-off-by: Julian Scheel <jscheel@jusst.de>
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 16 ++++++++++++++++
 arch/arm/boot/dts/imx7d-sbc-imx7.dts    |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index e77e0cc7de39..6c2c844dc052 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -214,6 +214,15 @@
 	status = "okay";
 };
 
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	assigned-clocks = <&clks IMX7D_UART2_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
+	status = "disabled";
+	fsl;
+};
+
 &usbotg1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usbotg1>;
@@ -314,6 +323,13 @@
 		>;
 	};
 
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX7D_PAD_LCD_ENABLE__UART2_DCE_TX		0x79
+			MX7D_PAD_LCD_CLK__UART2_DCE_RX		0x79
+		>;
+	};
+
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins = <
 			MX7D_PAD_SD2_CMD__SD2_CMD			0x59
diff --git a/arch/arm/boot/dts/imx7d-sbc-imx7.dts b/arch/arm/boot/dts/imx7d-sbc-imx7.dts
index f8a868552707..74904127fbc6 100644
--- a/arch/arm/boot/dts/imx7d-sbc-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-sbc-imx7.dts
@@ -26,6 +26,10 @@
 	status = "okay";
 };
 
+&uart2 {
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
