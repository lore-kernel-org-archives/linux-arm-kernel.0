Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FD8C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:27:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F76D21473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cs48fZgP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kReRXwnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F76D21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r2yCtW4rp43l92KqVO99xBnYgA+USAKPn9avYvxBNFY=; b=Cs48fZgP0CrGHL
	zvJ6Me8ADwB8YvaW+RqrJCwD8DlN6k70jTH9iuJuSznBXK1BB8DKnho5S1BpAfC3dRXjKFFB8dUqE
	JYdmjGyKK5oQJDu6m0Pge8IbGsFl4W5MC8/Dalp9Op6YKpfckaPaVO+fap5jQ2bZIGhdQEyHIRiZe
	jeKDbCdrltTEZKopBNlLyU+L+L7fRZY7A1NvWRpu9U6VCL7/nu3I0M/XCL2Qhtukka3OfqjnBsLLS
	K6B6AlpPp1yxHfWcVrZYgR7oVSo0QCmJP8RBxeF/fIYNnE4zWE4xyeUlJvwEg6nLIfb/YbAv0hluK
	dLuj4zW+3+mLOiUj7ZDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goZz3-0004tY-2O; Tue, 29 Jan 2019 20:27:49 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goZyz-0004t5-Ff
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 20:27:47 +0000
Received: by mail-pg1-x543.google.com with SMTP id j10so9259194pga.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 12:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=FcXX162GqhxYJvEtt0yO0BCjii24nkrvGMIFzvdDOIU=;
 b=kReRXwnNv9LdWNm9YCPt8kgqNiKnumGOhE3nk1ifJaU9YFoUPYUThUHCc/uGenOrZl
 Rsz6/DEbTIehqY2NJhGdHpyyE5h9HpTxUkyWD1iy3qfqym14NuD4JDGjYig5ONXLqcmK
 J20e2P7g+fAqwaeGD1nWEgpEdV2KNPls1dYg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=FcXX162GqhxYJvEtt0yO0BCjii24nkrvGMIFzvdDOIU=;
 b=SEftBmsbz4sXTjOVQtcy3/yIPJv/LKEYVf+94es4NbJW5XkO6vBnBVOcIcdL+PZlcV
 EpxuM+eBcGlF/2/iRUPtxbN+gUPG7e/FcJ+G2mRCs+gazfj2aV5Z69X2GrUFns/a4OBt
 usfGvlpyJBsBTobmAKLuDlTWfJiuVy9Z6itDK0T/aRTxjmO6s0jZaWa/DGLvP8ePmzM9
 Ho8qY3mQpeogfIflhYZJwUIEu2dgcgKLjp8ZPzgaWn10dD9QwOOOcw2/iEm3+mh/ZQdK
 gtEGg9rzhR24ZAYrkZqXqcQPkQTLs58TnqNaoze/0hJRQln+BHkFCUDyAc2meDhxNzd3
 9MCg==
X-Gm-Message-State: AJcUukfdLU+fDmrZtkNe1KVtXIMGPiTvjMOCQ9vP0INkJa7QYS3esJRu
 kNwbbg/lSUwB3qPVJlKhXFZl1g==
X-Google-Smtp-Source: ALg8bN4ZtZ2R5A1iBrYut3stE1Zu34zmPfEZwJwEBlHcx8zHXSHsl0XDs2uQHOyK2tofLtOYQ0O0+A==
X-Received: by 2002:a62:4181:: with SMTP id g1mr27587030pfd.45.1548793664269; 
 Tue, 29 Jan 2019 12:27:44 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id 6sm78912651pfv.30.2019.01.29.12.27.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Jan 2019 12:27:43 -0800 (PST)
Date: Tue, 29 Jan 2019 12:27:26 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH v2 2/2] phy: qualcomm: usb: Add Super-Speed PHY driver
Message-ID: <20190129202726.GA3036@builder>
References: <1548761715-4004-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548761715-4004-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548761715-4004-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_122745_536167_54F73EA4 
X-CRM114-Status: GOOD (  22.43  )
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

