Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC332C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:31:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBB202080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t7Unodyz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpvRD7Ka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB202080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PPjA3Kj9dbzq+hrBPDyBLrUri9JYAun9afOH7CQiyUs=; b=t7Unodyz6J4Ync
	uyQdyjHTpN20t2+ekSwBrf+KsXI2OBZqxGBlrhkQ43nnCB3jFxEpiTLFqnoV3ECRN9mXVFhy2NYm9
	+MHlAQAOm1zQMu3gYf7bDfJSQD0CjlYOfed8010lrjXx3jBRscobSE979uuaYkcLRcVvwdow+kNi4
	CM5AFdRvXj51E6qO6Zac/53EIjGFs2Ra8yAwdnAGxLH5i9IJRfT7F8CzmSqB/Jtu9sr0lPGO6we4f
	ZglAF0MD67q7h2RM+WY/Mqkbcamnd6JtpOMFkCZtR4ilEwUEzLJwuH+tXKOaWB8NRNPp7udi4L0eH
	zNf9GQBahXTtoFLT8eCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gru4l-0001rz-9W; Fri, 08 Feb 2019 00:31:27 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gru3Q-0007su-HF
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 00:30:10 +0000
Received: by mail-pg1-x532.google.com with SMTP id y1so751190pgk.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 16:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rpJNkOBHsfvv1X+OP8aoJHBEpYyMF+iONDDdi76qcyU=;
 b=CpvRD7Kasw/cgtJcGXCiiAqOkeTsqsFrDwWfGAtFo5xLxC6JqGr8UMhCAqu8zlk3op
 jf4Nj650Bg0E1FLP/y/KQ1tKzKwAt+sNSZzQHEtMHxPJS7Oqi0e4xjdnyzzpwLXsmxFp
 T2aOpQYueI7v4NANqdhNdPfLbrVLxWXvfRMY8YZyqoJu/iONmM/ZCbjkt7QMO6oOmk8c
 pDG3DdKhdIjyq4G8U+nydgTTrM1VsH5R+bgKxRtPvaRFbOyRrau51uB4giqbnaWWvNOt
 Z0Hvf582ZMepwds+I0EPKTGLM/OpO8Mij4ajyjOcNbqrqumrm1kh8omx21z0UFnhcWmM
 w4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rpJNkOBHsfvv1X+OP8aoJHBEpYyMF+iONDDdi76qcyU=;
 b=PO526dQb29zWgfU0QvvXLO5bTdXvrfA7ZWHf2LPNhD/qOO96sY990HKxshKvrB9OfP
 OFsbY6ryWM0IdQVU76cBnUMd3fEt/YEJn0TT3vZV4o+mirc/k2dha91U97jAt2PEfAg0
 NQyKlfgvUV0P2zdIp4BflwAsL3T3yOmtm6M3waW6Gtoa9N6PPZCF5+D7fPknEY0OWBVJ
 xlPZEDTVtIcAMi/5nYoac4SjDiabOFFPMfU7XKSxrKLLLuhguqYraJYwjWvE/pmmrtBP
 aUJ2NROkg0e9DbrWOqk5GurIR6q5dprjN7YGo2sOOhyXvnUI2nPa0oObQR2q7I3CRwrO
 a/+A==
X-Gm-Message-State: AHQUAua9kUdx+iDgrZvUI4BOUvu2jZAlnDjoysJjHSSEDqb6sgL2c+FY
 H5o8jTR8cmBKtc6K2zzgSqc=
X-Google-Smtp-Source: AHgI3IaIZS4Y2fg9Km1oRwdvMmzHrOA+B9Ly6diFlmKOF8/L8KoUYFjzqjdAzFcqqCL5WEcQTQpSTw==
X-Received: by 2002:a62:a9b:: with SMTP id 27mr1431301pfk.223.1549585803272;
 Thu, 07 Feb 2019 16:30:03 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id p81sm380835pfa.107.2019.02.07.16.30.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 16:30:02 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: [RFC v2 5/5] arm64: dts: imx8mq-evk: Enable PCIE0 interface
Date: Thu,  7 Feb 2019 16:29:41 -0800
Message-Id: <20190208002941.30343-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208002941.30343-1-andrew.smirnov@gmail.com>
References: <20190208002941.30343-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_163005_097561_74635065 
X-CRM114-Status: GOOD (  12.41  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-imx@nxp.com, Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Chris Healy <cphealy@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enable PCIE0 interface connected to BCM4356 WiFi/Bluetooth module.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 34 ++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 64acccc4bfcb..20afdb9ffdd9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -31,6 +31,12 @@
 		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	pcie0_refclk: pcie0-refclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
 };
 
 &fec1 {
@@ -40,6 +46,14 @@
 	status = "okay";
 };
 
+&gpio5 {
+ 	wl-reg-on {
+		gpio-hog;
+		gpios = <29 GPIO_ACTIVE_HIGH>;
+		output-high;
+	};
+};
+
 &i2c1 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
@@ -131,6 +145,18 @@
 	};
 };
 
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie0>;
+	reset-gpio = <&gpio5 28 GPIO_ACTIVE_LOW>;
+	clocks = <&clk IMX8MQ_CLK_PCIE1_ROOT>,
+		 <&clk IMX8MQ_CLK_PCIE1_AUX>,
+		 <&clk IMX8MQ_CLK_PCIE1_PHY>,
+		 <&pcie0_refclk>;
+	clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
@@ -195,6 +221,14 @@
 		>;
 	};
 
+	pinctrl_pcie0: pcie0grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_I2C4_SCL_PCIE1_CLKREQ_B		0x76
+			MX8MQ_IOMUXC_UART4_TXD_GPIO5_IO29		0x16
+			MX8MQ_IOMUXC_UART4_RXD_GPIO5_IO28		0x16
+		>;
+	};
+
 	pinctrl_reg_usdhc2: regusdhc2grpgpio {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD2_RESET_B_GPIO2_IO19		0x41
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
