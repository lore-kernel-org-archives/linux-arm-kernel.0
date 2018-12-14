Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7872EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:36:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDECD206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gYZ4XWEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDECD206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8i+CHwazO5ySAr1B2noQuHY+vfYrtTVVdJPHSq1A6/M=; b=gYZ4XWEe3sH10L
	pNZONPpSTenokg/uFMCel8tYLUHy5dta4r6Chw16HtoKW1FACFcZqokVTnVaL2L0D2oizOtH4jKuY
	mkPGOGePtO85oQcziSUl05RZHk3BLEMw9nfKwZo7oRmdj/Qdvp2yy5N2P9yZQE2QwP10DCVJNAK70
	mbpcjkrBT4XDkSi/7d4w85pefh+imXT2gVv3TV07tTKrkWZ0szTA5fd/sVcmoTdOfaxg7FYuM2lM3
	jVfggHyXSQGdUekIGgj6o+digPqUgnpE64hT+CRrOaLDhQhgnaymVH8SQmFKiShsPaqSVkNL3iH9t
	0aeLoXgFonKVjl0+07Jw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXoZk-0002aI-Bc; Fri, 14 Dec 2018 14:36:24 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXoY3-0008JG-Az
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 14:34:43 +0000
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wBEEVJel030825; Fri, 14 Dec 2018 15:34:24 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2p85qkm06e-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Fri, 14 Dec 2018 15:34:24 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AAB1D31;
 Fri, 14 Dec 2018 14:34:23 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8009752EC;
 Fri, 14 Dec 2018 14:34:23 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE3.st.com
 (10.75.127.18) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 14 Dec
 2018 15:34:23 +0100
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Fri, 14 Dec 2018 15:34:23 +0100
From: Pascal PAILLET-LME <p.paillet@st.com>
To: "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com"
 <lgirdwood@gmail.com>
Subject: [PATCH v8 4/6] input: stpmic1: add stpmic1 onkey driver
Thread-Topic: [PATCH v8 4/6] input: stpmic1: add stpmic1 onkey driver
Thread-Index: AQHUk7obfV2MfPTneUSIyd7WP5Q6bQ==
Date: Fri, 14 Dec 2018 14:34:22 +0000
Message-ID: <1544798057-1499-5-git-send-email-p.paillet@st.com>
References: <1544798057-1499-1-git-send-email-p.paillet@st.com>
In-Reply-To: <1544798057-1499-1-git-send-email-p.paillet@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-14_07:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_063439_762101_D964F48E 
X-CRM114-Status: GOOD (  17.70  )
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
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Pascal PAILLET-LME <p.paillet@st.com>,
 Alexandre TORGUE <alexandre.torgue@st.com>,
 "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The stpmic1 pmic is able to manage an onkey button. This driver exposes
the stpmic1 onkey as an input device. It can also be configured to
shut-down the power supplies on a long key-press with an adjustable
duration.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
changes in v8: nothing

 drivers/input/misc/Kconfig         |  11 +++
 drivers/input/misc/Makefile        |   2 +
 drivers/input/misc/stpmic1_onkey.c | 198 +++++++++++++++++++++++++++++++++++++
 3 files changed, 211 insertions(+)
 create mode 100644 drivers/input/misc/stpmic1_onkey.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index ca59a2b..279fb02 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -851,4 +851,15 @@ config INPUT_SC27XX_VIBRA
 	  To compile this driver as a module, choose M here. The module will
 	  be called sc27xx_vibra.
 
+config INPUT_STPMIC1_ONKEY
+	tristate "STPMIC1 PMIC Onkey support"
+	depends on MFD_STPMIC1
+	help
+	  Say Y to enable support of onkey embedded into STPMIC1 PMIC. onkey
+	  can be used to wakeup from low power modes and force a shut-down on
+	  long press.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called stpmic1_onkey.
+
 endif
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 9d0f9d1..1b44202 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_INPUT_SGI_BTNS)		+= sgi_btns.o
 obj-$(CONFIG_INPUT_SIRFSOC_ONKEY)	+= sirfsoc-onkey.o
 obj-$(CONFIG_INPUT_SOC_BUTTON_ARRAY)	+= soc_button_array.o
 obj-$(CONFIG_INPUT_SPARCSPKR)		+= sparcspkr.o
