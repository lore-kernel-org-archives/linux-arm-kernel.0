Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2F4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:00:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E699E2146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g1TRm3fA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oCCz9++K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E699E2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RIqEtCBoiZRkHQ4nT1o36ufOpLFBkANNy+AkD7076XI=; b=g1TRm3fAAEv81d
	1cIryKeaMhgUTvJxnuiCgnV6zk1uIM9eZ36cY3Wp+TEtHvS/JZ24wOTWmdzMCjw+YWYQvYMIkmNgq
	OIre6vOUE5SEIjGmrlKvAA9mQo49DyXSpIqauzG1tBYUK4EoM9yPula3CJ6UCMo2j3B9mLro0HQ0i
	GH/qCJ7np/iq+hXdixkcH0EZzbCMmjHlNJsxssr20Y40SubfaAWtktWUSEh7nkjwFw2ZzzkBlQZVW
	JwihKkjhjDgtcC4YtMd/MX9MoCUj8H/g50QrVnEXm5L8ycujANn9orK4xLvwRF39ZbjZt4QYW0Sxr
	eiOQzCh5hDn27GmtLwVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwHBO-0006Hb-15; Wed, 20 Feb 2019 02:00:22 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwHAJ-0003pC-Sp
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 01:59:18 +0000
Received: by mail-pg1-x542.google.com with SMTP id r11so11024605pgp.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 17:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Jwm+KkdHrEe85gK4fZx+9EbP9yhxtXPFuxUoUQNkykM=;
 b=oCCz9++KIXrXxGe44eo4uh9dFcF9rpDdxH2r6rk5zxhL3dNtmhx1jx0hyXVFR+Ju0u
 3q0w9bNBaN1bBjT6j/Hw2HiltBDkz9hgeAcV9JyaAT0/5WjcUW66gg/+lG7CZFSxlFRl
 eWYai+vTGDRIM3aZuBjQsE2/rMvzYD6twQcaIjlFi6lIKk56Qk8LA3Lb2jZv76rCtx6b
 HEb30xgXFD5PzogemGFwr2QQlxmUAv9zN/+9YGbn28YgGVV95bLak5moN9vCIKFMvZ0S
 fHms6FMQpDzZB1kzqKUEq2Gi0RUIdrnIW2ZSNWx78xNZN3Qjb3RFZ8c5WwAvD0vQ7acq
 kmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Jwm+KkdHrEe85gK4fZx+9EbP9yhxtXPFuxUoUQNkykM=;
 b=Ql7jF6wiBcenPqpcSbyzzRtJxJip25cTUyTC45G3+n13T6VwJxXYdsIKa6L3A+Gd5C
 rFEdk9EpIHBrzIXLPf0fIoKo39xk9Ffmc7BAlnQtsA0gdG/eqZ6kMCYIfxk1Ri4e7Iue
 Q66gGXiwcues7hK7YAA9xtGNDE7kcyldvlFscNLgDvFljRK6s+Ay8nhsE9cRfjV8IY+m
 0RxB7omH7WClbst3AcloxXeynHxi+pNH+IhlupMJAelYcWzwCFfNkTH5RhODuH+hjrrc
 GuoyDSYjKneGAj+mJKAVOnflVhgGMrFsdGYboENVSSnKrEHTwbp/Kf43hq4iwU8ObGZA
 KOGA==
X-Gm-Message-State: AHQUAuY5pvD6Ero8SgpAdRFGVzMJJSAXmkR5c97bWstTEhwmEw+07KqN
 EPIoMGquGo1bGzvZse/NMF0=
X-Google-Smtp-Source: AHgI3Ib5lEsSNe/UyDMMEY4uSPNkIh2WhcCBqxlOiWYIZGdqT4uGt06eVHivRfoY3zQtQ1WlzvCPGQ==
X-Received: by 2002:a63:6ac5:: with SMTP id
 f188mr27039781pgc.165.1550627955010; 
 Tue, 19 Feb 2019 17:59:15 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id h3sm2562525pgv.38.2019.02.19.17.59.13
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 19 Feb 2019 17:59:14 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v3 5/5] arm64: dts: imx8mq-evk: Enable PCIE0 interface
Date: Tue, 19 Feb 2019 17:58:57 -0800
Message-Id: <20190220015857.7136-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220015857.7136-1-andrew.smirnov@gmail.com>
References: <20190220015857.7136-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_175916_210204_FE565CAE 
X-CRM114-Status: GOOD (  12.50  )
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
 linux-arm-kernel@lists.infradead.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-imx@nxp.com, Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
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
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 42 ++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 64acccc4bfcb..226aeb9791a5 100644
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
@@ -40,6 +46,17 @@
 	status = "okay";
 };
 
+&gpio5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wifi_reset>;
+
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
@@ -131,6 +148,18 @@
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
@@ -195,6 +224,13 @@
 		>;
 	};
 
+	pinctrl_pcie0: pcie0grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_I2C4_SCL_PCIE1_CLKREQ_B		0x76
+			MX8MQ_IOMUXC_UART4_RXD_GPIO5_IO28		0x16
+		>;
+	};
+
 	pinctrl_reg_usdhc2: regusdhc2grpgpio {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD2_RESET_B_GPIO2_IO19		0x41
@@ -300,4 +336,10 @@
 			MX8MQ_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0xc6
 		>;
 	};
+
+	pinctrl_wifi_reset: wifiresetgrp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_UART4_TXD_GPIO5_IO29		0x16
+		>;
+	};
 };
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
