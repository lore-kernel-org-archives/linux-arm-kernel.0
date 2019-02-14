Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B4DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:48:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3816D2229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UP3adqkq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3816D2229F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rU5j5x89StGrC/RnoMMfWAj8aaxOsjd2q2lNxxptl/c=; b=UP3adqkqpRMqMV
	FrxgWecEQKXSbROoOe+I+CvSrJCOF1oVxdG+uB7RxaBmEs5pkNqDgew0JAHom/6q4GS3oFWHI4uQe
	dhE/EK6xsif44MPne5NCdteRjaNu2MRV02gilWzIpc0ee+FOm49CrmDkKQRUGWsSzHSkiY99Dgasz
	qukB0iZvTAYJIREjaZMp2bcvJO/mbhqtb8mfRrxU4ErBaASxD9URdh34IuvHGH/obQxTfmSAl+2sA
	zyp8+89uISiaETikAFxaMkcWMMR4HuhKEPNCLZY2mj5Sjxh+Al47FZtkO4hxD6wonokQXyv/cunAt
	85Uv9juXCjhW68BWLQcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guAp0-00037v-PW; Thu, 14 Feb 2019 06:48:34 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guAnT-0001Qr-CJ
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 06:47:04 +0000
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1E6a35J013987; Thu, 14 Feb 2019 07:46:52 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qn0jwrqbe-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Thu, 14 Feb 2019 07:46:52 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E646C38;
 Thu, 14 Feb 2019 06:46:51 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A75D62431;
 Thu, 14 Feb 2019 06:46:51 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 14 Feb
 2019 07:46:51 +0100
Received: from localhost (10.201.23.166) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 14 Feb 2019 07:46:51
 +0100
From: Christophe Roullier <christophe.roullier@st.com>
To: <robh@kernel.org>, <davem@davemloft.net>, <joabreu@synopsys.com>,
 <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
 <alexandre.torgue@st.com>, <peppe.cavallaro@st.com>
Subject: [PATCH 7/8] ARM: dts: stm32: Add Ethernet support on stm32h7 SOC and
 activate it for eval and disco boards
Date: Thu, 14 Feb 2019 07:46:02 +0100
Message-ID: <1550126763-22669-8-git-send-email-christophe.roullier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550126763-22669-1-git-send-email-christophe.roullier@st.com>
References: <1550126763-22669-1-git-send-email-christophe.roullier@st.com>
MIME-Version: 1.0
X-Originating-IP: [10.201.23.166]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-14_04:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_224659_708515_AFB9EACE 
X-CRM114-Status: GOOD (  11.23  )
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
Cc: devicetree@vger.kernel.org, andrew@lunn.ch, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 christophe.roullier@st.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Synopsys GMAC 4.10 is used. And Phy mode for eval and disco is RMII
with PHY SMSC LAN8742

Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
---
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi | 15 +++++++++++++++
 arch/arm/boot/dts/stm32h743.dtsi         | 19 +++++++++++++++++++
 arch/arm/boot/dts/stm32h743i-disco.dts   | 17 +++++++++++++++++
 arch/arm/boot/dts/stm32h743i-eval.dts    | 17 +++++++++++++++++
 4 files changed, 68 insertions(+)

diff --git a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi b/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
index 24be8e6..980b276 100644
--- a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
@@ -173,6 +173,21 @@
 				};
 			};
 
+			ethernet_rmii: rmii@0 {
+				pins {
+					pinmux = <STM32_PINMUX('G', 11, AF11)>,
+						 <STM32_PINMUX('G', 13, AF11)>,
+						 <STM32_PINMUX('G', 12, AF11)>,
+						 <STM32_PINMUX('C', 4, AF11)>,
+						 <STM32_PINMUX('C', 5, AF11)>,
+						 <STM32_PINMUX('A', 7, AF11)>,
+						 <STM32_PINMUX('C', 1, AF11)>,
+						 <STM32_PINMUX('A', 2, AF11)>,
+						 <STM32_PINMUX('A', 1, AF11)>;
+					slew-rate = <2>;
+				};
+			};
+
 			usart1_pins: usart1@0 {
 				pins1 {
 					pinmux = <STM32_PINMUX('B', 14, AF4)>; /* USART1_TX */
diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index cbdd69c..f6384af 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -511,6 +511,25 @@
 				status = "disabled";
 			};
 		};
+
+		syscfg: system-config@58000400 {
+			compatible = "syscon";
+			reg = <0x58000400 0x400>;
+		};
+
+		mac: ethernet@40028000 {
+			compatible = "st,stm32-dwmac", "snps,dwmac-4.10a";
+			reg = <0x40028000 0x8000>;
+			reg-names = "stmmaceth";
+			interrupts = <61>;
+			interrupt-names = "macirq";
+			clock-names = "stmmaceth", "mac-clk-tx", "mac-clk-rx",
+			"syscfg-clk";
+			clocks = <&rcc ETH1MAC_CK>, <&rcc ETH1TX_CK>, <&rcc ETH1RX_CK>, <&rcc SYSCFG_CK>;
+			st,syscon = <&syscfg 0x4>;
+			snps,pbl = <8>;
+			status = "disabled";
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/stm32h743i-disco.dts b/arch/arm/boot/dts/stm32h743i-disco.dts
index 45e088c..0f738d0 100644
--- a/arch/arm/boot/dts/stm32h743i-disco.dts
+++ b/arch/arm/boot/dts/stm32h743i-disco.dts
@@ -66,6 +66,23 @@
 	clock-frequency = <25000000>;
 };
 
+&mac {
+	status = "okay";
+	pinctrl-0	= <&ethernet_rmii>;
+	pinctrl-names	= "default";
+	phy-mode	= "rmii";
+	phy-handle	= <&phy1>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+		phy1: ethernet-phy@1 {
+			reg = <0>;
+		};
+	};
+};
+
 &usart2 {
 	pinctrl-0 = <&usart2_pins>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/stm32h743i-eval.dts b/arch/arm/boot/dts/stm32h743i-eval.dts
index 3f8e0c4..44997ba 100644
--- a/arch/arm/boot/dts/stm32h743i-eval.dts
+++ b/arch/arm/boot/dts/stm32h743i-eval.dts
@@ -104,6 +104,23 @@
 	status = "okay";
 };
 
+&mac {
+	status = "okay";
+	pinctrl-0	= <&ethernet_rmii>;
+	pinctrl-names	= "default";
+	phy-mode	= "rmii";
+	phy-handle	= <&phy1>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+		phy1: ethernet-phy@1 {
+			reg = <0>;
+		};
+	};
+};
+
 &usart1 {
 	pinctrl-0 = <&usart1_pins>;
 	pinctrl-names = "default";
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
