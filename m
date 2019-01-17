Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE72C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:56:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40E6520652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WsYF3dnE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VIJSI+MC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E6520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=FRVdfRSzJfa8zvUXoqQ73r3/shh0zHnNXozBt6CVbZw=; b=WsYF3dnEVHKNlVEjgOixlt3niK
	NrvH3Qw0VS9zeq2/fpoaG9/x6OvYoBLravCTcJXwcTGQvb+5uzLztPppLAfnnUl8Ui0esqu1IRh2d
	hnDFf6yW3Z+IfkdjdmoA52iqiZsK2dZ+Zx1F9J5lw6p4lVRxMmmHGIOrjt7Fjk2AoM8ALI9e+fMwF
	0J0XQhJdvwTsdFmiBQb8SqC/0m03AxI4tC/x0uDhaIqha064xI0Yg7YgYYaPGGQBAynMwF1Rs65L2
	FgpbKClr0uAE5U0k+V7fiFsjd/sBjNnSWn0SstmOcUkz0RSYpcZxKVvjstmyZDFa1FjKo3N6eihOb
	95ZXHdrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkAxk-0004bA-C6; Thu, 17 Jan 2019 16:56:16 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkAwI-00025W-Ie
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 16:54:53 +0000
Received: by mail-wr1-x441.google.com with SMTP id v13so11821077wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 08:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JdxC+TYoHyFvvG2M67CNwtrXKpmBLe0NX/snZJIlkJ4=;
 b=VIJSI+MCtGNJREA3jMHwYFVEg2tbXQUChJfvmWyIDkEHyT7GrUvwSo/C07Ty34fNx/
 idPh8+Col7at41ybNFoMDAzDnG9ZqkWTFk1SFQvA9uoKy5mf+SMXsdhaPV2lULnnCwm9
 L6JITLTdPOrvbyCO1LYh4IEj0Z4BSwNBpwNfcSQMQZVhv3qpuEOEaArWQRmj8spKXxYJ
 jpOtHerulPyj1U7pC7YjKx2NaCIboc4dRDlZNzAzrgPIeGpZx8P+VChQd5vbY/PEsjYy
 4j+E0r7DODoOaempD0oBMFLVQzgZssqYY2v9EEBK+6ceqXMVS4yVCQ4r1Jw4nFDOUO06
 NA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=JdxC+TYoHyFvvG2M67CNwtrXKpmBLe0NX/snZJIlkJ4=;
 b=S3r/YrNpe2s5j39zaNclzVL9KGMaaJT65o/WG+yBtffaaxP23VlRMMwcfPWh8gbKmj
 +EkbJLOxwCeeEI1IGDv7rHbLXyr6vQADEDfWNFquAzdUdRuYCjC6fJIL9M5dFZe90TLV
 orUMKw4ojz8HwlU3o25IdM6zLQrNp7Rqkc0D3f+4WDBy857viRE4ValMnnCwDrydRYY6
 WnaShPWO+1ospHh7mMquFlfXRBruPY5nh24J3phN8kXynQ59ANKVJomVpsiv0yKZKPDO
 oXdSHteJo5tyilW2bl8GeivZo7yKf/z8iMFUeI26IzJVO/xHidmRBSYWQehuSjb41Zn8
 Vajg==
X-Gm-Message-State: AJcUukd0xvsHLivuTx3qA6ztOiY+9DCw1Ecy/Umjsg186M2KlFEd0RkJ
 2UNiZNaXfSLHiSf68PeA1kRLyg==
X-Google-Smtp-Source: ALg8bN5c/ShGHyAearRs36+zG3iA762N//dFUFon5Q30uxKo7Ba3J3SrvAg/98I35ljHffxDkFCRyA==
X-Received: by 2002:adf:efd1:: with SMTP id i17mr12509696wrp.200.1547744084758; 
 Thu, 17 Jan 2019 08:54:44 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.googlemail.com with ESMTPSA id b12sm65309630wrt.17.2019.01.17.08.54.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 17 Jan 2019 08:54:44 -0800 (PST)
