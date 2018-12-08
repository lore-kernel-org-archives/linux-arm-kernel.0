Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71769C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:40:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 265BE2082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p++GbMwC";
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="BjxMl0XN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 265BE2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=HRl9ZPRxiidJZib32tiWbAyb8cAWhOFMU/2/DvkWLFE=; b=p++GbMwCJkeEzv1i0K9hBu7kyZ
	EyszVqAu0ZWJ0xHB1XlgQCDjAAZvPZIzskz7Kv0ai4yikeTzgmzXSip1t3hutK0lNz0ZJS4NtZxr3
	2HqhgzykrO+0L5jrp2QV1jtuGGWNwaTimPHIhzvi/omAekasXx8Q+9+ugnsJlfIfW6nF9HX4b3Jfu
	QaBeFzlI9sXCPJT2iH6MpvKAIoPv/kLwWERSSYt6A0DgMPSm+YlWjyDEzIL1g3FJWfYe+bZ3c4aBq
	KoIXiEY3o02gdmc04f4V8whXF0tfEn+bxlUnaktOQtW/dgmKH7NIbTHNOhAubMfmCWJixqTzoQGu6
	kMKS8g6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVgaY-0008ON-Lq; Sat, 08 Dec 2018 17:40:26 +0000
Received: from mail1.kuutio.org ([92.222.216.83])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVgYk-0005Mq-DY
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 17:38:42 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail1.kuutio.org (Postfix) with ESMTP id 19BE120B70;
 Sat,  8 Dec 2018 18:38:11 +0100 (CET)
Authentication-Results: mail1.kuutio.org (amavisd-new);
 dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
 header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
 references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received; s=dkim; t=1544290690; x=
 1546882691; bh=McHTmJfwqv5vT4ak3tr5W+9VZ0cs/KhRnl4KNDz2q2E=; b=B
 jxMl0XNAyZ0DDKZ1ZBb/gJGUJMRT/yHv/F63A1KCvhOHp9hmBqz7cV1rjPu6JO23
 Tm5Kppq8dGU55wWPQpvA51dFnRlMw4devTmHq0n+rBfuwecHWGChj6E/hZDUWSt/
 SYHA+FVF2B2opru5KCahOmU0eYruvVeTrgd5PtQGLw1b8VX1Jh0QNpGQ0troCBtz
 HVk7dF5iQRBSPGWS3/3Z9xTmMAjDu7BOAYoptH4i+YlEHUuxOfP0KlEEIAgbNq/+
 Vonpp93jzEhY/u7ChN3SwRflUuh+Os59jE/O7kyeCGKXYUGysr9O3RpqSnLWgv6h
 tkHEUSAuWgxtdA88k2zhfyjnjJeRbFZ8/EUvEBH4h0SIlRJJfRU8N22MWjqIPMGf
 +3ziJol1TS8Gs5SbzUn7dp/DRFqVN32qCScz68nMDYL3RiEqRHC41yzc1MeoRxAa
 h9moQDk+//5zQY0b/lf/3C404qjVTqwtLV09HjQK8ATAMd5qeg4mluAUxLnVvu/V
 F2w8QYSa7xCxY+4+kq49yqvFSsmKLDFvhj1L37r5Epz3JUBo8sEFaFKVx6QiOVG2
 0iEXMqeT5ujj/EEf17vjrKF7wHvLWgRDkawfA9M3tAX+uOoujniyn9BTtlUcGgEK
 vMvrsdqtbTGRhX/yjOIBqvN9mm+OG3vxCpzmPM6AK8=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
 by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id tfQMZucHYcu9; Sat,  8 Dec 2018 18:38:10 +0100 (CET)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
 by mail1.kuutio.org (Postfix) with ESMTPSA id A42D82092A;
 Sat,  8 Dec 2018 18:38:09 +0100 (CET)
From: Oskari Lemmela <oskari@lemmela.net>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v7 6/9] power: supply: add AC power supply driver for AXP813
Date: Sat,  8 Dec 2018 19:36:15 +0200
Message-Id: <20181208173618.31395-7-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181208173618.31395-1-oskari@lemmela.net>
References: <20181208173618.31395-1-oskari@lemmela.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_093835_225219_7AB4EE8D 
X-CRM114-Status: GOOD (  14.88  )
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
Cc: devicetree@vger.kernel.org, Quentin Schulz <quentin.schulz@bootlin.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Oskari Lemmela <oskari@lemmela.net>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

AXP813 and AXP803 PMICs can control input current and minimum voltage.

Both of these values are configurable.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/power/supply/axp20x_ac_power.c | 94 ++++++++++++++++++++++++++
 include/linux/mfd/axp20x.h             |  1 +
 2 files changed, 95 insertions(+)

diff --git a/drivers/power/supply/axp20x_ac_power.c b/drivers/power/supply/axp20x_ac_power.c
index 0771f951b11f..59b4c8d3b961 100644
--- a/drivers/power/supply/axp20x_ac_power.c
+++ b/drivers/power/supply/axp20x_ac_power.c
@@ -27,6 +27,16 @@
 #define AXP20X_PWR_STATUS_ACIN_PRESENT	BIT(7)
 #define AXP20X_PWR_STATUS_ACIN_AVAIL	BIT(6)
 
