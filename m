Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E767FC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:43:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6B7220842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bhKrACgw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B7220842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C0qjdRa6dc75tYFNppRRyk0E8GExdJirjoNy5lYWGXE=; b=bhKrACgwoGv4wl
	oAnQ2k0MPm7iWg0GDmvz9jX4HroNgwyrBSB6dEaxicUJ3NgFfT9j4AqwYP6gNjQPB1toBUCXixfFQ
	I2LeFvDpKS0HkQhVHuGEQ+ZvBoGWW7QysRTDkDDosgczdwwPspE8ZA3kVCL8T95yJpXGTAqtRkdbs
	83A+mF/j3VQmJUVGrRU94E3PAvhZzkZA9Gme60wUv9hcEGXUUieeXMLKZds3wsUCxj9F2SXkFpxqs
	1RojKBuTWk8Julad++SzRWDgYHQeEba+sC33XFk2/prfJSzcfodfPhgInufveTpqsVNTK1ZcikLLR
	PkL02qKOSc7OF3TBVblA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyDjn-0002zi-JN; Mon, 25 Feb 2019 10:43:55 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyDjN-0002Tl-0x
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 10:43:32 +0000
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1PAftBv025960; Mon, 25 Feb 2019 11:43:15 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qtvtwsdep-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Mon, 25 Feb 2019 11:43:15 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BE1C73A;
 Mon, 25 Feb 2019 10:43:12 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 92F242844;
 Mon, 25 Feb 2019 10:43:12 +0000 (GMT)
Received: from localhost (10.75.127.44) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2;
 Mon, 25 Feb 2019 11:43:11 +0100
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <robh+dt@kernel.org>, <alexandre.torgue@st.com>
Subject: [PATCH 2/2] iio: counter: stm32-lptimer: Add power management support
Date: Mon, 25 Feb 2019 11:42:47 +0100
Message-ID: <1551091367-21718-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551091367-21718-1-git-send-email-fabrice.gasnier@st.com>
References: <1551091367-21718-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-25_06:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_024329_553073_70B09CEC 
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 benjamin.gaignard@linaro.org, lars@metafoo.de, mcoquelin.stm32@gmail.com,
 linux-iio@vger.kernel.org, arnaud.pouliquen@st.com,
 linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de,
 fabrice.gasnier@st.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add suspend/resume PM sleep ops. When going to low power, disable
active counter. Only active counter should be resumed: don't touch
disabled counter, as it may be used by other LPTimer MFD child driver.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/counter/stm32-lptimer-cnt.c | 55 +++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/iio/counter/stm32-lptimer-cnt.c b/drivers/iio/counter/stm32-lptimer-cnt.c
index 42fb8ba..2a49cce 100644
--- a/drivers/iio/counter/stm32-lptimer-cnt.c
+++ b/drivers/iio/counter/stm32-lptimer-cnt.c
@@ -14,6 +14,7 @@
 #include <linux/iio/iio.h>
 #include <linux/mfd/stm32-lptimer.h>
 #include <linux/module.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 
 struct stm32_lptim_cnt {
@@ -23,6 +24,7 @@ struct stm32_lptim_cnt {
 	u32 preset;
 	u32 polarity;
 	u32 quadrature_mode;
+	bool enabled;
 };
 
 static int stm32_lptim_is_enabled(struct stm32_lptim_cnt *priv)
@@ -50,6 +52,7 @@ static int stm32_lptim_set_enable_state(struct stm32_lptim_cnt *priv,
 
 	if (!enable) {
 		clk_disable(priv->clk);
+		priv->enabled = false;
 		return 0;
 	}
 
@@ -79,6 +82,7 @@ static int stm32_lptim_set_enable_state(struct stm32_lptim_cnt *priv,
 		regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
 		return ret;
 	}
+	priv->enabled = true;
 
 	/* Start LP timer in continuous mode */
 	return regmap_update_bits(priv->regmap, STM32_LPTIM_CR,
@@ -361,6 +365,56 @@ static int stm32_lptim_cnt_probe(struct platform_device *pdev)
 	return devm_iio_device_register(&pdev->dev, indio_dev);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int stm32_lptim_cnt_suspend(struct device *dev)
+{
+	struct stm32_lptim_cnt *priv = dev_get_drvdata(dev);
+	int ret;
+
+	/* Only take care of enabled counter: don't disturb other MFD child */
+	if (priv->enabled) {
+		ret = stm32_lptim_setup(priv, 0);
+		if (ret)
+			return ret;
+
+		ret = stm32_lptim_set_enable_state(priv, 0);
+		if (ret)
+			return ret;
+
+		/* Force enable state for later resume */
+		priv->enabled = true;
+	}
+
+	return pinctrl_pm_select_sleep_state(dev);
+}
+
+static int stm32_lptim_cnt_resume(struct device *dev)
+{
+	struct stm32_lptim_cnt *priv = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pinctrl_pm_select_default_state(dev);
+	if (ret)
+		return ret;
+
+	if (priv->enabled) {
+		priv->enabled = false;
+		ret = stm32_lptim_setup(priv, 1);
+		if (ret)
+			return ret;
+
+		ret = stm32_lptim_set_enable_state(priv, 1);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(stm32_lptim_cnt_pm_ops, stm32_lptim_cnt_suspend,
+			 stm32_lptim_cnt_resume);
+
 static const struct of_device_id stm32_lptim_cnt_of_match[] = {
 	{ .compatible = "st,stm32-lptimer-counter", },
 	{},
@@ -372,6 +426,7 @@ static struct platform_driver stm32_lptim_cnt_driver = {
 	.driver = {
 		.name = "stm32-lptimer-counter",
 		.of_match_table = stm32_lptim_cnt_of_match,
+		.pm = &stm32_lptim_cnt_pm_ops,
 	},
 };
 module_platform_driver(stm32_lptim_cnt_driver);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
