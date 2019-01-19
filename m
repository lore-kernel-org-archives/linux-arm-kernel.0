Return-Path: <SRS0=AzG1=P3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFF9C61CE8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 21:18:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E03D2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 21:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NTpXAlYB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdEfYyXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E03D2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=niQDX1m3ysobRt6kR/WR+f2jLsK9ncYfMn5Zqjk3ekk=; b=NTpXAlYB4kzJpU/tgInWlx1qyU
	mfs4O+Tq3buUrK6ANbC9Xu68SQAJBy2N/vwH25NXt0QMGB2bt6Eth594FvyBCnLupzL8//EhJYdeo
	XiSVoJSdh/c6wKLvwGchaWw/xaEgXeMqFt5ZjCS11CRttrJ+/IDruUJsrMTMST8EMyL4/iB0xUmv6
	yreRQpgo6912cCWPN4iecBK6ctKQGa6ylUUam3MqCyioN2BlVwTetXa5jdq3eS60irPyKwR8nqiW+
	xULjQW8Ulzscwr4a2F111VG9mIdB0pTWZMcX+cJZ9yeOeSyXKgBR6xMi7V0155X0n/5VpE+CfTa/r
	JAUcOpSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gky0v-0004uq-5j; Sat, 19 Jan 2019 21:18:49 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gky0h-0004gw-4y
 for linux-arm-kernel@lists.infradead.org; Sat, 19 Jan 2019 21:18:37 +0000
Received: by mail-wm1-x341.google.com with SMTP id m22so7557830wml.3
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 19 Jan 2019 13:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=EcXNpdimy0F9xsPDYLjaUasTNqD0XXtOzr8O0QQSlgQ=;
 b=IdEfYyXapNkjimfQkDICQcO6Fm6aC8jBBTFH6aZlKU96yr0MH790LF21psju+LcLh9
 f/oJKtPmtvrNSwkfLUSe/ujalVO27O4JpvyhnmSW0gAL/1/KFmExDuL5o3U408MwbuDy
 5zTjqkuNCHTIW9pcAEr9PkUMZRPq2aaM5jTrNZrhbojTuCW8jUojGc85wXVrMeIRwXbV
 9ZoG902LGlzDvg5JcWa1RVIJf8NXjfsOvnx6evVF11zyBN8cuzrREQ9vFUQD8i3oO6bU
 kLAb3xMbbHftO1jehT17ysyyK/lOCVJdYtGDed2y0iPGQB9Pfakwn9YwbYGYb2JVs8GS
 8ZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=EcXNpdimy0F9xsPDYLjaUasTNqD0XXtOzr8O0QQSlgQ=;
 b=SJb7OBR+Q7TQ9lwmXFcb8/wRrAGyHLYFPgVVkNi6wm8Mu8xlbNKMsY8H328fKYL5n7
 GE0CsI662VbZgP0luG08es3HWyYbC+i/vlSHcMgw22bEa2lJhiSQ14MK02G8NRDd+lZm
 PiZS+Ak62Zx6uuf0261Vb8uCtlNyGKjUuj1jZfcs/zuklvMWl1zPWMMlftSQ9IXkho51
 tvvwSgyKLbewMSMx6Z/lkU+oj/SSoZdppLjnLiQdlVTitDfVD1/BEiALC/0jGQKophZN
 UXorI6Wjfc/ksvfXIl0fMiXOf2EvDJM8CT45toN6rfez2vzm0a9pTXP0mxVXIip2iaKE
 WSzw==
X-Gm-Message-State: AJcUukcqsbUqRxWlZZN5G7YB9gUFmsWu859Nm6yde0LvJapIB7hPVaAR
 VX4RvIzSPaIJHZ65TSiVXtjoalVd
X-Google-Smtp-Source: ALg8bN7h/K2L9PPkiGbjiQ7AYo+5JdIB6Y7t7tznfLo112/r+AldBNb2kQbauXGSo22otdgMr4nMAQ==
X-Received: by 2002:a1c:c181:: with SMTP id r123mr2808944wmf.8.1547932713390; 
 Sat, 19 Jan 2019 13:18:33 -0800 (PST)
Received: from mappy.world.mentorg.com (sjewanfw1-nat.mentorg.com.
 [139.181.7.34])
 by smtp.gmail.com with ESMTPSA id v6sm55737019wrd.88.2019.01.19.13.18.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 19 Jan 2019 13:18:32 -0800 (PST)
