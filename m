Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EEAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:39:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB04B2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f3cqjnTf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="kbboV7la"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB04B2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=zYnWZ4o8dBZ9oE1PlhkU5KcJUWiApSrfcESQ+o7iIwQ=; b=f3c
	qjnTfi8H2wfDCPyULn/opMmpa/7ieqL24RKha3hg/gJqdNbXsG/VOfn7jBj3yipWhMSBJVhqCPWLi
	unaucg4KD4XZ/iQnioLwZedQx2m0DcZV2Afj82sgRcWCT2A2Y1Z9Th+7LqaOXmNVZk2/0dFyZuT5u
	8cN1RRzEddw+9zftZq3NHzxCs8Q/u5mmRLj5HCE50YSOV5XP4VKZN9eTt9irliORm0pnhvBWPQ0qO
	QLv67iV5RphDT1HmTbbf2QoHE9dKyQdQkIkV5QAQnhfLExeQQyZxsOLVqDA9pdMDuGoj3zLtS7LrJ
	bNyS1z55mgwDRD+I5xvVG1uMOxc4aZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwE2j-0004b2-C7; Tue, 19 Feb 2019 22:39:13 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwE2g-0004ae-3C
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 22:39:11 +0000
Received: by mail-pl1-x642.google.com with SMTP id p8so11135561plo.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 14:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=wYabNxobeAIdUWqIshzsjfAVFGm3QlmnuSS/oA9tp58=;
 b=kbboV7laHOxNWz+zaORI1rJq+NiRNBrKu5WoTY92cH2465MTSl4M4C31ZkQBDNjbhd
 KriFWGnxUE7PkU7NYHMI4chcpVKOueYe/RfgsSpCuWQoA/KOZniC//heeCC7h+C8krGq
 dC3go08VCKspWhTIxLLOjvhUXs9FyPt7GPpkJLjWdsyom8KmJzQCWUxFPucLCgfdnS/H
 On79LJWMTBagsi/sAg6IF8mK/sA3uI5DShXXuNSk6WUqEbfpPlb3IP44h7rqdWcpZseO
 us4S6ov73OyebNFtX3dVLCXPx16kVG7RaiGyiCN/5lhgqE0mS0HCeTdIWvPM97okcWiV
 TnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=wYabNxobeAIdUWqIshzsjfAVFGm3QlmnuSS/oA9tp58=;
 b=CMq52S3B24Iq9gfKWZNok1PrTjG2ruhg+YCwrI22RXllFa+w/6EEyHsZpX8fJpjUoK
 8l8JzIITMfDOWe4kuRiMqHhuM3CPXq62+/gNnLKFUP+2PXteX4x1KpfwdPsJO0xDUg/k
 Qxwjyr3Mw19XJrkcG8eiF8HGWsSXRjoKM+lcBKWiZthBdncW6peeFZKL/8kHdCxGFCVQ
 tDJtULPwGC+l95owlx1SqH0QgQCUVJns1hOtmpToM4w+OdvyUinOv8YdZyhseVWhL4Mb
 XuiUQb6c09qb6zvsSFNu8cHHWp4H6avJ/k5bOEHE/3TAiaq0tJl5CpWe3yKMFwMJM/2Q
 c8BA==
X-Gm-Message-State: AHQUAubjmGaQz3s8zPJTTWPtW2fIo8oabgALRQmBb8UdsKdLdCPHw9zG
 sT7UfqyntDzkOOCSpzhSpInkFg==
X-Google-Smtp-Source: AHgI3IYy1uTgPjzfToXOPlQIwDR++aqXm/vQDF2mwnT8vRVj4TqDeDndiA5Xvz2XHVD491UK9RnF5g==
X-Received: by 2002:a17:902:3143:: with SMTP id
 w61mr34019522plb.253.1550615947820; 
 Tue, 19 Feb 2019 14:39:07 -0800 (PST)
Received: from tharvey.pdc.gateworks.com
 (68-189-91-139.static.snlo.ca.charter.com. [68.189.91.139])
 by smtp.gmail.com with ESMTPSA id z67sm8950714pfi.152.2019.02.19.14.39.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Feb 2019 14:39:06 -0800 (PST)
From: Tim Harvey <tharvey@gateworks.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH] ARM: dts: imx: Add TDA19971 HDMI Receiver to GW551x
Date: Tue, 19 Feb 2019 14:38:50 -0800
Message-Id: <20190219223850.8811-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_143910_276859_CE2BE638 
X-CRM114-Status: GOOD (  13.61  )
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

The GW551x has a TDA19971 HDMI reciver hooked up to the IMX IPU1_CSI0
via 16bit data and sync.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi | 138 ++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
index 4e21b3849394..61430f0780d8 100644
--- a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
@@ -46,6 +46,8 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/media/tda1997x.h>
+#include <dt-bindings/sound/fsl-imx-audmux.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -98,6 +100,50 @@
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 	};
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
+};
+
+&audmux {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_audmux>; /* AUD5<->tda1997x */
+	status = "okay";
+
+	ssi1 {
+		fsl,audmux-port = <0>;
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
+			IMX_AUDMUX_V2_PDCR_RXDSEL(0)>;
+	};
 };
 
 &can1 {
@@ -263,6 +309,60 @@
 		#gpio-cells = <2>;
 	};
 
+	tda1997x: tda1997x@48 {
+		compatible = "nxp,tda19971";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tda1997x>;
+		reg = <0x48>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+		DOVDD-supply = <&reg_3p3>;
+		AVDD-supply = <&reg_1p8b>;
+		DVDD-supply = <&reg_1p8a>;
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
 
 &pcie {
@@ -320,6 +420,14 @@
 };
 
 &iomuxc {
+	pinctrl_audmux: audmuxgrp {
+		fsl,pins = <
+			MX6QDL_PAD_DISP0_DAT19__AUD5_RXD	0x130b0
+			MX6QDL_PAD_DISP0_DAT14__AUD5_RXC	0x130b0
+			MX6QDL_PAD_DISP0_DAT13__AUD5_RXFS	0x130b0
+		>;
+	};
+
 	pinctrl_flexcan1: flexcan1grp {
 		fsl,pins = <
 			MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX	0x1b0b1
@@ -375,6 +483,30 @@
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
 	pinctrl_pcie: pciegrp {
 		fsl,pins = <
 			MX6QDL_PAD_GPIO_0__GPIO1_IO00		0x1b0b0 /* PCIE RST */
@@ -399,6 +531,12 @@
 		>;
 	};
 
+	pinctrl_tda1997x: tda1997xgrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_7__GPIO1_IO07		0x1b0b0
+		>;
+	};
+
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD4_DAT7__UART2_TX_DATA	0x1b0b1
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