On Tue 29 Jan 03:35 PST 2019, Jorge Ramirez-Ortiz wrote:
> diff --git a/drivers/phy/qualcomm/phy-qcom-usb-ss.c b/drivers/phy/qualcomm/phy-qcom-usb-ss.c
> new file mode 100644
> index 0000000..e6ae96e
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-usb-ss.c
> @@ -0,0 +1,347 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2012-2014,2017 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2018, Linaro Limited
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +
> +#define PHY_CTRL0			0x6C
> +#define PHY_CTRL1			0x70
> +#define PHY_CTRL2			0x74
> +#define PHY_CTRL4			0x7C
> +
> +/* PHY_CTRL bits */
> +#define REF_PHY_EN			BIT(0)
> +#define LANE0_PWR_ON			BIT(2)
> +#define SWI_PCS_CLK_SEL			BIT(4)
> +#define TST_PWR_DOWN			BIT(4)
> +#define PHY_RESET			BIT(7)
> +
> +enum phy_vdd_ctrl { ENABLE, DISABLE, };

Use bool to describe boolean values.

> +enum phy_regulator { VDD, VDDA1P8, };

It doesn't look like you need either of these if you remove the
set_voltage calls.

> +
> +struct ssphy_priv {
> +	void __iomem *base;
> +	struct device *dev;
> +	struct reset_control *reset_com;
> +	struct reset_control *reset_phy;
> +	struct regulator *vbus;
> +	struct regulator_bulk_data *regs;
> +	int num_regs;
> +	struct clk_bulk_data *clks;
> +	int num_clks;
> +	enum phy_mode mode;
> +};
> +
> +static inline void qcom_ssphy_updatel(void __iomem *addr, u32 mask, u32 val)
> +{
> +	writel((readl(addr) & ~mask) | val, addr);
> +}
> +
> +static inline int qcom_ssphy_vbus_enable(struct regulator *vbus)
> +{
> +	return !regulator_is_enabled(vbus) ? regulator_enable(vbus) : 0;

regulator_is_enabled() will check if the actual regulator is on, not if
you already voted for it.

So if something else is enabling the vbus regulator you will skip your
enable and be in the mercy of them not releasing it. Presumably there's
only one consumer of this particular regulator, but it's a bad habit.

Please keep track of this drivers requested state in this driver, if
qcom_ssphy_vbus_ctrl() is called not only for the state changes.

> +}
> +
> +static inline int qcom_ssphy_vbus_disable(struct regulator *vbus)
> +{
> +	return regulator_is_enabled(vbus) ? regulator_disable(vbus) : 0;
> +}
> +
> +static int qcom_ssphy_vdd_ctrl(struct ssphy_priv *priv, enum phy_vdd_ctrl ctrl)

As discussed on IRC, I think you should just leave the voltage
constraints to DeviceTree.