From: Loys Ollivier <lollivier@baylibre.com>
To: devicetree@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 4/4] gnss: add driver for mediatek receivers
Date: Thu, 17 Jan 2019 17:54:34 +0100
Message-Id: <1547744074-28308-5-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_085447_063474_2DE4CCFE 
X-CRM114-Status: GOOD (  20.55  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Loys Ollivier <lollivier@baylibre.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add driver for serial-connected Mediatek-based GNSS receivers.

These devices typically boot transmitting vendor specific NMEA output
sequences. The serial port bit rate is read from the device tree
"current-speed".

Note that the driver uses the generic GNSS serial implementation and
therefore essentially only manages power abstracted into three power
states: ACTIVE, STANDBY, and OFF.

For mediatek receivers with a main supply and no enable-gpios, this simply
means that the main supply is disabled in STANDBY and OFF (the optional
backup supply is kept enabled while the driver is bound).

Note that the timepulse-support is left unimplemented.

Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
---

v2: 
Renamed from gtop/Globaltop to mtk/Mediatek.
Added "mediatek,mt3339" compatible.

 drivers/gnss/Kconfig  |  13 +++++
 drivers/gnss/Makefile |   3 +
 drivers/gnss/core.c   |   1 +
 drivers/gnss/mtk.c    | 153 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 170 insertions(+)
 create mode 100644 drivers/gnss/mtk.c

diff --git a/drivers/gnss/Kconfig b/drivers/gnss/Kconfig
index 6abc88514512..51e6282d092a 100644
--- a/drivers/gnss/Kconfig
+++ b/drivers/gnss/Kconfig
@@ -40,4 +40,17 @@ config GNSS_UBX_SERIAL
 
 	  If unsure, say N.
 
+config GNSS_MTK_SERIAL
+	tristate "Mediatek GNSS receiver support"
+	depends on SERIAL_DEV_BUS
+	select GNSS_SERIAL
+	help
+	  Say Y here if you have a Mediatek-based GNSS receiver which uses a
+	  serial interface.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called gnss-mtk.
+
+	  If unsure, say N.
+
 endif # GNSS
diff --git a/drivers/gnss/Makefile b/drivers/gnss/Makefile
index 5cf0ebe0330a..43318375aa51 100644
--- a/drivers/gnss/Makefile
+++ b/drivers/gnss/Makefile
@@ -14,3 +14,6 @@ gnss-sirf-y := sirf.o
 
 obj-$(CONFIG_GNSS_UBX_SERIAL)		+= gnss-ubx.o
 gnss-ubx-y := ubx.o
+
+obj-$(CONFIG_GNSS_MTK_SERIAL)		+= gnss-mtk.o
+gnss-mtk-y := mtk.o
diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
index 4291a0dd22aa..320cfca80d5f 100644
--- a/drivers/gnss/core.c
+++ b/drivers/gnss/core.c
@@ -334,6 +334,7 @@ static const char * const gnss_type_names[GNSS_TYPE_COUNT] = {
 	[GNSS_TYPE_NMEA]	= "NMEA",
 	[GNSS_TYPE_SIRF]	= "SiRF",
 	[GNSS_TYPE_UBX]		= "UBX",
+	[GNSS_TYPE_MTK]		= "MTK",
 };
 
 static const char *gnss_type_name(struct gnss_device *gdev)
diff --git a/drivers/gnss/mtk.c b/drivers/gnss/mtk.c
new file mode 100644
index 000000000000..c91d4d251098
--- /dev/null
+++ b/drivers/gnss/mtk.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Mediatek GNSS receiver driver
+ *
+ * Copyright (C) 2018 Loys Ollivier <lollivier@baylibre.com>
+ */
+
+#include <linux/errno.h>
+#include <linux/gnss.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+#include <linux/serdev.h>
+
+#include "serial.h"
+
+struct mtk_data {
+	struct regulator *v_bckp;
+	struct regulator *vcc;
+};
+
+static int mtk_set_active(struct gnss_serial *gserial)
+{
+	struct mtk_data *data = gnss_serial_get_drvdata(gserial);
+	int ret;
+
+	ret = regulator_enable(data->vcc);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int mtk_set_standby(struct gnss_serial *gserial)
+{
+	struct mtk_data *data = gnss_serial_get_drvdata(gserial);
+	int ret;
+
+	ret = regulator_disable(data->vcc);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int mtk_set_power(struct gnss_serial *gserial,
+			 enum gnss_serial_pm_state state)
+{
+	switch (state) {
+	case GNSS_SERIAL_ACTIVE:
+		return mtk_set_active(gserial);
+	case GNSS_SERIAL_OFF:
+	case GNSS_SERIAL_STANDBY:
+		return mtk_set_standby(gserial);
+	}
+
+	return -EINVAL;
+}
+
+static const struct gnss_serial_ops mtk_gserial_ops = {
+	.set_power = mtk_set_power,
+};
+
+static int mtk_probe(struct serdev_device *serdev)
+{
+	struct gnss_serial *gserial;
+	struct mtk_data *data;
+	int ret;
+
+	gserial = gnss_serial_allocate(serdev, sizeof(*data));
+	if (IS_ERR(gserial)) {
+		ret = PTR_ERR(gserial);
+		return ret;
+	}
+
+	gserial->ops = &mtk_gserial_ops;
+
+	gserial->gdev->type = GNSS_TYPE_MTK;
+
+	data = gnss_serial_get_drvdata(gserial);
+
+	data->vcc = devm_regulator_get(&serdev->dev, "vcc");
+	if (IS_ERR(data->vcc)) {
+		ret = PTR_ERR(data->vcc);
+		goto err_free_gserial;
+	}
+
+	data->v_bckp = devm_regulator_get_optional(&serdev->dev, "v-bckp");
+	if (IS_ERR(data->v_bckp)) {
+		ret = PTR_ERR(data->v_bckp);
+		if (ret == -ENODEV)
+			data->v_bckp = NULL;
+		else
+			goto err_free_gserial;
+	}
+
+	if (data->v_bckp) {
+		ret = regulator_enable(data->v_bckp);
+		if (ret)
+			goto err_free_gserial;
+	}
+
+	ret = gnss_serial_register(gserial);
+	if (ret)
+		goto err_disable_v_bckp;
+
+	return 0;
+
+err_disable_v_bckp:
+	if (data->v_bckp)
+		regulator_disable(data->v_bckp);
+err_free_gserial:
+	gnss_serial_free(gserial);
+
+	return ret;
+}
+
+static void mtk_remove(struct serdev_device *serdev)
+{
+	struct gnss_serial *gserial = serdev_device_get_drvdata(serdev);
+	struct mtk_data *data = gnss_serial_get_drvdata(gserial);
+
+	gnss_serial_deregister(gserial);
+	if (data->v_bckp)
+		regulator_disable(data->v_bckp);
+	gnss_serial_free(gserial);
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id mtk_of_match[] = {
+	{ .compatible = "globaltop,pa6h" },
+	{ .compatible = "mediatek,mt3339" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mtk_of_match);
+#endif
+
+static struct serdev_device_driver mtk_driver = {
+	.driver	= {
+		.name		= "gnss-mtk",
+		.of_match_table	= of_match_ptr(mtk_of_match),
+		.pm		= &gnss_serial_pm_ops,
+	},
+	.probe	= mtk_probe,
+	.remove	= mtk_remove,
+};
+module_serdev_device_driver(mtk_driver);
+
+MODULE_AUTHOR("Loys Ollivier <lollivier@baylibre.com>");
+MODULE_DESCRIPTION("Mediatek GNSS receiver driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
