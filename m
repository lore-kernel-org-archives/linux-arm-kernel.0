Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828F1C64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:46:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4835F20848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QREX3Dgi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4835F20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oqE1JDK+3sAeOCijFVaeuLglDlouM53Tr+ol5Q6gZpY=; b=QREX3Dgi2cnKdV
	6oC88j9wrVY2lVp30ykBSwoaa4co9bBawOUD6EZApdL38/ICjanwWFKyyyF+T3DlAXEtdjDBuydAm
	sa3oFT5QEFFnkTloeIcfFMXlw/uHRnMlm7WvhiKS6OvBlFH1oKLwo+ic1Hs15ffN+QbRAzUitvOrD
	7QQQk3oNY5jPAcH11Hx8EPrnXp9H6wMJmmQeyZrnS999Z7hRGzwRaULXwuwrdCeH7b23zs5eulKRm
	nM2b7vVRuwMIhtqs+5U+q8Q72ANykRGl8Ux2nyj+LgMwkz9mUw/VAJ6TJgomiP65QqkhNkUwcCopx
	R/xO4srjWodEGySKLumg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTfBS-0004hK-Gb; Mon, 03 Dec 2018 03:46:10 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTfBO-0004eL-Ux
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 03:46:08 +0000
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 5D0C9B90FF95A;
 Mon,  3 Dec 2018 11:45:42 +0800 (CST)
Received: from vm100-107-113-134.huawei.com (100.107.113.134) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Mon, 3 Dec 2018 11:45:36 +0800
From: Yu Chen <chenyu56@huawei.com>
To: <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 12/12] dts: hi3660: Add support for usb on Hikey960
Date: Mon, 3 Dec 2018 11:45:15 +0800
Message-ID: <20181203034515.91412-13-chenyu56@huawei.com>
X-Mailer: git-send-email 2.15.0-rc2
In-Reply-To: <20181203034515.91412-1-chenyu56@huawei.com>
References: <20181203034515.91412-1-chenyu56@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [100.107.113.134]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_194607_161057_046D8C96 
X-CRM114-Status: GOOD (  12.42  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, suzhuangluan@hisilicon.com,
 Binghui Wang <wangbinghui@hisilicon.com>, Yu Chen <chenyu56@huawei.com>,
 kongfei@hisilicon.com, Wei Xu <xuwei5@hisilicon.com>,
 Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds support for usb on Hikey960.

Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: John Stultz <john.stultz@linaro.org>
Cc: Binghui Wang <wangbinghui@hisilicon.com>
Signed-off-by: Yu Chen <chenyu56@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 56 ++++++++++++++++++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi         | 72 +++++++++++++++++++++++
 2 files changed, 128 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index c98bcbc8dfba..066c558154ea 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -13,6 +13,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/usb/pd.h>
 
 / {
 	model = "HiKey960";
@@ -196,6 +197,28 @@
 			method = "smc";
 		};
 	};
+
+	hisi_hikey_usb: hisi_hikey_usb {
+		compatible = "hisilicon,hikey960_usb";
+		typec-vbus-gpios = <&gpio25 2 0>;
+		typc-vbus-enable-val = <1>;
+		otg-switch-gpios = <&gpio25 6 0>;
+		hub-vdd33-en-gpios = <&gpio5 6 0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usbhub5734_pmx_func>;
+
+		port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hikey_usb_ep: endpoint@0 {
+				reg = <0>;
+				device_type = "usb-role-switch";
+				remote-endpoint = <&dwc3_role_switch_notify>;
+			};
+		};
+	};
+
 };
 
 /*
@@ -526,6 +549,39 @@
 &i2c1 {
 	status = "okay";
 
+	rt1711h: rt1711h@4e {
+		compatible = "richtek,rt1711h";
+		reg = <0x4e>;
+		status = "ok";
+		interrupt-parent = <&gpio27>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_cfg_func>;
+
+		usb_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			data-role = "dual";
+			power-role = "dual";
+			try-power-role = "sink";
+			source-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)
+				PDO_VAR(5000, 5000, 1000)>;
+			op-sink-microwatt = <10000000>;
+		};
+
+		port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			rt1711h_ep: endpoint@0 {
+				reg = <0>;
+				device_type = "usb-role-switch";
+				remote-endpoint = <&dwc3_role_switch>;
+			};
+		};
+	};
+
 	adv7533: adv7533@39 {
 		status = "ok";
 		compatible = "adi,adv7533";
diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index f432b0a88c65..e6583bd7efdb 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -349,6 +349,12 @@
 			#clock-cells = <1>;
 		};
 
+		pmctrl: pmctrl@fff31000 {
+			compatible = "hisilicon,hi3660-pmctrl", "syscon";
+			reg = <0x0 0xfff31000 0x0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		pmuctrl: crg_ctrl@fff34000 {
 			compatible = "hisilicon,hi3660-pmuctrl", "syscon";
 			reg = <0x0 0xfff34000 0x0 0x1000>;
@@ -1122,5 +1128,71 @@
 				};
 			};
 		};
+
+		usb3_otg_bc: usb3_otg_bc@ff200000 {
+			compatible = "syscon";
+			reg = <0x0 0xff200000 0x0 0x1000>;
+		};
+
+		usb_phy: usb-phy {
+			compatible = "hisilicon,hi3660-usb-phy";
+			#phy-cells = <0>;
+			hisilicon,pericrg-syscon = <&crg_ctrl>;
+			hisilicon,pctrl-syscon = <&pctrl>;
+			hisilicon,usb3-otg-bc-syscon = <&usb3_otg_bc>;
+			hisilicon,eye-diagram-param = <0x22466e4>;
+		};
+
+		usb3: hisi_dwc3 {
+			compatible = "hisilicon,hi3660-dwc3";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&crg_ctrl HI3660_CLK_ABB_USB>,
+				 <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
+			clock-names = "clk_usb3phy_ref", "aclk_usb3otg";
+
+			assigned-clocks = <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
+			assigned-clock-rates = <229000000>;
+			resets = <&crg_rst 0x90 8>,
+				 <&crg_rst 0x90 7>,
+				 <&crg_rst 0x90 6>,
+				 <&crg_rst 0x90 5>;
+
+			dwc3: dwc3@ff100000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0xff100000 0x0 0x100000>;
+				interrupts = <0 159 4>, <0 161 4>;
+				phys = <&usb_phy>;
+				phy-names = "usb3-phy";
+				dr_mode = "otg";
+				maximum-speed = "super-speed";
+				phy_type = "utmi";
+				snps,dis-del-phy-power-chg-quirk;
+				snps,lfps_filter_quirk;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_u3_susphy_quirk;
+				snps,tx_de_emphasis_quirk;
+				snps,tx_de_emphasis = <1>;
+				snps,dis_enblslpm_quirk;
+				snps,gctl-reset-quirk;
+
+				port {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					dwc3_role_switch: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&rt1711h_ep>;
+					};
+
+					dwc3_role_switch_notify: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&hikey_usb_ep>;
+					};
+				};
+			};
+		};
 	};
 };
-- 
2.15.0-rc2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
