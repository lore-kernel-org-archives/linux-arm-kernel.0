Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97972C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:04:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 613A121855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lGgxTFkd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pDm2CF9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613A121855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iKfUFKeZyBhl2VpbRgzU8pnIhWKv5quG6448NAUAsy8=; b=lGgxTFkds6wcot
	UW4U9mN01+jaUm7EkeqC+Jr8OedzARrxmjuEwIsGNMXUBYdBHcyZoi30iHiRt1ICPL1fyUaiB8Dkj
	C+twq5PeynYBmbMq/sc+ClhX2iNL551fo54gNsJYWBoC+hlrj6ID5dvhmXgrVRHBbGoIVUBQaL73e
	Eqg3ay2i26ypn9V7BSNDRi7KskVy21Gs8oFL/L6S81lEtFhLN4+4u5hAGGhW87PlIrqx7RemqbgqC
	1IfeI49a9J0hQ4TXn0l2IhLaHBEZMdy2LiBU7pzO6Pn631XLWswg2YVM1W5nYX8GBryeSRy1iFRoq
	KeoiGjuCb9XPqq+tcFrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmlES-0003sC-F9; Thu, 24 Jan 2019 20:04:12 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmlBD-00015s-Vt
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 20:01:01 +0000
Received: by mail-pg1-x541.google.com with SMTP id j10so3141706pga.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 12:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=soUQzKMmxVLy4tGsbhoyX6SR8F/5vCDS2D75UzCy/p4=;
 b=pDm2CF9FEByve8QNGu0gfhjfwth1MWBhy/p3CB7KTTVbi8SWcZlwqxMz3Jj0FOQwJE
 hTiVNLIfFGYpkS/HEdtIdT3c4ofBZ2JFDLKeB0m54ERQiBG7t/2NK0InkdpBxqE0Qjoc
 BBEJPEQVYcjNZPvTxK8Qmvh3NG4ptucQ5FzRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=soUQzKMmxVLy4tGsbhoyX6SR8F/5vCDS2D75UzCy/p4=;
 b=bxsuKSPbFGqYaNGQs1hB4tE8gwR7aKSXapx+0z9XVXW2xPGd/NDkzo7lk9TG/mW8U5
 74Da4Wk3cgxW/ffFvSGXVuWv+hZNjqms035oq26r4MKgDmKUjxNYQGqdcbch8CcGFXvs
 AjM5EnfPQe5wEqF24ma0yZiG6wwHmRLyj836UFG7CvlyPgs3iHxfeJfUayogvlnSaT7z
 UWtKj7052G+NBxf2oRqULTtKX+PxFL+o/ZvRmqZ3/l9R0Uxgvg1pI22+J+2W7+cXAR3M
 u/cluoGRjIg0VLhkq2LkCmlHcv3tYRUJlUjUMiBpq2DjXrXwHyY8xHu0J9Z867r5TtYd
 GwSA==
X-Gm-Message-State: AJcUukcaKY/weSTF7alSl1C/2IECjB1YfF0LYcBcZNV2jID/w4nUYd0K
 Rm3zspNa9/pzt6FXQWsVKERz5g==
X-Google-Smtp-Source: ALg8bN7V/q3qfGMQdiguUqaCp/nOEgSFeiBDxo6NyBW78ZZ3lW3tUgTBZc4LEb1cspn/NZH8O7Mt/Q==
X-Received: by 2002:a63:9501:: with SMTP id p1mr7201961pgd.149.1548360051292; 
 Thu, 24 Jan 2019 12:00:51 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.12.00.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 12:00:50 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [DO NOT MERGE] [PATCH v6 17/22] arm64: allwinner: a64: pine64-lts:
 Enable Feiyang FY07024DI26A30-D DSI panel
Date: Fri, 25 Jan 2019 01:28:55 +0530
Message-Id: <20190124195900.22620-18-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124195900.22620-1-jagan@amarulasolutions.com>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_120052_558407_3488D3FF 
X-CRM114-Status: GOOD (  11.77  )
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

Feiyang FY07024DI26A30-D MIPI_DSI panel is desiged to attach with
DSI connector on pine64 boards, enable the same for pine64 LTS.

DSI panel connected via board DSI port with,
- DC1SW as AVDD supply
- DLDO2 as DVDD supply
- DLDO1 as VCC-DSI supply
- PD24 gpio for reset pin
- PH10 gpio for backlight enable pin

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../dts/allwinner/sun50i-a64-pine64-lts.dts   | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
index 72d6961dc312..341b1c035604 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
@@ -5,9 +5,48 @@
  */
 
 #include "sun50i-a64-sopine-baseboard.dts"
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "Pine64 LTS";
 	compatible = "pine64,pine64-lts", "allwinner,sun50i-r18",
 		     "allwinner,sun50i-a64";
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&r_pwm 0 50000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <1 2 4 8 16 32 64 128 512>;
+		default-brightness-level = <8>;
+		enable-gpios = <&pio 7 10 GPIO_ACTIVE_HIGH>; /* LCD-BL-EN: PH10 */
+	};
+};
+
+&de {
+	status = "okay";
+};
+
+&dphy {
+	status = "okay";
+};
+
+&dsi {
+	vcc-dsi-supply = <&reg_dldo1>;		/* VCC3V3-DSI */
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	panel@0 {
+		compatible = "feiyang,fy07024di26a30d";
+		reg = <0>;
+		avdd-supply = <&reg_dc1sw>;	/* VCC-LCD */
+		dvdd-supply = <&reg_dldo2>;	/* VCC-MIPI */
+		reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
+		backlight = <&backlight>;
+	};
+};
+
+&r_pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&r_pwm_pin>;
+	status = "okay";
 };
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
