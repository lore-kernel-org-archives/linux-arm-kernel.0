Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FE7C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:28:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 629AF20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iMwF14Bk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBA0QM5b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629AF20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=p8sk2aQdPAyTWBLwfbkdcWqZK+g3DKJwoeLLwILD7i4=; b=iMwF14Bkw8neDZK2XmI5UFm3RY
	hbLfm7FrwiB2zxJsahk9WmCAOb9tkONohrlac0EDG2VyDDtXNq0FMRfNtMEnP0rFQsAr267S3DN76
	nLxf/c3n+1OVsugwt0GkyRBSH1CW1dAgZ/g7l1PS3VL5vmUqSJZWIn8F0H3iE0TLG4KCdQVgv61L5
	d9KgCcsITS6NpKGt8Lqno3Xv0bBWMrhCw+a+CULi1+T2oMyKm9GqtQwdg4EXZPws0qxcsmgmhSlw8
	237G8PIv0zpFoC9k+eVe7ltaSYuU0cuwCNRRgzR/+f0hwIAoiRQwBN7gyvRANAuojdmq2yL/yYoHc
	foIB/TNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTYLI-0006hT-Go; Sun, 02 Dec 2018 20:27:52 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTYID-00022x-Tt
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 20:25:04 +0000
Received: by mail-wr1-x443.google.com with SMTP id t27so10059514wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 12:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Ev11KvbTIafEFzHvK/2w3PWoFb4QTPWkxQGfu8Exr1E=;
 b=YBA0QM5bHjzWob/D0W/tHk1MbCX9NXJz81tt0ZeDV2ROseL8IGnfJesLORqiigRmIX
 5C0/CrX0dM1BwYLvk1SbEogcrpbiK7R2YB3muKswARmuopMS2YsSZiPX4p+oCSsfqYxi
 EcEWyobUsaokwJa/WsJ4XV7fNzoBHl06KZTCC8h7UfpR9UDj/OaVSG47mWlS8M/HGVFp
 TAWLoKqW5gGPAdf4KNbfQSlCVkWGdTi3su3YEpoOG8SKSbELG350QNql9ctkgA5gihEc
 T3CZhe3100B0IBNO1CFTw/+YMRipfJCDQFu3RbLZs5RoqK9sH/M8sIdTZGta8pdkT7ir
 Jw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Ev11KvbTIafEFzHvK/2w3PWoFb4QTPWkxQGfu8Exr1E=;
 b=bDNZhbZk6VwjS5Pq3FGsFYOemOuCb4vBlGRXNfketbA9Jb4u4VYwrY7M7od33sFDIA
 eiJmBALL3sHRZOGOTmjYt+0pssyiqdT3iUAiduIOjk3y3984HggzBf2Vznr8ZVRcftnV
 8Vc4spNxsBkn+yhOEP8mGiXtO2mj3TQuOMP1F32wr8gNEFcFBcbKx6Rtig52VZQNJDTq
 +1JwWpLuycNHh5DEbhrLdim7qQvYF+CHgc+xZea8znvIIQL1ZT9GKHD9jE36f6EcFuc/
 TPOKncMGLeY/7+ASgKsz5UUIy5POMXAn6qqIJ7PmrF+Qm95xwxbBo2ybd4W0Dff3Y8V8
 tjsg==
X-Gm-Message-State: AA+aEWaHU7Y+Pc0kWy/m0FlaEiqMcSOWRxif/7Mzf2+YX5RvAG2KSeVG
 VYATjrDAp4wWnQRz9/JanQQ=
X-Google-Smtp-Source: AFSGD/XiEbH3Gikq+fwiMtc7cBCK4gDJonKwensh7TilLpxcBMfBzvR7dLN1ku07/ybi3U+Spu+TXA==
X-Received: by 2002:a5d:68c3:: with SMTP id p3mr12119990wrw.34.1543782269920; 
 Sun, 02 Dec 2018 12:24:29 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
 by smtp.gmail.com with ESMTPSA id l3sm14451510wma.44.2018.12.02.12.24.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 02 Dec 2018 12:24:29 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH v6 11/17] pinctrl: sunxi: add support for suniv F1C100s (newer
 F-series SoCs)
Date: Sun,  2 Dec 2018 23:23:45 +0300
Message-Id: <668e78ee04771c491a91d1f2bd054b252782c4dd.1543781680.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543781680.git.mesihkilinc@gmail.com>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_122443_002821_7076E35A 
X-CRM114-Status: GOOD (  17.53  )
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
Cc: Mesih Kilinc <mesihkilinc@gmail.com>,
 Julian Calaby <julian.calaby@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Marc Zyngier <marc.zyngier@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Icenowy Zheng <icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The suniv F1C100s chip (several new F-series SoCs) of Allwinner has a
