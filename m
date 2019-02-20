Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9DEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:09:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BF682147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P/I8OsMf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF682147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7KnQq2R5hk31TTxhuhYJ2jTsticUMl3uNuUZFbMYsRQ=; b=P/I8OsMfcv0Hti
	o90u87QlvsIZpUkhie+79cwFn3IYxpedPSG0m11sg3Fzfr4JXUNIXAyTObWiYDMClNTBOZu7u60YS
	prLJAQXbzhvBDPLu5u1fjktlJuIBmXdY/AgyObw7NMnq5NCwphWdO2kcZGVyJsZ7S3hL3m4qvofWk
	j3sFKK68wSqqV5ZFgnflIu1pj1id1isEQ47ILr8PIFYcpim5xEW+LktRA/UWvXdraP4WvOwE5QBid
	jV5NIna+VK9qIigf1HIwa8awDU37r+s7xAWTCsoKs8+fSoTafoU9zpWzKcMCmyFWiks5ZRM0v9hiK
	TqBTnJxNLhQFafiiNVcw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwRdJ-0006oe-Te; Wed, 20 Feb 2019 13:09:53 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwRcl-00068Q-Gp
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 13:09:25 +0000
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1KD6Mpa018722; Wed, 20 Feb 2019 14:09:10 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qr6x5s9fh-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Wed, 20 Feb 2019 14:09:10 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1AEE334;
 Wed, 20 Feb 2019 13:09:10 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E843F2BB4;
 Wed, 20 Feb 2019 13:09:09 +0000 (GMT)
Received: from localhost (10.75.127.47) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2;
 Wed, 20 Feb 2019 14:09:09 +0100
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <thierry.reding@gmail.com>
Subject: [PATCH v5 3/3] pwm: core: add consumer device link
Date: Wed, 20 Feb 2019 14:07:48 +0100
Message-ID: <1550668068-9661-4-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550668068-9661-1-git-send-email-fabrice.gasnier@st.com>
References: <1550668068-9661-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-20_11:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_050919_848291_E1DEEAF3 
X-CRM114-Status: GOOD (  19.89  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com,
 tduszyns@gmail.com, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 robh+dt@kernel.org, mcoquelin.stm32@gmail.com, u.kleine-koenig@pengutronix.de,
 fabrice.gasnier@st.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a device link between the PWM consumer and the PWM provider. This
enforces the PWM user to get suspended before the PWM provider. It
allows proper synchronization of suspend/resume sequences: the PWM user
is responsible for properly stopping PWM, before the provider gets
suspended: see [1]. Add the device link in:
- of_pwm_get()
- pwm_get()
- devm_*pwm_get() variants
as it requires a reference to the device for the PWM consumer.

[1] https://lkml.org/lkml/2019/2/5/770

Suggested-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v5:
- fix a style issue
- use dev_warn() instead of pr_warn

Changes in v4:
- rework error handling following Thierry's comments
- turn/split pr_debug() into dev_err()/pr_warn().

Changes in v3:
- add struct device to of_get_pwm() arguments to handle device link from
  there as discussed with Uwe.
---
 drivers/pwm/core.c  | 50 +++++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/pwm.h |  6 ++++--
 2 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 1581f6a..03aa1b5 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -636,8 +636,35 @@ static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
 	return ERR_PTR(-EPROBE_DEFER);
 }
 
+static struct device_link *pwm_device_link_add(struct device *dev,
+					       struct pwm_device *pwm)
+{
+	struct device_link *dl;
+
+	if (!dev) {
+		/*
+		 * No device for the PWM consumer has been provided. It may
+		 * impact the PM sequence ordering: the PWM supplier may get
+		 * suspended before the consumer.
+		 */
+		dev_warn(pwm->chip->dev,
+			 "No consumer device specified to create a link to\n");
+		return NULL;
+	}
+
+	dl = device_link_add(dev, pwm->chip->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
+	if (!dl) {
+		dev_err(dev, "failed to create device link to %s\n",
+			dev_name(pwm->chip->dev));
+		return ERR_PTR(-EINVAL);
+	}
+
+	return dl;
+}
+
 /**
  * of_pwm_get() - request a PWM via the PWM framework
+ * @dev: device for PWM consumer
  * @np: device node to get the PWM from
  * @con_id: consumer name
  *
@@ -655,10 +682,12 @@ static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
  * Returns: A pointer to the requested PWM device or an ERR_PTR()-encoded
  * error code on failure.
  */
-struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
+struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
+			      const char *con_id)
 {
 	struct pwm_device *pwm = NULL;
 	struct of_phandle_args args;
+	struct device_link *dl;
 	struct pwm_chip *pc;
 	int index = 0;
 	int err;
@@ -689,6 +718,14 @@ struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
 	if (IS_ERR(pwm))
 		goto put;
 
+	dl = pwm_device_link_add(dev, pwm);
+	if (IS_ERR(dl)) {
+		/* of_xlate ended up calling pwm_request_from_chip() */
+		pwm_free(pwm);
+		pwm = ERR_CAST(dl);
+		goto put;
+	}
+
 	/*
 	 * If a consumer name was not given, try to look it up from the
 	 * "pwm-names" property if it exists. Otherwise use the name of
@@ -764,6 +801,7 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 	const char *dev_id = dev ? dev_name(dev) : NULL;
 	struct pwm_device *pwm;
 	struct pwm_chip *chip;
+	struct device_link *dl;
 	unsigned int best = 0;
 	struct pwm_lookup *p, *chosen = NULL;
 	unsigned int match;
@@ -771,7 +809,7 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 
 	/* look up via DT first */
 	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
-		return of_pwm_get(dev->of_node, con_id);
+		return of_pwm_get(dev, dev->of_node, con_id);
 
 	/*
 	 * We look up the provider in the static table typically provided by
@@ -848,6 +886,12 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 	if (IS_ERR(pwm))
 		return pwm;
 
+	dl = pwm_device_link_add(dev, pwm);
+	if (IS_ERR(dl)) {
+		pwm_free(pwm);
+		return ERR_CAST(dl);
+	}
+
 	pwm->args.period = chosen->period;
 	pwm->args.polarity = chosen->polarity;
 
@@ -939,7 +983,7 @@ struct pwm_device *devm_of_pwm_get(struct device *dev, struct device_node *np,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	pwm = of_pwm_get(np, con_id);
+	pwm = of_pwm_get(dev, np, con_id);
 	if (!IS_ERR(pwm)) {
 		*ptr = pwm;
 		devres_add(dev, ptr);
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index d5199b5..895e074 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -406,7 +406,8 @@ struct pwm_device *of_pwm_xlate_with_flags(struct pwm_chip *pc,
 		const struct of_phandle_args *args);
 
 struct pwm_device *pwm_get(struct device *dev, const char *con_id);
-struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id);
+struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
+			      const char *con_id);
 void pwm_put(struct pwm_device *pwm);
 
 struct pwm_device *devm_pwm_get(struct device *dev, const char *con_id);
@@ -494,7 +495,8 @@ static inline struct pwm_device *pwm_get(struct device *dev,
 	return ERR_PTR(-ENODEV);
 }
 
-static inline struct pwm_device *of_pwm_get(struct device_node *np,
+static inline struct pwm_device *of_pwm_get(struct device *dev,
+					    struct device_node *np,
 					    const char *con_id)
 {
 	return ERR_PTR(-ENODEV);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
