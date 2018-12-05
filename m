Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A35C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:28:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87CA220879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H1sG8YFA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJIrhNmL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CA220879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I6p+CYuztw8Q5KCyX+W87zv63sYco8UjTyjN7s2xkY0=; b=H1sG8YFAqhtJ6Y
	TSE3SXfUDjDy67RDYyatZG/0ss4f1uk7BFs8xN1wYL1GNtZ8I1yUCA568HEmyVnG9Gi3sJSij60wE
	CVdHrqrximAATGdao5N5riKzEsXJOFfLjB4hoOz0K6SruYxNJvNSoM2g2Ff7WPdYEWvvPjxfg5aZ1
	JeB7qmRPmCYjM90FelrJr+WUkmIrxaoqxwAaDamlgcIXYNW4MzgzT4GbzxCwac+h1UiNZGb05B5Mq
	3ht7S1ChtXc8b9xdVb8wUAMhcGd5+dcAdJOopsUzNqabnTBAWZgymhHX1N8F6GsABDH7Cu2y00AQV
	p3vrrZwEhaI8HfaWfS8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUayS-0006VQ-0o; Wed, 05 Dec 2018 17:28:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUayO-0006Uy-CL
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 17:28:33 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EDE7D205C9;
 Wed,  5 Dec 2018 17:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544030902;
 bh=CJqF/RQAkQe8DyvmUG4i2ze4TJnVlCi4awEbse+57dk=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=pJIrhNmLsH1Iwo1G/6I/+g1aUjqR902jDDXUT0oxCPOFPR7vfDFFC//P1ke75dI0y
 VpfXSqI/ficJiQwCXaY5C+YqMn1OTC7zAHK7n1Y4uWsQa9dfwkSTstcMOyM5liT1pq
 sq8Ojw2L6rs++9O3yGz6niJ3KI+CJj190GOH3t68=
MIME-Version: 1.0
To: matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <b1a7aa06389ccd46f60db3e63bdf1e9ce9781d49.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <b1a7aa06389ccd46f60db3e63bdf1e9ce9781d49.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
Message-ID: <154403090130.88331.18352581261422337586@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6 10/10] clk: bd718x7: Initial support for ROHM
 bd71837/bd71847 PMIC clock
Date: Wed, 05 Dec 2018 09:28:21 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_092832_454809_189EAE81 
X-CRM114-Status: GOOD (  12.55  )
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
Cc: david.brown@linaro.org, linux-clk@vger.kernel.org, b.zolnierkie@samsung.com,
 andrew.smirnov@gmail.com, linux-kernel@vger.kernel.org,
 mturquette@baylibre.com, rafael.j.wysocki@intel.com, linux-doc@vger.kernel.org,
 linux@armlinux.org.uk, krzk@kernel.org, akshu.agrawal@amd.com,
 cw00.choi@samsung.com, djkurtz@chromium.org, pavel@ucw.cz,
 pombredanne@nexb.com, andy.gross@linaro.org, sjhuang@iluvatar.ai,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Matti Vaittinen (2018-12-04 03:39:38)
> diff --git a/drivers/clk/clk-bd718x7.c b/drivers/clk/clk-bd718x7.c
> new file mode 100644
> index 000000000000..d486859526ed
> --- /dev/null
> +++ b/drivers/clk/clk-bd718x7.c
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 ROHM Semiconductors
> +// bd71837.c  -- ROHM BD71837MWV clock driver

This isn't even the name of the file. Please remove. Also, only the SPDX
tag is supposed to have // on it and the other things should be normal
/* */ comment style.

> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/mfd/rohm-bd718x7.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
> +#include <linux/regmap.h>
[....]
> +
> +static int bd71837_clk_probe(struct platform_device *pdev)
> +{
> +       struct bd718xx_clk *c;
> +       int rval = -ENOMEM;
> +       const char *parent_clk;
> +       struct device *parent = pdev->dev.parent;
> +       struct bd718xx *mfd = dev_get_drvdata(parent);
> +       struct clk_init_data init = {
> +               .name = "bd718xx-32k-out",
> +               .ops = &bd71837_clk_ops,
> +       };
> +
> +       c = devm_kzalloc(&pdev->dev, sizeof(*c), GFP_KERNEL);
> +       if (!c)
> +               return -ENOMEM;
> +
> +       init.num_parents = 1;
> +       parent_clk = of_clk_get_parent_name(parent->of_node, 0);
> +
> +       init.parent_names = &parent_clk;
> +       if (!parent_clk) {
> +               dev_err(&pdev->dev, "No parent clk found\n");
> +               return -EINVAL;
> +       }
> +
> +       c->reg = BD718XX_REG_OUT32K;
> +       c->mask = BD718XX_OUT32K_EN;
> +       c->mfd = mfd;
> +       c->pdev = pdev;
> +       c->hw.init = &init;
> +
> +       of_property_read_string_index(parent->of_node,
> +                                     "clock-output-names", 0, &init.name);
> +
> +       rval = devm_clk_hw_register(&pdev->dev, &c->hw);
> +       if (!rval) {
> +               rval = devm_clk_hw_register_clkdev(&pdev->dev,
> +                                                  &c->hw, init.name, NULL);

Do you plan to use the clkdev lookup? This driver looks fairly DT
dependent, so I would prefer to remove the clkdev part and only add it
later if anyone needs it.

> +               if (rval)
> +                       dev_warn(&pdev->dev, "Failed to register clkdev\n");
> +               if (parent->of_node) {
> +                       rval = devm_of_clk_add_hw_provider(&pdev->dev,
> +                                            of_clk_hw_simple_get, &c->hw);
> +                       if (rval)
> +                               dev_err(&pdev->dev,
> +                                       "adding clk provider failed\n");
> +               }

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
