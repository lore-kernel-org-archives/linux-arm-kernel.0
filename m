Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C164DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:08:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55F1920874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ezJ9FmHe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YU+p55Se"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F1920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ENsyy9XYoC6Q5bXgg7pxGYJDkN05/NpQqNPQ3CiqM60=; b=ezJ9FmHesQFe+kDmQ809g+r42U
	vcxO4VBNT4b5hNlSydWtxjwg5lp3Y5UwjdniDwufjaKAlqYDoEmet1pXzPXoihdjPVSvfi5yWlc5J
	1jagEYglSnsEPW2dD+i6AY8k8T+D+WCJX1tFpSpHrF0eqgHAXKbcOLqTjZyW2qayd4zjjzMKdG83O
	SPIek0AgnRPi+xp+IcQY+rAsu294WHGlpccrixd88/GZMnx7KT4WntfoD6pkwDYSL5JlG0fQ7knNh
	5nnkM/CNX3KNUkPNLuQeWpG0np61InmxoPqO0WJZLIdDlm0S9h0smjUIgQpEOldQayKlxIArG3KPr
	Y/sE9iFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghp3M-0006Zu-4y; Fri, 11 Jan 2019 05:08:20 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghp2t-00063D-Ok
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 05:07:59 +0000
Received: by mail-pl1-x642.google.com with SMTP id y1so6215397plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 21:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=dSzt7MLRYV+yMWksfXxwLNCwO2m42Y1RhXwyI9Ost9c=;
 b=YU+p55SeJnQIgHec7XAyUbKnjGviwd9lj4/hjGV7pU0JlBvGpr7fB2OPSIizePumQw
 A4QA0cX9oN2AWA1N5HGcX9xtpBFGPE4giN6v0VK7Wj4rEJ9J/v+BW1Tc/dnmb0///afD
 j3Ci7u4e237aDGZcBMtvnC1PYNfiKPlzKx4PM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=dSzt7MLRYV+yMWksfXxwLNCwO2m42Y1RhXwyI9Ost9c=;
 b=o1WOKtQ1oUS8v/hN2QYtDQUY52i/eu7FvN29Y+HHXy0c50AZlHvf73GoU45OOw2U7w
 yuPH9WJ0K2Pw6RxailP/e4kK5TiPCHR0Q4OUa8YLhJZ76Sxg47LK6aYuSFjykp/3lStu
 fIAMRgMH7vO+y4Z3zdnHOmblCOweslTQju5CZGRH2zf67129vLAzrM7G9pFajMdjsDpf
 pRkFH3HwnvjRYi2wXmydMlGdWq+cfddfLw48XrW0nKlE8/gwQGfZMdX3TnOXo3tIFZIl
 g0AvfTXPly3bdyMYuXUzNsXq6KUVAx/Q95Ky/7c554rDTQquga1OuG15BOToAemOieLs
 cc3Q==
X-Gm-Message-State: AJcUukf+5L0gNE0Z5GtzveJbztKpJH1qp55w6/q/0PjH2Qr7WqFkcTh6
 jU5G6Gj5N9BG1FhROi494fUC6g==
X-Google-Smtp-Source: ALg8bN6qXpH5ZU7dI/TegGYCFj13wZx36FSvwK3yp9r91sma0olWBDoJ00hBgaT6WmO/9zi0rJq7RA==
X-Received: by 2002:a17:902:4025:: with SMTP id
 b34mr13388395pld.181.1547183270812; 
 Thu, 10 Jan 2019 21:07:50 -0800 (PST)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
 by smtp.gmail.com with ESMTPSA id d6sm107520893pgc.89.2019.01.10.21.07.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 10 Jan 2019 21:07:50 -0800 (PST)
From: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Subject: [PATCH INTERNAL V3 2/3] drivers: pwm: pwm-bcm-kona: Add pwm-kona-v2
 support
Date: Fri, 11 Jan 2019 10:38:03 +0530
Message-Id: <1547183284-19956-3-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547183284-19956-1-git-send-email-sheetal.tigadoli@broadcom.com>
References: <1547183284-19956-1-git-send-email-sheetal.tigadoli@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_210752_269459_0A72EF3A 
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
