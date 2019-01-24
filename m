Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5D6C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:17:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79C8B217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RgkJPSV8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OWieCc9W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="J/w9SOD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C8B217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AI9wmIf6Ljkci4fBnJL7tXhaPndZNWVykUquoLZOci4=; b=RgkJPSV8CU7PF9
	2xu89+Bg98A1xMAIvRvZ95874basoITfkdM1hy3uYBDG/jW2Nclzdx7vPvKZRRFu96PulJZfKOFTc
	Ptevyqkttl1/PHxM/9ppFqAb0c7UNoUgDH6rP4toeSW0YxKxKBasKNdEU6t6g2GYJpVKqKMmYRMPP
	hK3/X+TCV22GsI61ol16hhELyZC5IPmuZOu43t8Em2xZoQ4yIjPvZsZSLcDgqGzVYLG7WdhurCruA
	/NllS4mUy+oWr8kzxlbAKsckM4riDI7TrDPtmLMkW9OwwJugDY4Rzg4QepLgGGYU42DZb5KKWbrXf
	qg0nxCnHiqiRKTAquUZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmlRP-0002wo-4c; Thu, 24 Jan 2019 20:17:35 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmlPi-0000m3-Qg
 for linux-arm-kernel@bombadil.infradead.org; Thu, 24 Jan 2019 20:15:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=viWBxNLdmx5hdu4igYEdtrD9NNJ9I5QzFtzjPLFp1Zg=; b=OWieCc9Wf3APQPfW0TJsSb228H
 609s0Km0g865flhn0vvKfyMrhlvB7Hc6Vk0NYcwxDXuojYHVSpb8UTy9tgFsaVUL4xBax/bv8ZcAi
 Cynns1Kc8OyW1C2vGe1bjv8nZg/IMaN9YZYsUPswG8BPf/t4o4dYcjq4iWUbxLPtIRDC0LOdhBzj7
 VOsCW1lxQmWmaRbJlftM8JUmSv3jI2iaA+3P15GZWl+FX+4LZvADCbJ0xMmWKR/bFnpK5FiJ7CaRT
 6v8a70fSESDJIPirfPys4YMKUN1Z1AZDgfVcf7IvZfpazy1Of15EVSunisMLYh1i0ftnlkeIuAjMq
 ZO53QNmQ==;
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmlBk-00025H-9V
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 20:01:28 +0000
Received: by mail-pg1-x543.google.com with SMTP id m1so3126836pgq.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 12:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=viWBxNLdmx5hdu4igYEdtrD9NNJ9I5QzFtzjPLFp1Zg=;
 b=J/w9SOD6T4AdblpX5nwobBrlOLEkBmczgfC3EY9vW9U5isU0HSHZCQg04H+zLA8Amt
 ByrPzdOucoh0P1rugWULznnraWoSn7rsrzqZud/+tHUIuLElI4DOx6twc5+bMHFdvdIq
 Okztp/hQTyVgLiSWJe+rS0nY8Sw6pUepTXGKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=viWBxNLdmx5hdu4igYEdtrD9NNJ9I5QzFtzjPLFp1Zg=;
 b=rhXTqpxKSQS1gDWzcOvQgK/bkwU7nptVtfUFU8lEAwB4r93TFtoeSTKv6F+MVXUvJM
 V4d9sfeZR6LFpEmkp0B5dgpfxE1iXpKjfbuLxO0t/nMOeMaFhVxMbkSoLiTF88n6rEid
 ghz20UeR44lHBJlFLgmGhCuPRujxvDFQxMIpHQc700lCaWShUbhQXJDMMRgJwuWHhR7T
 j6hN0+lziFQ0zuxFVDrJ77dTXylcdIiB8AmxA/EGolqQkfrmpZjmatVuFE3C8ETsAoJL
 mI8sXROSshLkgcZdts0IGm1A+b0xF5bx4fBxEV2xun1x4iICJ9F13hDBLvj5CARKZcL0
 C/+A==
X-Gm-Message-State: AJcUukfSvSLFFptKYVGJjvd5EXxRivWCOb0ljoEI4ZII9mp5Kh6gG+yP
 k0VFod6bvX52o2d2+mWqe8IPbA==
X-Google-Smtp-Source: ALg8bN5A1xFJznW/r2sFKdv7KvB++13U9DACtd4l4I48QlIcvSwutN75lpAJXn4lrCOTyle7kzJtzA==
X-Received: by 2002:a63:e950:: with SMTP id q16mr7215772pgj.138.1548360082660; 
 Thu, 24 Jan 2019 12:01:22 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.12.01.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 12:01:22 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v6 22/22] arm64: dts: allwinner: a64-amarula-relic: Add
 Techstar TS8550B MIPI-DSI panel
Date: Fri, 25 Jan 2019 01:29:00 +0530
Message-Id: <20190124195900.22620-23-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124195900.22620-1-jagan@amarulasolutions.com>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_200124_716463_9CDAED8C 
X-CRM114-Status: GOOD (  14.48  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
 Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Amarula A64-Relic board by default bound with Techstar TS8550B
MIPI-DSI panel, add support for it.

DSI panel connected via board DSI port with,
- DLDO2 as VCC supply
- DLDO2 as IOVCC supply
- DLDO1 as VCC-DSI supply
- PD24 gpio for reset pin
- PD23 gpio for backlight enable pin

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../allwinner/sun50i-a64-amarula-relic.dts    | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
index f180c841ac3c..703055f2a4fb 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
@@ -9,6 +9,7 @@
 #include "sun50i-a64.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "Amarula A64-Relic";
@@ -18,6 +19,14 @@
 		serial0 = &uart0;
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <1 2 4 8 16 32 64 128 512>;
+		default-brightness-level = <2>;
+		enable-gpios = <&pio 3 23 GPIO_ACTIVE_HIGH>; /* LCD-BL-EN: PD23 */
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -83,6 +92,30 @@
 	};
 };
 
+&de {
+	status = "okay";
+};
+
+&dphy {
+	status = "okay";
+};
+
+&dsi {
+	vcc-dsi-supply = <&reg_dldo1>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	panel@0 {
+		compatible = "techstar,ts8550b", "sitronix,st7701";
+		reg = <0>;
+		VCC-supply = <&reg_dldo2>;
+		IOVCC-supply = <&reg_dldo2>;
+		reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
+		backlight = <&backlight>;
+	};
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -160,6 +193,12 @@
 	status = "okay";
 };
 
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm_pin>;
+	status = "okay";
+};
+
 &r_rsb {
 	status = "okay";
 
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
