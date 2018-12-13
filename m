Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_MIXED_ES,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7245C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:01:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 822A220672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CvUfQttA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BJu36hj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 822A220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lHx4yshcNiHZu72O0uIzA9E+u005vyD8Wt7+8WA6kRA=; b=CvUfQttANO16Fh
	940+h04QS5JeF/YIcD4zWeYFj36GP5dDGt7p8KWsgO0aic3PrxIt3d8EXFpSqPSIjqpOhz7ZudgGd
	LdqoKVJENmyntQFwPsgz0Cmic3eCh+9xoVvDiUSEYzlxEfYqOTrBMHSQ9mjakTka8v3Smyj/ssXux
	pMsNTT5enSVa87kxIrDthN5sfByUOTibQ9oIAciXVJCpVi9NsgxqxupWM/hm9sWnfGyWrdnnNhMOQ
	dxBHnOwTb53yn5b3yijVXNRMgefSGfIzDivdyKB4D787VakAHpfv/4equ3Yf5nWmuDjvGHWGPsdki
	Gg2Bp2xMZiuf74o0/CXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXMs2-00089y-Si; Thu, 13 Dec 2018 09:01:26 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXMry-00085X-CA
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 09:01:25 +0000
Received: by mail-wr1-x443.google.com with SMTP id v13so1129785wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 01:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=kjQKn7dx1022g73X0ghYGkaAbvd+REjWyJXX/6++FII=;
 b=BJu36hj4bgTAJa54RxghsLxfgt1Ub2+eW8iH/w4D8Ckh23IxBFNVlsDib65XU/OIGQ
 dT3gXrRjEy9uW2nKp98uNhzkixOH7ODr0vFFshpIqKwCJGb9MqrzGHYB66fjzYO3PzUF
 i7ew3pg3RG150wx6mHrFPM+wjRR9vo311+lBLRCpltZuDQzdrM9aaAvIWmcz54N9n7Wp
 +ckMbzNa5pE+UiAlijm5vZM43N8ig+BN8qNuNZi0aZpE6npdOrC7xkqFSud1aLXEzmQ6
 kbdYKft04DOd1uUfLfHeLx1I6nj2NGQtG/Jko8JhW/fdMv4NCmTAPzWpnFe91R+IRGAb
 qAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=kjQKn7dx1022g73X0ghYGkaAbvd+REjWyJXX/6++FII=;
 b=e5TPnGFPAEejzubjuRxr+GjmHIibIHgaTEoYGQr++bGKqT3XiB9uYXWCV6/gNoAHVr
 OC96SUk3cVruktcIr3Gtdxu5D1Yn979Ks+SClRLOdttOvUwRLgTaJG0KjeQKxuhCdfZL
 pVqfkpjbo8KQmOfbjEebSrIVEVvH/19Zso/NKIdgsv5G71HCP6W+djA6nfYsEb3xydt+
 iMHxnXVdkAIpOFZE4XLdyOmVnJWpW6onfCXq08OQy2kvm3uZbqUarwwaXgorF7qJimkb
 iJsRb45xkIhuII22gU+Y5au73Fmoj2gj/SHnoOoM4xw+fHzbyqk0+aKdvvt5tYtXhLE6
 gI0w==
X-Gm-Message-State: AA+aEWb8V3hv4LWlhhoUL5hm9s1SyluPsDPkVUrqa4iyvdjBtX+IDUO9
 zsAqJU4sEXlM1KbOsY3j04EKGw==
X-Google-Smtp-Source: AFSGD/XkasSk97qp5yOmQGkjKvlave03fNKBn050nti343PUnd3GpjR/DBbTQDxMFI/9DVyEoDcG9A==
X-Received: by 2002:a5d:628a:: with SMTP id k10mr19562183wru.254.1544691670280; 
 Thu, 13 Dec 2018 01:01:10 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.gmail.com with ESMTPSA id
 a12sm1318036wrm.45.2018.12.13.01.01.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 13 Dec 2018 01:01:09 -0800 (PST)
Message-ID: <2ed764a1c6a0fea5cb3e16dd48577c930ae28ca9.camel@baylibre.com>
Subject: Re: [PATCH RESEND v7 3/4] clk: meson: add sub MMC clock controller
 driver
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jianxin Pan <jianxin.pan@amlogic.com>, Neil Armstrong
 <narmstrong@baylibre.com>
