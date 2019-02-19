Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FA7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:39:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 220D42147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TDdpgkvi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="bxtyAho8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220D42147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=WaEK26XjkDAebKGf7yxXPHs8XFMH71VRsUpWMQA41A8=; b=TDd
	pgkvinlhRXcz7dkXX1Yfc0/3A5Ve/1sMUkKhjif4NYRsMfcZvL9wiUPoMJ6koIbM60VlAM64PAcFO
	fuVKO7db7hLGAtMSD5svkkjZ31vuvEYwHT8ASqSdHDj5cxHil26TJyHm+LcW5qnvTIO+nWpJQUDNh
	/Gcx5wfNJImtNO2SP7v/b+EeOzIIOfiarkey01JUPWtiHmXlBWkuD5k8j+WqbMBLHnJcFOPmFiSuv
	eDPKOL/0wCSypyxBZb9+IfWn8IqLNp9b7ebKvS89jV2k5opn+vna7Hr9DhsdqAakilLrov8TsSDHJ
	zuZd+8L0M961Fn+awmJ3nM/UFqjkUYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwE3J-0004w5-4v; Tue, 19 Feb 2019 22:39:49 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwE3G-0004vg-Gg
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 22:39:48 +0000
Received: by mail-pl1-x643.google.com with SMTP id y10so11145342plp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 14:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=tFnwwfXVIadkG/0Jn+8Avs7Kim6cd4s+EMyehNf3HFE=;
 b=bxtyAho8PeIJhTNP5oEMlPni+/bjgO6Rn+eWpgS/+itYD4mgHzJtOYU1LrekE61U46
 qk9Id0LmBGElK6XbP96mO/osMiw3Y2pPB4HUm+6CPsKyJTkJJIunMMTYQ+jCZt/sBEkV
 xORi5/3MjRa/4UQoUptQgNLH/DraOSE/XSjFoNdPNDO8XYtndHZhLGTiVKbDXTh8PdMR
 +UHs932FWc1pOZSlDWhQJKhsLMGRCNb0+6J/dpzN6RvofG8p80bpIHJOp0t/OpDtNMhb
 PnsiBYhtJ/jRQGApUGjj+1e4SWMvhzpuRseRbZ3zDxdGoUWbRE+zju0N/tNZzYu7SlQJ
 YJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=tFnwwfXVIadkG/0Jn+8Avs7Kim6cd4s+EMyehNf3HFE=;
 b=ZjWiEv1jMG3mDXel9E9C08ruq+ivMhvPpGAHf+3H6x2yOCo/dt6WQLphNpnPK8mDZo
 kPVh1QBY1SZXkTG1hL/DHhOdUgqjShfxrNuLz440C9iWlHvqL7i9f/tEbj3IGnn0z4Xt
 0MlPLk/I3XCzTo2EXwO7pWa3lSt8D1ljSQgDRksmTq8dGsKjmp/W0RSQdTYV3Rx+yo/o
 q2Jl88x+LNXx2fihMeX4TkaLyuaetOdDVHAripvS4XXA0BWnlhXiVItQlCJpwIEByULn
 dAJfQmZOM8RD5ak4lSj49n/dT/BCsDDqWgXKAN/nt5pPS6eBbStB23g7O11/enAurF9R
 PCSQ==
X-Gm-Message-State: AHQUAuYe0aUHc/6Jy3ZPOe+n1KXt4u198uaoBQTCl41kDs931Qs9hSmr
 2RkzUdyHcErCciWhaBu0kJGFiQ==
X-Google-Smtp-Source: AHgI3IaHa6rHVmCTBnLyS0VUKWDVjFEzZa7xyQn7Fqy1ibFUJIR7hDyMyNdDbS6kM8EWDXRFbRX46Q==
X-Received: by 2002:a17:902:bc3:: with SMTP id
 61mr33536003plr.15.1550615985482; 
 Tue, 19 Feb 2019 14:39:45 -0800 (PST)
Received: from tharvey.pdc.gateworks.com
 (68-189-91-139.static.snlo.ca.charter.com. [68.189.91.139])
 by smtp.gmail.com with ESMTPSA id e9sm70955154pfh.42.2019.02.19.14.39.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Feb 2019 14:39:44 -0800 (PST)