> +{
> +	const int vdd_min = ctrl == ENABLE ? 1050000 : 0;
> +	const int vdd_max = 1050000;
> +	int ret;
> +
> +	ret = regulator_set_voltage(priv->regs[VDD].consumer, vdd_min, vdd_max);
> +	if (ret)
> +		dev_err(priv->dev, "Failed to set regulator vdd to %d\n",
> +			vdd_min);
> +
> +	return ret;
> +}
[..]
> +static int qcom_ssphy_power_on(struct phy *phy)
> +{
> +	struct ssphy_priv *priv = phy_get_drvdata(phy);
> +	int ret;
> +
> +	ret = qcom_ssphy_vdd_ctrl(priv, ENABLE);
> +	if (ret)
> +		return ret;
> +
> +	ret = regulator_bulk_enable(priv->num_regs, priv->regs);
> +	if (ret)
> +		goto err1;
> +
> +	ret = clk_bulk_prepare_enable(priv->num_clks, priv->clks);
> +	if (ret)
> +		goto err2;
> +
> +	ret = qcom_ssphy_vbus_ctrl(priv->vbus, priv->mode);
> +	if (ret)
> +		goto err3;
> +
> +	ret = qcom_ssphy_do_reset(priv);
> +	if (ret)
> +		goto err4;
> +
> +	writeb(SWI_PCS_CLK_SEL, priv->base + PHY_CTRL0);
> +	qcom_ssphy_updatel(priv->base + PHY_CTRL4, LANE0_PWR_ON, LANE0_PWR_ON);
> +	qcom_ssphy_updatel(priv->base + PHY_CTRL2, REF_PHY_EN, REF_PHY_EN);
> +	qcom_ssphy_updatel(priv->base + PHY_CTRL4, TST_PWR_DOWN, 0);
> +
> +	return 0;
> +err4:

Name your labels based on what they do, e.g. err_disable_vbus.

> +	if (priv->vbus && priv->mode != PHY_MODE_INVALID)
> +		qcom_ssphy_vbus_disable(priv->vbus);

qcom_ssphy_vbus_ctrl() above was either enabling or disabling vbus, but
here you're directly calling disable to unroll that. It think the result
is correct (in host this reverts to disabled and in gadget it's a
no-op), but I'm not sure I like the design of sometimes calling straight
to the vbus enable/disable and sometimes to the wrapper function.

> +err3:

err_clk_disable

> +	clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
> +err2:
> +	regulator_bulk_disable(priv->num_regs, priv->regs);
> +err1:
> +	qcom_ssphy_vdd_ctrl(priv, DISABLE);
> +
> +	return ret;
> +}
> +
> +static int qcom_ssphy_power_off(struct phy *phy)
> +{
> +	struct ssphy_priv *priv = phy_get_drvdata(phy);
> +
> +	qcom_ssphy_updatel(priv->base + PHY_CTRL4, LANE0_PWR_ON, 0);
> +	qcom_ssphy_updatel(priv->base + PHY_CTRL2, REF_PHY_EN, 0);
> +	qcom_ssphy_updatel(priv->base + PHY_CTRL4, TST_PWR_DOWN, TST_PWR_DOWN);
> +
> +	clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
> +	regulator_bulk_disable(priv->num_regs, priv->regs);
> +
> +	if (priv->vbus && priv->mode != PHY_MODE_INVALID)
> +		qcom_ssphy_vbus_disable(priv->vbus);
> +
> +	qcom_ssphy_vdd_ctrl(priv, DISABLE);
> +
> +	return 0;
> +}
> +
> +static int qcom_ssphy_init_clock(struct ssphy_priv *priv)
> +{
> +	const char * const clk_id[] = { "ref", "phy", "pipe", };
> +	int i;
> +
> +	priv->num_clks = ARRAY_SIZE(clk_id);
> +	priv->clks = devm_kcalloc(priv->dev, priv->num_clks,
> +				  sizeof(*priv->clks), GFP_KERNEL);

You know num_clks is 3, so I would suggest that you just change the
sshphy_priv to clks[3] and skip the dynamic allocation.


Also, as num_clks always is ARRAY_SIZE(priv->clks) I would suggest using
the latter, to make that clear throughout the driver.

> +	if (!priv->clks)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < priv->num_clks; i++)
> +		priv->clks[i].id = clk_id[i];

There's no harm in just writing this on three lines:

	priv->clks[0].id = "ref";
	priv->clks[1].id = "phy";
	priv->clks[2].id = "pipe";

> +
> +	return devm_clk_bulk_get(priv->dev, priv->num_clks, priv->clks);
> +}
> +
> +static int qcom_ssphy_init_regulator(struct ssphy_priv *priv)
> +{
> +	const char * const reg_supplies[] = {
> +		[VDD] = "vdd",
> +		[VDDA1P8] = "vdda1p8",
> +	};
> +	int ret, i;
> +
> +	priv->num_regs = ARRAY_SIZE(reg_supplies);
> +	priv->regs = devm_kcalloc(priv->dev, priv->num_regs,
> +				  sizeof(*priv->regs), GFP_KERNEL);

As with clocks, you know there will only be 2 of these, make it fixed
size in ssphy_priv.

And as with clocks, I would suggest using ARRAY_SIZE(priv->regs)
throughout the driver to make it obvious that's it's a static number. 

> +	if (!priv->regs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < priv->num_regs; i++)
> +		priv->regs[i].supply = reg_supplies[i];

As with clocks, just unroll this and fill in the 2 supplies directly.

> +
> +	ret = devm_regulator_bulk_get(priv->dev, priv->num_regs, priv->regs);
> +	if (ret)
> +		return ret;
> +
> +	priv->vbus = devm_regulator_get_optional(priv->dev, "vbus");

get_optional means that if vbus-supply is not found, rather than
returning a dummy regulator object this will fail with -ENODEV.

Given the rest of the logic related to vbus you should set vbus to NULL
if the returned PTR_ERR(value) is -ENODEV, and fail for other errors.


Or just drop the _optional, and let your vbus controls operate on the
dummy regulator you get back.

(Right now vbus can't be NULL, so these checks are not very useful)

> +	if (IS_ERR(priv->vbus))
> +		return PTR_ERR(priv->vbus);
> +
> +	return 0;

return PTR_ERR_OR_ZERO(priv->vbus)

(Although that might change based on above comment)

> +}

Regards,
Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
