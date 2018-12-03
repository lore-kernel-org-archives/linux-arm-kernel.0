Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3617C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:17:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5870220851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hWfLz+P6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jlRr82vu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5870220851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uIBqCPWlbd5UzoV6sktqMdztiaTxvQOGg/Pc26SDzLo=; b=hWfLz+P6AOvcLd
	cj4dix8i/NciUvMo4SWkgYBvKJDd7oOzR6B68H9oO9a8U1rJLHQowGvHEIk2WoHE5yeNjRUsOl6Sl
	15amkC0LfEtprFOpdERCcdwvBODg66PyZlvQDDdJZkkgOz8fZwazlLM6wObF11O7hVqTQv+FsikCO
	6Kily9MYfHitxzK2HjKafjC/oowwY3H1xoQa0Cs/4nrgKPqyJP7kgkiomv2RKSg6eb+0YR9FgBG20
	JO1wk2BVvq4ZdDzYV736No3xgy5hBHo6aWIaUwpAj4e4hBwEla6+CaBXgdAF9vO90leos40Q7LI/V
	91+Ny3vqBXAGLiQB+urA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTlHh-0000Qb-U1; Mon, 03 Dec 2018 10:17:01 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTlGq-00082H-7e
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 10:16:10 +0000
Received: by mail-wm1-x342.google.com with SMTP id z18so5120151wmc.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 02:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Rcmd27QWJ4xmppTvwllwY6JeAM/zSw/3F56Tx3gVCeQ=;
 b=jlRr82vuqkK0mmH/legr7UuT2SR17Izjlh427s+xfWa7DmENHl9PTVPMRQg+2yZaVu
 t61q4G+qv5aM+Yho3fsirfrh5a4+/c6/1eUWio8l1K6LoIMCJRu4ILsS+8pk983poCaF
 QIbIl9qeY5dAErs7Q4rfb9Wl9XjygP+uAHQRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Rcmd27QWJ4xmppTvwllwY6JeAM/zSw/3F56Tx3gVCeQ=;
 b=RbQbBv957+enYtmFhFUeRZsj0WZrQ9pGoJinbbcHwNAjn+B0YWHwe1tFN0IYCoc0iE
 IxIZwrgPRgXbKfWyQnWuRuiWVNxB1DE2BLGAQMr9KhnuHJa+HsegY4t3t4EmO6oEHvWr
 VqZVxZCrV2jKbVczXPq/e8AQBY+3T5jUJU5e3DX7HaX/E1YFLN/xAv+9Lq5HpwkdhcRe
 hsd9Sd2mfZvhIyiG0GCEr4fyYXxzODtT6PTaCH9nNLLo5ZUJQph2M1CMr/sJaDi8HjvX
 DwE0eK3Alzcw0C52P2o5VQcd2fLS809V/IG+o3gALhMR5caDug+VbWCJF682MK0bs/DB
 hh4w==
X-Gm-Message-State: AA+aEWbfID1MVhVwT6/So0fdluf3SFo7CjXy0iNjG/PiYY7g9x8nnKAP
 u6qjVhnO7yfkwi6cgyP4+vGknA==
X-Google-Smtp-Source: AFSGD/XtKq3es9+911MegfWg8xs36aHwaMEywK0bx9cUOLdLgmGC8tOga7v8E9RG6igPmIUh54Mt9g==
X-Received: by 2002:a1c:27c6:: with SMTP id n189mr7546256wmn.108.1543832165929; 
 Mon, 03 Dec 2018 02:16:05 -0800 (PST)
Received: from localhost.localdomain (conf.hotelmediterraneo.com.
 [2.228.78.71])
 by smtp.gmail.com with ESMTPSA id f192sm5832158wmd.12.2018.12.03.02.16.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 02:16:05 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
 linux-sunxi@googlegroups.com
Subject: [PATCH 9/9] arm64: dts: allwinner: a64-amarula-relic: Add GT5663 CTP
 node
Date: Mon,  3 Dec 2018 15:45:47 +0530
Message-Id: <20181203101547.16835-9-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181203101547.16835-1-jagan@amarulasolutions.com>
References: <20181203101547.16835-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_021608_302736_C1C259FC 
X-CRM114-Status: GOOD (  13.46  )
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
Cc: Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add Goodix GT5663 capacitive touch controller node on
Amarula A64-Relic board.

The CTP connected to board with,
- SDA, SCK from i2c1
- GPIO-LD0 as vcc supply
- PH4 gpio as interrupt pin
- PH8 gpio as reset pin
- X and Y axis are inverted

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../allwinner/sun50i-a64-amarula-relic.dts    | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
index 9ac6d773188b..913fcdff828e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
@@ -88,6 +88,28 @@
 	status = "okay";
 };
 
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+	status = "okay";
+
+	touchscreen@5d {
+		compatible = "goodix,gt5663";
+		reg = <0x5d>;
+		vcc-supply = <&reg_ldo_io0>;			/* VCC-CTP: GPIO0-LDO */
+		interrupt-parent = <&pio>;
+		interrupts = <7 4 IRQ_TYPE_EDGE_FALLING>;
+		irq-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>;	/* CTP-INT: PH4 */
+		reset-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>;	/* CTP-RST: PH8 */
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+	};
+};
+
+&i2c1_pins {
+	bias-pull-up;
+};
+
 &mmc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
@@ -251,6 +273,13 @@
 	regulator-name = "vdd-cpus";
 };
 
+&reg_ldo_io0 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-ctp";
+	status = "okay";
+};
+
 &reg_rtc_ldo {
 	regulator-name = "vcc-rtc";
 };
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
