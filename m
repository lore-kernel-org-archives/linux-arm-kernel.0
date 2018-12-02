Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD22C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:19:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4317620892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UdxoOQkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4317620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OpS4qKOgbTGKaY4DK7X2CVq1O+sy0t3UVxHDfzU4rs8=; b=UdxoOQkWbOx8hB
	5bEtYAiDzz9UuiA+GzB7nuyT6dZUZ/YD+GdpcQhsbj7I0xhNa1zXveW3uH4nscoi5EM+1byEhZjVB
	aXNI/NF7TQdke9TYHTcKl04EDCpubur5zeYZ0Wd7pqt5OrkT9VKD5d46PzmKs7O5/983yc1DKGGJX
	YhDwnKqQFmJUUyDJGx63QB3/stdxIz8SHJbY4JVIDyo2XySuNYpIDS9uaE0vTU5v1N4N2YDot/xVv
	rY6ctiqS1AmLyzfpVgfzmWqR/v8QeMBTw1jw/ZvF+WTXyaMyjpOertjIpto8xKmDusQ/xv85uFWgN
	OY0a0z5rWkz1GA1Y28WA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTZ9A-0008BM-0k; Sun, 02 Dec 2018 21:19:24 +0000
Received: from mail-qk1-f193.google.com ([209.85.222.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZ8o-0007gi-Tf
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 21:19:21 +0000
Received: by mail-qk1-f193.google.com with SMTP id q1so6199729qkf.13
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 13:18:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:organization:content-transfer-encoding;
 bh=kF8o7Epwdu0dEA3UUb5PAzGLGYppW/4YWqYMcTCaLOc=;
 b=Jc6Qpg30HWOoBtprkjY0xzyTDe7mbORTZ3mmvTLJyuRIvrf5DX+ttFQGD3ajfyVFp1
 40IUPMRr5l3qSkJ8LsgdJQwGpzT2SlurvkKz+aGIB198s+3oy6h7QqGApOO9PYFhdZ5M
 MrzSuU1DOiOoix8UZQ7jQW7dqdLcXNfL2TMFRpixG9OWmOPw9s3pn2He3kAG9XwaQU8Z
 1XVMzsRCO9MwoQpHGZY/AgBLuSCyH7sq6s6KHjjEPear9zrx4+Ajx8pmbR3+I7i90ujE
 RSxwbHe7IkY62baAPADr/KtnCnTBeu7D0kpNZN7yIIv+CxVJwyN5jKIDy47P4UnRfAm7
 4lXQ==
X-Gm-Message-State: AA+aEWb1/rX0iqijOyirOiyM86DwKWp1doxbfd2VHKOJJjdfiDem6EbP
 DlT1ewYsP5RoINEGZAcV+7JoVMTH
X-Google-Smtp-Source: AFSGD/UvyLZGz/r+GwgCgbwSAHh35VTrREwcL+2T/yJFhdNoVAZk5XrnD1vtFiC2YwPta1Dx4LwIew==
X-Received: by 2002:a37:4289:: with SMTP id p131mr12678332qka.3.1543785531314; 
 Sun, 02 Dec 2018 13:18:51 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
 by smtp.gmail.com with ESMTPSA id j38sm10247759qtj.72.2018.12.02.13.18.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 02 Dec 2018 13:18:50 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation);
 Sun, 02 Dec 2018 19:18:44 -0200
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/5] ARM: dts: imx6ul-pico-hobbit: Extend peripherals support
Date: Sun,  2 Dec 2018 19:18:08 -0200
Message-Id: <20181202211809.11621-5-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181202211809.11621-1-otavio@ossystems.com.br>
References: <20181202211809.11621-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_131903_083575_3A4EFCE4 
X-CRM114-Status: GOOD (  12.66  )
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

This adds following peripherals support:

 - ADC
 - GPIO LED
 - GPIOs

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/imx6ul-pico-hobbit.dts | 30 ++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-pico-hobbit.dts b/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
index 8656ccbb5a06..f2dd6945e98c 100644
--- a/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
+++ b/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
@@ -14,6 +14,8 @@
 
 	leds {
 		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
 
 		led {
 			label = "gpio-led";
@@ -58,6 +60,12 @@
 &i2c3 {
 	status = "okay";
 
+	adc081c: adc@50 {
+		compatible = "ti,adc081c";
+		reg = <0x50>;
+		vref-supply = <&reg_3p3v>;
+	};
+
 	polytouch: touchscreen@38 {
 		compatible = "edt,edt-ft5x06";
 		reg = <0x38>;
@@ -68,3 +76,25 @@
 		touchscreen-size-y = <480>;
 	};
 };
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_VSYNC__GPIO4_IO19		0x10b0
+			MX6UL_PAD_CSI_DATA00__GPIO4_IO21	0x10b0
+			MX6UL_PAD_CSI_DATA01__GPIO4_IO22	0x10b0
+			MX6UL_PAD_CSI_DATA02__GPIO4_IO23	0x10b0
+			MX6UL_PAD_UART1_CTS_B__GPIO1_IO18	0x10b0
+			MX6UL_PAD_SNVS_TAMPER2__GPIO5_IO02	0x10b0
+		>;
+	};
+
+	pinctrl_gpio_leds: gpioledsgrp {
+		fsl,pins = <
+			MX6UL_PAD_UART4_RX_DATA__GPIO1_IO29	0x10b0
+		>;
+	};
+};
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
