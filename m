Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325DDC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:08:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02B8B2082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aPPpqY73"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B8B2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jusst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BRG4cUUmXndm35jKd65QVnkY3WT4XylbMu+PYeKNV/Y=; b=aPPpqY73yr61RG
	9kw8XZRm39dH1GwtlY2VZWw13T/pdyEdC+TiIzSwqwIsILTJZ8fZQ1jcO5wCpsjMJUqMRlJfE4hfO
	crvqgzuKU85o11jd2VeiauVm2HROaSzum4sfp3nxvC07DECv3xe69inQxCBrR/kInTqgP1WPtzTzd
	+xynUpbPWrb5pQb47dkYNq6EG0fTARIgZuKRxtpTHhRuLyvbTWQU/fwXYQ68o3GoPqeuwh7cmiUtV
	UA01qU6phkasgZUOEMJ4B0S0CHtqTrtqLFkCi+ZqFpIsG5uaYRtfc3j3vRBU6+2J7zWpc7IiTMk++
	c2KjSe+Yib5v62mIXlPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU8Z0-0004AG-JJ; Tue, 04 Dec 2018 11:08:26 +0000
Received: from jusst.de ([188.40.114.84] helo=web01.jusst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU8YX-0003O6-Ob
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 11:08:00 +0000
Received: from hans-ole-workstation.ms.jusst.de (i577BBB33.versanet.de
 [87.123.187.51]) (Authenticated sender: hohatzel@jusst.de)
 by web01.jusst.de (Postfix) with ESMTPSA id AE5B71B01CD9;
 Tue,  4 Dec 2018 12:07:45 +0100 (CET)
From: Hans Ole Hatzel <hohatzel@jusst.de>
To: linux-arm-kernel@lists.infradead.org, ilya@compulab.co.il,
 devicetree@vger.kernel.org, linux-imx@nxp.com, fabio.estevam@nxp.com,
 shawnguo@kernel.org
Subject: [PATCH 2/4] ARM: dts: imx7d: cl-som-imx7: WiLink8 WLAN support
Date: Tue,  4 Dec 2018 12:07:39 +0100
Message-Id: <20181204110741.6943-3-hohatzel@jusst.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204110741.6943-1-hohatzel@jusst.de>
References: <20181204110741.6943-1-hohatzel@jusst.de>
MIME-Version: 1.0
Authentication-Results: web01.jusst.de;
 auth=pass smtp.auth=hohatzel@jusst.de smtp.mailfrom=hohatzel@jusst.de
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_030757_971045_CF90865D 
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
Cc: Julian Scheel <jscheel@jusst.de>, Hans Ole Hatzel <hohatzel@jusst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add support for WiLink8 module which is connected via USDHC 2.

Signed-off-by: Hans Ole Hatzel <hohatzel@jusst.de>
Signed-off-by: Julian Scheel <jscheel@jusst.de>
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 64 +++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index 11bd713b540f..e77e0cc7de39 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -30,6 +30,28 @@
 		gpio = <&gpio1 5 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	rf_pwr_en_reg: regulator-rf-pwr-en {
+		compatible = "regulator-fixed";
+		regulator-name = "rf-pwr-en-regulator";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pca9555 9 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <70000>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	wlan_en_reg: regulator-wlan-en {
+		compatible = "regulator-fixed";
+		regulator-name = "wlan-en-regulator";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pca9555 0 GPIO_ACTIVE_HIGH>;
+		/* WLAN card specific delay */
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
 };
 
 &cpu0 {
@@ -199,6 +221,28 @@
 	status = "okay";
 };
 
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	cd-gpios = <>;
+	wp-gpios = <>;
+	no-1-8-v;
+	keep-power-in-suspend;
+	enable-sdio-wakeup;
+	vmmc-supply = <&wlan_en_reg>;
+	non-removable;
+	cap-power-off-card;
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	wlcore: wlcore@0 {
+		compatible = "ti,wl1835";
+		reg = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <15 IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
+
 &usdhc3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc3>;
@@ -211,6 +255,15 @@
 };
 
 &iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO15__GPIO1_IO15			0x34 /* WLAN IRQ */
+		>;
+	};
+
 	pinctrl_enet1: enet1grp {
 		fsl,pins = <
 			MX7D_PAD_SD2_CD_B__ENET1_MDIO			0x30
@@ -261,6 +314,17 @@
 		>;
 	};
 
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX7D_PAD_SD2_CMD__SD2_CMD			0x59
+			MX7D_PAD_SD2_CLK__SD2_CLK			0x19
+			MX7D_PAD_SD2_DATA0__SD2_DATA0			0x59
+			MX7D_PAD_SD2_DATA1__SD2_DATA1			0x59
+			MX7D_PAD_SD2_DATA2__SD2_DATA2			0x59
+			MX7D_PAD_SD2_DATA3__SD2_DATA3			0x59
+		>;
+	};
+
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins = <
 			MX7D_PAD_SD3_CMD__SD3_CMD		0x59
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