+obj-$(CONFIG_INPUT_STPMIC1_ONKEY)  	+= stpmic1_onkey.o
 obj-$(CONFIG_INPUT_TPS65218_PWRBUTTON)	+= tps65218-pwrbutton.o
 obj-$(CONFIG_INPUT_TWL4030_PWRBUTTON)	+= twl4030-pwrbutton.o
 obj-$(CONFIG_INPUT_TWL4030_VIBRA)	+= twl4030-vibra.o
@@ -81,3 +82,4 @@ obj-$(CONFIG_INPUT_WM831X_ON)		+= wm831x-on.o
 obj-$(CONFIG_INPUT_XEN_KBDDEV_FRONTEND)	+= xen-kbdfront.o
 obj-$(CONFIG_INPUT_YEALINK)		+= yealink.o
 obj-$(CONFIG_INPUT_IDEAPAD_SLIDEBAR)	+= ideapad_slidebar.o
+
diff --git a/drivers/input/misc/stpmic1_onkey.c b/drivers/input/misc/stpmic1_onkey.c
new file mode 100644
index 0000000..7b49c99
--- /dev/null
+++ b/drivers/input/misc/stpmic1_onkey.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) STMicroelectronics 2018
+// Author: Pascal Paillet <p.paillet@st.com> for STMicroelectronics.
+
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/stpmic1.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+
+/**
+ * struct stpmic1_onkey - OnKey data
+ * @input_dev:		pointer to input device
+ * @irq_falling:	irq that we are hooked on to
+ * @irq_rising:		irq that we are hooked on to
+ */
+struct stpmic1_onkey {
+	struct input_dev *input_dev;
+	int irq_falling;
+	int irq_rising;
+};
+
+static irqreturn_t onkey_falling_irq(int irq, void *ponkey)
+{
+	struct stpmic1_onkey *onkey = ponkey;
+	struct input_dev *input_dev = onkey->input_dev;
+
+	input_report_key(input_dev, KEY_POWER, 1);
+	pm_wakeup_event(input_dev->dev.parent, 0);
+	input_sync(input_dev);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t onkey_rising_irq(int irq, void *ponkey)
+{
+	struct stpmic1_onkey *onkey = ponkey;
+	struct input_dev *input_dev = onkey->input_dev;
+
+	input_report_key(input_dev, KEY_POWER, 0);
+	pm_wakeup_event(input_dev->dev.parent, 0);
+	input_sync(input_dev);
+
+	return IRQ_HANDLED;
+}
+
+static int stpmic1_onkey_probe(struct platform_device *pdev)
+{
+	struct stpmic1 *pmic = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct input_dev *input_dev;
+	struct stpmic1_onkey *onkey;
+	unsigned int val, reg = 0;
+	int error;
+
+	onkey = devm_kzalloc(dev, sizeof(*onkey), GFP_KERNEL);
+	if (!onkey)
+		return -ENOMEM;
+
+	onkey->irq_falling = platform_get_irq_byname(pdev, "onkey-falling");
+	if (onkey->irq_falling < 0) {
+		dev_err(dev, "failed: request IRQ onkey-falling %d\n",
+			onkey->irq_falling);
+		return onkey->irq_falling;
+	}
+
+	onkey->irq_rising = platform_get_irq_byname(pdev, "onkey-rising");
+	if (onkey->irq_rising < 0) {
+		dev_err(dev, "failed: request IRQ onkey-rising %d\n",
+			onkey->irq_rising);
+		return onkey->irq_rising;
+	}
+
+	if (!device_property_read_u32(dev, "power-off-time-sec", &val)) {
+		if (val > 0 && val <= 16) {
+			dev_dbg(dev, "power-off-time=%d seconds\n", val);
+			reg |= PONKEY_PWR_OFF;
+			reg |= ((16 - val) & PONKEY_TURNOFF_TIMER_MASK);
+		} else {
+			dev_err(dev, "power-off-time-sec out of range\n");
+			return -EINVAL;
+		}
+	}
+
+	if (device_property_present(dev, "st,onkey-clear-cc-flag"))
+		reg |= PONKEY_CC_FLAG_CLEAR;
+
+	error = regmap_update_bits(pmic->regmap, PKEY_TURNOFF_CR,
+				   PONKEY_TURNOFF_MASK, reg);
+	if (error) {
+		dev_err(dev, "PKEY_TURNOFF_CR write failed: %d\n", error);
+		return error;
+	}
+
+	if (device_property_present(dev, "st,onkey-pu-inactive")) {
+		error = regmap_update_bits(pmic->regmap, PADS_PULL_CR,
+					   PONKEY_PU_INACTIVE,
+					   PONKEY_PU_INACTIVE);
+		if (error) {
+			dev_err(dev, "ONKEY Pads configuration failed: %d\n",
+				error);
+			return error;
+		}
+	}
+
+	input_dev = devm_input_allocate_device(dev);
+	if (!input_dev) {
+		dev_err(dev, "Can't allocate Pwr Onkey Input Device\n");
+		return -ENOMEM;
+	}
+
+	input_dev->name = "pmic_onkey";
+	input_dev->phys = "pmic_onkey/input0";
+
+	input_set_capability(input_dev, EV_KEY, KEY_POWER);
+
+	onkey->input_dev = input_dev;
+
+	/* interrupt is nested in a thread */
+	error = devm_request_threaded_irq(dev, onkey->irq_falling, NULL,
+					  onkey_falling_irq, IRQF_ONESHOT,
+					  dev_name(dev), onkey);
+	if (error) {
+		dev_err(dev, "Can't get IRQ Onkey Falling: %d\n", error);
+		return error;
+	}
+
+	error = devm_request_threaded_irq(dev, onkey->irq_rising, NULL,
+					  onkey_rising_irq, IRQF_ONESHOT,
+					  dev_name(dev), onkey);
+	if (error) {
+		dev_err(dev, "Can't get IRQ Onkey Rising: %d\n", error);
+		return error;
+	}
+
+	error = input_register_device(input_dev);
+	if (error) {
+		dev_err(dev, "Can't register power button: %d\n", error);
+		return error;
+	}
+
+	platform_set_drvdata(pdev, onkey);
+	device_init_wakeup(dev, true);
+
+	return 0;
+}
+
+static int __maybe_unused stpmic1_onkey_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct stpmic1_onkey *onkey = platform_get_drvdata(pdev);
+
+	if (device_may_wakeup(dev)) {
+		enable_irq_wake(onkey->irq_falling);
+		enable_irq_wake(onkey->irq_rising);
+	}
+	return 0;
+}
+
+static int __maybe_unused stpmic1_onkey_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct stpmic1_onkey *onkey = platform_get_drvdata(pdev);
+
+	if (device_may_wakeup(dev)) {
+		disable_irq_wake(onkey->irq_falling);
+		disable_irq_wake(onkey->irq_rising);
+	}
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(stpmic1_onkey_pm,
+			 stpmic1_onkey_suspend,
+			 stpmic1_onkey_resume);
+
+static const struct of_device_id of_stpmic1_onkey_match[] = {
+	{ .compatible = "st,stpmic1-onkey" },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, of_stpmic1_onkey_match);
+
+static struct platform_driver stpmic1_onkey_driver = {
+	.probe	= stpmic1_onkey_probe,
+	.driver	= {
+		.name	= "stpmic1_onkey",
+		.of_match_table = of_match_ptr(of_stpmic1_onkey_match),
+		.pm	= &stpmic1_onkey_pm,
+	},
+};
+module_platform_driver(stpmic1_onkey_driver);
+
+MODULE_DESCRIPTION("Onkey driver for STPMIC1");
+MODULE_AUTHOR("Pascal Paillet <p.paillet@st.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