From: Steve Longerbeam <slongerbeam@gmail.com>
To: devicetree@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: imx53-smd: Add OV5642 video capture support
Date: Sat, 19 Jan 2019 13:18:15 -0800
Message-Id: <20190119211815.25101-3-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190119211815.25101-1-slongerbeam@gmail.com>
References: <20190119211815.25101-1-slongerbeam@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_131835_224051_36375A4A 
X-CRM114-Status: GOOD (  13.64  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 open list <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Steve Longerbeam <slongerbeam@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add video capture support from the OV5642 to IPU CSI0 on
the i.MX53 SMD.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
 arch/arm/boot/dts/imx53-smd.dts | 75 +++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-smd.dts
index 09071ca11c6c..2d6fc07629e6 100644
--- a/arch/arm/boot/dts/imx53-smd.dts
+++ b/arch/arm/boot/dts/imx53-smd.dts
@@ -185,6 +185,31 @@
 			>;
 		};
 
+		pinctrl_ipu_csi0: ipucsi0grp {
+			fsl,pins = <
+				MX53_PAD_CSI0_DAT12__IPU_CSI0_D_12    0x1c4
+				MX53_PAD_CSI0_DAT13__IPU_CSI0_D_13    0x1c4
+				MX53_PAD_CSI0_DAT14__IPU_CSI0_D_14    0x1c4
+				MX53_PAD_CSI0_DAT15__IPU_CSI0_D_15    0x1c4
+				MX53_PAD_CSI0_DAT16__IPU_CSI0_D_16    0x1c4
+				MX53_PAD_CSI0_DAT17__IPU_CSI0_D_17    0x1c4
+				MX53_PAD_CSI0_DAT18__IPU_CSI0_D_18    0x1c4
+				MX53_PAD_CSI0_DAT19__IPU_CSI0_D_19    0x1c4
+				MX53_PAD_CSI0_PIXCLK__IPU_CSI0_PIXCLK 0x1e4
+				MX53_PAD_CSI0_VSYNC__IPU_CSI0_VSYNC   0x1e4
+				MX53_PAD_CSI0_MCLK__IPU_CSI0_HSYNC    0x1e4
+				MX53_PAD_CSI0_DATA_EN__IPU_CSI0_DATA_EN 0x1e4
+			>;
+		};
+
+		pinctrl_ov5642: ov5642grp {
+			fsl,pins = <
+				MX53_PAD_NANDF_WP_B__GPIO6_9   0x1e4
+				MX53_PAD_NANDF_RB0__GPIO6_10   0x1e4
+				MX53_PAD_GPIO_0__CCM_SSI_EXT1_CLK 0x1c4
+			>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				MX53_PAD_CSI0_DAT10__UART1_TXD_MUX	0x1e4
@@ -256,11 +281,49 @@
 	camera: ov5642@3c {
 		compatible = "ovti,ov5642";
 		reg = <0x3c>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ov5642>;
+		assigned-clocks = <&clks IMX5_CLK_SSI_EXT1_SEL>,
+				  <&clks IMX5_CLK_SSI_EXT1_COM_SEL>;
+		assigned-clock-parents = <&clks IMX5_CLK_PLL2_SW>,
+					 <&clks IMX5_CLK_SSI_EXT1_PODF>;
+		assigned-clock-rates = <0>, <24000000>;
+		clocks = <&clks IMX5_CLK_SSI_EXT1_GATE>;
+		clock-names = "xclk";
+		DVDD-supply = <&ldo9_reg>;
+		AVDD-supply = <&ldo7_reg>;
+		reset-gpios = <&gpio6 9 GPIO_ACTIVE_LOW>;
+		powerdown-gpios = <&gpio6 10 GPIO_ACTIVE_HIGH>;
+
+		port {
+			ov5642_to_ipu_csi0: endpoint {
+				remote-endpoint = <&ipu_csi0_from_parallel_sensor>;
+				bus-width = <8>;
+				hsync-active = <1>;
+				vsync-active = <1>;
+			};
+		};
 	};
 
 	pmic: dialog@48 {
 		compatible = "dlg,da9053", "dlg,da9052";
 		reg = <0x48>;
+		interrupt-parent = <&gpio7>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>; /* low-level active IRQ at GPIO7_11 */
+
+		regulators {
+			ldo7_reg: ldo7 {
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-always-on;
+			};
+
+			ldo9_reg: ldo9 {
+				regulator-min-microvolt = <1250000>;
+				regulator-max-microvolt = <3650000>;
+				regulator-always-on;
+			};
+		};
 	};
 };
 
@@ -271,3 +334,15 @@
 	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
+
+&ipu_csi0_from_parallel_sensor {
+	remote-endpoint = <&ov5642_to_ipu_csi0>;
+	data-shift = <12>; /* Lines 19:12 used */
+	hsync-active = <1>;
+	vsync-active = <1>;
+};
+
+&ipu_csi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ipu_csi0>;
+};
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
