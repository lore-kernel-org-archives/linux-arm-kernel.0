Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B73C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:17:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA4AF2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="af51muoh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ctOtaMPG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA4AF2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qNZpq6+dhIPKU9to5WfyrcXcN6Wzc2Eoyw7vANnwqXM=; b=af51muohSka3Sg
	iEZD8VwN12B+MuklIODwlYfX35UBTSlF9EpYB4F76Rcu7pxNoPHSN27H5eU9ctZFIG+16Md+ZYA6r
	tdzaLUh9F2p8P5zEO9zEsqJxdX25IzhA2yCKvwwFTCdxQoCtt71Y30RD9gumz5KBwMG7MQNdDyUGz
	QShjCTe5BvquzeZeAlyppE2HwKN6k0StOiBfHuK7dD75UTH0AKPNqRWrfVtogLxGR+9ifs28Y6NY/
	u6tOyNwzuYLc8Kj6mCAfEsqUJZzToZHXfuSpB6iEjPFPKzolrptSv+xMyDSyxNBhnzBGCM1tk7pcw
	g7bamEs2YH/dqwMqeoAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTlIW-0001Nf-Nq; Mon, 03 Dec 2018 10:17:52 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTlGr-0007zZ-M3
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 10:16:13 +0000
Received: by mail-wr1-x444.google.com with SMTP id x10so11479306wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 02:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MX6hF1WvT6/jnjg/Hvxrw/jbX1gmvj02z43j9IhctPk=;
 b=ctOtaMPGCmFOsRrqLmlS+E6Vf5lZ8qOMRYKnnfunQTf7jPddBD4Q5tt6umguIojCEq
 svzBj6FKXHKdjaclTZh12ET5K/gRPnVZLmEl1EYH7z9QIKUQ5QYGqsHgSQVKfgyKZaqw
 BCRT0CB1J7fK1u+aQQ6PLGAMYUdPKWUF/rHVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MX6hF1WvT6/jnjg/Hvxrw/jbX1gmvj02z43j9IhctPk=;
 b=RIx3P4Dt6R/jfKZkqu1pg0KLquUhAi+XpGfygjXvPCAEivyAsAIXZ4LthpLmNj1Ys3
 hLpVatyQJctnBgJ8vtC3ExzlF975H8sUHVueEGqVZ7TO9AZN519eUvrUV8MkjykUe2kr
 84uq5SCROUXeh+z5IS/FpNyoGlutibAEf2F2841S35iDxwCNwLcLaZy9Kg1Lg6u7PmXd
 Qydp2tEjIbMMteoHjtLqWrlZMbA+MhGL3J1emZtIP0fhhq/DKWVadt+/VWn4aMLkzGaP
 yLFH0/CfrzKIMdWwK5JP7eRKndS3y3gX8AGJpTzPLm9U4jbhBeSlJYe1Rg9il88daAfJ
 kaBA==
X-Gm-Message-State: AA+aEWbas2F2lFjrGyZtKZd6IG31SwVUAlldenTuG2z7P+inmQzN6QzB
 ISRq5WQuuhe75ORNI2yd2pqHUg==
X-Google-Smtp-Source: AFSGD/XZrkrloQ5/rvxj/0OMNRHVR0EheGpmH5OuudxmqmlBlo2LoDkZaoKHippBpsUviaxdeZIqzA==
X-Received: by 2002:a5d:448f:: with SMTP id j15mr9244659wrq.108.1543832161996; 
 Mon, 03 Dec 2018 02:16:01 -0800 (PST)
Received: from localhost.localdomain (conf.hotelmediterraneo.com.
 [2.228.78.71])
 by smtp.gmail.com with ESMTPSA id f192sm5832158wmd.12.2018.12.03.02.16.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 02:16:01 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
 linux-sunxi@googlegroups.com