pin
controller like other SoCs from Allwinner.

Add support for it.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Patch applied to the pin control tree for v4.21.
---
 drivers/pinctrl/sunxi/Kconfig                 |   4 +
 drivers/pinctrl/sunxi/Makefile                |   1 +
 drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c | 416 ++++++++++++++++++++++++++
 3 files changed, 421 insertions(+)
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c

diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index 95282cd..a731fc9 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -6,6 +6,10 @@ config PINCTRL_SUNXI
 	select GENERIC_PINCONF
 	select GPIOLIB
 
+config PINCTRL_SUNIV_F1C100S
+	def_bool MACH_SUNIV
+	select PINCTRL_SUNXI
+
 config PINCTRL_SUN4I_A10
 	def_bool MACH_SUN4I || MACH_SUN7I || MACH_SUN8I
 	select PINCTRL_SUNXI
diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
index adb8443..fafcdae 100644
--- a/drivers/pinctrl/sunxi/Makefile
+++ b/drivers/pinctrl/sunxi/Makefile
@@ -3,6 +3,7 @@
 obj-y					+= pinctrl-sunxi.o
 
 # SoC Drivers
+obj-$(CONFIG_PINCTRL_SUNIV_F1C100S)	+= pinctrl-suniv-f1c100s.o
 obj-$(CONFIG_PINCTRL_SUN4I_A10)		+= pinctrl-sun4i-a10.o
 obj-$(CONFIG_PINCTRL_SUN5I)		+= pinctrl-sun5i.o
 obj-$(CONFIG_PINCTRL_SUN6I_A31)		+= pinctrl-sun6i-a31.o
