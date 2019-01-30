Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0524BC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:36:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA14D20882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="On99ClC7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tnKn1wan";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KQEP0qOC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA14D20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=7rTE8i136sGIero58rIihEnoX6/J3k8ftrMt3fiA3Vg=; b=On99ClC7CdWhej
	VEehIFdTYH6EK5hmK9GYGRJMtSz2xju7YlGwsVa/Zw0iZXOb/DTMZLJmtz6/oOCqdyD/SajJy/DSv
	C3nT+9ZDr0WXCvUfTy94rMPNAlmm+6Ge75MH5aWpHL1ArOReOUwRVh+7VCf0kN3McdgpT4L47+vPm
	k0WEJhuXwS4BIqCwjKJ8ndGM4lEaNkJorO778WYYqSotsKlYVd1F1VglLdVFfaLB16kMC8w2hQsOJ
	rSipaipzBlOeyS5elzyv/3Ed5E1haTOifAdb9EMFY8SyW5HnTp2vEZ2ho3x9Ixf/6tMnXXlnWJ9GE
	W6BdYOK6KMg14kbVCihg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gomI6-00030m-Ao; Wed, 30 Jan 2019 09:36:18 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gomHy-0002Yv-0G
 for linux-arm-kernel@bombadil.infradead.org; Wed, 30 Jan 2019 09:36:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5BYwMDxJkDeOSHAu4Y7eWGKdLcHGjaOL/cVYmaAVXxE=; b=tnKn1wanZECUyLXGG4bccRSd8K
 zO5RpCeZ6ST7VW5nWAiS/OdAnMqoA3UcStzyRlgyIaLy6hDLr9SmwrNP0kQ6qPqOARxWGN1jcOfsv
 bTGRcR8XLDmNydmBsiTsqfuOhA6yJP53613Glytqs+dDufyuAwuDxeG6ym0SOJncZP7ptgwBPR6rb
 yQHRD8LVdcBIGsSTrxTAx9dvECbk5jZMzHMsnHzXgMg/1BY5IVROVCvsTdv68kJQxDrT0RSZ801W6
 8eqLdzc7Xvnj9rrsK1QyLpjhEcMAxU3jqAA0R7apdpPGCEzNFGD5eNi4Ogsw4rsW4PSln1iACuYe1
 Hmvsy6aQ==;
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gom2M-0005Nv-GI
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 09:20:05 +0000
Received: by mail-wm1-x341.google.com with SMTP id f188so20673380wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 01:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5BYwMDxJkDeOSHAu4Y7eWGKdLcHGjaOL/cVYmaAVXxE=;
 b=KQEP0qOCzE1I7AujnAMWflUAQJZH7vtuBlhSHF+7pLNExB70cjwAkN/37yeogOpyPz
 OItepokP7MYFYwoRmPQuWZCbSPCvwEpwlb98RribeRJoxJ/v5wWMjP3ji3YZKPLlW9R1
 6FvkzVpfbXuGh2ykLUBXcpeD+vXtRE/V8H9oERHH0m6rFsy+6thuRBZXN63q5yDbfFfl
 eeT3j5hHOxxbgfoUju/mK7j7jJ96oIRODMDxcV9pSODjpZ0zWfF+/qW3VyD9IeH2pzoO
 eLHEIpEbGweDZZMvPfgkQdYwkDkie8UCMFfvlaDI4kWvcv+9W5n9N9HWMfm+CSV3rhdm
 pwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5BYwMDxJkDeOSHAu4Y7eWGKdLcHGjaOL/cVYmaAVXxE=;
 b=ZbFPI9ob+nUqirRGQPVSklHj5l4v4lATPfYsb7gdo7OWfh05T62JaTXjLQpzAf2qQw
 4DlmTWXTEOnQ3p0kO8MyraatexKpdaYvB4FKXS6g/SHvRuHe8Z2Wgyq82O6UMN/5nFwd
 CK4u0NfVakdOQqqTxEXTS4eFNamtyPCVTlbLljF5BYl8CPLknQ6CZ7JIAjPmQfLkJ2b6
 6wCwJ6SUdcDeElF0xiIxet2/8djJmMZqYZuiU90BoxTG4CIvd5rBJaTsZauFXUm0Gnnf
 ywl6ntrTtE+YU4xwco3UPRDxQU1RH4eBMfm8OiM2euDnWqIum8RjE9RYNgSW/JO0ttxN
 /DZw==
X-Gm-Message-State: AJcUukf8HWiqbUnWHSytRhuY5zQN6GD9MdXaVpjaJsJJKzGwjkMtXg6N
 hDpG9BlQeFSljouLKRiAoQZjlw==
X-Google-Smtp-Source: ALg8bN65JDVw6MdTdoGKUWeBvXoj+VuWxtHbm81v3uRLq0m7VMoXiz7acMfSo/yA9z7ht85NSYGWDA==
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr24818821wmi.144.1548839998722; 
 Wed, 30 Jan 2019 01:19:58 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6])
 by smtp.gmail.com with ESMTPSA id f191sm1408562wmg.12.2019.01.30.01.19.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 01:19:57 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, l.stach@pengutronix.de, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] arm64: dts: imx8mq: Add QuadSPI controller
Date: Wed, 30 Jan 2019 09:19:53 +0000
Message-Id: <20190130091953.20131-1-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_092002_553957_45C944BB 
X-CRM114-Status: GOOD (  12.96  )
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
Extend also the AIPS3 memory range to accommodate the QuadSPI-memory
region.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 27 ++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 16 +++++++++++-
 2 files changed, 42 insertions(+), 1 deletion(-)

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
index dbedc4a5e7fb..c20f43f63c4e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -379,7 +379,8 @@
 			compatible = "fsl,imx8mq-aips-bus", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x30800000 0x30800000 0x400000>;
+			ranges = <0x30800000 0x30800000 0x400000>,
+				 <0x08000000 0x08000000 0x10000000>;
 
 			uart1: serial@30860000 {
 				compatible = "fsl,imx8mq-uart",
@@ -497,6 +498,19 @@
 				status = "disabled";
 			};
 
+			spi0: spi@30bb0000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx8mq-qspi", "fsl,imx7d-qspi";
+				reg = <0x30bb0000 0x10000>, <0x08000000 0x10000000>;
+				reg-names = "QuadSPI", "QuadSPI-memory";
+				interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_QSPI_ROOT>,
+					 <&clk IMX8MQ_CLK_QSPI_ROOT>;
+				clock-names = "qspi_en", "qspi";
+				status = "disabled";
+			};
+
 			fec1: ethernet@30be0000 {
 				compatible = "fsl,imx8mq-fec", "fsl,imx6sx-fec";
 				reg = <0x30be0000 0x10000>;
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
