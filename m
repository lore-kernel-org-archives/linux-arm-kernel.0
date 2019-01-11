Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03811C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:21:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3A6D2146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZOZBu97G";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GkF4aOBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A6D2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ENsyy9XYoC6Q5bXgg7pxGYJDkN05/NpQqNPQ3CiqM60=; b=ZOZBu97GMkvNIsCiaTsBtNYYt4
	rJiIwLXNwJq5CFjMRW4fi9do75kBQapPr5r7P+vvm6zD9K9Gr8WVvXY4VVsFIq3AiaJn1e+hrtxNS
	Wc9CTi3Ebf/zRVRXHSmyda62TNcj/1+4a97ReDyJlt+vd5bTzb5vPEJ4wbAhhpCWvKmpf7/S9VESG
	2h8k+DxG+MiX35Mph1rhhuucLmCIh6aFEr6JqgT5yPXAZnkfv9reRFImPpKyyF4yn1CCWqdz1I8kW
	JiF0L/Adj97iY2EExnEAgHpCF5t5JUd+ITHtxULtVz87LY4vZile9zaN+Q4GI4DX79EES44gSb23p
	Pj7csH2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghpGG-0003iX-OH; Fri, 11 Jan 2019 05:21:40 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghpG5-0003Xv-8G
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 05:21:35 +0000
Received: by mail-pl1-x641.google.com with SMTP id p8so6247780plo.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 21:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=dSzt7MLRYV+yMWksfXxwLNCwO2m42Y1RhXwyI9Ost9c=;
 b=GkF4aOBNqGTJG7bdvva2HxeTin21woo9vAvEwRxW7LV2lRQ0Ccr5asajkPNWEaG5+N
 gcLwW+4EDQOpMhzqNtLRFsYGitZnX5k+cS9SxRqPnazaSypAWeAawesa+jWCfo+UCzfS
 A7GaqOCCYS51H9uQbH8mluHh8wHjCbVpZKIIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=dSzt7MLRYV+yMWksfXxwLNCwO2m42Y1RhXwyI9Ost9c=;
 b=OM4uERF/VqDLnMwdL5tO5Tnch8YMqaN67/Jsoo9puETfp+uLVHvOZiHRIMfs84ypVA
 7VUYpuASduh6xSr2A/q6f4u4uDquYDeQD9ZzuF8xPZGpgrdPWMaseJqh0Yrvk/Ysv831
 jxcyNXSjQzWtalBqTLEriKYFDMjQFDjbLCCdyqKY6CNN7WEDEKzLOMskVTMVbojJOfMI
 /sZvnrH/ujit9QYn7ZSDscSQ3fSHWQ40kfj8sMjSGOxHqDeANAGI5I/X3Z9KR91d0bk6
 wWnL6I7Q1ZByWcL2GptC7wQh2NwutU0o8p4lSYjEQDrY3g76emlWfT9/6+tuRoXhCTXm
 cDzA==
X-Gm-Message-State: AJcUukc2NiUS4WS+uA0YE2/jkDAHHzz2x17PTJ6kFjAUWr9Un6bhhiQT
 YaNAsTmuqfL06wUpCtnnqr8NsQ==
X-Google-Smtp-Source: ALg8bN7iIvL3Ky8/0EfKkOTKfsqIxVgj72nNPuUzlB6r/kI4qIYSf8+00jioZ/bYwEQXLoK9RoUgjA==
X-Received: by 2002:a17:902:12f:: with SMTP id 44mr1113843plb.74.1547184088506; 
 Thu, 10 Jan 2019 21:21:28 -0800 (PST)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
 by smtp.gmail.com with ESMTPSA id 186sm148425418pga.36.2019.01.10.21.21.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 10 Jan 2019 21:21:27 -0800 (PST)
From: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Subject: [PATCH 2/3] drivers: pwm: pwm-bcm-kona: Add pwm-kona-v2 support
Date: Fri, 11 Jan 2019 10:51:15 +0530
Message-Id: <1547184076-20521-3-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547184076-20521-1-git-send-email-sheetal.tigadoli@broadcom.com>
References: <1547184076-20521-1-git-send-email-sheetal.tigadoli@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_212129_634817_AB55A7BE 
X-CRM114-Status: GOOD (  20.69  )
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
Cc: linux-pwm@vger.kernel.org, Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>,
 Praveen Kumar B <praveen.b@broadcom.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Praveen Kumar B <praveen.b@broadcom.com>

Add support for new version of pwm-kona.
Add support to make PWM changes configured and stable.

Signed-off-by: Praveen Kumar B <praveen.b@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
---
 drivers/pwm/pwm-bcm-kona.c | 128 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 98 insertions(+), 30 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 09a95ae..2b44ad8 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -45,30 +45,39 @@
  *    high or low depending on its state at that exact instant.
  */
 
-#define PWM_CONTROL_OFFSET			(0x00000000)
+#define PWM_CONTROL_OFFSET			0x00000000
 #define PWM_CONTROL_SMOOTH_SHIFT(chan)		(24 + (chan))
 #define PWM_CONTROL_TYPE_SHIFT(chan)		(16 + (chan))
 #define PWM_CONTROL_POLARITY_SHIFT(chan)	(8 + (chan))
 #define PWM_CONTROL_TRIGGER_SHIFT(chan)		(chan)
 
