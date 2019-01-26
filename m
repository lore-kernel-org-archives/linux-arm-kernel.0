Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C730BC282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 21:28:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E2D42133D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 21:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OAQ3WLCP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+QnA6K1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E2D42133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=pYkUqSDD0+g9TOkx7aLYMGQ6ASl3XrfJnG7yocgO8FY=; b=OAQ
	3WLCP8QDN4d1bqH3Td16LWo6mMt6mQEWpoMKac5F2a3GbEUaQ68olKIsboVcZW+GUUvymmx42MNFM
	Z+BvNMrmNc7pWbBdV9OqxG+GlcyX/sJ6sR4rfyf3QtMGB2npU5FWxF6sE31GR0JkA2371nEJNvdwr
	RQV4u2SD9SbfTBBgx80NzRGLvbZIKXewVbTeac60qOxyvUA2XJ0zRk2NeV9GGNqN4/yt2ckKt5HBv
	qjdIwRQ0EyLbCmbzKTiON5eu3EgLI+Mk9UUw+N21MrrCIbRKf3az7aTPxGS3yIz0o13HzsK1vByrH
	peO/0DwbIsJ9QWyT+tbjPcysDfE/+6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnVVK-0007Tx-S2; Sat, 26 Jan 2019 21:28:42 +0000
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnVVH-0007Tc-Kl
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 21:28:40 +0000
Received: by mail-qt1-x843.google.com with SMTP id l11so14547503qtp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 26 Jan 2019 13:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=wL07cL87X1QfQpOo0AiHPWy5r75DGEz96nldHEtmgj0=;
 b=H+QnA6K1ix3PJZ3/2eWuUCDAgGf9ATy/Be5cv55e0mtutDE+W4kWeNEC/2Ub6TzK0l
 pi8JzcWQmoBM/RwZPHK7A7ab60wye7YiVz8MLZkiu+4y73+wv3+gkR+gBoujEpYUbIem
 CYWpjXvM0iIe7v0yxq4HymmglMLc2ct2i12qrtwTV2qCwMQ7OQQbzEabMv/JEc/zgddq
 swNEpaRot8iwj7jlLVPbm7Vmp6f96yGPfj206f0HQHzcTJ5I6R6P1/NrO5U/ERP+InXM
 4iEtjrDPNA74zfIYVXugeq+U4FxmExUczFtExF7cupEBjEoZnMZsTVcDeq7ij2JmAQ1b
 c9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=wL07cL87X1QfQpOo0AiHPWy5r75DGEz96nldHEtmgj0=;
 b=EonGYdBlBbdWdNIADqg01SRe1VnASL9YSQM93fe7Dohnnj59x4+Gt913txK5MiGq/X
 vxg98x5/iaRc6qWHG5clCePrFQ1mUy9BqOL9L8gKeqNTR5KSUwIFanlzi7VzyJpidiJW
 U27qetoYP20lFktWy54a80Xm+BBzVIVJIgr2zEK7k5A8dBr9O50vTalySjIQaS4DmtZC
 joHo+yxXMNZwpiPrDXLIsdtcNK08pV0LMD41GxAuKTcmar7XkSzmBgx9bGou85tF4T2y
 zeXLbBsiEARGdv+1FVH0jNojbjbTJnv4P5CR/ADULy+6XZ54sqcnlUv3iX7VBDElfcH+
 dWBA==
X-Gm-Message-State: AJcUukeLOpGIz+/S0v6ASVCyn0zRrYijEeUXaUFmZw64fTDfMOEG1PwT
 R9sTf7kbZ5Mkn66SPTVC0co=
X-Google-Smtp-Source: ALg8bN7CN+Un/GYU97xMo9GE0m5rffdJHs6/hAI/pci3qta8M/Ghku0sU+M33+pS0jH7fEL92S2iYQ==
X-Received: by 2002:ac8:34b3:: with SMTP id w48mr16407059qtb.125.1548538118120; 
 Sat, 26 Jan 2019 13:28:38 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:482:a73::2])
 by smtp.gmail.com with ESMTPSA id t123sm61434525qkc.6.2019.01.26.13.28.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 26 Jan 2019 13:28:37 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: shawnguo@kernel.org
Subject: [PATCH] arm64: dts: imx8mq: Add ECSPI support
Date: Sat, 26 Jan 2019 19:28:24 -0200
Message-Id: <20190126212824.15641-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190126_132839_701355_01C075EC 
X-CRM114-Status: GOOD (  10.74  )
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
Cc: linux-arm-kernel@lists.infradead.org, Fabio Estevam <festevam@gmail.com>,
 linux-imx@nxp.com, kernel@pengutronix.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add support for the three ECSPI ports present on i.MX8MQ.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 39 +++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 892063a7c26c..45b9d4a8b0da 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -26,6 +26,9 @@
 		serial1 = &uart2;
 		serial2 = &uart3;
 		serial3 = &uart4;
+		spi0 = &ecspi1;
+		spi1 = &ecspi2;
+		spi2 = &ecspi3;
 	};
 
 	ckil: clock-ckil {
@@ -381,6 +384,42 @@
 			#size-cells = <1>;
 			ranges = <0x30800000 0x30800000 0x400000>;
 
+			ecspi1: spi@30820000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx8mq-ecspi", "fsl,imx51-ecspi";
+				reg = <0x0 0x30820000 0x0 0x10000>;
+				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_ECSPI1_ROOT>,
+					 <&clk IMX8MQ_CLK_ECSPI1_ROOT>;
+				clock-names = "ipg", "per";
+				status = "disabled";
+			};
+
+			ecspi2: spi@30830000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx8mq-ecspi", "fsl,imx51-ecspi";
+				reg = <0x0 0x30830000 0x0 0x10000>;
+				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_ECSPI2_ROOT>,
+					 <&clk IMX8MQ_CLK_ECSPI2_ROOT>;
+				clock-names = "ipg", "per";
+				status = "disabled";
+			};
+
+			ecspi3: spi@30840000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx8mq-ecspi", "fsl,imx51-ecspi";
+				reg = <0x0 0x30840000 0x0 0x10000>;
+				interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_ECSPI3_ROOT>,
+					 <&clk IMX8MQ_CLK_ECSPI3_ROOT>;
+				clock-names = "ipg", "per";
+				status = "disabled";
+			};
+
 			uart1: serial@30860000 {
 				compatible = "fsl,imx8mq-uart",
 				             "fsl,imx6q-uart";
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
