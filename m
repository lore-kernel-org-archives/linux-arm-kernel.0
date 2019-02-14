Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144EDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:20:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D88FA21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="munWIH4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88FA21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l3kZGEgwqt2rKmxmX49znPdJ7Ljc4toYeBc8aP55yuw=; b=munWIH4fpfxqIm
	yuIPx9fFZXv27fCuISbuToXEqVq+hyEKKRKiNbtmIvYpZhC1+ytVyShL3/2/t3JnpWIFHpO624rIq
	kGoqFWUMCARDhA5parJfl5m6QQSGQhscZeowKQmMS6ts6Fch4FursIEGhMH91X8xcWnEfouV+5fLB
	ISr+IjMOGatpSXjMbLIpKb3EoIkmaskPOQ9I6GZbgxi5UO0/z6i0FPQHsRn9TzC5DOv+dobuWUz3z
	jJOXTLKaWT6QhkYehyNhShGJiAjPQJCUQBn9YTzP15aqi0d77ZOzsTH0kuOXcBMluO0nMp/FEg5Bv
	ShaAvVdmlqGZDBVpmc0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guQJ3-000177-Ve; Thu, 14 Feb 2019 23:20:37 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guQIY-0007nR-Tz; Thu, 14 Feb 2019 23:20:08 +0000
X-UUID: e4acc68d67e046b08266c36a7a49459e-20190214
X-UUID: e4acc68d67e046b08266c36a7a49459e-20190214
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <sean.wang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 2146563295; Thu, 14 Feb 2019 15:19:57 -0800
Received: from MTKMBS01N2.mediatek.inc (172.21.101.79) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 14 Feb 2019 15:19:57 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 15 Feb 2019 07:19:42 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Fri, 15 Feb 2019 07:19:42 +0800
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <marcel@holtmann.org>,
 <johan.hedberg@gmail.com>
Subject: [PATCH 1/6] dt-bindings: net: bluetooth: add support for MediaTek
 MT7663U and MT7668U UART devices
Date: Fri, 15 Feb 2019 07:19:33 +0800
Message-ID: <c31b9ed0f2c711f53ad88c96f2d0a1bd22d9de58.1550184473.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1550184473.git.sean.wang@mediatek.com>
References: <cover.1550184473.git.sean.wang@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: D779B2618311713CB527479DA034E29B1828AC39E163F6697A3287C8909486902000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_152007_036319_E4CF8AB9 
X-CRM114-Status: UNSURE (   9.95  )
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
Cc: devicetree@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Update binding document with adding support of MT7663U and MT7668U UART
devices to mediatek-bluetooth.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../bindings/net/mediatek-bluetooth.txt       | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt b/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
index 14ceb2a5b4e8..41a7dcc80f5b 100644
--- a/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
@@ -33,3 +33,67 @@ Example:
 			clock-names = "ref";
 		};
 	};
+
+MediaTek UART based Bluetooth Devices
+==================================
+
+This device is a serial attached device to UART device and thus it must be a
+child node of the serial node with UART.
+
+Please refer to the following documents for generic properties:
+
+	Documentation/devicetree/bindings/serial/slave-device.txt
+
+Required properties:
+
+- compatible:	Must be
+		  "mediatek,mt7663u-bluetooth": for MT7663U device
+		  "mediatek,mt7668u-bluetooth": for MT7668U device
+- vcc-supply:	Main voltage regulator
+- pinctrl-names: Should be "default", "runtime"
+- pinctrl-0: Should contain UART RXD low when the device is powered up to
+	     enter proper bootstrap mode.
+- pinctrl-1: Should contain UART mode pin ctrl
+
+Optional properties:
+
+- reset-gpios:	GPIO used to reset the device whose initial state keeps low,
+		if the GPIO is missing, then board-level design should be
+		guaranteed.
+- current-speed:  Current baud rate of the device whose defaults to 921600
+
+Example:
+
+	uart1_pins_boot: uart1-default {
+		pins-dat {
+			pinmux = <MT7623_PIN_81_URXD1_FUNC_GPIO81>;
+			output-low;
+		};
+	};
+
+	uart1_pins_runtime: uart1-runtime {
+		pins-dat {
+			pinmux = <MT7623_PIN_81_URXD1_FUNC_URXD1>,
+				 <MT7623_PIN_82_UTXD1_FUNC_UTXD1>;
+		};
+	};
+
+	uart1: serial@11003000 {
+		compatible = "mediatek,mt7623-uart",
+			     "mediatek,mt6577-uart";
+		reg = <0 0x11003000 0 0x400>;
+		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_UART1_SEL>,
+			 <&pericfg CLK_PERI_UART1>;
+		clock-names = "baud", "bus";
+
+		bluetooth {
+			compatible = "mediatek,mt7663u-bluetooth";
+			vcc-supply = <&reg_5v>;
+			reset-gpios = <&pio 24 GPIO_ACTIVE_LOW>;
+			pinctrl-names = "default", "runtime";
+			pinctrl-0 = <&uart1_pins_boot>;
+			pinctrl-1 = <&uart1_pins_runtime>;
+			current-speed = <921600>;
+		};
+	};
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
