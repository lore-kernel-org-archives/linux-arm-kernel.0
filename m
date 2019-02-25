Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37105C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 03:32:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E99AD2087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 03:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QHgMTs7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99AD2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YHgj3zDjWiOszfHaxOFigjBMdrJugPVOkHzYnTbkuQc=; b=QHgMTs7IZ0cBSO
	tAeiTi94Kxd/ZTRpYocWUGRSCkYjrWx3LXh9aD6QH1GwJtSFgyOBzpav/9rl6dvAMOFPhcS/4l89c
	5bdzvXmMo9ImtUzUa2Ckb56ndeaNVCiVUaAAng86OAkMSK/MI4AaljrvYNjUyzFmaAln16Aft6eMh
	M4NB+CCQr1+Sd3t1KE8ZBWgd2Rk8E6C4vuQ6rSFCIlU8LD9066vVrDF0SWa4ZKeE80mhJXMsUsUxj
	CjIEzarykUd2ByYUmbyvCzjh4irZHjbEu4NQzTo1qWNGuVx1xw12EP+bYm4OldA+C1qg2pHtjZo6r
	WC4iA5EEPTHHiEU4m+fQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gy70b-0000tM-OO; Mon, 25 Feb 2019 03:32:49 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gy6zF-0007cM-DV
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 03:31:29 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 5977F5FDDF; Mon, 25 Feb 2019 11:31:16 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v2 6/9] power: supply: axp20x_usb_power: add support for AXP813
Date: Mon, 25 Feb 2019 11:31:04 +0800
Message-Id: <20190225033107.17326-7-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225033107.17326-1-wens@csie.org>
References: <20190225033107.17326-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_193125_831784_E3F9F157 
X-CRM114-Status: GOOD (  13.27  )
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
 Hans de Goede <hdegoede@redhat.com>, linux-sunxi@googlegroups.com,
 Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Quentin Schulz <quentin.schulz@bootlin.com>

This adds support for AXP813 PMIC. It is almost the same as AXP22X but
has a different current limit.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/power/supply/axp20x_usb_power.c | 66 ++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 90d06027bf98..d39c450b14c6 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -42,6 +42,11 @@
 #define AXP20X_VBUS_CLIMIT_100mA	2
 #define AXP20X_VBUS_CLIMIT_NONE		3
 
+#define AXP813_VBUS_CLIMIT_900mA	0
+#define AXP813_VBUS_CLIMIT_1500mA	1
+#define AXP813_VBUS_CLIMIT_2000mA	2
+#define AXP813_VBUS_CLIMIT_2500mA	3
+
 #define AXP20X_ADC_EN1_VBUS_CURR	BIT(2)
 #define AXP20X_ADC_EN1_VBUS_VOLT	BIT(3)
 
@@ -131,6 +136,31 @@ static int axp20x_get_current_max(struct axp20x_usb_power *power, int *val)
 	return 0;
 }
 
+static int axp813_get_current_max(struct axp20x_usb_power *power, int *val)
+{
+	unsigned int v;
+	int ret = regmap_read(power->regmap, AXP20X_VBUS_IPSOUT_MGMT, &v);
+
+	if (ret)
+		return ret;
+
+	switch (v & AXP20X_VBUS_CLIMIT_MASK) {
+	case AXP813_VBUS_CLIMIT_900mA:
+		*val = 900000;
+		break;
+	case AXP813_VBUS_CLIMIT_1500mA:
+		*val = 1500000;
+		break;
+	case AXP813_VBUS_CLIMIT_2000mA:
+		*val = 2000000;
+		break;
+	case AXP813_VBUS_CLIMIT_2500mA:
+		*val = 2500000;
+		break;
+	}
+	return 0;
+}
+
 static int axp20x_usb_power_get_property(struct power_supply *psy,
 	enum power_supply_property psp, union power_supply_propval *val)
 {
@@ -169,6 +199,8 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 		val->intval = ret * 1700; /* 1 step = 1.7 mV */
 		return 0;
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		if (power->axp20x_id == AXP813_ID)
+			return axp813_get_current_max(power, &val->intval);
 		return axp20x_get_current_max(power, &val->intval);
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		if (IS_ENABLED(CONFIG_AXP20X_ADC)) {
@@ -260,6 +292,31 @@ static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
 	return -EINVAL;
 }
 
+static int axp813_usb_power_set_current_max(struct axp20x_usb_power *power,
+					    int intval)
+{
+	int val;
+
+	switch (intval) {
+	case 900000:
+		return regmap_update_bits(power->regmap,
+					  AXP20X_VBUS_IPSOUT_MGMT,
+					  AXP20X_VBUS_CLIMIT_MASK,
+					  AXP813_VBUS_CLIMIT_900mA);
+	case 1500000:
+	case 2000000:
+	case 2500000:
+		val = (intval - 1000000) / 500000;
+		return regmap_update_bits(power->regmap,
+					  AXP20X_VBUS_IPSOUT_MGMT,
+					  AXP20X_VBUS_CLIMIT_MASK, val);
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
 static int axp20x_usb_power_set_current_max(struct axp20x_usb_power *power,
 					    int intval)
 {
@@ -299,6 +356,9 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
 		return axp20x_usb_power_set_voltage_min(power, val->intval);
 
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		if (power->axp20x_id == AXP813_ID)
+			return axp813_usb_power_set_current_max(power,
+								val->intval);
 		return axp20x_usb_power_set_current_max(power, val->intval);
 
 	default:
@@ -434,7 +494,8 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 		usb_power_desc = &axp20x_usb_power_desc;
 		irq_names = axp20x_irq_names;
 	} else if (power->axp20x_id == AXP221_ID ||
-		   power->axp20x_id == AXP223_ID) {
+		   power->axp20x_id == AXP223_ID ||
+		   power->axp20x_id == AXP813_ID) {
 		usb_power_desc = &axp22x_usb_power_desc;
 		irq_names = axp22x_irq_names;
 	} else {
@@ -493,6 +554,9 @@ static const struct of_device_id axp20x_usb_power_match[] = {
 	}, {
 		.compatible = "x-powers,axp223-usb-power-supply",
 		.data = (void *)AXP223_ID,
+	}, {
+		.compatible = "x-powers,axp813-usb-power-supply",
+		.data = (void *)AXP813_ID,
 	}, { /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, axp20x_usb_power_match);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
