Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7097FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:23:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EE6D217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="InaHARiI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE6D217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mMyeMQii3VStIXYD8J7xIVzRYSnzCvsX87xOnwKNqN0=; b=InaHARiIzNie6X
	39QvpxtNEHtJ19XFNtZlfPRTK3kBn8QuSh8NlsGJHK81ZT9PHbQ2crJA7hIFEenhKnvqgtUMPB4K9
	2qZH55Uhy59am0fDdx+D3RYiU1NjzFVD99g2PgfubrqnLE9fsn4QApXhyhnMSd2Efq8EM9DcSSaLv
	UyEgi5kfIOwTqLaDClbLm7NG6SFsL8baAtjTUQ/+jIO+xo9yWHSkMgGHGuYHsqshFigRmFS2RYR+Z
	d9UYqTcg2wAUVgDO1OdjGOsxqI9SqEkeehLk9tFA3DG4Cq6nOA14cbSoywAi5h81JANkAjr3Z7oGC
	GlMFDRtod6yzNUKUr2XA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvh1X-00065s-Kd; Mon, 18 Feb 2019 11:23:47 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvh1T-000648-Rc
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 11:23:45 +0000
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id D0669AAE83E6631E8CEB;
 Mon, 18 Feb 2019 19:23:31 +0800 (CST)
Received: from vm100-107-113-134.huawei.com (100.107.113.134) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Mon, 18 Feb 2019 19:23:26 +0800
From: Yu Chen <chenyu56@huawei.com>
To: <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 10/10] dts: hi3660: Add support for usb on Hikey960
Date: Mon, 18 Feb 2019 19:23:10 +0800
Message-ID: <20190218112310.17860-11-chenyu56@huawei.com>
X-Mailer: git-send-email 2.15.0-rc2
In-Reply-To: <20190218112310.17860-1-chenyu56@huawei.com>
References: <20190218112310.17860-1-chenyu56@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [100.107.113.134]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_032344_064261_8FF29AC2 
X-CRM114-Status: GOOD (  13.15  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, yudongbin@hisilicon.com,
 Binghui Wang <wangbinghui@hisilicon.com>, xuyiping@hisilicon.com,
 xuyoujun4@huawei.com, suzhuangluan@hisilicon.com, songxiaowei@hisilicon.com,
 Yu Chen <chenyu56@huawei.com>, kongfei@hisilicon.com,
 Wei Xu <xuwei5@hisilicon.com>, fangshengzhou@hisilicon.com,
 lipengcheng8@huawei.com, Rob Herring <robh+dt@kernel.org>,
 john.stultz@linaro.org, wanghu17@hisilicon.com, zangleigang@hisilicon.com,
 chenyao11@huawei.com, liuyu712@hisilicon.com,
 linux-arm-kernel@lists.infradead.org, butao@hisilicon.com
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
v2:
* Remove device_type property.
* Add property "usb-role-switch".
---
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 54 +++++++++++++++++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi         | 73 +++++++++++++++++++++++
 2 files changed, 127 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index 46435466f1ab..2cada9d44046 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -13,6 +13,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/usb/pd.h>
 
 / {
 	model = "HiKey960";
@@ -196,6 +197,27 @@
 			method = "smc";
 		};
 	};
+
+	hisi_hikey_usb: hisi_hikey_usb {
+		compatible = "hisilicon,hikey960_usb";
+		typec-vbus-gpios = <&gpio25 2 0>;
+		typec-vbus-enable-val = <1>;
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
+				remote-endpoint = <&dwc3_role_switch_notify>;
+			};
+		};
+	};
+
 };
 
 /*
@@ -526,6 +548,38 @@
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
+				remote-endpoint = <&dwc3_role_switch>;
+			};
+		};
+	};
+
 	adv7533: adv7533@39 {
 		status = "ok";
 		compatible = "adi,adv7533";
diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 20ae40df61d5..a2808c53c538 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -355,6 +355,12 @@
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
@@ -1134,5 +1140,72 @@
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
+				usb-role-switch;
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