From: Tim Harvey <tharvey@gateworks.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH] ARM: dts: imx: Add TDA19971 HDMI Receiver to GW54xx
Date: Tue, 19 Feb 2019 14:39:37 -0800
Message-Id: <20190219223937.8901-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_143946_550920_B05FD64B 
X-CRM114-Status: GOOD (  16.86  )
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
Cc: Tim Harvey <tharvey@gateworks.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The GW54xx has a front-panel microHDMI connector routed to a TDA19971
which is connected the the IPU CSI when using IMX6Q.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6q-gw54xx.dts    | 105 ++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi |  29 ++++++-
 2 files changed, 131 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-gw54xx.dts b/arch/arm/boot/dts/imx6q-gw54xx.dts
index 56e5b5050fcf..0477120d5718 100644
--- a/arch/arm/boot/dts/imx6q-gw54xx.dts
+++ b/arch/arm/boot/dts/imx6q-gw54xx.dts
@@ -12,10 +12,30 @@
 /dts-v1/;
 #include "imx6q.dtsi"
 #include "imx6qdl-gw54xx.dtsi"
+#include <dt-bindings/media/tda1997x.h>
 
 / {
 	model = "Gateworks Ventana i.MX6 Dual/Quad GW54XX";
 	compatible = "gw,imx6q-gw54xx", "gw,ventana", "fsl,imx6q";
+
+	sound-digital {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "tda1997x-audio";
+
+		simple-audio-card,dai-link@0 {
+			format = "i2s";
+
+			cpu {
+				sound-dai = <&ssi2>;
+			};
+
+			codec {
+				bitclock-master;
+				frame-master;
+				sound-dai = <&tda1997x>;
+			};
+		};
+	};
 };
 
 &i2c3 {
@@ -35,6 +55,61 @@
 			};
 		};
 	};
+
+	tda1997x: codec@48 {
+		compatible = "nxp,tda19971";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tda1997x>;
+		reg = <0x48>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+		DOVDD-supply = <&reg_3p3v>;
+		AVDD-supply = <&sw4_reg>;
+		DVDD-supply = <&sw4_reg>;
+		#sound-dai-cells = <0>;
+		nxp,audout-format = "i2s";
+		nxp,audout-layout = <0>;
+		nxp,audout-width = <16>;
+		nxp,audout-mclk-fs = <128>;
+		/*
+		 * The 8bpp YUV422 semi-planar mode outputs CbCr[11:4]
+		 * and Y[11:4] across 16bits in the same cycle
+		 * which we map to VP[15:08]<->CSI_DATA[19:12]
+		 */
+		nxp,vidout-portcfg =
+			/*G_Y_11_8<->VP[15:12]<->CSI_DATA[19:16]*/
+			< TDA1997X_VP24_V15_12 TDA1997X_G_Y_11_8 >,
+			/*G_Y_7_4<->VP[11:08]<->CSI_DATA[15:12]*/
+			< TDA1997X_VP24_V11_08 TDA1997X_G_Y_7_4 >,
+			/*R_CR_CBCR_11_8<->VP[07:04]<->CSI_DATA[11:08]*/
+			< TDA1997X_VP24_V07_04 TDA1997X_R_CR_CBCR_11_8 >,
+			/*R_CR_CBCR_7_4<->VP[03:00]<->CSI_DATA[07:04]*/
+			< TDA1997X_VP24_V03_00 TDA1997X_R_CR_CBCR_7_4 >;
+
+		port {
+			tda1997x_to_ipu1_csi0_mux: endpoint {
+				remote-endpoint = <&ipu1_csi0_mux_from_parallel_sensor>;
+				bus-width = <16>;
+				hsync-active = <1>;
+				vsync-active = <1>;
+				data-active = <1>;
+			};
+		};
+	};
+};
+
+&ipu1_csi0_from_ipu1_csi0_mux {
+	bus-width = <16>;
+};
+
+&ipu1_csi0_mux_from_parallel_sensor {
+	remote-endpoint = <&tda1997x_to_ipu1_csi0_mux>;
+	bus-width = <16>;
+};
+
+&ipu1_csi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ipu1_csi0>;
 };
 
 &ipu2_csi1_from_ipu2_csi1_mux {
@@ -63,6 +138,30 @@
 		>;
 	};
 
