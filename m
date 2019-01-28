Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC89C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:09:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B2CA214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sTNTux1n";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2v417i6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B2CA214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=r5L8t9jWtSDoIp+WnJVHvJE9TaopLTzxhcPDrqbrCFU=; b=sTN
	Tux1n4g6w9RT9xizxDsRmfNm3Ub2k+yewGeh6l40/0e0Uke978mzOhkt4YDMZ8DAxFZVx+EBHFgX9
	CN09JHE9tl8TRLhi0MzJ8uyvrXDlQGfJzo88uwcGXaOmdpdm9on6MK+jGa/Q1LgkFYV8fELT31Dl8
	aK0IuyBHHVgxnBNGy5buSYN2IPlz3S61VfsqGvMtVPFK1d5yOdqTiLktxuFbfR3oG8p5dok/saGwH
	tvBrZcq+4BJz3gy8ahUsz9okm0MhP9xwsvKozZogjhqK7spS7fzEKGKpqvRFPhC94Kps9BcjEaLbk
	BE73nA1ww/nKLOn2//Q+OgOT+1q4Opw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go5j6-0005Mx-3Q; Mon, 28 Jan 2019 12:09:20 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go5ip-000595-KF
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 12:09:10 +0000
Received: by mail-qt1-x842.google.com with SMTP id t33so17891531qtt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 04:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=NrxmR5g91UGnZQl5TALQDAkJzh5OGQEUOwolXMifgYM=;
 b=Z2v417i6osXgouCIU6l1X4BNmGhKCN2qR68onoM0xAJnI2I835yWa8Klzm04XLCVIc
 5xX7ADGm+G3J6D78oxVGYkYziXDGYlMfhu9t+oTLFFZPcIGSL03TKnLk0CKR18FMHppw
 66FbIcL05qxrCqt6bMLLoDr1pCwv7+lzI0Fx07niU6oCoFjiR7HbgzLUUMeBCcdDzFR3
 DoGPnV2HwwVxN/07A/rwLvdCbsMtREerEIJ8TVpCyo4sK05pDCqTaWjyDuYv9io/HaAI
 jK/JmSpocKyHkf1JeestJoezE1SSiB5Abl4IMLdFuHsvQcb1guQwixHhGKTYckCetjKX
 Z2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=NrxmR5g91UGnZQl5TALQDAkJzh5OGQEUOwolXMifgYM=;
 b=rpwNONR+kZbb+zt4oYhJzDK7AYQCvCxg5fU5lWUSKXB0wyRi132+3kJopqx5/3lZlw
 +Z3WCUcBzCRsFSnlyBH9q1ZkSfjgt222dl3wqlIbHYvO91NrsdbhIdk5SDi8Fc0/umQG
 9MNQmZLoAwp+WJoOLY2Y1V2Alf0+ZX4jyMU32tb8PfKhgIj7WOkk1Kl8IJrxKaN/s5Gx
 O3DEOtD1cXfgmOmgfHoDe0hvbcT9B4YrvICJiug5MdbXed++95juMj7u2uOmiutz9HpN
 Kl8EJkz+GS7o5nwZmvOSc3XDfgrxbIPWveM5P8RF+/sGcjVhlDJePjDKa0by667P0PT2
 JG2g==
X-Gm-Message-State: AJcUukcAXbn+FLqd5QxkgkYU5w72EEozKEA6p6dJIihqWbQnElUCeWnL
 SgDFBcKRXn75sID0aeyvSl8=
X-Google-Smtp-Source: ALg8bN5c9m24eWiIr91uE/7lAAvD0Uvq7iVtrmPx0FhgXrmv6bk6JvHnDk/+QcOAaNljObkED3s58A==
X-Received: by 2002:aed:27d9:: with SMTP id m25mr21016787qtg.303.1548677339976; 
 Mon, 28 Jan 2019 04:08:59 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:482:a73::2])
 by smtp.gmail.com with ESMTPSA id r47sm80744265qtc.77.2019.01.28.04.08.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Jan 2019 04:08:59 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: shawnguo@kernel.org
Subject: [PATCH v2] arm64: dts: imx8mq: Add ECSPI support
Date: Mon, 28 Jan 2019 10:08:13 -0200
Message-Id: <20190128120813.23933-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_040904_121319_DD753C5C 
X-CRM114-Status: GOOD (  10.75  )
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
Cc: andrew.smirnov@gmail.com, linux-imx@nxp.com, kernel@pengutronix.de,
 Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org,
 l.stach@pengutronix.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add support for the three ECSPI ports present on i.MX8MQ.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Make reg a single address (Lucas)

 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 39 +++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 892063a7c26c..14949eec2d80 100644
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
+				reg = <0x30820000 0x10000>;
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
+				reg = <0x30830000 0x10000>;
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
+				reg = <0x30840000 0x10000>;
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