+#define AXP813_VHOLD_MASK		GENMASK(5, 3)
+#define AXP813_VHOLD_UV_TO_BIT(x)	((((x) / 100000) - 40) << 3)
+#define AXP813_VHOLD_REG_TO_UV(x)	\
+	(((((x) & AXP813_VHOLD_MASK) >> 3) + 40) * 100000)
+
+#define AXP813_CURR_LIMIT_MASK		GENMASK(2, 0)
+#define AXP813_CURR_LIMIT_UA_TO_BIT(x)	(((x) / 500000) - 3)
+#define AXP813_CURR_LIMIT_REG_TO_UA(x)	\
+	((((x) & AXP813_CURR_LIMIT_MASK) + 3) * 500000)
+
 #define DRVNAME "axp20x-ac-power-supply"
 
 struct axp20x_ac_power {
@@ -102,6 +112,57 @@ static int axp20x_ac_power_get_property(struct power_supply *psy,
 
 		return 0;
 
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		ret = regmap_read(power->regmap, AXP813_ACIN_PATH_CTRL, &reg);
+		if (ret)
+			return ret;
+
+		val->intval = AXP813_VHOLD_REG_TO_UV(reg);
+
+		return 0;
+
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		ret = regmap_read(power->regmap, AXP813_ACIN_PATH_CTRL, &reg);
+		if (ret)
+			return ret;
+
+		val->intval = AXP813_CURR_LIMIT_REG_TO_UA(reg);
+		/* AXP813 datasheet defines values 11x as 4000mA */
+		if (val->intval > 4000000)
+			val->intval = 4000000;
+
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
+static int axp813_ac_power_set_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					const union power_supply_propval *val)
+{
+	struct axp20x_ac_power *power = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		if (val->intval < 4000000 || val->intval > 4700000)
+			return -EINVAL;
+
+		return regmap_update_bits(power->regmap, AXP813_ACIN_PATH_CTRL,
+					  AXP813_VHOLD_MASK,
+					  AXP813_VHOLD_UV_TO_BIT(val->intval));
+
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		if (val->intval < 1500000 || val->intval > 4000000)
+			return -EINVAL;
+
+		return regmap_update_bits(power->regmap, AXP813_ACIN_PATH_CTRL,
+					  AXP813_CURR_LIMIT_MASK,
+					  AXP813_CURR_LIMIT_UA_TO_BIT(val->intval));
+
 	default:
 		return -EINVAL;
 	}
@@ -109,6 +170,13 @@ static int axp20x_ac_power_get_property(struct power_supply *psy,
 	return -EINVAL;
 }
 
+static int axp813_ac_power_prop_writeable(struct power_supply *psy,
+					  enum power_supply_property psp)
+{
+	return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
+	       psp == POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT;
+}
+
 static enum power_supply_property axp20x_ac_power_properties[] = {
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_PRESENT,
@@ -123,6 +191,14 @@ static enum power_supply_property axp22x_ac_power_properties[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 };
 
+static enum power_supply_property axp813_ac_power_properties[] = {
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+};
+
 static const struct power_supply_desc axp20x_ac_power_desc = {
 	.name = "axp20x-ac",
 	.type = POWER_SUPPLY_TYPE_MAINS,
@@ -139,6 +215,16 @@ static const struct power_supply_desc axp22x_ac_power_desc = {
 	.get_property = axp20x_ac_power_get_property,
 };
 
+static const struct power_supply_desc axp813_ac_power_desc = {
+	.name = "axp813-ac",
+	.type = POWER_SUPPLY_TYPE_MAINS,
+	.properties = axp813_ac_power_properties,
+	.num_properties = ARRAY_SIZE(axp813_ac_power_properties),
+	.property_is_writeable = axp813_ac_power_prop_writeable,
+	.get_property = axp20x_ac_power_get_property,
+	.set_property = axp813_ac_power_set_property,
+};
+
 struct axp_data {
 	const struct power_supply_desc	*power_desc;
 	bool				acin_adc;
@@ -154,6 +240,11 @@ static const struct axp_data axp22x_data = {
 	.acin_adc = false,
 };
 
+static const struct axp_data axp813_data = {
+	.power_desc = &axp813_ac_power_desc,
+	.acin_adc = false,
+};
+
 static int axp20x_ac_power_probe(struct platform_device *pdev)
 {
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
@@ -234,6 +325,9 @@ static const struct of_device_id axp20x_ac_power_match[] = {
 	}, {
 		.compatible = "x-powers,axp221-ac-power-supply",
 		.data = &axp22x_data,
+	}, {
+		.compatible = "x-powers,axp813-ac-power-supply",
+		.data = &axp813_data,
 	}, { /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, axp20x_ac_power_match);
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 517e60eecbcb..2302b620d238 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -266,6 +266,7 @@ enum axp20x_variants {
 #define AXP288_RT_BATT_V_H		0xa0
 #define AXP288_RT_BATT_V_L		0xa1
 
+#define AXP813_ACIN_PATH_CTRL		0x3a
 #define AXP813_ADC_RATE			0x85
 
 /* Fuel Gauge */
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
