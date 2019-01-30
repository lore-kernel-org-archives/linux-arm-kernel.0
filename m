Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A569C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:06:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F9D720869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qol065ER";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wRyimw4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9D720869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z/lCdad/E86GWw5o+s74+NMBholtvMyg8TMWzTFmZGI=; b=Qol065ERfIRF7E
	9gc7shV2Oi4KPd1zJNUulfLPCqKsE6Km1YEHpFudtpla9XIx2HLsfC5HC6PnJjO/N5En8n5A7qLNS
	VGCOBBDoBfqEEXYxV3ae/6zLs9AwB8R2ccDcx0oiNFcw5T8pnjCIEmHpAmvhMVrW+mb8vMKKk1Thh
	kJ/hjrWWM2Iiv16dIYbbcbA4bIPIU0+YidqdE8Gzt5wcBCKTc8mPdQHHBamEUJGw5Jgiu3o4J346n
	RhF6MXpF4Af1LOCPOgW0sqb2A4jdDNqKum/KDIRFf/leR6CGhLyrLL/oiNi/YlAtny6BtKdEqqy2d
	/XCbBe5tRLEIYNVIaxhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gooct-0003tY-Fi; Wed, 30 Jan 2019 12:05:55 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goocO-0003Te-0z
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 12:05:28 +0000
Received: by mail-wr1-x443.google.com with SMTP id t6so25722117wrr.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 04:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B2BO+fwpvQNa7co+MBheCqT9EeSpoweliE1h0nvrf8E=;
 b=wRyimw4q/CieZB39/w/yhj+9ddW4wWJIPVHSz2pzkG7HYONNvO9kG6mEWI+iUQM75u
 19gwknb+I/uBUwUo2C1D1nyn8TykoWa/dBDl8+Y99hWUHSrGkY8i+GmOwN9PIYxOGYIw
 mo4fl5SZbNymgwpog8C9gTPquMZdIOQ/RyCiUeVjQI6YalOvwBrDH+w/1ENwYKglw4G4
 cFEWgMmvIik8MeFZvJj4xZzGtAzlgnRKVeUNjoacMs1bUOReud5FOf/qT3O1CUJum2+2
 VD5c2hVD+idwH2F1ezARhmgywKUcszcDzTgFQjuvTCUbKJvlO3OTLnY1zkyOTlLIk8Hk
 ekZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B2BO+fwpvQNa7co+MBheCqT9EeSpoweliE1h0nvrf8E=;
 b=cvkQOAdyw/Rr+2kaMzkrK821imUm7yp+wN8sesS1IvadY2ihqTZvBssZqHWgb9PEf5
 rwFGZjI83N8XUNCoPigGFd/pBLjkrANldNFo1KUrX3t9Qne1nt5qCh2SAZFXgehZ/kpj
 JMEEYRJnJSDPW4wdyhTgEXDqt7Il3xgBvyuQpeYhwnM9xcAPOtkqEglMk4gTKyfCP0P2
 YnTnrgWhMUzrUQ7MB+Kge+Z4XOBQJkKidOB8oqhMlbKKGfWG0KAd+JXaSUT9VXaTkIUi
 XB8aEfMUDlocoCYfo10kdUBGMjo4VEp0pQp6OwxRcE3McqWfM4TB2Q7AueuMWDvx8uNt
 sSZQ==
X-Gm-Message-State: AJcUukcRkP1IGDDZObdvb1uodKeVYLn4yU/Rg15ZRk3bo1WOEb5R0LlD
 NeUqIwr2o0NIKVkp8ksEfHIOcg==
X-Google-Smtp-Source: ALg8bN7nsDf+G5dOa1/Oa2WPTbn+01xvu7HqJHNgAmRduhxmqMb+n3anOXwM3TvInm31/a1A3mJbyg==
X-Received: by 2002:a5d:60cc:: with SMTP id x12mr28816411wrt.193.1548849920399; 
 Wed, 30 Jan 2019 04:05:20 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6])
 by smtp.gmail.com with ESMTPSA id f15sm642954wrt.10.2019.01.30.04.05.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 04:05:19 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, l.stach@pengutronix.de, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/3] arm64: dts: imx8mq-evk: Enable the QuadSPI controller
Date: Wed, 30 Jan 2019 12:05:10 +0000
Message-Id: <20190130120511.11555-3-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190130120511.11555-1-ccaione@baylibre.com>
References: <20190130120511.11555-1-ccaione@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_040524_266212_F0BBC32C 
X-CRM114-Status: GOOD (  11.21  )
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

Enable the Freescale/NXP QuadSPI controller with a proper pinctrl set on
the i.MX8MQ EVK board.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 26 ++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index f74b13aa5aa5..ef452d2d8653 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -137,6 +137,20 @@
 	status = "okay";
 };
 
+&qspi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_qspi>;
+	status = "okay";
+
+	n25q256a: flash@0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "micron,n25q256a", "jedec,spi-nor";
+		spi-max-frequency = <29000000>;
+	};
+};
+
 &usdhc1 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc1>;
@@ -195,6 +209,18 @@
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
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
