Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB65C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:09:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74BFC20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hR1aHjXG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="E/h89nvU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74BFC20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AW+jbeXQyNa3DW+asXXBJBM+pHT/rqnBrZfO1x2z17Q=; b=hR1aHjXGDpC+sQ
	9KjGpNgmcStvZIMhfPsF/sYEGHKOo8m/yh1joRYtMFmr8GH5bx1SmWOVrnWBG5v7I0HbdswtiNF2t
	JAc0sCPbe5rZDJg0jG6akX2zSanl8u2bPpgbUpwGSUfNGt1sgERLdzTVmbnog8qb48YKvSRinb/zR
	OrIKbaq4OLjoXVlaZarp/N1syLVvd8/b9Oxw8NWFl3g5rlI4g4ABceBYe5SalDblsJ/lIlaJvNd/O
	s6WF9Vv8QjWI07rlQQ5wCawb0zoYo/otWy3Ht7kc3FlXTV+RJB+rTs5UxG02BfXEn4RXyfh97Tzj4
	RjoRHqoK6+srRB8sBoow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTZvZ-0006Lj-Oe; Sun, 02 Dec 2018 22:09:25 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZvI-00065J-Gm; Sun, 02 Dec 2018 22:09:10 +0000
Received: by mail-wm1-x344.google.com with SMTP id r11-v6so3843969wmb.2;
 Sun, 02 Dec 2018 14:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zHtdvDVx24SLhUypHX0kK+/ZWuDmjIU2gQoRWk4834s=;
 b=E/h89nvU8lw3sdwp6W+y6Zsp74FgV1n5rUpxUqg5wWF9B8YKk2yoTw3rgJsYgWOJZT
 8vZrsQwcYb94Q7lq9Me5MlRr0YaX4m8mpiY25aW7Noc4pL7ZAWhQ2JzeE2fpxghOx4H9
 +Y0WH4fK4EQ+BGr3JDNuXoVhtLBp3U3UTCD7ySouo3UgNh3fugfTfyuXymKyHaUasPWv
 cp5oxWUSHa/9HKAf7oLku7NXWbWJMcE7zH+yDCyM1wC0wAQu+VvfMP7GIfd+MZmZNWV/
 PCutIX4ec50xD8F0qT0pZSZ87/S/CbGwnhubuZsk/uGMERRbN4Kf/9yfoJGi9vo1x07U
 bgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zHtdvDVx24SLhUypHX0kK+/ZWuDmjIU2gQoRWk4834s=;
 b=fKJ3HlKGdfpCYrga01Kfcjksv+OKulfg1dSy01i3j7SCyoqY5npwvVLpxzqPmK19Ja
 NleOSRLUmaCOq96cYjB7iavi5+CJ84StRvdZVKS1OFFkxCVWyDUct22ghBfVaOhF+54c
 fAFi+wJ/m/pyJeIZdTTtdQ7GrPbYVH6mlyYZ3VzNJN4L4Ia4gLKRyptINvMvDVuFfseL
 mzXMUR/4BVs4FrMVfyoQn0FYHh1F1JOFeAiaiHC+q4cj4V670AmHSN2V2k9cklRR/RaO
 0GrkStYr1epF75u4d4h7/d5Dvr09ZN4byimznuNAyHKBTRR2wnikzq1YxNWCvsH5RNOl
 787Q==
X-Gm-Message-State: AA+aEWaq1DYUuM2xls4ikRdEnbZZClXUalUQQXUeApQlEo9+oFhCrqGT
 1n8uAkkzEgXPlPgD1iL5YiIjZ2fd
X-Google-Smtp-Source: AFSGD/WpkSuTcKDOl97vaFsiaoW80zWcVnhYsrAjx4ImDCfJtrJeJbiOtrcthn//xIz0UTw2Lt0R9Q==
X-Received: by 2002:a1c:7511:: with SMTP id o17mr2817869wmc.42.1543788538947; 
 Sun, 02 Dec 2018 14:08:58 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73FBA00B1CC0EB38CD20A4E.dip0.t-ipconnect.de.
 [2003:dc:d73f:ba00:b1cc:eb3:8cd2:a4e])
 by smtp.googlemail.com with ESMTPSA id m15sm8503351wrr.95.2018.12.02.14.08.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 02 Dec 2018 14:08:58 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, linux-rtc@vger.kernel.org,
 alexandre.belloni@bootlin.com, a.zummo@towertech.it