+	pinctrl_ipu1_csi0: ipu1_csi0grp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT4__IPU1_CSI0_DATA04		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT5__IPU1_CSI0_DATA05		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT6__IPU1_CSI0_DATA06		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT7__IPU1_CSI0_DATA07		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT8__IPU1_CSI0_DATA08		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT9__IPU1_CSI0_DATA09		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT10__IPU1_CSI0_DATA10		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT11__IPU1_CSI0_DATA11		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT12__IPU1_CSI0_DATA12		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT13__IPU1_CSI0_DATA13		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT14__IPU1_CSI0_DATA14		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT15__IPU1_CSI0_DATA15		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT16__IPU1_CSI0_DATA16		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT17__IPU1_CSI0_DATA17		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT18__IPU1_CSI0_DATA18		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT19__IPU1_CSI0_DATA19		0x1b0b0
+			MX6QDL_PAD_CSI0_MCLK__IPU1_CSI0_HSYNC		0x1b0b0
+			MX6QDL_PAD_CSI0_PIXCLK__IPU1_CSI0_PIXCLK	0x1b0b0
+			MX6QDL_PAD_CSI0_VSYNC__IPU1_CSI0_VSYNC		0x1b0b0
+		>;
+	};
+
 	pinctrl_ipu2_csi1: ipu2_csi1grp {
 		fsl,pins = <
 			MX6QDL_PAD_EIM_EB2__IPU2_CSI1_DATA19    0x1b0b0
@@ -78,4 +177,10 @@
 			MX6QDL_PAD_EIM_A16__IPU2_CSI1_PIXCLK    0x1b0b0
 		>;
 	};
+
+	pinctrl_tda1997x: tda1997xgrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_7__GPIO1_IO07	0x1b0b0
+		>;
+	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index a1a6fb5541e1..0ef221212845 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -10,6 +10,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/sound/fsl-imx-audmux.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -114,12 +115,12 @@
 		};
 	};
 
-	sound {
+	sound-analog {
 		compatible = "fsl,imx6q-ventana-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
 		model = "sgtl5000-audio";
 		ssi-controller = <&ssi1>;
-		audio-codec = <&codec>;
+		audio-codec = <&sgtl5000>;
 		audio-routing =
 			"MIC_IN", "Mic Jack",
 			"Mic Jack", "Mic Bias",
@@ -133,6 +134,25 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_audmux>; /* AUD4<->sgtl5000 */
 	status = "okay";
+
+	ssi2 {
+		fsl,audmux-port = <1>;
+		fsl,port-config = <
+			(IMX_AUDMUX_V2_PTCR_TFSDIR |
+			IMX_AUDMUX_V2_PTCR_TFSEL(4+8) | /* RXFS */
+			IMX_AUDMUX_V2_PTCR_TCLKDIR |
+			IMX_AUDMUX_V2_PTCR_TCSEL(4+8) | /* RXC */
+			IMX_AUDMUX_V2_PTCR_SYN)
+			IMX_AUDMUX_V2_PDCR_RXDSEL(4)
+		>;
+	};
+
+	aud5 {
+		fsl,audmux-port = <4>;
+		fsl,port-config = <
+			IMX_AUDMUX_V2_PTCR_SYN
+			IMX_AUDMUX_V2_PDCR_RXDSEL(1)>;
+	};
 };
 
 &can1 {
@@ -331,7 +351,7 @@
 	pinctrl-0 = <&pinctrl_i2c3>;
 	status = "okay";
 
-	codec: sgtl5000@a {
+	sgtl5000: codec@a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
 		clocks = <&clks IMX6QDL_CLK_CKO>;
@@ -475,6 +495,9 @@
 			MX6QDL_PAD_SD2_DAT2__AUD4_TXD		0x110b0
 			MX6QDL_PAD_SD2_DAT1__AUD4_TXFS		0x130b0
 			MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x130b0 /* AUD4_MCK */
+			MX6QDL_PAD_EIM_D25__AUD5_RXC            0x130b0
+			MX6QDL_PAD_DISP0_DAT19__AUD5_RXD        0x130b0
+			MX6QDL_PAD_EIM_D24__AUD5_RXFS           0x130b0
 		>;
 	};
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
