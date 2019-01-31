Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409E1C282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:45:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7F21218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lFw45Kxb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPiPlB3p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F21218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HeJkKGkkOzPtsXG79ye+2op7mec1xpb+323vehktZYw=; b=lFw45KxbOeEF4o
	JcyOuyR3nVYYsFPu+ZRTudqAEz7+tSIrlWdkSDlWVwYbjIs+5+jXcJs3P9SS9b90OZpDMR5hNY2s0
	gII+euVU1mcsxDUpujFm03XPN+s6c3I+FjtsQRmzRgo7ZD0OxFwM7uM+QCSJdUWZNaA2HIrBH+Bkh
	49O+TVRhLBRATOjpSBP9LQDeik7KoyrSRQQjYrTxSarqu50YS+IfxKKfM5khjCHcQHBVvd5o/Z7Yw
	XobesUy5vf4FomGO/AN4E6CZXAmKZKk7sm0bTK16vyZq0qnOjDLHlbmdU9O+VRZ8QHQy53hMBGiZr
	JRDpS2b6srQ/hXXx01yQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpJD5-0004h4-JK; Thu, 31 Jan 2019 20:45:19 +0000
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpJBk-00030L-9w
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 20:44:01 +0000
Received: by mail-pg1-x52f.google.com with SMTP id n2so1867974pgm.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 12:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Pe73Lkv9Hk1MIlu+vYdLxJuU5C6xW3dASTYFyCiskD4=;
 b=jPiPlB3p/Oqrg47KjEhCFhXAG8TiR6N886MNsavLSEzUXvSYOnGRtOSzbitWg1KWln
 VFm4fKp3yU5z/fG9mcgtdfY3zIOY1oBkBKO7SmCZBcGV0BkUrM6rhwUSAxcyuELh6VpQ
 1c/gVs5s/z0LJbqOgyJCko5/nC6h/UZvpGzSlBt12abu0vQtlv4CnoYZYGy9/5Une2Sf
 BWcxDGClguJZyJNm0ZP6nMyFDOE6dWUuOQxRdvZx19iQAVpxcCrElDlTmuNkBktFx6et
 g9sRKXQuYKorXiPbgJMNgMWc4dJNwWqd/cLsofJGiGBHWQ+iDnqlPcZ2YIsfOJx6zpYb
 wkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Pe73Lkv9Hk1MIlu+vYdLxJuU5C6xW3dASTYFyCiskD4=;
 b=WNmHeYmaMtuV00s92yeTZPPCfddoiaTHlnGbcoVFQPeEqrxlUofxSg2wPs9dSK43gi
 h9ZVIpaRrEw5R6eIDfLkWF+AIa7Mw1wJTzcEQnnuYMxfCjcO3jT8Qrlz/GQrKlkIxeiN
 YPYB6GYKgYqQWtECWTKdI/3XKd6ePAI1dbdhLDfoXQfySYrH7j40DoLgm2ikFVPrY7eL
 wVL7XNsTJieBLxRc12hWBJqQPEuwxAmoE758ZNGgrBnLL+8joZrAYS2Jm7uOPxs84Q4b
 VUT4cNjtZqnyI2PtfVkrRXnI21Dw/CT/v1lYS6NlLBXp+SpI/c63iKIaD58mGGoHBRoc
 ssdg==
X-Gm-Message-State: AJcUukezv1XF1nvY2ctbfkkv2cwl95YE0ICXaKYjN4dllWTbIq9M5Lzl
 RCdxdwnFsJQDWCjWjOO3sq4=
X-Google-Smtp-Source: ALg8bN7Jk+/LzgF96bF0YT/T4azzt9XYAoB+stjNRKBvew00nwglQCtd5BejlQqGz9xblLRNrJYdnQ==
X-Received: by 2002:a62:8096:: with SMTP id
 j144mr36830521pfd.140.1548967435145; 
 Thu, 31 Jan 2019 12:43:55 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id s190sm7272034pfb.103.2019.01.31.12.43.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 31 Jan 2019 12:43:54 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [RFC 5/5] arm64: dts: imx8mq-evk: Enable PCIE0 interface
Date: Thu, 31 Jan 2019 12:43:33 -0800
Message-Id: <20190131204333.31846-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131204333.31846-1-andrew.smirnov@gmail.com>
References: <20190131204333.31846-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_124356_697404_F198F267 
X-CRM114-Status: GOOD (  11.64  )
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
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 23 ++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 64acccc4bfcb..6c7af6c0c9a6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -40,6 +40,14 @@
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
@@ -131,6 +139,13 @@
 	};
 };
 
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie0>;
+	reset-gpio = <&gpio5 28 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
@@ -195,6 +210,14 @@
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
