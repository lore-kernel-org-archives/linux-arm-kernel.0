Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7E1C282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:53:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AEBD2082C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MJZQzNbT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mt1rbyKo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AEBD2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8hTO8Onr97quwNF3rOoENE3zhd7mfxiroLMT7Q3S0KY=; b=MJZQzNbTPPHVSI
	T/+00BQaXiRjK3psAE40OO2w+Y99ga+ClCca2kMiXS+yOESHL9fVNNrp2decujM/AEpIEZB5VNjRD
	J1PlRFCRTh+/Yo1Z2q+DoS6tWDZ9+NNihy3sOmZkNZm1ypNYf/WI7WyiAzcxGEgKs9eAlAR1BQE0x
	dfrQvumasoE/Ug3Hl+P0BTbhmKPwA665R2aa4AdV+djyl0SByXp4SL7nfK2WzvSs1ScXitFw6B2XA
	92S1vpSHcW3UCMcdWg2eZUV2c8em0vQDRm0kXNnKh9l/upAlcxKsEe4b/G3pFgRaIP9TXb4KvaY5/
	8xsqm1bPML3itwjb5+KA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gomYy-0003NK-Vj; Wed, 30 Jan 2019 09:53:45 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gomYq-0003MR-HX
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 09:53:43 +0000
Received: by mail-wm1-x343.google.com with SMTP id n190so20945079wmd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 01:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dpepguYKa93uvnR9U774spYX7Jjb1lKwQhQj5NL8T8o=;
 b=Mt1rbyKoGoxQYnEWLFHU3eq8avrS5CPT+Ek81W4bOApyp/KHaPJuetQOhiVgwwhe9O
 cSsokr6elQvFfPTX+afMgVyp0HtyhtVVMqgEyypjAhBOxnSvPs0Xpp6+kpOSjnAv3upo
 f1k3rZdIrzUIkt4peOnsHE9aQPuj5/wgY/ITs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dpepguYKa93uvnR9U774spYX7Jjb1lKwQhQj5NL8T8o=;
 b=NlnPWtfo4C0R9KTK2OFkss9eGB9TRWEgBvzefuKqHsO1jYLrFXzHDDiXAvh0uwGUTc
 nXjgw7hsQiWqET52tQv/xFAYsNXlLu6F8rzhLHChn6XIpJOoxGlOHKfSrqoXEtSduRvZ
 IigFoFjvvJdGhXcVS0VyGXS2HUQN1xKgGqTHjpDbi9qI4950xDQuplSFVNWOZtj4K9Fc
 6CJ8gkceCeCS8IEl5JYYPAeT0RPV4tvWH3vUYsi3ez1moFPMw+bDGgPCVDBVxOf4esHb
 3k9Jbkz0jS2YgOGrw38oulS4YJm6Zi3BpsE3Mz4aUL4nccVabWij5oKT+ObYCsaB0nao
 iFqw==
X-Gm-Message-State: AJcUukdrt/eGP+gDSfUTXwI2DDr35zi1kJL7sumPqay3O+xSqvx6d79p
 SuUR9LzMLOP2zQwMjROQPGwOHw==
X-Google-Smtp-Source: ALg8bN68jFqOKOKYbDdVyzzHZFayG4Pd/yCnV6XLbBUaBk1F9G3f6bYb012FxUfcrUaNkvX0Vdl6pg==
X-Received: by 2002:a1c:c60e:: with SMTP id w14mr26117385wmf.18.1548842014776; 
 Wed, 30 Jan 2019 01:53:34 -0800 (PST)
Received: from [192.168.1.2] (99.red-79-146-83.dynamicip.rima-tde.net.
 [79.146.83.99])
 by smtp.gmail.com with ESMTPSA id x81sm1125240wmg.17.2019.01.30.01.53.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 01:53:34 -0800 (PST)
