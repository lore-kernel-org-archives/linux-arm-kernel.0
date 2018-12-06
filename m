Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5772BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:25:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 265A520989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H4gA2afG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qoZ6tq3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 265A520989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8j5ijQQYe42UoG68aNBJEom75y0exXPLTc/VzJSb2JY=; b=H4gA2afGLk0xlD
	5C38wn4oHe66K7AwYAtsGY890WwvHPofEFmYdmOCPZho0k3rv11w/5uAoVATMx+zep6rr6SFQfsOJ
	Q6U5V7u0Y4HB+cZUypBY6cLagR/SFqO6m4tM8Dc/fI9QRNqx6Tie8I/FaXNsm+WrP5xwoX6k3CpBt
	nfj9b7eywfleUpRrym9lnuKvA4ISIw/kdigc4v230yAynLCxFdLw16Cxx1dPmO4gDKpcQ47jG1RAy
	IkvNPPWcZixQbyydjFDhXCkV/1eVEi6raZUHtJ+2nHC6jcWv5pbjg9Yrd6mL9W33c3+qqDIL6sp5t
	YMmupHCjyp7Uivn05p6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUqqn-00020t-UU; Thu, 06 Dec 2018 10:25:45 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUqqe-0000ah-RD
 for linux-arm-kernel@bombadil.infradead.org; Thu, 06 Dec 2018 10:25:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BXcoAYV0VGEgzVpj2DLs9vLGGu6/9WBGwYXVxCkYZTI=; b=qoZ6tq3ZRhupFY7cZV9iESqeG3
 zQ1toPi99MECF5nX1kZ72cI2U7qxVM+H0AEdk5brIqt+G6+TBRKCCCxzaYQuXsU1JyIafRGRFw50y
 Got3QikSFatgmc+aeHUCWlotbfQXppL4ErLXBk4q3X1dZE4nDDIT8iwWwzeX+Jd5eLw4wJw9ueuWT
 6wUAUju2FPjG/1o+VxM+uRIjYUZD65ZDk8zAfjP7A0l646PcjQ6M6FQYzxOYycJ/LyX5uKkD2DUXU
 SQmQ7Hr2+wKq/E70U5VN0GZZHsBMF8+4+upsq1Dcbm3oJ/xmbdJwbZG7v1bmRYnoLkuWefNsAWRde
 oscRBOhg==;
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUqbz-0006GS-Hj
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 10:10:29 +0000
Received: by mail-qt1-f193.google.com with SMTP id d18so25607222qto.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 02:10:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:organization:content-transfer-encoding;
 bh=BXcoAYV0VGEgzVpj2DLs9vLGGu6/9WBGwYXVxCkYZTI=;
 b=egDqa98jm73a89YE3g2lVL/iqC80oaPDKfEZ66hayCniEZaQnPSD14tD5lWCYTFEcp
 0mc+ITBWwyXzKwTuSrrYfNjkTPEgJOgradwGwA4f1t8dkjvK1YhxWLDGkihCnjBKkGXk
 ED623K3WlWcncQmdkiAx433ilG7nUEih0UjD0kqStoMO0jBcMDsUGk43zoBZYKtmdl2Z
 YVE3RE7PBwGqcNr/ZM+0JSE9oddn4pCHdF7FiC+MK6A7MHqck/0mNb2DAW9GQaVvHLcj
 c5yy809cajA2tsyD7e+effJdIJa5w7WH2sh//7nhu97asANmbdGSi+hb4edj5wM9bU7N
 LXLA==
X-Gm-Message-State: AA+aEWZ7HbP+ZTOBYzkGA3JFHz5lEZ0W9ztPTvOnR53azb9FHLg5DjZZ
 Y0nTKqWWeu2gAe/6D03SjHKpKepR
X-Google-Smtp-Source: AFSGD/XYL7Yx+n4trZrdJjoFLvOreMRbRZsSjVlI7vQEuWAJSdN5qkJ35QldjPAGNb1KVJtwYtmsaA==
X-Received: by 2002:a0c:a045:: with SMTP id b63mr27160920qva.164.1544091015573; 
 Thu, 06 Dec 2018 02:10:15 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
 by smtp.gmail.com with ESMTPSA id 5sm14552824qtw.50.2018.12.06.02.10.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 02:10:14 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation);
 Thu, 06 Dec 2018 08:10:08 -0200
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 8/9] ARM: dts: imx7d-pico-pi: Extend peripherals support
Date: Thu,  6 Dec 2018 08:09:04 -0200
Message-Id: <20181206100905.15053-9-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206100905.15053-1-otavio@ossystems.com.br>
References: <20181206100905.15053-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_101027_574464_448F191B 
X-CRM114-Status: GOOD (  13.75  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Otavio Salvador <otavio@ossystems.com.br>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Fabio Estevam <festevam@gmail.com>

This adds following peripherals for the imx7d-pico-pi as:

 - LED
 - Touchscreen
 - GPIO

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

Changes in v2: None

 arch/arm/boot/dts/imx7d-pico-pi.dts | 56 +++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-pico-pi.dts b/arch/arm/boot/dts/imx7d-pico-pi.dts
index 039c17066fe0..70bea95c06d8 100644
--- a/arch/arm/boot/dts/imx7d-pico-pi.dts
+++ b/arch/arm/boot/dts/imx7d-pico-pi.dts
@@ -8,6 +8,17 @@
 	model = "TechNexion PICO-IMX7D Board and PI baseboard";
 	compatible = "technexion,imx7d-pico-pi", "fsl,imx7d";
 
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+
+		led {
+			label = "gpio-led";
+			gpios = <&gpio2 6 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
 	sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "imx7-sgtl5000";
@@ -35,3 +46,48 @@
 		VDDIO-supply = <&reg_vref_1v8>;
 	};
 };
+
+&i2c4 {
+	polytouch: touchscreen@38 {
+		compatible = "edt,edt-ft5x06";
+		reg = <0x38>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_touchscreen>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio2 4 GPIO_ACTIVE_LOW>;
+		touchscreen-size-x = <800>;
+		touchscreen-size-y = <480>;
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX7D_PAD_EPDC_DATA00__GPIO2_IO0		0x14
+			MX7D_PAD_EPDC_DATA01__GPIO2_IO1		0x14
+			MX7D_PAD_EPDC_DATA02__GPIO2_IO2		0x14
+			MX7D_PAD_EPDC_DATA03__GPIO2_IO3		0x14
+			MX7D_PAD_EPDC_DATA05__GPIO2_IO5		0x14
+			MX7D_PAD_EPDC_DATA12__GPIO2_IO12	0x14
+			MX7D_PAD_EPDC_DATA07__GPIO2_IO7		0x14
+		>;
+	};
+
+	pinctrl_gpio_leds: gpioledsgrp {
+		fsl,pins = <
+			MX7D_PAD_EPDC_DATA06__GPIO2_IO6		0x14
+		>;
+	};
+
+	pinctrl_touchscreen: touchscreengrp {
+		fsl,pins = <
+			MX7D_PAD_EPDC_DATA04__GPIO2_IO4		0x14
+			MX7D_PAD_EPDC_DATA13__GPIO2_IO13	0x14
+		>;
+	};
+
+};
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