diff --git a/drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c b/drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c
new file mode 100644
index 0000000..2801ca7
--- /dev/null
+++ b/drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c
@@ -0,0 +1,416 @@
+/*
+ * Allwinner new F-series F1C100s SoC (suniv) pinctrl driver.
+ *
+ * Copyright (C) 2018 Icenowy Zheng
+ *
+ * Icenowy Zheng <icenowy@aosc.io>
+ *
+ * Copyright (C) 2014 Jackie Hwang
+ *
+ * Jackie Hwang <huangshr@allwinnertech.com>
+ *
+ * Copyright (C) 2014 Chen-Yu Tsai
+ *
+ * Chen-Yu Tsai <wens@csie.org>
+ *
+ * Copyright (C) 2014 Maxime Ripard
+ *
+ * Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/pinctrl.h>
+
+#include "pinctrl-sunxi.h"
+static const struct sunxi_desc_pin suniv_f1c100s_pins[] = {
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "rtp"),		/* X1 */
+		  SUNXI_FUNCTION(0x4, "i2s"),		/* BCLK */
+		  SUNXI_FUNCTION(0x5, "uart1"),		/* RTS */
+		  SUNXI_FUNCTION(0x6, "spi1")),		/* CS */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "rtp"),		/* X2 */
+		  SUNXI_FUNCTION(0x4, "i2s"),		/* LRCK */
+		  SUNXI_FUNCTION(0x5, "uart1"),		/* CTS */
+		  SUNXI_FUNCTION(0x6, "spi1")),		/* MOSI */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "rtp"),		/* Y1 */
+		  SUNXI_FUNCTION(0x3, "pwm0"),		/* PWM0 */
+		  SUNXI_FUNCTION(0x4, "i2s"),		/* IN */
+		  SUNXI_FUNCTION(0x5, "uart1"),		/* RX */
+		  SUNXI_FUNCTION(0x6, "spi1")),		/* MOSI */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "rtp"),		/* Y2 */
+		  SUNXI_FUNCTION(0x3, "ir0"),		/* RX */
+		  SUNXI_FUNCTION(0x4, "i2s"),		/* OUT */
+		  SUNXI_FUNCTION(0x5, "uart1"),		/* TX */
+		  SUNXI_FUNCTION(0x6, "spi1")),		/* MISO */
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "dram"),		/* DQS0 */
+		  SUNXI_FUNCTION(0x3, "i2c1"),		/* SCK */
+		  SUNXI_FUNCTION(0x4, "i2s"),		/* BCLK */
+		  SUNXI_FUNCTION(0x5, "uart1"),		/* RTS */
+		  SUNXI_FUNCTION(0x6, "spi1")),		/* CS */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "dram"),		/* DQS1 */
+		  SUNXI_FUNCTION(0x3, "i2c1"),		/* SDA */
+		  SUNXI_FUNCTION(0x4, "i2s"),		/* LRCK */
+		  SUNXI_FUNCTION(0x5, "uart1"),		/* CTS */
+		  SUNXI_FUNCTION(0x6, "spi1")),		/* MOSI */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "dram"),		/* CKE */
+		  SUNXI_FUNCTION(0x3, "pwm0"),		/* PWM0 */
+		  SUNXI_FUNCTION(0x4, "i2s"),		/* IN */
+		  SUNXI_FUNCTION(0x5, "uart1"),		/* RX */
+		  SUNXI_FUNCTION(0x6, "spi1")),		/* CLK */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "dram"),		/* DDR_REF_D */
+		  SUNXI_FUNCTION(0x3, "ir0"),		/* RX */
+		  SUNXI_FUNCTION(0x4, "i2s"),		/* OUT */
+		  SUNXI_FUNCTION(0x5, "uart1"),		/* TX */
+		  SUNXI_FUNCTION(0x6, "spi1")),		/* MISO */
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 0),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "spi0"),		/* CLK */
+		  SUNXI_FUNCTION(0x3, "mmc1")),		/* CLK */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "spi0"),		/* CS */
+		  SUNXI_FUNCTION(0x3, "mmc1")),		/* CMD */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "spi0"),		/* MISO */
+		  SUNXI_FUNCTION(0x3, "mmc1")),		/* D0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "spi0"),		/* MOSI */
+		  SUNXI_FUNCTION(0x3, "uart0")),	/* TX */
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D2 */
+		  SUNXI_FUNCTION(0x3, "i2c0"),		/* SDA */
+		  SUNXI_FUNCTION(0x4, "rsb"),		/* SDA */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 0)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D3 */
+		  SUNXI_FUNCTION(0x3, "uart1"),		/* RTS */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 1)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D4*/
+		  SUNXI_FUNCTION(0x3, "uart1"),		/* CTS */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 2)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D5 */
+		  SUNXI_FUNCTION(0x3, "uart1"),		/* RX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 3)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D6 */
+		  SUNXI_FUNCTION(0x3, "uart1"),		/* TX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 4)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D7 */
+		  SUNXI_FUNCTION(0x3, "i2c1"),		/* SCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 5)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D10 */
+		  SUNXI_FUNCTION(0x3, "i2c1"),		/* SDA */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 6)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D11 */
+		  SUNXI_FUNCTION(0x3, "i2s"),		/* MCLK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 7)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 8),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D12 */
+		  SUNXI_FUNCTION(0x3, "i2s"),		/* BCLK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 8)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 9),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D13 */
+		  SUNXI_FUNCTION(0x3, "i2s"),		/* LRCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 9)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 10),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D14 */
+		  SUNXI_FUNCTION(0x3, "i2s"),		/* IN */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 10)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 11),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D15 */
+		  SUNXI_FUNCTION(0x3, "i2s"),		/* OUT */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 11)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 12),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D18 */
+		  SUNXI_FUNCTION(0x3, "i2c0"),		/* SCK */
+		  SUNXI_FUNCTION(0x4, "rsb"),		/* SCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 12)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 13),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D19 */
+		  SUNXI_FUNCTION(0x3, "uart2"),		/* TX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 13)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 14),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D20 */
+		  SUNXI_FUNCTION(0x3, "lvds1"),		/* RX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 14)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 15),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D21 */
+		  SUNXI_FUNCTION(0x3, "uart2"),		/* RTS */
+		  SUNXI_FUNCTION(0x4, "i2c2"),		/* SCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 15)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 16),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D22 */
+		  SUNXI_FUNCTION(0x3, "uart2"),		/* CTS */
+		  SUNXI_FUNCTION(0x4, "i2c2"),		/* SDA */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 16)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 17),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* D23 */
+		  SUNXI_FUNCTION(0x3, "spdif"),		/* OUT */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 17)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 18),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* CLK */
+		  SUNXI_FUNCTION(0x3, "spi0"),		/* CS */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 18)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 19),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* DE */
+		  SUNXI_FUNCTION(0x3, "spi0"),		/* MOSI */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 19)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 20),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* HYSNC */
+		  SUNXI_FUNCTION(0x3, "spi0"),		/* CLK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 20)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 21),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "lcd"),		/* VSYNC */
+		  SUNXI_FUNCTION(0x3, "spi0"),		/* MISO */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 21)),
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi"),		/* HSYNC */
+		  SUNXI_FUNCTION(0x3, "lcd"),		/* D0 */
+		  SUNXI_FUNCTION(0x4, "i2c2"),		/* SCK */
+		  SUNXI_FUNCTION(0x5, "uart0"),		/* RX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 0)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi"),		/* VSYNC */
+		  SUNXI_FUNCTION(0x3, "lcd"),		/* D1 */
+		  SUNXI_FUNCTION(0x4, "i2c2"),		/* SDA */
+		  SUNXI_FUNCTION(0x5, "uart0"),		/* TX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 1)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi"),		/* PCLK */
+		  SUNXI_FUNCTION(0x3, "lcd"),		/* D8 */
+		  SUNXI_FUNCTION(0x4, "clk"),		/* OUT */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 2)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi"),		/* D0 */
+		  SUNXI_FUNCTION(0x3, "lcd"),		/* D9 */
+		  SUNXI_FUNCTION(0x4, "i2s"),		/* BCLK */
+		  SUNXI_FUNCTION(0x5, "rsb"),		/* SCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 3)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi"),		/* D1 */
+		  SUNXI_FUNCTION(0x3, "lcd"),		/* D16 */
+		  SUNXI_FUNCTION(0x4, "i2s"),		/* LRCK */
+		  SUNXI_FUNCTION(0x5, "rsb"),		/* SDA */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 4)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi"),		/* D2 */
+		  SUNXI_FUNCTION(0x3, "lcd"),		/* D17 */
+		  SUNXI_FUNCTION(0x4, "i2s"),		/* IN */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 5)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi"),		/* D3 */
+		  SUNXI_FUNCTION(0x3, "pwm1"),		/* PWM1 */
+		  SUNXI_FUNCTION(0x4, "i2s"),		/* OUT */
+		  SUNXI_FUNCTION(0x5, "spdif"),		/* OUT */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 6)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi"),		/* D4 */
+		  SUNXI_FUNCTION(0x3, "uart2"),		/* TX */
+		  SUNXI_FUNCTION(0x4, "spi1"),		/* CS */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 7)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 8),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi"),		/* D5 */
+		  SUNXI_FUNCTION(0x3, "uart2"),		/* RX */
+		  SUNXI_FUNCTION(0x4, "spi1"),		/* MOSI */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 8)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 9),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi"),		/* D6 */
+		  SUNXI_FUNCTION(0x3, "uart2"),		/* RTS */
+		  SUNXI_FUNCTION(0x4, "spi1"),		/* CLK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 9)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 10),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "csi"),		/* D7 */
+		  SUNXI_FUNCTION(0x3, "uart2"),		/* CTS */
+		  SUNXI_FUNCTION(0x4, "spi1"),		/* MISO */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 10)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 11),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "clk0"),		/* OUT */
+		  SUNXI_FUNCTION(0x3, "i2c0"),		/* SCK */
+		  SUNXI_FUNCTION(0x4, "ir"),		/* RX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 11)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 12),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "i2s"),		/* MCLK */
+		  SUNXI_FUNCTION(0x3, "i2c0"),		/* SDA */
+		  SUNXI_FUNCTION(0x4, "pwm0"),		/* PWM0 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 12)),
+
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc0"),		/* D1 */
+		  SUNXI_FUNCTION(0x3, "jtag"),		/* MS */
+		  SUNXI_FUNCTION(0x4, "ir0"),		/* MS */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 0)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc0"),		/* D0 */
+		  SUNXI_FUNCTION(0x3, "dgb0"),		/* DI */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 1)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc0"),		/* CLK */
+		  SUNXI_FUNCTION(0x3, "uart0"),		/* TX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 2)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc0"),		/* CMD */
+		  SUNXI_FUNCTION(0x3, "jtag"),		/* DO */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 3)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc0"),		/* D3 */
+		  SUNXI_FUNCTION(0x3, "uart0"),		/* TX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 4)),
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc0"),		/* D2 */
+		  SUNXI_FUNCTION(0x3, "jtag"),		/* CK */
+		  SUNXI_FUNCTION(0x4, "pwm1"),		/* PWM1 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 5)),
+};
+
+static const struct sunxi_pinctrl_desc suniv_f1c100s_pinctrl_data = {
+	.pins = suniv_f1c100s_pins,
+	.npins = ARRAY_SIZE(suniv_f1c100s_pins),
+	.irq_banks = 3,
+};
+
+static int suniv_pinctrl_probe(struct platform_device *pdev)
+{
+	return sunxi_pinctrl_init(pdev,
+				  &suniv_f1c100s_pinctrl_data);
+}
+
+static const struct of_device_id suniv_f1c100s_pinctrl_match[] = {
+	{ .compatible = "allwinner,suniv-f1c100s-pinctrl", },
+	{}
+};
+
+static struct platform_driver suniv_f1c100s_pinctrl_driver = {
+	.probe	= suniv_pinctrl_probe,
+	.driver	= {
+		.name		= "suniv-f1c100s-pinctrl",
+		.of_match_table	= suniv_f1c100s_pinctrl_match,
+	},
+};
+builtin_platform_driver(suniv_f1c100s_pinctrl_driver);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