-#define PRESCALE_OFFSET				(0x00000004)
+#define PRESCALE_OFFSET				0x00000004
 #define PRESCALE_SHIFT(chan)			((chan) << 2)
 #define PRESCALE_MASK(chan)			(0x7 << PRESCALE_SHIFT(chan))
-#define PRESCALE_MIN				(0x00000000)
-#define PRESCALE_MAX				(0x00000007)
+#define PRESCALE_MIN				0x00000000
+#define PRESCALE_MAX				0x00000007
 
 #define PERIOD_COUNT_OFFSET(chan)		(0x00000008 + ((chan) << 3))
-#define PERIOD_COUNT_MIN			(0x00000002)
-#define PERIOD_COUNT_MAX			(0x00ffffff)
+#define PERIOD_COUNT_MIN			0x00000002
+#define PERIOD_COUNT_MAX			0x00ffffff
 
 #define DUTY_CYCLE_HIGH_OFFSET(chan)		(0x0000000c + ((chan) << 3))
-#define DUTY_CYCLE_HIGH_MIN			(0x00000000)
-#define DUTY_CYCLE_HIGH_MAX			(0x00ffffff)
+#define DUTY_CYCLE_HIGH_MIN			0x00000000
+#define DUTY_CYCLE_HIGH_MAX			0x00ffffff
+
+#define PWM_MONITOR_OFFSET			0xb0
+#define PWM_MONITOR_TIMEOUT_US			5
+
+enum kona_pwmc_ver {
+	KONA_PWM_V1 = 1,
+	KONA_PWM_V2
+};
 
 struct kona_pwmc {
 	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *clk;
+	enum kona_pwmc_ver version;
 };
 
 static inline struct kona_pwmc *to_kona_pwmc(struct pwm_chip *_chip)
@@ -76,11 +85,40 @@ static inline struct kona_pwmc *to_kona_pwmc(struct pwm_chip *_chip)
 	return container_of(_chip, struct kona_pwmc, chip);
 }
 
+static int kona_pwmc_wait_stable(struct pwm_chip *chip, unsigned int chan,
+				 unsigned int kona_ver)
+{
+	struct kona_pwmc *kp = to_kona_pwmc(chip);
+	unsigned int value;
+	unsigned int count = PWM_MONITOR_TIMEOUT_US * 1000;
+
+	switch (kona_ver) {
+	case KONA_PWM_V1:
+		/*
+		 * There must be a min 400ns delay between clearing trigger and
+		 * settingit. Failing to do this may result in no PWM signal.
+		 */
+		ndelay(400);
+		return 0;
+	case KONA_PWM_V2:
+		do {
+			value = readl(kp->base + PWM_MONITOR_OFFSET);
+			if (!(value & (BIT(chan))))
+				return 0;
+			ndelay(1);
+		} while (count--);
+
+		return -ETIMEDOUT;
+	default:
+		return -ENODEV;
+	}
+}
+
 /*
  * Clear trigger bit but set smooth bit to maintain old output.
  */
-static void kona_pwmc_prepare_for_settings(struct kona_pwmc *kp,
-	unsigned int chan)
+static int kona_pwmc_prepare_for_settings(struct kona_pwmc *kp,
+					  unsigned int chan)
 {
 	unsigned int value = readl(kp->base + PWM_CONTROL_OFFSET);
 
@@ -88,14 +126,10 @@ static void kona_pwmc_prepare_for_settings(struct kona_pwmc *kp,
 	value &= ~(1 << PWM_CONTROL_TRIGGER_SHIFT(chan));
 	writel(value, kp->base + PWM_CONTROL_OFFSET);
 
-	/*
-	 * There must be a min 400ns delay between clearing trigger and setting
-	 * it. Failing to do this may result in no PWM signal.
-	 */
-	ndelay(400);
+	return kona_pwmc_wait_stable(&kp->chip, chan, kp->version);
 }
 
-static void kona_pwmc_apply_settings(struct kona_pwmc *kp, unsigned int chan)
+static int kona_pwmc_apply_settings(struct kona_pwmc *kp, unsigned int chan)
 {
 	unsigned int value = readl(kp->base + PWM_CONTROL_OFFSET);
 
@@ -104,8 +138,7 @@ static void kona_pwmc_apply_settings(struct kona_pwmc *kp, unsigned int chan)
 	value |= 1 << PWM_CONTROL_TRIGGER_SHIFT(chan);
 	writel(value, kp->base + PWM_CONTROL_OFFSET);
 
-	/* Trigger bit must be held high for at least 400 ns. */
-	ndelay(400);
+	return kona_pwmc_wait_stable(&kp->chip, chan, kp->version);
 }
 
 static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -115,6 +148,7 @@ static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	u64 val, div, rate;
 	unsigned long prescale = PRESCALE_MIN, pc, dc;
 	unsigned int value, chan = pwm->hwpwm;
+	int ret;
 
 	/*
 	 * Find period count, duty count and prescale to suit duty_ns and
@@ -156,7 +190,12 @@ static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * validated immediately instead of on enable.
 	 */
 	if (pwm_is_enabled(pwm)) {
-		kona_pwmc_prepare_for_settings(kp, chan);
+		ret = kona_pwmc_prepare_for_settings(kp, chan);
+		if (ret < 0) {
+			dev_err(chip->dev, "failed to prepare pwm settings: %d\n",
+				ret);
+			return ret;
+		}
 
 		value = readl(kp->base + PRESCALE_OFFSET);
 		value &= ~PRESCALE_MASK(chan);
@@ -167,7 +206,12 @@ static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 		writel(dc, kp->base + DUTY_CYCLE_HIGH_OFFSET(chan));
 
-		kona_pwmc_apply_settings(kp, chan);
+		ret = kona_pwmc_apply_settings(kp, chan);
+		if (ret < 0) {
+			dev_err(chip->dev, "failed to apply settings: %d\n",
+				ret);
+			return ret;
+		}
 	}
 
 	return 0;
@@ -187,7 +231,11 @@ static int kona_pwmc_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 		return ret;
 	}
 
