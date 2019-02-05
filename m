Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D620C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:41:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F28A62083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DDj1xWJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F28A62083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l9id4V3ovmMJgDqf381wpUJespoZsxxD6J8jOWkiaAI=; b=DDj1xWJSt6rLAR
	UQhfnUKmVYeJbUDtZ64jQNx6c3RUsoFCtJ68NpRCsoHteqxCWZ2QF+p5tL1opLYmy2V+5ZW/IQhjV
	mqOnTfQsx4zTtt9olKs+vaZ/lo8JI6zfprB0r/QAnKp3LnhKXV6pFGL8fT+FtahKx4/nNao18wUou
	c0/69gxwtGAi4r3kl1pJ3n3LAx3BDixxLK0U5Ou64ljmvSQA+b136vlJ6kMyaOdIFrjdd88cVtZZf
	Z6rm8IIvvNuXdNMhhVsbjCedxbaQN6oc9P2k75EOXcLXeO7aEPS/U6Mv3ydyCD5jiT+2lZlDwkH8K
	tR+v+mGvJWqqv089lHbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr02y-00034o-Dk; Tue, 05 Feb 2019 12:41:52 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr01z-00026p-D6
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 12:40:55 +0000
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x15CaEJQ002718; Tue, 5 Feb 2019 13:40:42 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qd1v06pqn-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Tue, 05 Feb 2019 13:40:42 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 43A8A31;
 Tue,  5 Feb 2019 12:40:42 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 20A8829AC;
 Tue,  5 Feb 2019 12:40:42 +0000 (GMT)
Received: from localhost (10.75.127.47) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2;
 Tue, 5 Feb 2019 13:40:41 +0100
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <thierry.reding@gmail.com>, <robh+dt@kernel.org>
Subject: [PATCH 2/4] pwm: stm32-lp: Add power management support
Date: Tue, 5 Feb 2019 13:40:27 +0100
Message-ID: <1549370429-19116-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
References: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-05_05:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_044051_782206_0A01F18E 
X-CRM114-Status: GOOD (  13.55  )
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
 linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, vilhelm.gray@gmail.com,
 mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add suspend/resume PM sleep ops. When going to low power, disable
active PWM channel. Active PWM channel is resumed, by calling
pwm_apply_state(). This is inspired by Thierry's comment in [1].
Don't touch inactive channels, as it may be used by other LPTimer MFD
child driver.
[1]https://lkml.org/lkml/2017/12/5/175

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/pwm/pwm-stm32-lp.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 0059b24c..0c40d48 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -13,6 +13,7 @@
 #include <linux/mfd/stm32-lptimer.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 
@@ -20,6 +21,8 @@ struct stm32_pwm_lp {
 	struct pwm_chip chip;
 	struct clk *clk;
 	struct regmap *regmap;
+	struct pwm_state suspend;
+	bool suspended;
 };
 
 static inline struct stm32_pwm_lp *to_stm32_pwm_lp(struct pwm_chip *chip)
@@ -223,6 +226,40 @@ static int stm32_pwm_lp_remove(struct platform_device *pdev)
 	return pwmchip_remove(&priv->chip);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int stm32_pwm_lp_suspend(struct device *dev)
+{
+	struct stm32_pwm_lp *priv = dev_get_drvdata(dev);
+
+	pwm_get_state(&priv->chip.pwms[0], &priv->suspend);
+	priv->suspended = priv->suspend.enabled;
+
+	/* safe to call pwm_disable() for already disabled pwm */
+	pwm_disable(&priv->chip.pwms[0]);
+
+	return pinctrl_pm_select_sleep_state(dev);
+}
+
+static int stm32_pwm_lp_resume(struct device *dev)
+{
+	struct stm32_pwm_lp *priv = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pinctrl_pm_select_default_state(dev);
+	if (ret)
+		return ret;
+
+	/* Only restore suspended pwm, not to disrupt other MFD child */
+	if (!priv->suspended)
+		return 0;
+
+	return pwm_apply_state(&priv->chip.pwms[0], &priv->suspend);
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(stm32_pwm_lp_pm_ops, stm32_pwm_lp_suspend,
+			 stm32_pwm_lp_resume);
+
 static const struct of_device_id stm32_pwm_lp_of_match[] = {
 	{ .compatible = "st,stm32-pwm-lp", },
 	{},
@@ -235,6 +272,7 @@ static int stm32_pwm_lp_remove(struct platform_device *pdev)
 	.driver	= {
 		.name = "stm32-pwm-lp",
 		.of_match_table = of_match_ptr(stm32_pwm_lp_of_match),
+		.pm = &stm32_pwm_lp_pm_ops,
 	},
 };
 module_platform_driver(stm32_pwm_lp_driver);
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