Subject: Re: [PATCH v2 2/2] phy: qualcomm: usb: Add Super-Speed PHY driver
To: Bjorn Andersson <bjorn.andersson@linaro.org>
References: <1548761715-4004-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548761715-4004-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20190129202726.GA3036@builder>
From: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <fbd70494-e2f1-ae04-8b14-2cc97cead8b9@linaro.org>
Date: Wed, 30 Jan 2019 10:53:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190129202726.GA3036@builder>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_015336_602189_07F68A0D 
X-CRM114-Status: GOOD (  30.30  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, jackp@codeaurora.org,
 shawn.guo@linaro.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 khasim.mohammed@linaro.org, linux-kernel@vger.kernel.org, swboyd@chromium.org,
 vkoul@kernel.org, linux-arm-msm@vger.kernel.org, andy.gross@linaro.org,
 kishon@ti.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/29/19 21:27, Bjorn Andersson wrote:
> On Tue 29 Jan 03:35 PST 2019, Jorge Ramirez-Ortiz wrote:
>> diff --git a/drivers/phy/qualcomm/phy-qcom-usb-ss.c b/drivers/phy/qualcomm/phy-qcom-usb-ss.c
>> new file mode 100644
>> index 0000000..e6ae96e
>> --- /dev/null
>> +++ b/drivers/phy/qualcomm/phy-qcom-usb-ss.c
>> @@ -0,0 +1,347 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2012-2014,2017 The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2018, Linaro Limited
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/phy/phy.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/reset.h>
>> +#include <linux/slab.h>
>> +
>> +#define PHY_CTRL0			0x6C
>> +#define PHY_CTRL1			0x70
>> +#define PHY_CTRL2			0x74
>> +#define PHY_CTRL4			0x7C
>> +
>> +/* PHY_CTRL bits */
>> +#define REF_PHY_EN			BIT(0)
>> +#define LANE0_PWR_ON			BIT(2)
>> +#define SWI_PCS_CLK_SEL			BIT(4)
>> +#define TST_PWR_DOWN			BIT(4)
>> +#define PHY_RESET			BIT(7)
>> +
>> +enum phy_vdd_ctrl { ENABLE, DISABLE, };
> 
> Use bool to describe boolean values.

um, ok, but these are not booleans, they are actions (ie ctrl = action
not true or false).

anyway will change it to something else

> 
>> +enum phy_regulator { VDD, VDDA1P8, };
> 
> It doesn't look like you need either of these if you remove the
> set_voltage calls.

we need to point to the regulator in the array so we need an index to it
somehow.

> 
>> +
>> +struct ssphy_priv {
>> +	void __iomem *base;
>> +	struct device *dev;
>> +	struct reset_control *reset_com;
>> +	struct reset_control *reset_phy;
>> +	struct regulator *vbus;
>> +	struct regulator_bulk_data *regs;
>> +	int num_regs;
>> +	struct clk_bulk_data *clks;
>> +	int num_clks;
>> +	enum phy_mode mode;
>> +};
>> +
>> +static inline void qcom_ssphy_updatel(void __iomem *addr, u32 mask, u32 val)
>> +{
>> +	writel((readl(addr) & ~mask) | val, addr);
>> +}
>> +
>> +static inline int qcom_ssphy_vbus_enable(struct regulator *vbus)
>> +{
>> +	return !regulator_is_enabled(vbus) ? regulator_enable(vbus) : 0;
> 
> regulator_is_enabled() will check if the actual regulator is on, not if
> you already voted for it.
> 
> So if something else is enabling the vbus regulator you will skip your
> enable and be in the mercy of them not releasing it. Presumably there's
> only one consumer of this particular regulator, but it's a bad habit.

yep

> 
> Please keep track of this drivers requested state in this driver, if
> qcom_ssphy_vbus_ctrl() is called not only for the state changes.

um, there is not such a function: the ctrl function is not for vbus but
for vdd

> 
>> +}
>> +
>> +static inline int qcom_ssphy_vbus_disable(struct regulator *vbus)
>> +{
>> +	return regulator_is_enabled(vbus) ? regulator_disable(vbus) : 0;
>> +}
>> +
>> +static int qcom_ssphy_vdd_ctrl(struct ssphy_priv *priv, enum phy_vdd_ctrl ctrl)
> 
> As discussed on IRC, I think you should just leave the voltage
> constraints to DeviceTree.

yes

> 
>> +{
>> +	const int vdd_min = ctrl == ENABLE ? 1050000 : 0;
>> +	const int vdd_max = 1050000;
>> +	int ret;
>> +
>> +	ret = regulator_set_voltage(priv->regs[VDD].consumer, vdd_min, vdd_max);
>> +	if (ret)
>> +		dev_err(priv->dev, "Failed to set regulator vdd to %d\n",
>> +			vdd_min);
>> +
>> +	return ret;
>> +}
> [..]
>> +static int qcom_ssphy_power_on(struct phy *phy)
>> +{
>> +	struct ssphy_priv *priv = phy_get_drvdata(phy);
>> +	int ret;
>> +
>> +	ret = qcom_ssphy_vdd_ctrl(priv, ENABLE);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regulator_bulk_enable(priv->num_regs, priv->regs);
>> +	if (ret)
>> +		goto err1;
>> +
>> +	ret = clk_bulk_prepare_enable(priv->num_clks, priv->clks);
>> +	if (ret)
>> +		goto err2;
>> +
>> +	ret = qcom_ssphy_vbus_ctrl(priv->vbus, priv->mode);
>> +	if (ret)
>> +		goto err3;
>> +
>> +	ret = qcom_ssphy_do_reset(priv);
>> +	if (ret)
>> +		goto err4;
>> +
>> +	writeb(SWI_PCS_CLK_SEL, priv->base + PHY_CTRL0);
>> +	qcom_ssphy_updatel(priv->base + PHY_CTRL4, LANE0_PWR_ON, LANE0_PWR_ON);
>> +	qcom_ssphy_updatel(priv->base + PHY_CTRL2, REF_PHY_EN, REF_PHY_EN);
>> +	qcom_ssphy_updatel(priv->base + PHY_CTRL4, TST_PWR_DOWN, 0);
>> +
>> +	return 0;
>> +err4:
> 
> Name your labels based on what they do, e.g. err_disable_vbus.

ok

> 
>> +	if (priv->vbus && priv->mode != PHY_MODE_INVALID)
>> +		qcom_ssphy_vbus_disable(priv->vbus);
> 
> qcom_ssphy_vbus_ctrl() above was either enabling or disabling vbus, but
> here you're directly calling disable to unroll that. It think the result
> is correct (in host this reverts to disabled and in gadget it's a
> no-op), but I'm not sure I like the design of sometimes calling straight
> to the vbus enable/disable and sometimes to the wrapper function.

I think you misread: we have vbus enable/disable and vdd control
(different regulators)


I have to admit that the only reason I had separate functions for vbus
enable/disable was cosmetic (and "if" on the control variable + another
"if" to check that the regulator was already voted was taking me beyond
the 80 lines character and I hate when that happens on simple
operations). anyway will redo

> 
>> +err3:
> 
> err_clk_disable
> 
>> +	clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
>> +err2:
>> +	regulator_bulk_disable(priv->num_regs, priv->regs);
>> +err1:
>> +	qcom_ssphy_vdd_ctrl(priv, DISABLE);
>> +
>> +	return ret;
>> +}
>> +
>> +static int qcom_ssphy_power_off(struct phy *phy)
>> +{
>> +	struct ssphy_priv *priv = phy_get_drvdata(phy);
>> +
>> +	qcom_ssphy_updatel(priv->base + PHY_CTRL4, LANE0_PWR_ON, 0);
>> +	qcom_ssphy_updatel(priv->base + PHY_CTRL2, REF_PHY_EN, 0);
>> +	qcom_ssphy_updatel(priv->base + PHY_CTRL4, TST_PWR_DOWN, TST_PWR_DOWN);
>> +
>> +	clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
>> +	regulator_bulk_disable(priv->num_regs, priv->regs);
>> +
>> +	if (priv->vbus && priv->mode != PHY_MODE_INVALID)
>> +		qcom_ssphy_vbus_disable(priv->vbus);
>> +
>> +	qcom_ssphy_vdd_ctrl(priv, DISABLE);
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_ssphy_init_clock(struct ssphy_priv *priv)
>> +{
>> +	const char * const clk_id[] = { "ref", "phy", "pipe", };
>> +	int i;
>> +
>> +	priv->num_clks = ARRAY_SIZE(clk_id);
>> +	priv->clks = devm_kcalloc(priv->dev, priv->num_clks,
>> +				  sizeof(*priv->clks), GFP_KERNEL);
> 
> You know num_clks is 3, so I would suggest that you just change the
> sshphy_priv to clks[3] and skip the dynamic allocation.


ok

> 
> 
> Also, as num_clks always is ARRAY_SIZE(priv->clks) I would suggest using
> the latter, to make that clear throughout the driver.

maybe then just define NBR_CLKS (I find long lines a pain to read)

> 
>> +	if (!priv->clks)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < priv->num_clks; i++)
>> +		priv->clks[i].id = clk_id[i];
> 
> There's no harm in just writing this on three lines:
> 
> 	priv->clks[0].id = "ref";
> 	priv->clks[1].id = "phy";
> 	priv->clks[2].id = "pipe";
> 
>> +
>> +	return devm_clk_bulk_get(priv->dev, priv->num_clks, priv->clks);
>> +}
>> +
>> +static int qcom_ssphy_init_regulator(struct ssphy_priv *priv)
>> +{
>> +	const char * const reg_supplies[] = {
>> +		[VDD] = "vdd",
>> +		[VDDA1P8] = "vdda1p8",
>> +	};
>> +	int ret, i;
>> +
>> +	priv->num_regs = ARRAY_SIZE(reg_supplies);
>> +	priv->regs = devm_kcalloc(priv->dev, priv->num_regs,
>> +				  sizeof(*priv->regs), GFP_KERNEL);
> 
> As with clocks, you know there will only be 2 of these, make it fixed
> size in ssphy_priv.

well ok

> 
> And as with clocks, I would suggest using ARRAY_SIZE(priv->regs)
> throughout the driver to make it obvious that's it's a static number. 
> 
>> +	if (!priv->regs)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < priv->num_regs; i++)
>> +		priv->regs[i].supply = reg_supplies[i];
> 
> As with clocks, just unroll this and fill in the 2 supplies directly.

um, ok, I find the above more readable but I see where you are going
with these sort of recomendations...will just follow them

> 
>> +
>> +	ret = devm_regulator_bulk_get(priv->dev, priv->num_regs, priv->regs);
>> +	if (ret)
>> +		return ret;
>> +
>> +	priv->vbus = devm_regulator_get_optional(priv->dev, "vbus");
> 
> get_optional means that if vbus-supply is not found, rather than
> returning a dummy regulator object this will fail with -ENODEV.

yes I messed this up.

> 
> Given the rest of the logic related to vbus you should set vbus to NULL
> if the returned PTR_ERR(value) is -ENODEV, and fail for other errors.
> 
> 
> Or just drop the _optional, and let your vbus controls operate on the
> dummy regulator you get back.

yes will do this. thanks for the suggestion and the review!

> 
> (Right now vbus can't be NULL, so these checks are not very useful)
> 
>> +	if (IS_ERR(priv->vbus))
>> +		return PTR_ERR(priv->vbus);
>> +
>> +	return 0;
> 
> return PTR_ERR_OR_ZERO(priv->vbus)
> 
> (Although that might change based on above comment)
> 
>> +}
> 
> Regards,
> Bjorn
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
