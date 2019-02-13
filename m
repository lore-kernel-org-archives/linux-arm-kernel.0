Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF47C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:10:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39767222BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jiN3yZnN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RnMa0DCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39767222BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=CpOpt/cwISmyHO8W/xGMiyVeBn0T/SIqw/7KnONcA4I=; b=jiN3yZnNZKraKNEyTD+eq0j5bX
	wIO/pPnKXic2clAeyhj48eicrAOGuCXWRhjzHvVwLE2Cixw9Sv5VSWJnPw+IlQ0iQWcnOZwvfNGg2
	aZgAAAsYLISw5UxcREl8hP6m7393gWhGiq/k8TLhcfuCe/DJZUuH5X0fW0O7VvD+KRpHd5ZiUzv2l
	6iltxPQykU4Ka0X7NfoJ5MM94HIXpe0lZdIzJOaVsyV9FIF2DRfleNajyiZTAN9fL87hqlaigGXTz
	K3CRD9ses8GbwpEU7/JreaeByb9EgeoMxzCVX4YOy8KvDNoQkzKjDrDorUVoCzj4kqMK0L1FRCGb7
	lHMzTbFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtwBZ-0008Di-NV; Wed, 13 Feb 2019 15:10:53 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtwAX-0005mF-Dl
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 15:09:57 +0000
Received: by mail-ed1-x543.google.com with SMTP id 10so2212591eds.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 07:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fg1xdGO8EkGUtIV12ZYanIZ1eOCYMIk7dyPh7m8OchY=;
 b=RnMa0DCJoxyCQchhKdk0Uy1ymckGzcFr/RpHobpa4tlBqlXutbV/trmJMBt2thP/gm
 hJvcCLrd0F0dgHNN1v8DnT5FQXX+EDmygwNYupaJ3FXFnipzVTtkcCy1tJlhD45A1mva
 SrViNrqHKZt6leQA92NtutTdSNqYJFUXfzk84l4mosT48da2BABL2kMByRRv3SdetjDH
 6G/moKfylTMev/bHNGU7/BAQ/VHRJ/MHE9qFKSM/E0x4Ol12SkfYaL/a1qlXB2VLaOCR
 wzJ6+sKKnPd0y2f1FWyoJu/NR6zXedMj+GhRD27j0zX9UOj3awXwJuVSNMz7YqJaFLNc
 6qGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fg1xdGO8EkGUtIV12ZYanIZ1eOCYMIk7dyPh7m8OchY=;
 b=N1s/fK3RUFcjDOb54kU6A51MAx2ObUvvnFSblCKGepQJD0BDsi6LCaRLCEXJSiwiWC
 Ze4Up0e+C93CVg+p+lcKvTlR0+N73vyezmBWIBJ5WIDi6aV2SDf2Fzmdp7dwj1siQUeM
 4nuENrCmGLJ6MVvVtNCbm+PQ2Fnc1kfDaN+W08v1dQB/LRa0ffQwC5kXLJVCRsUp2dh4
 unnR68eP+j4RrN0v2QfeNoPpSrY81757cAuPDJyZ1ySnZ1KxhqKh4YSNTyTNYFYMJqaW
 uYUkYOBvYWmA1xo2lrme0h5a1OEpslHmiXRegvXXgW4ZIHksMyNeFyDUlswi7B2AGo3+
 cCcw==
X-Gm-Message-State: AHQUAubKLfdlr2MRqmsntG/ogGwOS0joGRQmGaavzTz2Zt2XH1Uvhski
 4ffV3BBCF07cXVCyMPvCK3kvLw==
X-Google-Smtp-Source: AHgI3IZuHEWv/wXhpvSH5jUsM8w2Hvg68H/147M/f6O0acFjdezTf8Ns+zzfE9pGih1h8dt9sCAxng==
X-Received: by 2002:a17:906:a296:: with SMTP id
 i22mr741442ejz.62.1550070587890; 
 Wed, 13 Feb 2019 07:09:47 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com
 ([2620:10d:c092:180::1:4505])
 by smtp.googlemail.com with ESMTPSA id k26sm1903941ejv.63.2019.02.13.07.09.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 13 Feb 2019 07:09:47 -0800 (PST)
From: Loys Ollivier <lollivier@baylibre.com>
To: devicetree@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v4 4/4] gnss: add driver for mediatek receivers
Date: Wed, 13 Feb 2019 16:09:29 +0100
Message-Id: <1550070569-18588-5-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550070569-18588-1-git-send-email-lollivier@baylibre.com>
References: <1550070569-18588-1-git-send-email-lollivier@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_070950_021736_F87B3651 
X-CRM114-Status: GOOD (  19.72  )
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
v4:
No changes

v3:
Sorted the Kconfig and Makefile
Retained the original Copyright
Removed "mediatek,mt3339" compatible.

v2: 
Renamed from gtop/Globaltop to mtk/Mediatek.
Added "mediatek,mt3339" compatible.

 drivers/gnss/Kconfig  |  13 +++++
 drivers/gnss/Makefile |   3 +
 drivers/gnss/mtk.c    | 152 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+)
 create mode 100644 drivers/gnss/mtk.c

diff --git a/drivers/gnss/Kconfig b/drivers/gnss/Kconfig
index 6abc88514512..6d8c8027e1cd 100644
--- a/drivers/gnss/Kconfig
+++ b/drivers/gnss/Kconfig
@@ -15,6 +15,19 @@ if GNSS
 config GNSS_SERIAL
 	tristate
 
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
 config GNSS_SIRF_SERIAL
 	tristate "SiRFstar GNSS receiver support"
 	depends on SERIAL_DEV_BUS
diff --git a/drivers/gnss/Makefile b/drivers/gnss/Makefile
index 5cf0ebe0330a..451f11401ecc 100644
--- a/drivers/gnss/Makefile
+++ b/drivers/gnss/Makefile
@@ -9,6 +9,9 @@ gnss-y := core.o
 obj-$(CONFIG_GNSS_SERIAL)		+= gnss-serial.o
 gnss-serial-y := serial.o
 
+obj-$(CONFIG_GNSS_MTK_SERIAL)		+= gnss-mtk.o
+gnss-mtk-y := mtk.o
+
 obj-$(CONFIG_GNSS_SIRF_SERIAL)		+= gnss-sirf.o
 gnss-sirf-y := sirf.o
 
diff --git a/drivers/gnss/mtk.c b/drivers/gnss/mtk.c
new file mode 100644
index 000000000000..a5aad08fb9d7
--- /dev/null
+++ b/drivers/gnss/mtk.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Mediatek GNSS receiver driver
+ *
+ * Copyright (C) 2018 Johan Hovold <johan@kernel.org>
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
