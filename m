Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BA4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 15:30:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AB9720854
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 15:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d3jkKctY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMCeWlRQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB9720854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qAdRHzEXdCAlEi9mrnij29rgkrnFkJ0OpbeEiO0DC94=; b=d3jkKctYWIbNkW
	rxS+/epYSnWk4zOoAb/dLKaW/2Pv0OQCERhTZuGAEkLNoUxjrMatnlgw3tadgp3UyhMddz/HwVA33
	svmgIWC6fTD6y/4gYoGJ+ACyLj88X1GQ4rE6RyuY3mug1M9ZgjSCrrO/6rkmJ+Z2GfGrsayx0AiYb
	BjCkx7D/LGH3ioYcudaLPWIMRuRIQVnIBIeJjyhWIyyAtSI8jTEwKc8rVnOBqnX0Hz4KwCmzrmNuf
	4vF0sAhg44q7a2nbGV8RDOoD2CxEOI1T6k+N6h0PiQ/u49H0qt9aiZrb+F58YRLuO7Bdel/iqQUy6
	3wbrEeObVOGxDnZq4ScQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gihis-00032H-Ex; Sun, 13 Jan 2019 15:30:50 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gihie-0002l9-LR; Sun, 13 Jan 2019 15:30:38 +0000
Received: by mail-pg1-x52d.google.com with SMTP id j10so8405615pga.1;
 Sun, 13 Jan 2019 07:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2wWJQP3qlm0dkufRBC92pArEv03qZqPjGRD3HuPdEs4=;
 b=oMCeWlRQ2QQqDoLvuxXcKMQqQxJ3rnJyehBfMkQnCGpd75xUohqetHPmz7/hOvPjvv
 Bo7wMBLAvepX1ovx6F1Xf/iaRHKFWP7vcCT+pYtux3u4X+kwJzRybT7UeKCXSpM9b+R0
 Th2TtbFEFnZfDuVDw1YZ9mQFoUPjIZfhN7VQ7ULzlY2U20C670jKRlDCxzcGstdoFnEa
 +l2msuHLFuBXsnWUMyB4HJrgSOltWMH7TFE1t+LY3z1qDa3a7UAEHBDc2YCxOXyoO5yA
 Zw+3qFAvyDsfXZItEmCRDWTlHNyg90P052Aio2IonMceuP79RDFmsD+E1QdobbScvpES
 6Fxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2wWJQP3qlm0dkufRBC92pArEv03qZqPjGRD3HuPdEs4=;
 b=WYG51O1Zp9Qml5GwDbwd++Tb9gnpWWCxKcw7np9qusmMU6tQZZcjTksKMI1vK1oBNp
 ZPReYSTS056fTIUFXg20oyOWgSOQEuGbPU314iAmfVwtwyoaRy8yTgh1ue4fRTqkX2l7
 yi/qpq3UYmA1OBsmrWS73s4uSuSEOwbRDLEQujgExUfQqcyhwgzdQ0BD5lSX4BuhJCqx
 6sxr0CRFMIGPh98O+auTMueViTKW7nSbx5uTXhHcNVtkf2yPiBQB9jUaACj2vwCYSIOt
 1R0VefGQ2cdNBQjh2H0dv0iRNqBlaisFGtwkQKqrTFGFtg1x/eZWU2pjEAFb7zdq+Zx1
 f1NA==
X-Gm-Message-State: AJcUukdMUo4GAolBxFZbQobLvNtiCpV49L0FqQV+Q3Tjv0fJT66AE6xD
 fuORISUDuHHTgvRpfg5yVQM=
X-Google-Smtp-Source: ALg8bN6EAWVUOAov0iU9P6gxA9IZF0kFm2UfrixriBbFO3+1uZIiRssPAD7nEeGcG9U3UZuYMfA8Dg==
X-Received: by 2002:a62:4e16:: with SMTP id c22mr21686745pfb.167.1547393435804; 
 Sun, 13 Jan 2019 07:30:35 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.105])
 by smtp.gmail.com with ESMTPSA id r187sm265107745pfc.63.2019.01.13.07.30.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 13 Jan 2019 07:30:35 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PatchV2 2/2] ARM64: dts: meson-gxbb-odroidc2: Fix usb phy reset
 warning
Date: Sun, 13 Jan 2019 15:30:22 +0000
Message-Id: <20190113153022.5040-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190113153022.5040-1-linux.amoon@gmail.com>
References: <20190113153022.5040-1-linux.amoon@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_073036_826208_92303055 
X-CRM114-Status: UNSURE (   9.36  )
X-CRM114-Notice: Please train this message.
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Rob Herring <robh+dt@kernel.org>,
 Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add missing vin-supply node 5.0V regulator setting to power
to usb ports, changes help fix the usb reset warning.

[  795.380156] usb 1-1.2: reset high-speed USB device number 3 using dwc2
[  798.356073] usb 1-1.2: reset high-speed USB device number 3 using dwc2
[  801.331999] usb 1-1.2: reset high-speed USB device number 3 using dwc2
[  804.307919] usb 1-1.2: reset high-speed USB device number 3 using dwc2
[  807.283844] usb 1-1.2: reset high-speed USB device number 3 using dwc2

Fixes: 5a0803bd5ae (ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes)
Tested-by: Kevin Hilman <khilman@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Rebased on Kevin's amlogic/v5.0/fixes branch
Changes from patch v1 [0] https://lore.kernel.org/patchwork/patch/1031243/
- Split the patch into two part: new patch
- Fix the commit message
- Added Tested by Kevin Hilman
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 25a36d117183..a947b46bfaa8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -28,6 +28,13 @@
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
+	p5v0: regulator-p5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "P5V0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
 	usb_otg_pwr: regulator-usb-pwrs {
 		compatible = "regulator-fixed";
 
@@ -36,6 +43,8 @@
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 
+		vin-supply = <&p5v0>;
+
 		gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