Date: Thu, 13 Dec 2018 10:01:05 +0100
In-Reply-To: <11bb5068-2c93-a415-b295-6ca994621280@amlogic.com>
References: <1544457877-51301-1-git-send-email-jianxin.pan@amlogic.com>
 <1544457877-51301-4-git-send-email-jianxin.pan@amlogic.com>
 <10f2875c9724d9d9dd4bd32eab1fa3f8e42a809c.camel@baylibre.com>
 <11bb5068-2c93-a415-b295-6ca994621280@amlogic.com>
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_010122_429925_2D6545B0 
X-CRM114-Status: GOOD (  27.62  )
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

On Thu, 2018-12-13 at 12:55 +0800, Jianxin Pan wrote:
> On 2018/12/12 0:59, Jerome Brunet wrote:
> > On Tue, 2018-12-11 at 00:04 +0800, Jianxin Pan wrote:
> > > From: Yixun Lan <yixun.lan@amlogic.com>
> > > 
> [...]
> > >  
> > > +config COMMON_CLK_MMC_MESON
> > > +	tristate "Meson MMC Sub Clock Controller Driver"
> > > +	select MFD_SYSCON
> > > +	select COMMON_CLK_AMLOGIC
> > > +	select COMMON_CLK_AMLOGIC_AUDIO
> > 
> > No it is wrong for the mmc to select AUDIO clocks.
> > If as a result of your patch sclk is needed for things, make the necessary
> > change in the Makefile.
> OK, I will add COMMON_CLK_AMLOGIC_SCLKDIV for sclk-div.

No! There is no reason to create a specific configuration for this.
please put it under COMMON_CLK_AMLOGIC

> [...]>> +#include <linux/clk.h>
> > > +#include <linux/clk-provider.h>
> > > +#include <linux/module.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/mfd/syscon.h>
> > > +#include <linux/platform_device.h>
> > > +#include <dt-bindings/clock/amlogic,mmc-clkc.h>
> > > +
> > > +#include "clkc.h"
> > > +#include "clkc-audio.h"
> > 
> > Again having audio in the mmc controller is wrong.
> > Please make the necessary rework.
> Yes, I will split out sclk-div.h from clkc-audio.h in the next version.

Same, clkc.h will do

