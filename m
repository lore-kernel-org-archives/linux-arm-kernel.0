Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28840C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 03:08:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCDDF222D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 03:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SjeYKkQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCDDF222D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h0C1pmNpF8rtGeICvnyDaTyg7bwsmgV9eOw8bT3oSOw=; b=SjeYKkQsJCgLpI
	tyv5ATe55LZyyLAIOh05yaQ7yYDkvXroHFvl85Bl98OShgefNZU+JdXi/Cgx4otmQzL6dqIYgwQ8d
	9vaQtNYVm4VyMUn80WLStfRBEYkv5bocKuplsuN61XPHhVtDAiV9qbcVEWXx+9849xZPYIkui0jAb
	JhPsJdMWmBXJ8yxc+30vfpc4UAF/8RzIShjQkO21k5w9Bf2wudxUR5f847T8gyfXP4CKIDCvGiDoH
	e28UlM3vg48p6DdX6LHBTlEq8kM4XzuIGXWSP42/lIhL8EcVoXV7ZVYX1BkWIwa1LZsxukui1jaL1
	RuSRmOyLYsqQGlKSaDtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guqKn-0001op-M8; Sat, 16 Feb 2019 03:08:09 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guqKj-0001oP-1q; Sat, 16 Feb 2019 03:08:07 +0000
X-UUID: 1bb4e8b5b5e246bd8d77368f8364df5a-20190215
X-UUID: 1bb4e8b5b5e246bd8d77368f8364df5a-20190215
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <andrew-sh.cheng@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1730267117; Fri, 15 Feb 2019 19:08:01 -0800
Received: from mtkmbs03n2.mediatek.inc (172.21.101.182) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 15 Feb 2019 19:07:59 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 16 Feb 2019 11:07:45 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 16 Feb 2019 11:07:45 +0800
Message-ID: <1550286465.23797.20.camel@mtksdaap41>
Subject: Re: [PATCH 3/3] devfreq: add mediatek cci devfreq
From: andrew-sh.cheng <andrew-sh.cheng@mediatek.com>
To: Matthias Kaehlcke <mka@chromium.org>
Date: Sat, 16 Feb 2019 11:07:45 +0800
In-Reply-To: <20190201201338.GS81583@google.com>
References: <1548743704-16821-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1548743704-16821-4-git-send-email-andrew-sh.cheng@mediatek.com>
 <20190201201338.GS81583@google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 036AD9B5E7862132CB1C77CDCF6DAE575BC6F9626415CF3DB078D8AEE81ECC152000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_190805_107398_4932B745 