-	kona_pwmc_prepare_for_settings(kp, chan);
+	ret = kona_pwmc_prepare_for_settings(kp, chan);
+	if (ret < 0) {
+		dev_err(chip->dev, "failed to prepare pwm settings: %d\n", ret);
+		return ret;
+	}
 
 	value = readl(kp->base + PWM_CONTROL_OFFSET);
 
@@ -198,7 +246,11 @@ static int kona_pwmc_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	writel(value, kp->base + PWM_CONTROL_OFFSET);
 
-	kona_pwmc_apply_settings(kp, chan);
+	ret = kona_pwmc_apply_settings(kp, chan);
+	if (ret < 0) {
+		dev_err(chip->dev, "failed to apply pwm settings: %d\n", ret);
+		return ret;
+	}
 
 	clk_disable_unprepare(kp->clk);
 
@@ -231,8 +283,13 @@ static void kona_pwmc_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct kona_pwmc *kp = to_kona_pwmc(chip);
 	unsigned int chan = pwm->hwpwm;
 	unsigned int value;
+	int ret;
 
-	kona_pwmc_prepare_for_settings(kp, chan);
+	ret = kona_pwmc_prepare_for_settings(kp, chan);
+	if (ret < 0) {
+		dev_err(chip->dev, "failed to prepare pwm settings: %d\n", ret);
+		return;
+	}
 
 	/* Simulate a disable by configuring for zero duty */
 	writel(0, kp->base + DUTY_CYCLE_HIGH_OFFSET(chan));
@@ -243,7 +300,11 @@ static void kona_pwmc_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	value &= ~PRESCALE_MASK(chan);
 	writel(value, kp->base + PRESCALE_OFFSET);
 
-	kona_pwmc_apply_settings(kp, chan);
+	ret = kona_pwmc_apply_settings(kp, chan);
+	if (ret < 0) {
+		dev_err(chip->dev, "failed to prepare pwm settings: %d\n", ret);
+		return;
+	}
 
 	clk_disable_unprepare(kp->clk);
 }
@@ -256,14 +317,26 @@ static void kona_pwmc_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	.owner = THIS_MODULE,
 };
 
+static const struct of_device_id bcm_kona_pwmc_dt[] = {
+	{ .compatible = "brcm,kona-pwm", .data = (void *)KONA_PWM_V1},
+	{ .compatible = "brcm,kona-pwm-v2", .data = (void *)KONA_PWM_V2},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, bcm_kona_pwmc_dt);
+
 static int kona_pwmc_probe(struct platform_device *pdev)
 {
 	struct kona_pwmc *kp;
 	struct resource *res;
+	const struct of_device_id *of_id;
 	unsigned int chan;
 	unsigned int value = 0;
 	int ret = 0;
 
+	of_id = of_match_node(bcm_kona_pwmc_dt, pdev->dev.of_node);
+	if (!of_id)
+		return -ENODEV;
+
 	kp = devm_kzalloc(&pdev->dev, sizeof(*kp), GFP_KERNEL);
 	if (kp == NULL)
 		return -ENOMEM;
@@ -276,6 +349,7 @@ static int kona_pwmc_probe(struct platform_device *pdev)
 	kp->chip.npwm = 6;
 	kp->chip.of_xlate = of_pwm_xlate_with_flags;
 	kp->chip.of_pwm_n_cells = 3;
+	kp->version = (enum kona_pwmc_ver)of_id->data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	kp->base = devm_ioremap_resource(&pdev->dev, res);
@@ -322,12 +396,6 @@ static int kona_pwmc_remove(struct platform_device *pdev)
 	return pwmchip_remove(&kp->chip);
 }
 
-static const struct of_device_id bcm_kona_pwmc_dt[] = {
-	{ .compatible = "brcm,kona-pwm" },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, bcm_kona_pwmc_dt);
-
 static struct platform_driver kona_pwmc_driver = {
 	.driver = {
 		.name = "bcm-kona-pwm",
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
