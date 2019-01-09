Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFD9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:49:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B633D214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YfFzvgML";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzUey9Nk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B633D214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-ID:References:From:
	In-Reply-To:To:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FyGmo/uawr6tU4jLiF6eA5XFr4zEgzh0t1DfAnqvQac=; b=YfFzvgMLO8kFYx
	6OXGfTIY+gOhX0torCQccRv0JzuDOeB27vEjcJEg7oPbPR2Dc5CPZA/Uf6JhLBh4twdWM7BAd/kxQ
	wywf3OeFX2FvFQcdbnLyxcdX8OnnD0LfFeObOCt4GJOt2zoPCINm3IPIMSK67Ft7p1DTsAuLDDO+M
	ja86K9Sam+fQ7TlYGlcHVliqd1Bdk39PM0OeddlB3CbOvg5ZJzUSZCGYiBumEp96p1uuqi5Re/yuC
	iBUzVNxbrWNWsqVcE8ufzAt2vi/D0VvL/4K/5KZq6/sv3Z3PMUHDTaPdvTD/fWB0WDpuWFMo3DabD
	NBrVlZrZ0k32ni1YqLDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghKmc-0004dk-PE; Wed, 09 Jan 2019 20:49:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghKmY-0004cN-O0; Wed, 09 Jan 2019 20:49:00 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0549D206B7;
 Wed,  9 Jan 2019 20:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547066938;
 bh=cb0SYlVzLEaJ/SdiLk39dlCFU+6Ho8pDktRsskgpI9o=;
 h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
 b=RzUey9NkunWOHBzLzzBYeFXcQ6tvuKr3e1L5WoqF9VG2Gajz1G/JZN6yxYhI0yGxn
 dQokodwVbFtGDELH7FgVJlGXhcfm8Ih48iKGOovTtnFyC77ohAbPPjWWnF5n1h2nnT
 PsnhuhCaSvtcuHMEEuTRQC/KP5zzLp+HuYJOnKvI=
MIME-Version: 1.0
Subject: Re: [PATCH v8 4/4] clk: meson: add sub MMC clock controller driver
To: Jerome Brunet <jbrunet@baylibre.com>, Jianxin Pan <jianxin.pan@amlogic.com>,
 Neil Armstrong <narmstrong@baylibre.com>
In-Reply-To: <1545063850-21504-5-git-send-email-jianxin.pan@amlogic.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <1545063850-21504-1-git-send-email-jianxin.pan@amlogic.com>
 <1545063850-21504-5-git-send-email-jianxin.pan@amlogic.com>
Message-ID: <154706693724.15366.10802936604309826132@swboyd.mtv.corp.google.com>
Date: Wed, 09 Jan 2019 12:48:57 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_124858_818038_DAEBE029 
X-CRM114-Status: GOOD (  10.95  )
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
 Victor Wan <victor.wan@amlogic.com>, Jianxin Pan <jianxin.pan@amlogic.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Yixun Lan <yixun.lan@amlogic.com>,
 linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@bootlin.com>,
 Liang Yang <liang.yang@amlogic.com>, Jian Hu <jian.hu@amlogic.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Carlo Caione <carlo@caione.org>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Qiufang Dai <qiufang.dai@amlogic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Jianxin Pan (2018-12-17 08:24:10)
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

Do you need this include?

> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/of_device.h>
> +#include <linux/mfd/syscon.h>

Is this used?

> +#include <linux/platform_device.h>
[...]
> +       init.num_parents = 1;
> +
> +       clk = mmc_clkc_register_clk(dev, map, &init, suffix, data);
> +       if (IS_ERR(clk))
> +               dev_err(dev, "%s clock registration failed\n", suffix);
> +
> +       return clk;
> +}
> +
> +static int mmc_clkc_probe(struct platform_device *pdev)
> +{
> +       struct clk_hw_onecell_data *onecell_data;
> +       struct device *dev = &pdev->dev;
> +       struct mmc_clkc_data *data;
> +       struct regmap *map;
> +       struct clk_regmap *clk, *core;
> +       struct meson_sclk_div_data *div_data;
> +
> +       /*cast to drop the const in match->data*/
> +       data = (struct mmc_clkc_data *)of_device_get_match_data(dev);

Is that necessary? Maybe the users of this should take a const argument
and copy things?

> +       if (!data)
> +               return -ENODEV;
> +
> +       map = syscon_node_to_regmap(dev->of_node);
> +       if (IS_ERR(map)) {
> +               dev_err(dev, "could not find mmc clock controller\n");
> +               return PTR_ERR(map);
> +       }
> +
> +       onecell_data = devm_kzalloc(dev, sizeof(*onecell_data) +
> +                                   sizeof(*onecell_data->hws) * MMC_MAX_CLKS,

struct_size()?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
