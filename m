Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66ED0C4151A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:35:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37A9E2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MQEL4MGF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xY0qzMOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A9E2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=NRJTV//FCxB2l/ZdjvzJKMPQJQe3pBi2svpKodUDZ0M=; b=MQEL4MGFtzKVMJ
	GpS4EbC+pmtg6Ls+hxCu2slJIjHIkNRUciT9ke9UkSeWS+xjXLL2f9NpPFW9CPOWXkOef0oKRG1vm
	PsjO3DayqmxQ7MdoflDXz1tQCQGFrduhNs9qHbrVW1pyD+NZg+9xuWQxLSq96YmGGpzSFjTLtBLo6
	WUnKrisdf1eaGDe8uzopsIUU7+2ZG7/BrrKI4XkM3M3MpN3R4pP7dbZE0+1USYyf2w4TPO3AkR3Fx
	+nm7aub1u4i2EznWp6+yp0NpV0OHcgFCQj4alHJt+lT6VkfOdfTYoofZZOP9WIyxHnXi3UNv0G5hX
	NbQ80P7dD8F912nx1ToA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goWMX-0005mU-8J; Tue, 29 Jan 2019 16:35:49 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goWMT-0005m4-Lg
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 16:35:47 +0000
Received: by mail-wr1-x441.google.com with SMTP id f7so22906180wrp.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 08:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+QvfvjNopRQP/Xd/cNUCXkmM/r7dkjZm41EQ895Pe2w=;
 b=xY0qzMOwwariOniQn44i0aGnZNjGPj3P0YkdO5jWcnCaeNWGxvavKTjVPCbI0cPKR+
 y3OFNf/xm/nI/Eo1Qo6BZQF8p8SHr3SsLjufhKvolchL4dmTGU0c56NrtmcofrrQlV8f
 Vaaw2UpT5mVR7QpZIw3ztjYvvzzWBTqA8axytFDyzmJ/I41JD7YSS94m5TZAZff0SjwB
 zLgRRIz3K+E8qhpLWfu5ELwRVQ51z56vealHccKeue5JIECtPYD7ekNjoJyRCCr/l4GL
 Y1TL9DwqT2NlGOeGtkgL1kKQ+RcbAddMZ6oC4Gu/ptQioLK0C8mUEyJVIUJB/tXohuCC
 erag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+QvfvjNopRQP/Xd/cNUCXkmM/r7dkjZm41EQ895Pe2w=;
 b=dVDSFaCQn9y9KSq2LFpfdxRwghie6HIe5OtRZ4e2D+BjryROie39PU+LnIabOrJQCq
 Nzxu8C4skX3KPZvuGU2EkUrGaXKttyIL4MH3p5OsyXVUFYXu3i85FGEwH5mVEh23yQO8
 iR/vyiR+iUZWqvW/5oCAK/dbWcrtBdaWbAUKSYHmILwIE6C0Eslr2ZaQt46YqsqhIKA0
 D4hNzfk6qvSUS1suTt08DOq4sZHn9rE9hKc6O3qWbmBRgSZSlXOUXJlkNbA5gGc5F7ih
 4qQl53r004JeeGVgJb7feUwyJ4iVds8pMIbxiugu8y3t3A91txc4dBCiRdge78XrzLN9
 q3ZA==
X-Gm-Message-State: AJcUukc9ta9ETWvqQrm63MRsSEQhia6DAKDytj4NK7CvS5svKUcwf6F6
 coYF7jR9Qxna+pT3sTFP8hVv7g==
X-Google-Smtp-Source: ALg8bN7bHNtxYwxRAczm6U/07QM5yxQESr3LlK9xtVkcX4r2vFj+fnGYtDkEQAGj/n8aBo/Lr/wzMA==
X-Received: by 2002:a05:6000:108d:: with SMTP id
 y13mr25535733wrw.135.1548779743073; 
 Tue, 29 Jan 2019 08:35:43 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6])
 by smtp.gmail.com with ESMTPSA id x81sm3320860wmg.17.2019.01.29.08.35.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 08:35:41 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, l.stach@pengutronix.de, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: imx8mq: Add QuadSPI controller
Date: Tue, 29 Jan 2019 16:34:57 +0000
Message-Id: <20190129163457.7107-1-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_083545_768321_E8C1243F 
X-CRM114-Status: GOOD (  11.40  )
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
Cc: Carlo Caione <ccaione@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a node for the Freescale/NXP QuadSPI controller with a proper
pinctrl set and enable it for the i.MX8MQ EVK board.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 27 ++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 13 ++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index f74b13aa5aa5..ae181c2a5003 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -137,6 +137,21 @@
 	status = "okay";
 };
 
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_qspi>;
+	status = "okay";
+
+	flash0: n25q256a@0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "micron,n25q256a", "jedec,spi-nor";
+		spi-max-frequency = <29000000>;
+		spi-nor,ddr-quad-read-dummy = <6>;
+	};
+};
+
 &usdhc1 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc1>;
@@ -195,6 +210,18 @@
 		>;
 	};
 
+	pinctrl_qspi: qspigrp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_NAND_ALE_QSPI_A_SCLK	0x82
+			MX8MQ_IOMUXC_NAND_CE0_B_QSPI_A_SS0_B	0x82
+			MX8MQ_IOMUXC_NAND_DATA00_QSPI_A_DATA0	0x82
+			MX8MQ_IOMUXC_NAND_DATA01_QSPI_A_DATA1	0x82
+			MX8MQ_IOMUXC_NAND_DATA02_QSPI_A_DATA2	0x82
+			MX8MQ_IOMUXC_NAND_DATA03_QSPI_A_DATA3	0x82
+
+		>;
+	};
+
 	pinctrl_reg_usdhc2: regusdhc2grpgpio {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD2_RESET_B_GPIO2_IO19		0x41
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index dbedc4a5e7fb..e0059f451591 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -516,6 +516,19 @@
 			};
 		};
 
+		spi0: spi@30bb0000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,imx7d-qspi";
+			reg = <0x30bb0000 0x10000>, <0x08000000 0x10000000>;
+			reg-names = "QuadSPI", "QuadSPI-memory";
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk IMX8MQ_CLK_QSPI_ROOT>,
+			<&clk IMX8MQ_CLK_QSPI_ROOT>;
+			clock-names = "qspi_en", "qspi";
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@38800000 {
 			compatible = "arm,gic-v3";
 			reg = <0x38800000 0x10000>,	/* GIC Dist */
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