> Thanks for your time.
> > > +
> > > +/* clock ID used by internal driver */
> > > +#define CLKID_MMC_MUX			0
> > > +
> > > +#define   SD_EMMC_CLOCK		0
> >            ^
> > why the multiple space here ? this looks odd
> I will check the alignement  in the whole patchset and fix them, Thank you.
> > > +#define   CLK_DELAY_STEP_PS		200
> > 
> > Please keep thing aligned aligned consistently.
> > 
> > > +
> > > +#define MUX_CLK_NUM_PARENTS		2
> > > +#define MMC_MAX_CLKS			5
> > > +
> > > +struct mmc_clkc_data {
> > > +	struct meson_clk_phase_delay_data	tx;
> > > +	struct meson_clk_phase_delay_data	rx;
> > 
> > Why use a tab above ?
> OK
> > > +};
> > > +
> > > +static struct clk_regmap_mux_data mmc_clkc_mux_data = {
> > > +	.offset		= SD_EMMC_CLOCK,
> > > +	.mask		= 0x3,
> > > +	.shift		= 6,
> > > +};
> > > +
> > > +static const struct meson_sclk_div_data mmc_clkc_div_data = {
> > > +	.div = {
> > > +		.reg_off = SD_EMMC_CLOCK,
> > > +		.shift   = (0),
> > > +		.width   = (6),
> > 
> > Please remove the unncessary parenthesis
> OK, I will remove them.
> > > +	},
> > > +	.hi = {
> > > +		.width   = 0,
> > > +	},
> > 
> > structure is a static const, all non-list members will be zero
> > drop the 
> OK, I will remove it in the next version. 
> > > +	.flags = CLK_DIVIDER_ONE_BASED,
> > > +};
> > > +
> > > +static struct meson_clk_phase_data mmc_clkc_core_phase = {
> > > +	.ph = {
> > > +		.reg_off	= SD_EMMC_CLOCK,
> > > +		.shift	= 8,
> > > +		.width	= 2,
> > > +	}
> > > +};
> > > +
> > > +static const struct mmc_clkc_data mmc_clkc_gx_data = {
> > > +	.tx = {
> > > +		.phase = {
> > > +			.reg_off	= SD_EMMC_CLOCK,
> > > +			.shift	= 10,
> > > +			.width	= 2,
> > > +		},
> > > +		.delay = {
> > > +			.reg_off	= SD_EMMC_CLOCK,
> > > +			.shift	= 16,
> > > +			.width	= 4,
> > > +		},
> > 
> > Again, an effort on alignement would appreciated, same below
> OK, I will fix them.
> > > +		.delay_step_ps	= CLK_DELAY_STEP_PS,
> > > +	},
> > > +	.rx = {
> > > +		.phase = {
> > > +			.reg_off	= SD_EMMC_CLOCK,
> > > +			.shift	= 12,
> > > +			.width	= 2,
> > > +		},
> > > +		.delay = {
> > > +			.reg_off	= SD_EMMC_CLOCK,
> > > +			.shift	= 20,
> > > +			.width	= 4,
> > > +		},
> > > +		.delay_step_ps	= CLK_DELAY_STEP_PS,
> > > +	},
> > > +};
> > > +
> > > +static const struct mmc_clkc_data mmc_clkc_axg_data = {
> > > +	.tx = {
> > > +		.phase = {
> > > +			.reg_off	= SD_EMMC_CLOCK,
> > > +			.shift	= 10,
> > > +			.width	= 2,
> > > +		},
> > > +		.delay = {
> > > +			.reg_off	= SD_EMMC_CLOCK,
> > > +			.shift	= 16,
> > > +			.width	= 6,
> > > +		},
> > > +		.delay_step_ps	= CLK_DELAY_STEP_PS,
> > > +	},
> > > +	.rx = {
> > > +		.phase = {
> > > +			.reg_off	= SD_EMMC_CLOCK,
> > > +			.shift	= 12,
> > > +			.width	= 2,
> > > +		},
> > > +		.delay = {
> > > +			.reg_off	= SD_EMMC_CLOCK,
> > > +			.shift	= 22,
> > > +			.width	= 6,
> > > +		},
> > > +		.delay_step_ps	= CLK_DELAY_STEP_PS,
> > > +	},
> > > +};
> > > +
> > > +static const struct of_device_id mmc_clkc_match_table[] = {
> > > +	{
> > > +		.compatible	= "amlogic,gx-mmc-clkc",
> > > +		.data		= &mmc_clkc_gx_data
> > > +	},
> > > +	{
> > > +		.compatible	= "amlogic,axg-mmc-clkc",
> > > +		.data		= &mmc_clkc_axg_data
> > > +	},
> > > +	{}
> > > +};
> > > +MODULE_DEVICE_TABLE(of, mmc_clkc_match_table);
> > > +
> > > +static struct clk_regmap *
> > > +mmc_clkc_register_clk(struct device *dev, struct regmap *map,
> > > +		      struct clk_init_data *init,
> > > +		      const char *suffix, void *data)
> > > +{
> > > +	struct clk_regmap *clk;
> > > +	char *name;
> > > +	int ret;
> > > +
> > > +	clk = devm_kzalloc(dev, sizeof(*clk), GFP_KERNEL);
> > > +	if (!clk)
> > > +		return ERR_PTR(-ENOMEM);
> > > +
> > > +	name = kasprintf(GFP_KERNEL, "%s#%s", dev_name(dev), suffix);
> > > +	if (!name)
> > > +		return ERR_PTR(-ENOMEM);
> > > +
> > > +	init->name = name;
> > > +
> > 
> > nitpick: remove this newline
> OK.
> > > +	clk->map = map;
> > > +	clk->data = data;
> > > +	clk->hw.init = init;
> > > +
> > > +	ret = devm_clk_hw_register(dev, &clk->hw);
> > > +	if (ret)
> > > +		clk = ERR_PTR(ret);
> > > +
> > > +	kfree(name);
> > > +	return clk;
> > > +}
> > > +
> > > +static struct clk_regmap *mmc_clkc_register_mux(struct device *dev,
> > > +						struct regmap *map)
> > > +{
> > > +	const char *parent_names[MUX_CLK_NUM_PARENTS];
> > > +	struct clk_init_data init;
> > > +	struct clk_regmap *mux;
> > > +	struct clk *clk;
> > > +	int i;
> > > +
> > > +	for (i = 0; i < MUX_CLK_NUM_PARENTS; i++) {
> > > +		char name[8];
> > > +
> > > +		snprintf(name, sizeof(name), "clkin%d", i);
> > > +		clk = devm_clk_get(dev, name);
> > > +		if (IS_ERR(clk)) {
> > > +			if (clk != ERR_PTR(-EPROBE_DEFER))
> > > +				dev_err(dev, "Missing clock %s\n", name);
> > > +			return ERR_PTR((long)clk);
> > 
> > I don't think this cast is necessary     ^
> Yes, return clk is ok here.
> > > +		}
> > > +
> > > +		parent_names[i] = __clk_get_name(clk);
> > > +	}
> > > +
> > > +	init.ops = &clk_regmap_mux_ops;
> > > +	init.flags = CLK_SET_RATE_PARENT;
> > > +	init.parent_names = parent_names;
> > > +	init.num_parents = MUX_CLK_NUM_PARENTS;
> > > +
> > > +	mux = mmc_clkc_register_clk(dev, map, &init, "mux",
> > > &mmc_clkc_mux_data);
> > > +	if (IS_ERR(mux))
> > > +		dev_err(dev, "Mux clock registration failed\n");
> > > +
> > > +	return mux;
> > > +}
> > > +
> > > +static struct clk_regmap *
> > > +mmc_clkc_register_clk_with_parent(struct device *dev, struct regmap
> > > *map,
> > > +				  char *suffix, const struct clk_hw *hw,
> > > +				  unsigned long flags,
> > > +				  const struct clk_ops *ops, void *data)
> > > +{
> > > +	struct clk_init_data init;
> > > +	struct clk_regmap *clk;
> > > +	const char *parent_name = clk_hw_get_name(hw);
> > > +
> > > +	init.ops = ops;
> > > +	init.flags = flags;
> > > +	init.parent_names = &parent_name;
> > > +	init.num_parents = 1;
> > > +
> > > +	clk = mmc_clkc_register_clk(dev, map, &init, suffix, data);
> > > +	if (IS_ERR(clk))
> > > +		dev_err(dev, "Core %s clock registration failed\n", suffix);
> > 
> >                                ^
> > this function is not only called by the core clock, is it ?
> OK, I will drop "Core" in this line.
> > > +
> > > +	return clk;
> > > +}
> > > +
> > > +static int mmc_clkc_probe(struct platform_device *pdev)
> > > +{
> > > +	struct clk_hw_onecell_data *onecell_data;
> > > +	struct device *dev = &pdev->dev;
> > > +	struct mmc_clkc_data *data;
> > > +	struct regmap *map;
> > > +	struct clk_regmap *clk, *core;
> > > +	struct meson_sclk_div_data *div_data;
> > > +
> > > +	/*cast to drop the const in match->data*/
> > > +	data = (struct mmc_clkc_data *)of_device_get_match_data(dev);
> > > +	if (!data)
> > > +		return -ENODEV;
> > > +
> > > +	map = syscon_node_to_regmap(dev->of_node);
> > > +	if (IS_ERR(map)) {
> > > +		dev_err(dev, "could not find mmc clock controller\n");
> > > +		return PTR_ERR(map);
> > > +	}
> > > +
> > > +	onecell_data = devm_kzalloc(dev, sizeof(*onecell_data) +
> > > +				    sizeof(*onecell_data->hws) * MMC_MAX_CLKS,
> > > +				    GFP_KERNEL);
> > > +	if (!onecell_data)
> > > +		return -ENOMEM;
> > > +
> > > +	clk = mmc_clkc_register_mux(dev, map);
> > > +	if (IS_ERR(clk))
> > > +		return PTR_ERR(clk);
> > > +	onecell_data->hws[CLKID_MMC_MUX]		= &clk->hw,
> > 
> > It does not really need to have an ID or be in the onecell data if you are
> > not
> > going to expose it. On the other controllers, we are using the onecell for
> > the
> > registration as well, which is why there is unexpeosed IDs, but it is not
> > the
> > case here.
> > 
> > ... and please, stop with this unnecessary tab. a space will do. same
> > below.
> CLKID_MMC_MUX is an internal clock, and I will remove the ID and onecell
> date in the next version.
> And I will double check and fix tabs. Thank you.
> > > +
> > > +	div_data = devm_kzalloc(dev, sizeof(*div_data), GFP_KERNEL);
> > > +	if (!div_data)
> > > +		return -ENOMEM;
> > > +	*div_data = mmc_clkc_div_data;
> > 
> > memcpy would be more appropriate.
> Sure.
> > > +
> > > +	clk = mmc_clkc_register_clk_with_parent(dev, map, "div",
> > > +						&clk->hw,
> [...]
> > 
> > .
> > 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