Subject: [PATCH v5 2/2] rtc: support for the Amlogic Meson RTC
Date: Sun,  2 Dec 2018 23:08:47 +0100
Message-Id: <20181202220847.24364-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181202220847.24364-1-martin.blumenstingl@googlemail.com>
References: <20181202220847.24364-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_140908_623709_660FB75C 
X-CRM114-Status: GOOD (  26.05  )
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
 ben.dooks@codethink.co.uk, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, ccaione@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add support for the RTC block on the 32-bit Amlogic Meson6, Meson8,
Meson8b and Meson8m2 SoCs.

The RTC is split in to two parts, which are both managed by this driver:
- the AHB front end
- and a simple serial connection to the actual registers

The RTC_COUNTER register which holds the time is 32-bits wide.

There are four 32-bit wide (in total: 16 bytes) "regmem" registers which
are exposed using nvmem. On Amlogic's 3.10 kernel this is used to store
data which needs to survive a suspend / resume cycle.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
[resurrected Ben's patches after 2 years]
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/rtc/Kconfig     |  11 ++
 drivers/rtc/Makefile    |   1 +
 drivers/rtc/rtc-meson.c | 409 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 421 insertions(+)
 create mode 100644 drivers/rtc/rtc-meson.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index a819ef07b7ec..d5d0e3affdc6 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1285,6 +1285,17 @@ config RTC_DRV_IMXDI
 	   This driver can also be built as a module, if so, the module
 	   will be called "rtc-imxdi".
 
+config RTC_DRV_MESON
+	tristate "Amlogic Meson RTC"
+	depends on (ARM && ARCH_MESON) || COMPILE_TEST
+	select REGMAP_MMIO
+	help
+	   Support for the RTC block on the Amlogic Meson6, Meson8, Meson8b
+	   and Meson8m2 SoCs.
+
+	   This driver can also be built as a module, if so, the module
+	   will be called "rtc-meson".
+
 config RTC_DRV_OMAP
 	tristate "TI OMAP Real Time Clock"
 	depends on ARCH_OMAP || ARCH_DAVINCI || COMPILE_TEST
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 290c1730fb0a..3b088e75149d 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -99,6 +99,7 @@ obj-$(CONFIG_RTC_DRV_MAX8997)	+= rtc-max8997.o
 obj-$(CONFIG_RTC_DRV_MAX8998)	+= rtc-max8998.o
 obj-$(CONFIG_RTC_DRV_MC13XXX)	+= rtc-mc13xxx.o
 obj-$(CONFIG_RTC_DRV_MCP795)	+= rtc-mcp795.o
+obj-$(CONFIG_RTC_DRV_MESON)	+= rtc-meson.o
 obj-$(CONFIG_RTC_DRV_MOXART)	+= rtc-moxart.o
 obj-$(CONFIG_RTC_DRV_MPC5121)	+= rtc-mpc5121.o
 obj-$(CONFIG_RTC_DRV_MSM6242)	+= rtc-msm6242.o
diff --git a/drivers/rtc/rtc-meson.c b/drivers/rtc/rtc-meson.c
new file mode 100644
index 000000000000..09d6849b804a
--- /dev/null
+++ b/drivers/rtc/rtc-meson.c
@@ -0,0 +1,409 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RTC driver for the interal RTC block in the Amlogic Meson6, Meson8,
+ * Meson8b and Meson8m2 SoCs.
+ *
+ * The RTC is split in to two parts, the AHB front end and a simple serial
+ * connection to the actual registers. This driver manages both parts.
+ *
+ * Copyright (c) 2018 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+ * Copyright (c) 2015 Ben Dooks <ben.dooks@codethink.co.uk> for Codethink Ltd
+ * Based on origin by Carlo Caione <carlo@endlessm.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
+#include <linux/rtc.h>
+
+/* registers accessed from cpu bus */
+#define RTC_ADDR0				0x00
+	#define RTC_ADDR0_LINE_SCLK		BIT(0)
+	#define RTC_ADDR0_LINE_SEN		BIT(1)
+	#define RTC_ADDR0_LINE_SDI		BIT(2)
+	#define RTC_ADDR0_START_SER		BIT(17)
+	#define RTC_ADDR0_WAIT_SER		BIT(22)
+	#define RTC_ADDR0_DATA			GENMASK(31, 24)
+
+#define RTC_ADDR1				0x04
+	#define RTC_ADDR1_SDO			BIT(0)
+	#define RTC_ADDR1_S_READY		BIT(1)
+
+#define RTC_ADDR2				0x08
+#define RTC_ADDR3				0x0c
+
+#define RTC_REG4				0x10
+	#define RTC_REG4_STATIC_VALUE		GENMASK(7, 0)
+
+/* rtc registers accessed via rtc-serial interface */
+#define RTC_COUNTER		(0)
+#define RTC_SEC_ADJ		(2)
+#define RTC_REGMEM_0		(4)
+#define RTC_REGMEM_1		(5)
+#define RTC_REGMEM_2		(6)
+#define RTC_REGMEM_3		(7)
+
+#define RTC_ADDR_BITS		(3)	/* number of address bits to send */
+#define RTC_DATA_BITS		(32)	/* number of data bits to tx/rx */
+
+#define MESON_STATIC_BIAS_CUR	(0x5 << 1)
+#define MESON_STATIC_VOLTAGE	(0x3 << 11)
+#define MESON_STATIC_DEFAULT    (MESON_STATIC_BIAS_CUR | MESON_STATIC_VOLTAGE)
+
+struct meson_rtc {
+	struct rtc_device	*rtc;		/* rtc device we created */
+	struct device		*dev;		/* device we bound from */
+	struct reset_control	*reset;		/* reset source */
+	struct regulator	*vdd;		/* voltage input */
+	struct regmap		*peripheral;	/* peripheral registers */
+	struct regmap		*serial;	/* serial registers */
+};
+
+static const struct regmap_config meson_rtc_peripheral_regmap_config = {
+	.name		= "peripheral-registers",
+	.reg_bits	= 8,
+	.val_bits	= 32,
+	.reg_stride	= 4,
+	.max_register	= RTC_REG4,
+	.fast_io	= true,
+};
+
+/* RTC front-end serialiser controls */
+
+static void meson_rtc_sclk_pulse(struct meson_rtc *rtc)
+{
+	udelay(5);
+	regmap_update_bits(rtc->peripheral, RTC_ADDR0, RTC_ADDR0_LINE_SCLK, 0);
+	udelay(5);
+	regmap_update_bits(rtc->peripheral, RTC_ADDR0, RTC_ADDR0_LINE_SCLK,
+			   RTC_ADDR0_LINE_SCLK);
+}
+
+static void meson_rtc_send_bit(struct meson_rtc *rtc, unsigned int bit)
+{
+	regmap_update_bits(rtc->peripheral, RTC_ADDR0, RTC_ADDR0_LINE_SDI,
+			   bit ? RTC_ADDR0_LINE_SDI : 0);
+	meson_rtc_sclk_pulse(rtc);
+}
+
+static void meson_rtc_send_bits(struct meson_rtc *rtc, u32 data,
+				unsigned int nr)
+{
+	u32 bit = 1 << (nr - 1);
+
+	while (bit) {
+		meson_rtc_send_bit(rtc, data & bit);
+		bit >>= 1;
+	}
+}
+
+static void meson_rtc_set_dir(struct meson_rtc *rtc, u32 mode)
+{
+	regmap_update_bits(rtc->peripheral, RTC_ADDR0, RTC_ADDR0_LINE_SEN, 0);
+	regmap_update_bits(rtc->peripheral, RTC_ADDR0, RTC_ADDR0_LINE_SDI, 0);
+	meson_rtc_send_bit(rtc, mode);
+	regmap_update_bits(rtc->peripheral, RTC_ADDR0, RTC_ADDR0_LINE_SDI, 0);
+}
+
+static u32 meson_rtc_get_data(struct meson_rtc *rtc)
+{
+	u32 tmp, val = 0;
+	int bit;
+
+	for (bit = 0; bit < RTC_DATA_BITS; bit++) {
+		meson_rtc_sclk_pulse(rtc);
+		val <<= 1;
+
+		regmap_read(rtc->peripheral, RTC_ADDR1, &tmp);
+		val |= tmp & RTC_ADDR1_SDO;
+	}
+
+	return val;
+}
+
+static int meson_rtc_get_bus(struct meson_rtc *rtc)
+{
+	int ret, retries = 3;
+	u32 val;
+
+	/* prepare bus for transfers, set all lines low */
+	val = RTC_ADDR0_LINE_SDI | RTC_ADDR0_LINE_SEN | RTC_ADDR0_LINE_SCLK;
+	regmap_update_bits(rtc->peripheral, RTC_ADDR0, val, 0);
+
+	for (retries = 0; retries < 3; retries++) {
+		/* wait for the bus to be ready */
+		if (!regmap_read_poll_timeout(rtc->peripheral, RTC_ADDR1, val,
+					      val & RTC_ADDR1_S_READY, 10,
+					      10000))
+			return 0;
+
+		dev_warn(rtc->dev, "failed to get bus, resetting RTC\n");
+
+		ret = reset_control_reset(rtc->reset);
+		if (ret)
+			return ret;
+	}
+
+	dev_err(rtc->dev, "bus is not ready\n");
+	return -ETIMEDOUT;
+}
+
+static int meson_rtc_serial_bus_reg_read(void *context, unsigned int reg,
+					 unsigned int *data)
+{
+	struct meson_rtc *rtc = context;
+	int ret;
+
+	ret = meson_rtc_get_bus(rtc);
+	if (ret)
+		return ret;
+
+	regmap_update_bits(rtc->peripheral, RTC_ADDR0, RTC_ADDR0_LINE_SEN,
+			   RTC_ADDR0_LINE_SEN);
+	meson_rtc_send_bits(rtc, reg, RTC_ADDR_BITS);
+	meson_rtc_set_dir(rtc, 0);
+	*data = meson_rtc_get_data(rtc);
+
+	return 0;
+}
+
+static int meson_rtc_serial_bus_reg_write(void *context, unsigned int reg,
+					  unsigned int data)
+{
+	struct meson_rtc *rtc = context;
+	int ret;
+
+	ret = meson_rtc_get_bus(rtc);
+	if (ret)
+		return ret;
+
+	regmap_update_bits(rtc->peripheral, RTC_ADDR0, RTC_ADDR0_LINE_SEN,
+			   RTC_ADDR0_LINE_SEN);
+	meson_rtc_send_bits(rtc, data, RTC_DATA_BITS);
+	meson_rtc_send_bits(rtc, reg, RTC_ADDR_BITS);
+	meson_rtc_set_dir(rtc, 1);
+
+	return 0;
+}
+
+static const struct regmap_bus meson_rtc_serial_bus = {
+	.reg_read	= meson_rtc_serial_bus_reg_read,
+	.reg_write	= meson_rtc_serial_bus_reg_write,
+};
+
+static const struct regmap_config meson_rtc_serial_regmap_config = {
+	.name		= "serial-registers",
+	.reg_bits	= 4,
+	.reg_stride	= 1,
+	.val_bits	= 32,
+	.max_register	= RTC_REGMEM_3,
+	.fast_io	= false,
+};
+
+static int meson_rtc_write_static(struct meson_rtc *rtc, u32 data)
+{
+	u32 tmp;
+
+	regmap_write(rtc->peripheral, RTC_REG4,
+		     FIELD_PREP(RTC_REG4_STATIC_VALUE, (data >> 8)));
+
+	/* write the static value and start the auto serializer */
+	tmp = FIELD_PREP(RTC_ADDR0_DATA, (data & 0xff)) | RTC_ADDR0_START_SER;
+	regmap_update_bits(rtc->peripheral, RTC_ADDR0,
+			   RTC_ADDR0_DATA | RTC_ADDR0_START_SER, tmp);
+
+	/* wait for the auto serializer to complete */
+	return regmap_read_poll_timeout(rtc->peripheral, RTC_REG4, tmp,
+					!(tmp & RTC_ADDR0_WAIT_SER), 10,
+					10000);
+}
+
+/* RTC interface layer functions */
+
+static int meson_rtc_gettime(struct device *dev, struct rtc_time *tm)
+{
+	struct meson_rtc *rtc = dev_get_drvdata(dev);
+	u32 time;
+	int ret;
+
+	ret = regmap_read(rtc->serial, RTC_COUNTER, &time);
+	if (!ret)
+		rtc_time64_to_tm(time, tm);
+
+	return ret;
+}
+
+static int meson_rtc_settime(struct device *dev, struct rtc_time *tm)
+{
+	struct meson_rtc *rtc = dev_get_drvdata(dev);
+
+	return regmap_write(rtc->serial, RTC_COUNTER, rtc_tm_to_time64(tm));
+}
+
+static const struct rtc_class_ops meson_rtc_ops = {
+	.read_time	= meson_rtc_gettime,
+	.set_time	= meson_rtc_settime,
+};
+
+/* NVMEM interface layer functions */
+
+static int meson_rtc_regmem_read(void *context, unsigned int offset,
+				 void *buf, size_t bytes)
+{
+	struct meson_rtc *rtc = context;
+	unsigned int read_offset, read_size;
+
+	read_offset = RTC_REGMEM_0 + (offset / 4);
+	read_size = bytes / 4;
+
+	return regmap_bulk_read(rtc->serial, read_offset, buf, read_size);
+}
+
+static int meson_rtc_regmem_write(void *context, unsigned int offset,
+				  void *buf, size_t bytes)
+{
+	struct meson_rtc *rtc = context;
+	unsigned int write_offset, write_size;
+
+	write_offset = RTC_REGMEM_0 + (offset / 4);
+	write_size = bytes / 4;
+
+	return regmap_bulk_write(rtc->serial, write_offset, buf, write_size);
+}
+
+static int meson_rtc_probe(struct platform_device *pdev)
+{
+	struct nvmem_config meson_rtc_nvmem_config = {
+		.name = "meson-rtc-regmem",
+		.word_size = 4,
+		.stride = 4,
+		.size = SZ_16,
+		.reg_read = meson_rtc_regmem_read,
+		.reg_write = meson_rtc_regmem_write,
+	};
+	struct device *dev = &pdev->dev;
+	struct meson_rtc *rtc;
+	struct resource *res;
+	void __iomem *base;
+	int ret;
+	u32 tm;
+
+	rtc = devm_kzalloc(dev, sizeof(struct meson_rtc), GFP_KERNEL);
+	if (!rtc)
+		return -ENOMEM;
+
+	rtc->rtc = devm_rtc_allocate_device(dev);
+	if (IS_ERR(rtc->rtc))
+		return PTR_ERR(rtc->rtc);
+
+	platform_set_drvdata(pdev, rtc);
+
+	rtc->dev = dev;
+
+	rtc->rtc->ops = &meson_rtc_ops;
+	rtc->rtc->range_max = U32_MAX;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	rtc->peripheral = devm_regmap_init_mmio(dev, base,
+					&meson_rtc_peripheral_regmap_config);
+	if (IS_ERR(rtc->peripheral)) {
+		dev_err(dev, "failed to create peripheral regmap\n");
+		return PTR_ERR(rtc->peripheral);
+	}
+
+	rtc->reset = devm_reset_control_get(dev, NULL);
+	if (IS_ERR(rtc->reset)) {
+		dev_err(dev, "missing reset line\n");
+		return PTR_ERR(rtc->reset);
+	}
+
+	rtc->vdd = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(rtc->vdd)) {
+		dev_err(dev, "failed to get the vdd-supply\n");
+		return PTR_ERR(rtc->vdd);
+	}
+
+	ret = regulator_enable(rtc->vdd);
+	if (ret) {
+		dev_err(dev, "failed to enable vdd-supply\n");
+		return ret;
+	}
+
+	ret = meson_rtc_write_static(rtc, MESON_STATIC_DEFAULT);
+	if (ret) {
+		dev_err(dev, "failed to set static values\n");
+		goto out_disable_vdd;
+	}
+
+	rtc->serial = devm_regmap_init(dev, &meson_rtc_serial_bus, rtc,
+				       &meson_rtc_serial_regmap_config);
+	if (IS_ERR(rtc->serial)) {
+		dev_err(dev, "failed to create serial regmap\n");
+		ret = PTR_ERR(rtc->serial);
+		goto out_disable_vdd;
+	}
+
+	/*
+	 * check if we can read RTC counter, if not then the RTC is probably
+	 * not functional. If it isn't probably best to not bind.
+	 */
+	ret = regmap_read(rtc->serial, RTC_COUNTER, &tm);
+	if (ret) {
+		dev_err(dev, "cannot read RTC counter, RTC not functional\n");
+		goto out_disable_vdd;
+	}
+
+	meson_rtc_nvmem_config.priv = rtc;
+	ret = rtc_nvmem_register(rtc->rtc, &meson_rtc_nvmem_config);
+	if (ret)
+		goto out_disable_vdd;
+
+	ret = rtc_register_device(rtc->rtc);
+	if (ret)
+		goto out_unregister_nvmem;
+
+	return 0;
+
+out_unregister_nvmem:
+	rtc_nvmem_unregister(rtc->rtc);
+
+out_disable_vdd:
+	regulator_disable(rtc->vdd);
+	return ret;
+}
+
+static const struct of_device_id meson_rtc_dt_match[] = {
+	{ .compatible = "amlogic,meson6-rtc", },
+	{ .compatible = "amlogic,meson8-rtc", },
+	{ .compatible = "amlogic,meson8b-rtc", },
+	{ .compatible = "amlogic,meson8m2-rtc", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, meson_rtc_dt_match);
+
+static struct platform_driver meson_rtc_driver = {
+	.probe		= meson_rtc_probe,
+	.driver		= {
+		.name	= "meson-rtc",
+		.of_match_table	= of_match_ptr(meson_rtc_dt_match),
+	},
+};
+module_platform_driver(meson_rtc_driver);
+
+MODULE_DESCRIPTION("Amlogic Meson RTC Driver");
+MODULE_AUTHOR("Ben Dooks <ben.doosk@codethink.co.uk>");
+MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:meson-rtc");
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
