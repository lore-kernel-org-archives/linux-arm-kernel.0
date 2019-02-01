Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AD2C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:59:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E336218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NAeHXhj7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nj9B61bS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="M1VoXvE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E336218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+CFFxBtJ2RjMNkskMfK4xb5Dxoiwx/Pfiim4o6CLzuM=; b=NAeHXhj7kBL+Bq
	F5rRJSEz77PKMmNJQbOEi8WOZCGdBIY2L5d1ZSSyxpHTr4POI6wMWyKAr9hDB02VM/6BuAY7Yrefg
	pPObG2Odo9VxNx0CucTWu70JSJ3KcLkpWFYpRycXgLM1TJSCMBQQE8UG8utg20lw+Z+a5rPTqFsYB
	uXWJfY4W9OfAqlsdYjmM4R4nypGmpbYO2sIQ36hHuOJ1rXSg1JJN91CGD28Rw5K152tipl9qoi47V
	rEIwa3RPKrFMc/JA3eHh7KROPAr1gIka0aIkh1hhdtttBXiDaI4uwynizmX44qHoP8ZV8nikG/6mt
	/e2rDjomxdnfq9iMslGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpbE3-00084P-2y; Fri, 01 Feb 2019 15:59:31 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpbDu-0007GL-GK
 for linux-arm-kernel@bombadil.infradead.org; Fri, 01 Feb 2019 15:59:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=87uAT10+TXiQ8RUQObJ13rsTWKA95oUQQrz1NYnUkkc=; b=nj9B61bSp9UgmaWuJJmlTnVrJ7
 ifx52geukE1HaLxIL4MaO6bcVv6U2n41W3IwFtdF7qRbnsgdAiqlCEUaj2xyotsHYhXziUuutm2lM
 ZkXQ2go4rT1XhG9GoACv7EdR2WPXZlrakmS0oJOFK7GIci7gJAjXnxs7YqD5hjYNyGvhr9EJe+Hl1
 s5wOq/XzdFnMY45B7EG7LjUFRFb90ERf6H8Zy6JKcWSAaTLr9/1s6xc9HUshf+GV7f/XZ6f10oD6c
 LaSx5AkHEfCbNiJio2SJ1qEl6Sd1VPA7wngS7jdLXgpv/8f/6BaiqajX4xHmWzftqqYd0DZXT+PfF
 RycH9HXg==;
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpayU-0005Kk-Ac
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 15:43:27 +0000
Received: by mail-lj1-x243.google.com with SMTP id x85-v6so6211851ljb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 07:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=87uAT10+TXiQ8RUQObJ13rsTWKA95oUQQrz1NYnUkkc=;
 b=M1VoXvE1Szk5NA7GJTJMsRcCil+0rnZt7ypHyOVEdwDVa4dZSQ+kppG5DCm4N0JTOE
 GT62Ww17WS3ODFsfZmD48Jz54ZXKIU3Kse/Ckp2XT1JRwZtGhS5ltyuC9bMky2+s35ei
 /GjtCGUkPWOp4cXCDJ3h5p5wDVeHg0LndW2LM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=87uAT10+TXiQ8RUQObJ13rsTWKA95oUQQrz1NYnUkkc=;
 b=kizFiRd6HisGn2N1ox/deydkMa3kHsQz4XUAKLd5n5t6twPYr3zh1i9Tn3q3k+bGSg
 1I7rHakQIJwBc/Q8yCkavsKvvc6yKLHeTp/I73PNUeBntDk+lkvzCEN1KpgGgWFg0blv
 5vqFspft/aQ+raHGhkPu3z/vpn9qEoquzC7D5QzeTPXZfEc8lSeR8YISAn0YI/c7j252
 AllFZyJo0CCs7/6//2bAtWxcKZOjDnoPgc/M0suLLsfTyMxjgLovbEO6rgnr6lQEhx0q
 +riA7LL7GQLECor+n5pbczxcbbWOW6KIqLQ5Knm12lJR3l40gCKvkZrhzKSCZMkkonGe
 2k1g==
X-Gm-Message-State: AJcUukeOlf9HcT5s1lyiixVp5hIlvXydCkrQhQv5HCxAvUGKIFk6+zU6
 y0krnYWPzt08vy/wgE7H1MESsw==
X-Google-Smtp-Source: ALg8bN4Q3v+ELltV8yrXXTQiDUCRBw/HFQzvbq5ATN7sdZy1/CP4lI5ssgFWBSQmOj1gE+dKktvsug==
X-Received: by 2002:a2e:5dd9:: with SMTP id
 v86-v6mr31776125lje.86.1549035804241; 
 Fri, 01 Feb 2019 07:43:24 -0800 (PST)
Received: from localhost.localdomain ([217.76.202.68])
 by smtp.gmail.com with ESMTPSA id i13-v6sm1305712ljg.82.2019.02.01.07.43.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Feb 2019 07:43:23 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v7 23/23] arm64: dts: allwinner: a64-amarula-relic: Add
 Techstar TS8550B MIPI-DSI panel
Date: Fri,  1 Feb 2019 21:12:32 +0530
Message-Id: <20190201154232.10505-24-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190201154232.10505-1-jagan@amarulasolutions.com>
References: <20190201154232.10505-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_154326_370588_39462DBD 
X-CRM114-Status: GOOD (  14.77  )
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
index df0de0772d6b..a5a0a650b589 100644
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
