Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29FAC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:08:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A438A2082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NWTQdTAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A438A2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jusst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WzbcMlaT3TPuASnkKUz6dL/KOrrjN4eTBlVDtHF+YNw=; b=NWTQdTAmQ2Jopi
	8VzyntGNuOOp+YWBcGC3GZ/+iSY3sq0XubbRHd+sztlBd6zVUiPoQKhoqrlo/XJ/3aItkzZo2LDFP
	bp8Cyo9tT37Ix3JjujQHdh2yEbq1iwINaTEzZKZFsTr9Prqz/OHjc3rksTsr0J84jZQMyrgbw+sZ7
	IlAd0D335u/s5XaVaQQyuEM9TtsU6HAhowNPrSDNltCEy9PJ5YU7qg461QqMHrdOZ0l6PaMXE4DAu
	IdDXQGR8Cv3PX2IWExxF4sUldKUBYWb9mqZzwZdZIqSD1JNUJwk12K6SdH/bcAkky2gSncsoZFl9Z
	4Os8ijESkdw4Adq6ImOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU8ZQ-0004dS-US; Tue, 04 Dec 2018 11:08:52 +0000
Received: from jusst.de ([188.40.114.84] helo=web01.jusst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU8YX-0003O8-Oc
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 11:08:01 +0000
Received: from hans-ole-workstation.ms.jusst.de (i577BBB33.versanet.de
 [87.123.187.51]) (Authenticated sender: hohatzel@jusst.de)
 by web01.jusst.de (Postfix) with ESMTPSA id 7B39E1B01CFD;
 Tue,  4 Dec 2018 12:07:46 +0100 (CET)
From: Hans Ole Hatzel <hohatzel@jusst.de>
To: linux-arm-kernel@lists.infradead.org, ilya@compulab.co.il,
 devicetree@vger.kernel.org, linux-imx@nxp.com, fabio.estevam@nxp.com,
 shawnguo@kernel.org
Subject: [PATCH 4/4] ARM: dts: imx7d: sbc imx7: add uart5
Date: Tue,  4 Dec 2018 12:07:41 +0100
Message-Id: <20181204110741.6943-5-hohatzel@jusst.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204110741.6943-1-hohatzel@jusst.de>
References: <20181204110741.6943-1-hohatzel@jusst.de>
MIME-Version: 1.0
Authentication-Results: web01.jusst.de;
 auth=pass smtp.auth=hohatzel@jusst.de smtp.mailfrom=hohatzel@jusst.de
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_030757_976741_1651106E 
X-CRM114-Status: GOOD (  10.21  )
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

Adds uart5 connections as used on the sbc.
In the sbc's reference material this is known as uart1, it does however
connect to the som as uart5. This uart is connected via the soc's
pins 11 (TX) and 13 (RX). On the sbc it is pinned out on P5
using pins 15 (TX) and 17 (RX).

Signed-off-by: Hans Ole Hatzel <hohatzel@jusst.de>
Signed-off-by: Julian Scheel <jscheel@jusst.de>
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 16 ++++++++++++++++
 arch/arm/boot/dts/imx7d-sbc-imx7.dts    |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index 6c2c844dc052..f7c002093c67 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -223,6 +223,15 @@
 	fsl;
 };
 
+&uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	assigned-clocks = <&clks IMX7D_UART5_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
+	status = "okay";
+	fsl;
+};
+
 &usbotg1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usbotg1>;
@@ -330,6 +339,13 @@
 		>;
 	};
 
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			MX7D_PAD_I2C4_SCL__UART5_DCE_RX		0x79
+			MX7D_PAD_I2C4_SDA__UART5_DCE_TX		0x79
+		>;
+	};
+
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins = <
 			MX7D_PAD_SD2_CMD__SD2_CMD			0x59
diff --git a/arch/arm/boot/dts/imx7d-sbc-imx7.dts b/arch/arm/boot/dts/imx7d-sbc-imx7.dts
index 74904127fbc6..d23d62aceb82 100644
--- a/arch/arm/boot/dts/imx7d-sbc-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-sbc-imx7.dts
@@ -30,6 +30,10 @@
 	status = "okay";
 };
 
+&uart5 {
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
