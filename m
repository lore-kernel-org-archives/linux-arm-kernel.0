Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6232BC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:26:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C610218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bxpxypry";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hvECbj5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C610218D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=27+I4bYAFNFb5J/b1wFh1M0jVcRAeW5UcEgXtoJZeQM=; b=BxpxypryhCfvmb
	FoHj6AYGbdRnd7kt2EYAibr2a97/7GOp15gMGKo67ca1dsF8em0XUC4zshbXD+vnfy2INzzG0cXSg
	LCg6CXWEpelJV+ppoCIwauvamyBP9B4mPcacy2RRm5Z7jwlCWfWTCxRWF9pkr3mZwAjYtilKylyw/
	TtbZjgX8IZ5UsOItQf5o2AVNPDPPUP1uUZZQm91tKSN8fmMd2xQN1cvHjL0MO5QLSQRwGhbEoK0ha
	fSQm72Hao/PXbeLXDRSpdF48FAYoN0S7FW4nIX+FS3bsoZmMO1P7JeLVIuyZBP9XodddV7DXsR8yr
	7l4KkWJbEUgYSO7GqXxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glsJi-0004AZ-Pv; Tue, 22 Jan 2019 09:25:58 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glsJT-0003xm-AT
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 09:25:48 +0000
Received: by mail-wm1-x341.google.com with SMTP id f188so13343918wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 01:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=b8n6t2KX6QGtHw8sz3dDfvmKaL9hpkk5RGnyG5h2JYM=;
 b=hvECbj5CtGcjZrjLcDl51vO2CEnTDxYGZzYTkfnD0YgKTHGcIHsUjMvUM2LT1/ZQFg
 ZBqKgjZQROx/Wt7LMOWb3ynIFUUgIi1zQ7suDrHWeAneKhiL9VopVskqtwYz8LxIlIXU
 4PuaCB/uftyW04ukE9mIB4TRSm0zOcewQT+0VyOow7mAQ7eLQ5pYZzE9eZ9WuU3VAqAC
 xYR7J2ijk6auMdL9wLDfjdtOruesoCaXA6jvyeJYYxzgD+tj9HKDaraSNFG7zsbOiTzV
 TWOfHBEXsp4joAR0DrxP4T3iIh0zxcN/UZRfvbJYCXIGdsSTVN/MdLtL4ifPBjbWLL1c
 9xyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=b8n6t2KX6QGtHw8sz3dDfvmKaL9hpkk5RGnyG5h2JYM=;
 b=SS836WBoGoFKdYgIlWkuh6CyCbGgo5i7B7Dbl/PNWm1uQngypnGYNPOsKSW1YwSKOB
 dy08sINdKByw79d6GBMicYWGosRiN33mVKhy8RguZVnNGY1X7zH0H4PKGEvNCREnaQLr
 ttKy7ioAyORTdzcRUU5yChhsjX4EmadH0Jwwe3rKUnMbun92GWSYHl0z0K2gMF5w0F2o
 F5O6ySVpxXTMWpLzp/LSEzqA3K80k9PrBqERDpCgM790cHuvsbZf3fzwK3+XTOnKtSl2
 5HAq7m8h2LEF0F97CA1yNH4QOVRCa3Y3fEtyP2+UwIfAoRhhLMkMg4dHw+Nh0JFQAlqU
 jv2Q==
X-Gm-Message-State: AJcUuke14CHlHfA/UbfBN3FVriSi8zQNj4TrEp03L9wW+vuDSEK4a+UV
 OkAOt8KSfaPlebGgqdcyaPR1ew==
X-Google-Smtp-Source: ALg8bN48qgEdcGvnjjeoIMmzUiTnI6VJfwj4VeWhJCS5FI7PeirY91jWA4ocAaPp2Caa6ovWVYQrvg==
X-Received: by 2002:a1c:c483:: with SMTP id u125mr2834764wmf.14.1548149141536; 
 Tue, 22 Jan 2019 01:25:41 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.gmail.com with ESMTPSA id
 199sm58297562wmh.21.2019.01.22.01.25.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 22 Jan 2019 01:25:40 -0800 (PST)
Message-ID: <6fa1832985ae139c853904cb13ecf135988a65cb.camel@baylibre.com>
Subject: Re: [PATCH v9 4/4] clk: meson: add sub MMC clock controller driver
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jianxin Pan <jianxin.pan@amlogic.com>, Neil Armstrong
 <narmstrong@baylibre.com>
