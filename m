Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB68C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:26:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A9821473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A3urjJBI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Esy4jdEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A9821473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iVaDNnIboN2YoOgvam9+tvuCshkk79oM08E+PpKlajU=; b=A3urjJBIvWhvek
	POgeWauWy3SRoub3gY1tWcoEfdK8bNfKHDptbs/trz080MtzVl/ZkMj0QthDIDT1CBp61JzDRzogr
	l8hV4j0e2zpHQ8d3lv3EnlyvG6OO9VN2PfDU6LlgkklbfQ1QMSLwkRqHGpXENeUjD3BJ+pSMpG2ME
	iBT0YGsQGSZWMKcsAVMqktGjJ5T14qpCJWZMbXT/lJwCt6ADgaxQawPOUg8tce/b443K+2dRd8P1N
	qRtcKJy3NxWuo0EoyOYhCHow3EfJaCGcIxcM8F38cy/vazq1+OH/8o+Q2WKCWHB4Wqhv8+xfUYQak
	x9YaY7DM1ygtuEUa8N9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goQaX-0002O3-VH; Tue, 29 Jan 2019 10:25:53 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goQaN-0002Fj-Rz; Tue, 29 Jan 2019 10:25:49 +0000
Received: by mail-pf1-x444.google.com with SMTP id r136so9461695pfc.6;
 Tue, 29 Jan 2019 02:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jFWGUl7z7nhwQNXynQb9n7uk9a+BMTH31BB1HMIVpnY=;
 b=Esy4jdELg3IUjWKjkOkBTrFtfTK6XK7o7SY17QtpxSCDy7rUMyYUJ7QZIRH2U3S17E
 SM5Qk+NbOABCq5Ic+xxn7k0aianbOfgjw3DpOZwM9B9mIZV2oc3/l6QhDH+0M7rkWiUs
 V91SJ1JKmNsM+9e3XR150xCEM8OLKxXsCWc6NzKwOS1aFfxL2BcNhbZSCLSQagwHm8E3
 CFIPoGNCGgz8ey65N6AnSQUA16PzZdwP5fBeKcoL9X6M2fsY2F8C1pdT9efk+MfFP5YO
 yeajrSoy0mdu8GKA1EUTP3uQy+pa2DLvV8jTmTIlXUf+Npw/s9uy4Zz8hvMH3pHEK/Lt
 6HDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jFWGUl7z7nhwQNXynQb9n7uk9a+BMTH31BB1HMIVpnY=;
 b=gQTFEjU6jFvokh7Kbx4f3Ot6i6awiKb9M6GZ9hjA1mTbiG3kUQWW5Pyc9Pzxm8qPfW
 Taip/WWoSP/XoXHv8Nzok7hklHHbLDvrqv8I3912mvZkKfi3hIrtiOtZ/DF4HYniWfUw
 GgJbKDaaYMnCD3WjSbODuhQY+SKJ1ssTvwhG7ix3xY0ie1oyMStWulgn+8c9yVxJgzam
 m3XdxLkE2nj5yFDwrR4Px0dT00Es3+22lBq53QuF328MZbchcQA8Ak1+KYrDsrprHGjJ
 amK/QSlY22qjfMXbJNzRmQstdVOYZgJmNDdr7HiSvPwSL0sgLyqronDw3gGdKLkuq6sn
 stEA==
X-Gm-Message-State: AJcUukfzCrCe2Gc+g9QTKH/6KdcCeRq7ksAiOIPSgNYu0nkv7TZHnXL+
 zjx/LclOHses7yHUlSAMxsk=
X-Google-Smtp-Source: ALg8bN76tj21xfEaQOzkqF3IXWsMe04uN8p/Ac2pYKS5tK/MRnEeakbWBAV9AfRk/iq1ZLX3DDrqDw==
X-Received: by 2002:a63:e21:: with SMTP id d33mr23070880pgl.272.1548757541849; 
 Tue, 29 Jan 2019 02:25:41 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.149])
 by smtp.gmail.com with ESMTPSA id d21sm47744462pfo.162.2019.01.29.02.25.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 02:25:41 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv3 1/2] ARM64: dts: meson-gxbb-odroidc2: Fix usb phy reset
 warning
Date: Tue, 29 Jan 2019 10:25:20 +0000
Message-Id: <20190129102521.4141-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129102521.4141-1-linux.amoon@gmail.com>
References: <20190129102521.4141-1-linux.amoon@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_022544_463884_E1DFA46E 
X-CRM114-Status: UNSURE (   9.13  )
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
 Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>
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
changes from prevoius

 regulator                      use open bypass  opmode voltage current     min     max
---------------------------------------------------------------------------------------
 regulator-dummy                  5    4      0 unknown     0mV     0mA     0mV     0mV
    c9100000.usb                  1                                 0mA     0mV     0mV
    c9100000.usb                  1                                 0mA     0mV     0mV
    c9000000.usb                  1                                 0mA     0mV     0mV
    c9000000.usb                  1                                 0mA     0mV     0mV
 P5V0                             1    1      0 unknown  5000mV     0mA  5000mV  5000mV
    USB_OTG_PWR                   4    2      0 unknown  5000mV     0mA  5000mV  5000mV
       phy-c0000020.phy.1         2                                 0mA     0mV     0mV
       phy-c0000000.phy.0         2                                 0mA     0mV     0mV
--
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 2e1cd5e3a246..da729ed00408 100644
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
