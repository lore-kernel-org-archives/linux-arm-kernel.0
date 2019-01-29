Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3E9C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:36:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D853A2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M3fbA4Ct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D853A2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+cWujpEXf35PkEMHfYRbd3TzicNkuJyzhbZ2VOskdJs=; b=M3fbA4CtD5O4xF
	cWjdPN9wIo+m+9Ai4sLN4My8vht0O8NGPuXtgtOJbPAA7Tjl4f/TSwTmVL7m6HII5D0cKXjA6cbKl
	UZgimuAeFPpOECm++6468gSte3jp1xLs6/17od72EegCvWECVWA7uZPL+voyPybTCazAIVvEbrbL5
	bNOG3EBPzeq9X5H/jxUYJsnySx+Hc8omb17Xnazbmt1gU3iQwFxQp9OwoJgvsi38K8XEDPUnf5/xF
	33VUvBmcjkjLykJ25F7B4Kvg0HnInwGqM4H0qKUbX0HMRtQRFWjMzXl2NabJvjnMrLI+tK8yFgWLl
	FS635tt6DgftIhRphIeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goN0O-0006aO-KY; Tue, 29 Jan 2019 06:36:20 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goMzW-0005od-Q5; Tue, 29 Jan 2019 06:35:28 +0000
X-UUID: b2e2946d9a6a4445935e4bc985ac9ba6-20190128
X-UUID: b2e2946d9a6a4445935e4bc985ac9ba6-20190128
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <andrew-sh.cheng@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 643623121; Mon, 28 Jan 2019 22:35:17 -0800
Received: from MTKMBS01N2.mediatek.inc (172.21.101.79) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 28 Jan 2019 22:35:16 -0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 29 Jan 2019 14:35:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Tue, 29 Jan 2019 14:35:10 +0800
From: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park
 <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, "Rob
 Herring" <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/3] devfreq: add mediatek cci devfreq
Date: Tue, 29 Jan 2019 14:35:04 +0800
Message-ID: <1548743704-16821-4-git-send-email-andrew-sh.cheng@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1548743704-16821-1-git-send-email-andrew-sh.cheng@mediatek.com>
References: <1548743704-16821-1-git-send-email-andrew-sh.cheng@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: AB3E92C340FECE0B34C63EFF9A9587E5758820EC4A6AD836B24201A1DC3711C32000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_223526_909759_AEF66D7B 
X-CRM114-Status: GOOD (  20.11  )
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
Cc: devicetree@vger.kernel.org,
 "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>, srv_heupstream@mediatek.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, fan.chen@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>

For big/little cpu cluster architecture,
not only CPU frequency, but CCI frequency will also affect performance.

Little cores and cci share the same buck in Mediatek mt8183 IC,
so we add a CCI devfreq which will get notification when buck voltage
is changed, then CCI devfreq can set cci frequency as high as possible.

Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
---
 drivers/devfreq/Kconfig              |   9 ++
 drivers/devfreq/Makefile             |   1 +
 drivers/devfreq/mt8183-cci-devfreq.c | 224 +++++++++++++++++++++++++++++++++++
 3 files changed, 234 insertions(+)
 create mode 100644 drivers/devfreq/mt8183-cci-devfreq.c

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 6a172d3..0b14aab 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -113,6 +113,15 @@ config ARM_RK3399_DMC_DEVFREQ
           It sets the frequency for the memory controller and reads the usage counts
           from hardware.
 
+config ARM_MT8183_CCI_DEVFREQ
+	tristate "MT8183 CCI DEVFREQ Driver"
+	depends on ARM_MEDIATEK_CPUFREQ
+	help
+		This adds devfreq for cci clock
+		which is shared the same regulator with cpu cluster.
+		It can track buck voltage and update a proper cci frequency.
+		Use notification to get regulator status.
+
 source "drivers/devfreq/event/Kconfig"
 
 endif # PM_DEVFREQ
diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
index 32b8d4d..25afe8c 100644
--- a/drivers/devfreq/Makefile
+++ b/drivers/devfreq/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
 obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
 obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
 obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra-devfreq.o