Subject: [PATCH 6/9] Input: goodix - Add vcc-supply regulator support
Date: Mon,  3 Dec 2018 15:45:44 +0530
Message-Id: <20181203101547.16835-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181203101547.16835-1-jagan@amarulasolutions.com>
References: <20181203101547.16835-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_021609_724829_1B1309CF 
X-CRM114-Status: GOOD (  17.03  )
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

vcc-supply property is need for some Goodix CTP controller like GT5663
where 3.3V external pull-up regulator connected via controller VCC pin.

So, enable the regulator for those it attached the vcc-supply.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/input/touchscreen/goodix.c | 39 ++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index f2d9c2c41885..7adcf1491609 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -27,6 +27,7 @@
 #include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <linux/of.h>
@@ -47,6 +48,7 @@ struct goodix_ts_data {
 	struct touchscreen_properties prop;
 	unsigned int max_touch_num;
 	unsigned int int_trigger_type;
+	struct regulator *vcc;
 	struct gpio_desc *gpiod_int;
 	struct gpio_desc *gpiod_rst;
 	u16 id;
@@ -58,6 +60,7 @@ struct goodix_ts_data {
 
 #define GOODIX_GPIO_INT_NAME		"irq"
 #define GOODIX_GPIO_RST_NAME		"reset"
+#define GOODIX_VCC_CTP_NAME		"vcc"
 
 #define GOODIX_MAX_HEIGHT		4096
 #define GOODIX_MAX_WIDTH		4096
@@ -525,12 +528,24 @@ static int goodix_get_gpio_config(struct goodix_ts_data *ts)
 {
 	int error;
 	struct device *dev;
+	struct regulator *regulator;
 	struct gpio_desc *gpiod;
 
 	if (!ts->client)
 		return -EINVAL;
 	dev = &ts->client->dev;
 
+	regulator = devm_regulator_get(dev, GOODIX_VCC_CTP_NAME);
+	if (IS_ERR(regulator)) {
+		error = PTR_ERR(regulator);
+		if (error != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get vcc regulator: %d\n",
+				error);
+		return error;
+	}
+
+	ts->vcc = regulator;
+
 	/* Get the interrupt GPIO pin number */
 	gpiod = devm_gpiod_get_optional(dev, GOODIX_GPIO_INT_NAME, GPIOD_IN);
 	if (IS_ERR(gpiod)) {
@@ -786,25 +801,34 @@ static int goodix_ts_probe(struct i2c_client *client,
 	if (error)
 		return error;
 
+	/* power the controller */
+	if (ts->vcc) {
+		error = regulator_enable(ts->vcc);
+		if (error) {
+			dev_err(&client->dev, "Controller fail to enable vcc\n");
+			return error;
+		}
+	}
+
 	if (ts->gpiod_int && ts->gpiod_rst) {
 		/* reset the controller */
 		error = goodix_reset(ts);
 		if (error) {
 			dev_err(&client->dev, "Controller reset failed.\n");
-			return error;
+			goto error;
 		}
 	}
 
 	error = goodix_i2c_test(client);
 	if (error) {
 		dev_err(&client->dev, "I2C communication failure: %d\n", error);
-		return error;
+		goto error;
 	}
 
 	error = goodix_read_version(ts);
 	if (error) {
 		dev_err(&client->dev, "Read version failed.\n");
-		return error;
+		goto error;
 	}
 
 	ts->chip = goodix_get_chip_data(ts->id);
@@ -823,17 +847,22 @@ static int goodix_ts_probe(struct i2c_client *client,
 			dev_err(&client->dev,
 				"Failed to invoke firmware loader: %d\n",
 				error);
-			return error;
+			goto error;
 		}
 
 		return 0;
 	} else {
 		error = goodix_configure_dev(ts);
 		if (error)
-			return error;
+			goto error;
 	}
 
 	return 0;
+
+error:
+	if (ts->vcc)
+		regulator_disable(ts->vcc);
+	return error;
 }
 
 static int goodix_ts_remove(struct i2c_client *client)
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