X-CRM114-Status: GOOD (  38.52  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com, linux-pm@vger.kernel.org,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Chanwoo
 Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, fan.chen@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 2019-02-01 at 12:13 -0800, Matthias Kaehlcke wrote:
> Hi Andrew,
> 
> On Tue, Jan 29, 2019 at 02:35:04PM +0800, Andrew-sh Cheng wrote:
> > From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
> 
> the 'From' tag is only needed when you send patches not authored by
> yourself. It doesn't do any harm either, but you can drop it in future
> submissions.
Got it~
> 
> > For big/little cpu cluster architecture,
> > not only CPU frequency, but CCI frequency will also affect performance.
> 
> This doesn't provide much information, I suggest to drop it unless
> others find it valuable.
I will remove it in next patch.
> 
> > Little cores and cci share the same buck in Mediatek mt8183 IC,
> > so we add a CCI devfreq which will get notification when buck voltage
> > is changed, then CCI devfreq can set cci frequency as high as
> > possible.
> 
> Possible alternative:
> 
> "This adds a devfreq driver for the Cache Coherent Interconnect (CCI)
> of the Mediatek MT8183.
> 
> On the MT8183 the CCI is supplied by the same regulator as the LITTLE
> cores. The driver is notified when the regulator voltage changes
> (driven by cpufreq) and adjusts the CCI frequency to the maximum
> possible value."
> 
> Feel free to ignore or to adjust.
Thank you. This description provide suitable information.
> 
> > Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> > ---
> >  drivers/devfreq/Kconfig              |   9 ++
> >  drivers/devfreq/Makefile             |   1 +
> >  drivers/devfreq/mt8183-cci-devfreq.c | 224 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 234 insertions(+)
> >  create mode 100644 drivers/devfreq/mt8183-cci-devfreq.c
> > 
> > diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> > index 6a172d3..0b14aab 100644
> > --- a/drivers/devfreq/Kconfig
> > +++ b/drivers/devfreq/Kconfig
> > @@ -113,6 +113,15 @@ config ARM_RK3399_DMC_DEVFREQ
> >            It sets the frequency for the memory controller and reads the usage counts
> >            from hardware.
> >  
> > +config ARM_MT8183_CCI_DEVFREQ
> > +	tristate "MT8183 CCI DEVFREQ Driver"
> > +	depends on ARM_MEDIATEK_CPUFREQ
> > +	help
> > +		This adds devfreq for cci clock
> 
> "This adds a devfreq driver for the Cache Coherent Interconnect (CCI)
> of the Mediatek MT8183"?
Yes, I describe more detail in next patch.
> 
> > +		which is shared the same regulator with cpu cluster.
> > +		It can track buck voltage and update a proper cci frequency.
> > +		Use notification to get regulator status.
> 
> not sure how important this info is here, sounds more like an
> implementation detail to me.
Yes, just describe the situation.
> 
> > +
> >  source "drivers/devfreq/event/Kconfig"
> >  
> >  endif # PM_DEVFREQ
> > diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> > index 32b8d4d..25afe8c 100644
> > --- a/drivers/devfreq/Makefile
> > +++ b/drivers/devfreq/Makefile
> > @@ -11,6 +11,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
> >  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
> >  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
> >  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra-devfreq.o
> > +obj-$(CONFIG_ARM_MT8183_CCI_DEVFREQ)	+= mt8183-cci-devfreq.o
> >  
> >  # DEVFREQ Event Drivers
> >  obj-$(CONFIG_PM_DEVFREQ_EVENT)		+= event/
> > diff --git a/drivers/devfreq/mt8183-cci-devfreq.c b/drivers/devfreq/mt8183-cci-devfreq.c
> > new file mode 100644
> > index 0000000..4837892
> > --- /dev/null
> > +++ b/drivers/devfreq/mt8183-cci-devfreq.c
> > @@ -0,0 +1,224 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// Copyright (c) 2018 MediaTek Inc.
> 
> 2019 :)
Got it  :)
> 
> > +#include <linux/cpu.h>
> > +#include <linux/cpufreq.h>
> > +#include <linux/devfreq.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regulator/consumer.h>
> > +
> > +#include "governor.h"
> > +
> > +struct cci_devfreq_data {
> 
> nit: consider dropping the '_data' suffix, it doesn't add much/any
> value.
I will change to struct cci_devfreq in next patch.
> 
> > +	struct devfreq		*devfreq;
> > +	struct regulator	*proc_reg;
> > +	struct clk		*cci_clk;
> > +	unsigned long		buck_volt;
> 
> proc_reg_uV?
> 
> place after proc_reg
OK~
> 
> > +	int			volt_increasing;
> 
> should be bool
> 
> actually, is it really needed? See comment in cci_devfreq_regulator_notifier()
> 
You are right. I will remove this and use notification data to judge the
condition in next patch.

> > +	struct notifier_block	nb;
> > +};
> > +
> > +static int mtk_cci_governor_get_target(struct devfreq *devfreq,
> > +				       unsigned long *freq)
> > +{
> > +	struct cci_devfreq_data *cci_devdata;
> 
> nit: consider calling it 'cci_df' (here and elsewhere). In the context
> the abbreviation is clear and there is less clutter when accessing
> fields in the structure.
OK, I will change it in next patch. 
> 
> > +	int	i, opp_count;
> > +	struct dev_pm_opp	*opp;
> > +	unsigned long	opp_rate, opp_voltage;
> > +
> > +	cci_devdata = dev_get_drvdata(devfreq->dev.parent);
> > +
> > +	/* find available frequency */
> > +	opp_count = dev_pm_opp_get_opp_count(devfreq->dev.parent);
> > +	for (i = 0, opp_rate = ULONG_MAX; i < opp_count; i++, opp_rate--) {
> > +		opp = dev_pm_opp_find_freq_floor(devfreq->dev.parent,
> > +						 &opp_rate);
> > +		opp_voltage = dev_pm_opp_get_voltage(opp);
> > +		dev_pm_opp_put(opp);
> > +
> > +		if (opp_voltage <= cci_devdata->buck_volt)
> > +			break;
> > +	}
> > +	*freq = opp_rate;
> > +
> > +	return 0;
> > +}
> > +
> > +static int mtk_cci_governor_event_handler(struct devfreq *devfreq,
> > +					  unsigned int event, void *data)
> > +{
> > +	return 0;
> > +}
> > +
> > +static struct devfreq_governor mtk_cci_devfreq_governor = {
> > +	.name = "voltage_monitor",
> 
> "mtk_cci_vmon" or similar?
OK. I will change it in next patch. 

> > +	.get_target_freq = mtk_cci_governor_get_target,
> > +	.event_handler = mtk_cci_governor_event_handler,
> > +};
> > +
> > +static int mtk_cci_devfreq_target(struct device *dev, unsigned long *freq,
> > +				  u32 flags)
> > +{
> > +	struct cci_devfreq_data *cci_devdata;
> > +
> > +	cci_devdata = dev_get_drvdata(dev);
> > +
> > +	clk_set_rate(cci_devdata->cci_clk, *freq);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct devfreq_dev_profile cci_devfreq_profile = {
> > +	.polling_ms	= 0,
> > +	.target		= mtk_cci_devfreq_target,
> > +};
> > +
> > +static int cci_devfreq_regulator_notifier(struct notifier_block *nb,
> > +					  unsigned long val, void *data)
> > +{
> > +	struct cci_devfreq_data *cci_devdata =
> > +		container_of(nb, struct cci_devfreq_data, nb);
> > +
> > +	/* deal with reduce frequency */
> > +	if (val & REGULATOR_EVENT_PRE_VOLTAGE_CHANGE) {
> > +		struct pre_voltage_change_data *pvc_data = data;
> > +
> > +		if (pvc_data->old_uV > pvc_data->min_uV) {
> 
> I would suggest to invert the condition. For humans it is easier to
> parse "is the new voltage smaller than the previous one", than
> viceversa.
Got it.
> 
> > +			cci_devdata->volt_increasing = 0;
> > +			cci_devdata->buck_volt =
> > +				(unsigned long)(pvc_data->min_uV);
> > +			mutex_lock(&cci_devdata->devfreq->lock);
> > +			update_devfreq(cci_devdata->devfreq);
> > +			mutex_unlock(&cci_devdata->devfreq->lock);
> > +		} else {
> > +			cci_devdata->volt_increasing = 1;
> > +		}
> > +	}
> 
> nit: add empty line
I will modify in next patch.
> 
> > +	/* deal with abort reduce frequency */
> 
> Shouldn't this be "abort voltage change?". If so I suggest to drop the
> comment, REGULATOR_EVENT_ABORT_VOLTAGE_CHANGE in the condition makes
> it clear.
OK
> 
> > +	if ((val & REGULATOR_EVENT_ABORT_VOLTAGE_CHANGE) ||
> > +	    /* deal with increase frequency */
> > +	    ((val & REGULATOR_EVENT_VOLTAGE_CHANGE) &&
> > +	     cci_devdata->volt_increasing == 1)) {
> 
> to check for a voltage increase you could use 'cci_devdata->buck_volt
> < (unsigned long)data' instead of ->volt_increasing.
Thank you for suggestion.
I will modify in next patch.
> 
> > +		cci_devdata->buck_volt = (unsigned long)data;
> > +		mutex_lock(&cci_devdata->devfreq->lock);
> > +		update_devfreq(cci_devdata->devfreq);
> > +		mutex_unlock(&cci_devdata->devfreq->lock);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int mtk_cci_devfreq_probe(struct platform_device *pdev)
> > +{
> > +	struct device *cci_dev = &pdev->dev;
> > +	struct cci_devfreq_data *cci_devdata;
> > +	struct notifier_block *nb;
> > +	int ret;
> > +
> > +	dev_pm_opp_of_add_table(&pdev->dev);
> > +
> > +	cci_devdata = devm_kzalloc(cci_dev, sizeof(*cci_devdata), GFP_KERNEL);
> > +	if (!cci_devdata)
> > +		return -ENOMEM;
> > +	nb = &cci_devdata->nb;
> > +	cci_devdata->cci_clk = ERR_PTR(-ENODEV);
> 
> initialization not needed, the field is assigned a few lines below.
> 
> > +	cci_devdata->proc_reg = ERR_PTR(-ENODEV);
> 
> also not really needed with the right gotos in place
OK. I will remove unnecessary initialization. 
> 
> > +
> > +	cci_devdata->cci_clk = clk_get(cci_dev, "cci_clock");
> > +	ret = PTR_ERR_OR_ZERO(cci_devdata->cci_clk);
> > +	if (ret) {
> > +		if (ret == -EPROBE_DEFER)
> > +			pr_err("cci clock not ready, retry\n");
> > +		else
> > +			pr_err("no clock for cci: %d\n", ret);
> > +
> > +		goto out_free_resources;
> 
> nothing to be freed here, just return ret.
OK.
> 
> > +	}
> > +
> > +	cci_devdata->proc_reg = regulator_get_optional(cci_dev, "proc");
> > +	ret = PTR_ERR_OR_ZERO(cci_devdata->proc_reg);
> > +	if (ret) {
> > +		if (ret == -EPROBE_DEFER)
> > +			pr_err("cci regulator not ready, retry\n");
> > +		else
> > +			pr_err("no regulator for cci: %d\n", ret);
> > +
> > +		goto out_free_resources;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, cci_devdata);
> > +
> > +	/* create cci_devfreq and add to cci device.
> > +	 * governor is voltage_monitor.
> > +	 * governor will get platform_device data to make decision.
> > +	 */
> > +	cci_devdata->devfreq = devm_devfreq_add_device(cci_dev,
> > +						       &cci_devfreq_profile,
> > +						       "voltage_monitor",
> 
> adjust name in case you follow my suggestion above.
> 
> check cci_devdata->devfreq for errors.
Will add error check in next patch.
> 
> > +						       NULL);
> > +
> > +	nb->notifier_call = cci_devfreq_regulator_notifier;
> > +	regulator_register_notifier(cci_devdata->proc_reg,
> > +				    nb);
> > +
> > +	return 0;
> > +
> > +out_free_resources:
> > +	if (!IS_ERR(cci_devdata->cci_clk))
> > +		clk_put(cci_devdata->cci_clk);
> > +	if (!IS_ERR(cci_devdata->proc_reg))
> > +		regulator_put(cci_devdata->proc_reg);
> 
> use individual labels and get rid of the IS_ERRs.
> 
> e.g.
> 
> err_put_reg:
> 	regulator_put(cci_devdata->proc_reg);
> 
> err_put_clk:
> 	clk_put(cci_devdata->cci_clk);
> 
> 
> and jump to the corresponding lable above.
Got it. I will use individual label and remove the IS_ERR checking.
> 
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct of_device_id mediatek_cci_devfreq_of_match[] = {
> > +	{ .compatible = "mediatek,mt8183-cci" },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, mediatek_cci_devfreq_of_match);
> > +
> > +static struct platform_driver cci_devfreq_driver = {
> > +	.probe	= mtk_cci_devfreq_probe,
> > +	.driver = {
> > +		.name = "mediatek-cci-devfreq",
> > +		.of_match_table = mediatek_cci_devfreq_of_match,
> > +	},
> > +};
> > +
> > +static int __init mtk_cci_devfreq_init(void)
> > +{
> > +	int ret = 0;
> 
> initialization not needed
OK.
> 
> > +
> > +	ret = devfreq_add_governor(&mtk_cci_devfreq_governor);
> > +	if (ret) {
> > +		pr_err("%s: failed to add governor: %d\n", __func__, ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = platform_driver_register(&cci_devfreq_driver);
> > +	if (ret)
> > +		devfreq_remove_governor(&mtk_cci_devfreq_governor);
> > +
> > +	return ret;
> > +}
> > +module_init(mtk_cci_devfreq_init)
> > +
> > +static void __exit mtk_cci_devfreq_exit(void)
> > +{
> > +	int ret = 0;
> 
> initialization not needed
OK.
> 
> > +	platform_driver_unregister(&cci_devfreq_driver);
> > +
> > +	ret = devfreq_remove_governor(&mtk_cci_devfreq_governor);
> > +	if (ret)
> > +		pr_err("%s: failed to remove governor: %d\n", __func__, ret);
> 
> typically you reverse the order of initialization, i.e. remove the
> governor, then unregister the driver.
OK. I will change it in next patch.

> 
> > +}
> > +module_exit(mtk_cci_devfreq_exit)
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DESCRIPTION("Mediatek CCI devfreq driver");
> > +MODULE_AUTHOR("andrew-sh.cheng");
> 
> should be either "Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>" or
> "Andrew-sh.Cheng"
I will change to "Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>"  :)
> 
> Cheers
> 
> Matthias
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