+obj-$(CONFIG_ARM_MT8183_CCI_DEVFREQ)	+= mt8183-cci-devfreq.o
 
 # DEVFREQ Event Drivers
 obj-$(CONFIG_PM_DEVFREQ_EVENT)		+= event/
diff --git a/drivers/devfreq/mt8183-cci-devfreq.c b/drivers/devfreq/mt8183-cci-devfreq.c
new file mode 100644
index 0000000..4837892
--- /dev/null
+++ b/drivers/devfreq/mt8183-cci-devfreq.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2018 MediaTek Inc.
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/devfreq.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+
+#include "governor.h"
+
+struct cci_devfreq_data {
+	struct devfreq		*devfreq;
+	struct regulator	*proc_reg;
+	struct clk		*cci_clk;
+	unsigned long		buck_volt;
+	int			volt_increasing;
+	struct notifier_block	nb;
+};
+
+static int mtk_cci_governor_get_target(struct devfreq *devfreq,
+				       unsigned long *freq)
+{
+	struct cci_devfreq_data *cci_devdata;
+	int	i, opp_count;
+	struct dev_pm_opp	*opp;
+	unsigned long	opp_rate, opp_voltage;
+
+	cci_devdata = dev_get_drvdata(devfreq->dev.parent);
+
+	/* find available frequency */
+	opp_count = dev_pm_opp_get_opp_count(devfreq->dev.parent);
+	for (i = 0, opp_rate = ULONG_MAX; i < opp_count; i++, opp_rate--) {
+		opp = dev_pm_opp_find_freq_floor(devfreq->dev.parent,
+						 &opp_rate);
+		opp_voltage = dev_pm_opp_get_voltage(opp);
+		dev_pm_opp_put(opp);
+
+		if (opp_voltage <= cci_devdata->buck_volt)
+			break;
+	}
+	*freq = opp_rate;
+
+	return 0;
+}
+
+static int mtk_cci_governor_event_handler(struct devfreq *devfreq,
+					  unsigned int event, void *data)
+{
+	return 0;
+}
+
+static struct devfreq_governor mtk_cci_devfreq_governor = {
+	.name = "voltage_monitor",
+	.get_target_freq = mtk_cci_governor_get_target,
+	.event_handler = mtk_cci_governor_event_handler,
+};
+
+static int mtk_cci_devfreq_target(struct device *dev, unsigned long *freq,
+				  u32 flags)
+{
+	struct cci_devfreq_data *cci_devdata;
+
+	cci_devdata = dev_get_drvdata(dev);
+
+	clk_set_rate(cci_devdata->cci_clk, *freq);
+
+	return 0;
+}
+
+static struct devfreq_dev_profile cci_devfreq_profile = {
+	.polling_ms	= 0,
+	.target		= mtk_cci_devfreq_target,
+};
+
+static int cci_devfreq_regulator_notifier(struct notifier_block *nb,
+					  unsigned long val, void *data)
+{
+	struct cci_devfreq_data *cci_devdata =
+		container_of(nb, struct cci_devfreq_data, nb);
+
+	/* deal with reduce frequency */
+	if (val & REGULATOR_EVENT_PRE_VOLTAGE_CHANGE) {
+		struct pre_voltage_change_data *pvc_data = data;
+
+		if (pvc_data->old_uV > pvc_data->min_uV) {
+			cci_devdata->volt_increasing = 0;
+			cci_devdata->buck_volt =
+				(unsigned long)(pvc_data->min_uV);
+			mutex_lock(&cci_devdata->devfreq->lock);
+			update_devfreq(cci_devdata->devfreq);
+			mutex_unlock(&cci_devdata->devfreq->lock);
+		} else {
+			cci_devdata->volt_increasing = 1;
+		}
+	}
+	/* deal with abort reduce frequency */
+	if ((val & REGULATOR_EVENT_ABORT_VOLTAGE_CHANGE) ||
+	    /* deal with increase frequency */
+	    ((val & REGULATOR_EVENT_VOLTAGE_CHANGE) &&
+	     cci_devdata->volt_increasing == 1)) {
+		cci_devdata->buck_volt = (unsigned long)data;
+		mutex_lock(&cci_devdata->devfreq->lock);
+		update_devfreq(cci_devdata->devfreq);
+		mutex_unlock(&cci_devdata->devfreq->lock);
+	}
+
+	return 0;
+}
+
+static int mtk_cci_devfreq_probe(struct platform_device *pdev)
+{
+	struct device *cci_dev = &pdev->dev;
+	struct cci_devfreq_data *cci_devdata;
+	struct notifier_block *nb;
+	int ret;
+
+	dev_pm_opp_of_add_table(&pdev->dev);
+
+	cci_devdata = devm_kzalloc(cci_dev, sizeof(*cci_devdata), GFP_KERNEL);
+	if (!cci_devdata)
+		return -ENOMEM;
+	nb = &cci_devdata->nb;
+	cci_devdata->cci_clk = ERR_PTR(-ENODEV);
+	cci_devdata->proc_reg = ERR_PTR(-ENODEV);
+
+	cci_devdata->cci_clk = clk_get(cci_dev, "cci_clock");
+	ret = PTR_ERR_OR_ZERO(cci_devdata->cci_clk);
+	if (ret) {
+		if (ret == -EPROBE_DEFER)
+			pr_err("cci clock not ready, retry\n");
+		else
+			pr_err("no clock for cci: %d\n", ret);
+
+		goto out_free_resources;
+	}
+
+	cci_devdata->proc_reg = regulator_get_optional(cci_dev, "proc");
+	ret = PTR_ERR_OR_ZERO(cci_devdata->proc_reg);
+	if (ret) {
+		if (ret == -EPROBE_DEFER)
+			pr_err("cci regulator not ready, retry\n");
+		else
+			pr_err("no regulator for cci: %d\n", ret);
+
+		goto out_free_resources;
+	}
+
+	platform_set_drvdata(pdev, cci_devdata);
+
+	/* create cci_devfreq and add to cci device.
+	 * governor is voltage_monitor.
+	 * governor will get platform_device data to make decision.
+	 */
+	cci_devdata->devfreq = devm_devfreq_add_device(cci_dev,
+						       &cci_devfreq_profile,
+						       "voltage_monitor",
+						       NULL);
+
+	nb->notifier_call = cci_devfreq_regulator_notifier;
+	regulator_register_notifier(cci_devdata->proc_reg,
+				    nb);
+
+	return 0;
+
+out_free_resources:
+	if (!IS_ERR(cci_devdata->cci_clk))
+		clk_put(cci_devdata->cci_clk);
+	if (!IS_ERR(cci_devdata->proc_reg))
+		regulator_put(cci_devdata->proc_reg);
+
+	return ret;
+}
+
+static const struct of_device_id mediatek_cci_devfreq_of_match[] = {
+	{ .compatible = "mediatek,mt8183-cci" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, mediatek_cci_devfreq_of_match);
+
+static struct platform_driver cci_devfreq_driver = {
+	.probe	= mtk_cci_devfreq_probe,
+	.driver = {
+		.name = "mediatek-cci-devfreq",
+		.of_match_table = mediatek_cci_devfreq_of_match,
+	},
+};
+
+static int __init mtk_cci_devfreq_init(void)
+{
+	int ret = 0;
+
+	ret = devfreq_add_governor(&mtk_cci_devfreq_governor);
+	if (ret) {
+		pr_err("%s: failed to add governor: %d\n", __func__, ret);
+		return ret;
+	}
+
+	ret = platform_driver_register(&cci_devfreq_driver);
+	if (ret)
+		devfreq_remove_governor(&mtk_cci_devfreq_governor);
+
+	return ret;
+}
+module_init(mtk_cci_devfreq_init)
+
+static void __exit mtk_cci_devfreq_exit(void)
+{
+	int ret = 0;
+
+	platform_driver_unregister(&cci_devfreq_driver);
+
+	ret = devfreq_remove_governor(&mtk_cci_devfreq_governor);
+	if (ret)
+		pr_err("%s: failed to remove governor: %d\n", __func__, ret);
+}
+module_exit(mtk_cci_devfreq_exit)
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Mediatek CCI devfreq driver");
+MODULE_AUTHOR("andrew-sh.cheng");
+
-- 
1.8.1.1.dirty


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