Date: Tue, 22 Jan 2019 10:25:38 +0100
In-Reply-To: <1546955444-7549-5-git-send-email-jianxin.pan@amlogic.com>
References: <1546955444-7549-1-git-send-email-jianxin.pan@amlogic.com>
 <1546955444-7549-5-git-send-email-jianxin.pan@amlogic.com>
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_012543_538533_5D40AA68 
X-CRM114-Status: GOOD (  24.90  )
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
Cc: Rob Herring <robh@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>,
 Victor Wan <victor.wan@amlogic.com>, Stephen Boyd <sboyd@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Yixun Lan <yixun.lan@amlogic.com>,
 linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@bootlin.com>,
 Liang Yang <liang.yang@amlogic.com>, Jian Hu <jian.hu@amlogic.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Carlo Caione <carlo@caione.org>,
 linux-amlogic@lists.infradead.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Qiufang Dai <qiufang.dai@amlogic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2019-01-08 at 21:50 +0800, Jianxin Pan wrote:
> From: Yixun Lan <yixun.lan@amlogic.com>
> 
> The patch will add a MMC clock controller driver which used by MMC or NAND,
> It provide a mux and divider clock, and three phase clocks - core, tx, tx.
> 
> Two clocks are provided as the parent of MMC clock controller from
> upper layer clock controller - eg "amlogic,axg-clkc" in AXG platform.
> 
> To specify which clock the MMC or NAND driver may consume,
> the preprocessor macros in the dt-bindings/clock/amlogic,mmc-clkc.h header
> can be used in the device tree sources.
> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  drivers/clk/meson/Kconfig    |  10 ++
>  drivers/clk/meson/Makefile   |   1 +
>  drivers/clk/meson/mmc-clkc.c | 304
> +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 315 insertions(+)
>  create mode 100644 drivers/clk/meson/mmc-clkc.c
> 
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index efaa70f..3555f9d 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -15,6 +15,16 @@ config COMMON_CLK_MESON_AO
>  	select COMMON_CLK_REGMAP_MESON
>  	select RESET_CONTROLLER
>  
> +config COMMON_CLK_MMC_MESON
> +	tristate "Meson MMC Sub Clock Controller Driver"
> +	depends on ARCH_MESON || COMPILE_TEST
> +	select MFD_SYSCON
> +	select COMMON_CLK_AMLOGIC
> +	help
> +	  Support for the MMC sub clock controller on Amlogic Meson Platform,
> +	  which include S905 (GXBB, GXL), A113D/X (AXG) devices.
> +	  Say Y if you want this clock enabled.
> +
>  config COMMON_CLK_REGMAP_MESON
>  	bool
>  	select REGMAP
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index d59620d..54416a2 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -12,4 +12,5 @@ obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
>  obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-
> 32k.o
>  obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o axg-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_AXG_AUDIO)	+= axg-audio.o
> +obj-$(CONFIG_COMMON_CLK_MMC_MESON) 	+= mmc-clkc.o
>  obj-$(CONFIG_COMMON_CLK_REGMAP_MESON)	+= clk-regmap.o
> diff --git a/drivers/clk/meson/mmc-clkc.c b/drivers/clk/meson/mmc-clkc.c
> new file mode 100644
> index 0000000..2582a98
> --- /dev/null
> +++ b/drivers/clk/meson/mmc-clkc.c
> @@ -0,0 +1,304 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Amlogic Meson MMC Sub Clock Controller Driver
> + *
> + * Copyright (c) 2017 Baylibre SAS.
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> + *
> + * Copyright (c) 2018 Amlogic, inc.
> + * Author: Yixun Lan <yixun.lan@amlogic.com>
> + * Author: Jianxin Pan <jianxin.pan@amlogic.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/of_device.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/platform_device.h>
> +#include <dt-bindings/clock/amlogic,mmc-clkc.h>
> +
> +#include "clkc.h"
> +
> +/* clock ID used by internal driver */
> +
> +#define SD_EMMC_CLOCK		0
> +#define CLK_DELAY_STEP_PS	200
> +#define MUX_CLK_NUM_PARENTS	2
> +#define MMC_MAX_CLKS		4
> +
> +struct mmc_clkc_data {
> +	struct meson_clk_phase_delay_data tx;
> +	struct meson_clk_phase_delay_data rx;
> +};
> +
> +static struct clk_regmap_mux_data mmc_clkc_mux_data = {
> +	.offset = SD_EMMC_CLOCK,
> +	.mask   = 0x3,
> +	.shift  = 6,
> +};
> +
> +static const struct meson_sclk_div_data mmc_clkc_div_data = {
> +	.div = {
> +		.reg_off = SD_EMMC_CLOCK,
> +		.width   = 6,
> +	},
> +	.flags = CLK_DIVIDER_ONE_BASED,
> +};
> +
> +static struct meson_clk_phase_data mmc_clkc_core_phase = {
> +	.ph = {
> +		.reg_off = SD_EMMC_CLOCK,
> +		.shift   = 8,
> +		.width   = 2,
> +	}
> +};
> +
> +static const struct mmc_clkc_data mmc_clkc_gx_data = {
> +	.tx = {
> +		.phase = {
> +			.reg_off = SD_EMMC_CLOCK,
> +			.shift   = 10,
> +			.width   = 2,
> +		},
> +		.delay = {
> +			.reg_off = SD_EMMC_CLOCK,
> +			.shift   = 16,
> +			.width   = 4,
> +		},
> +		.delay_step_ps = CLK_DELAY_STEP_PS,
> +	},
> +	.rx = {
> +		.phase = {
> +			.reg_off = SD_EMMC_CLOCK,
> +			.shift   = 12,
> +			.width   = 2,
> +		},
> +		.delay = {
> +			.reg_off = SD_EMMC_CLOCK,
> +			.shift   = 20,
> +			.width   = 4,
> +		},
> +		.delay_step_ps   = CLK_DELAY_STEP_PS,
> +	},
> +};
> +
> +static const struct mmc_clkc_data mmc_clkc_axg_data = {
> +	.tx = {
> +		.phase = {
> +			.reg_off = SD_EMMC_CLOCK,
> +			.shift   = 10,
> +			.width   = 2,
> +		},
> +		.delay = {
> +			.reg_off = SD_EMMC_CLOCK,
> +			.shift   = 16,
> +			.width   = 6,
> +		},
> +		.delay_step_ps   = CLK_DELAY_STEP_PS,

Please check this. The delay step is not 200ns on the AXG.

> +	},
> +	.rx = {
> +		.phase = {
> +			.reg_off = SD_EMMC_CLOCK,
> +			.shift   = 12,
> +			.width   = 2,
> +		},
> +		.delay = {
> +			.reg_off = SD_EMMC_CLOCK,
> +			.shift   = 22,
> +			.width   = 6,
> +		},
> +		.delay_step_ps   = CLK_DELAY_STEP_PS,
> +	},
> +};
> +
> +static const struct of_device_id mmc_clkc_match_table[] = {
> +	{
> +		.compatible	= "amlogic,gx-mmc-clkc",
> +		.data		= &mmc_clkc_gx_data
> +	},
> +	{
> +		.compatible	= "amlogic,axg-mmc-clkc",
> +		.data		= &mmc_clkc_axg_data
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, mmc_clkc_match_table);
> +
> +static struct clk_regmap *
> +mmc_clkc_register_clk(struct device *dev, struct regmap *map,
> +		      struct clk_init_data *init,
> +		      const char *suffix, void *data)
> +{
> +	struct clk_regmap *clk;
> +	char *name;
> +	int ret;
> +
> +	clk = devm_kzalloc(dev, sizeof(*clk), GFP_KERNEL);
> +	if (!clk)
> +		return ERR_PTR(-ENOMEM);
> +
> +	name = kasprintf(GFP_KERNEL, "%s#%s", dev_name(dev), suffix);
> +	if (!name)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init->name = name;
> +	clk->map = map;
> +	clk->data = data;
> +	clk->hw.init = init;
> +	ret = devm_clk_hw_register(dev, &clk->hw);
> +	if (ret)
> +		clk = ERR_PTR(ret);
> +
> +	kfree(name);
> +	return clk;
> +}
> +
> +static struct clk_regmap *mmc_clkc_register_mux(struct device *dev,
> +						struct regmap *map)
> +{
> +	const char *parent_names[MUX_CLK_NUM_PARENTS];
> +	struct clk_init_data init;
> +	struct clk_regmap *mux;
> +	struct clk *clk;
> +	int i;
> +
> +	for (i = 0; i < MUX_CLK_NUM_PARENTS; i++) {
> +		char name[8];
> +
> +		snprintf(name, sizeof(name), "clkin%d", i);
> +		clk = devm_clk_get(dev, name);
> +		if (IS_ERR(clk)) {
> +			if (clk != ERR_PTR(-EPROBE_DEFER))
> +				dev_err(dev, "Missing clock %s\n", name);
> +			return ERR_CAST(clk);
> +		}
> +
> +		parent_names[i] = __clk_get_name(clk);
> +	}
> +
> +	init.ops = &clk_regmap_mux_ops;
> +	init.flags = CLK_SET_RATE_PARENT;
> +	init.parent_names = parent_names;
> +	init.num_parents = MUX_CLK_NUM_PARENTS;
> +
> +	mux = mmc_clkc_register_clk(dev, map, &init, "mux",
> &mmc_clkc_mux_data);
> +	if (IS_ERR(mux))
> +		dev_err(dev, "Mux clock registration failed\n");
> +
> +	return mux;
> +}
> +
> +static struct clk_regmap *
> +mmc_clkc_register_clk_with_parent(struct device *dev, struct regmap *map,
> +				  char *suffix, const struct clk_hw *hw,
> +				  unsigned long flags,
> +				  const struct clk_ops *ops, void *data)
> +{
> +	struct clk_init_data init;
> +	struct clk_regmap *clk;
> +	const char *parent_name = clk_hw_get_name(hw);
> +
> +	init.ops = ops;
> +	init.flags = flags;
> +	init.parent_names = &parent_name;
> +	init.num_parents = 1;
> +
> +	clk = mmc_clkc_register_clk(dev, map, &init, suffix, data);
> +	if (IS_ERR(clk))
> +		dev_err(dev, "%s clock registration failed\n", suffix);
> +
> +	return clk;
> +}
> +
> +static int mmc_clkc_probe(struct platform_device *pdev)
> +{
> +	struct clk_hw_onecell_data *onecell_data;
> +	struct device *dev = &pdev->dev;
> +	struct mmc_clkc_data *data;
> +	struct regmap *map;
> +	struct clk_regmap *clk, *core;
> +	struct meson_sclk_div_data *div_data;
> +
> +	/*cast to drop the const in match->data*/
> +	data = (struct mmc_clkc_data *)of_device_get_match_data(dev);
> +	if (!data)
> +		return -ENODEV;
> +
> +	map = syscon_node_to_regmap(dev->of_node);
> +	if (IS_ERR(map)) {
> +		dev_err(dev, "could not find mmc clock controller\n");
> +		return PTR_ERR(map);
> +	}
> +
> +	onecell_data = devm_kzalloc(dev, sizeof(*onecell_data) +
> +				    sizeof(*onecell_data->hws) * MMC_MAX_CLKS,
> +				    GFP_KERNEL);
> +	if (!onecell_data)
> +		return -ENOMEM;
> +
> +	clk = mmc_clkc_register_mux(dev, map);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	div_data = devm_kzalloc(dev, sizeof(*div_data), GFP_KERNEL);
> +	if (!div_data)
> +		return -ENOMEM;
> +
> +	memcpy(div_data, &mmc_clkc_div_data, sizeof(*div_data));
> +	clk = mmc_clkc_register_clk_with_parent(dev, map, "div",
> +						&clk->hw,
> +						CLK_SET_RATE_PARENT,
> +						&meson_sclk_div_ops,
> +						div_data);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	onecell_data->hws[CLKID_MMC_DIV] = &clk->hw,
> +
> +	core = mmc_clkc_register_clk_with_parent(dev, map, "core",
> +						 &clk->hw,
> +						 CLK_SET_RATE_PARENT,
> +						 &meson_clk_phase_ops,
> +						 &mmc_clkc_core_phase);
> +	if (IS_ERR(core))
> +		return PTR_ERR(core);
> +
> +	onecell_data->hws[CLKID_MMC_PHASE_CORE] = &core->hw,
> +
> +	clk = mmc_clkc_register_clk_with_parent(dev, map, "rx",
> +						&core->hw,  0,
> +						&meson_clk_phase_delay_ops,
> +						&data->rx);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	onecell_data->hws[CLKID_MMC_PHASE_RX] = &clk->hw,
> +	clk = mmc_clkc_register_clk_with_parent(dev, map, "tx",
> +						&core->hw,  0,
> +						&meson_clk_phase_delay_ops,
> +						&data->tx);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	onecell_data->hws[CLKID_MMC_PHASE_TX] = &clk->hw,
> +	onecell_data->num = MMC_MAX_CLKS;
> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> +					   onecell_data);
> +}
> +
> +static struct platform_driver mmc_clkc_driver = {
> +	.probe		= mmc_clkc_probe,
> +	.driver		= {
> +		.name	= "meson-mmc-clkc",
> +		.of_match_table = of_match_ptr(mmc_clkc_match_table),
> +	},
> +};
> +
> +module_platform_driver(mmc_clkc_driver);
> +
> +MODULE_DESCRIPTION("Amlogic AXG MMC clock driver");
> +MODULE_AUTHOR("Jianxin Pan <jianxin.pan@amlogic.com>");
> +MODULE_LICENSE("GPL v2");



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
