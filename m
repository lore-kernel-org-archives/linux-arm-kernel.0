Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD857C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:24:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9097020645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GZNa0YNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9097020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KbccPEib2U3GyI/BBzsBJjK3tmuLHb7RFOPVoiXQqCo=; b=GZNa0YNW03FNpc
	akjIBhYJpVaKwACIt7gJofPAH2DNGD+K7DsUK62q/duxGEb2b/BQALBDN9w+qQOWglb4+1PsGB6Qa
	NXVh/RYeE1y64kzD0bD+URawlf+vJdYh/whaXCWT5NibTAtqu3jquQrZ+xJrP8sg9Kf/TBUcVHYDl
	kS29s1WSnZKbK0iMTyKcN2kU+9j0hcm1LNA3hqPsWlNNLx3/OFk8ccAK9rzcpDTEoFR41FAd8WwxI
	k7zDkDQGjkWHyyCnCM/rGx9XwmplSHW/BDXC6Zxbyw8bLm+XigIOyv23FpUO0he3chIXPueTcFXP+
	7Jgm2k4TZJTnnMyo6Qiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUbqs-00072H-FI; Wed, 05 Dec 2018 18:24:50 +0000
Received: from mail-lj1-f193.google.com ([209.85.208.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUbqo-00071n-MJ
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 18:24:48 +0000
Received: by mail-lj1-f193.google.com with SMTP id v1-v6so19278571ljd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 10:24:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=LEpiSlqrR7Ad0w48eDX/Xp8zFO8FXef8bg6emoIDpa8=;
 b=PlQS8pUh5UzWjYpAVt+hb65n3Ve43aYNHc6xQZigC8reXvDg8alGT/kQ6ufx+i+aOa
 /lV2lB6t+T5hY0s4ctxTNqPrcUlG3TbHUEAJU87q1gylWjlYE7NLStTExdHEE87P74G1
 dEJvIYVBnkabMAshDlaMrqUXRRUkjryYdPn1sOL4nJrADxhKfmK4Xpw5XtlZaYGqvvm4
 4kbKHBD1VtI9MmrYEq+cy0lQ6hOyYVF9R3NDbJOcYsE1w15kDzaKo3yKDLyk3o9bPLF3
 vF9dkq1sRwjkpbg2arFyez7qgvzzrztS3hGttbGK8eyZm5VQLXo0sTiFz7jrTB8aWZBF
 yTSA==
X-Gm-Message-State: AA+aEWbn6QzAiJ+SNLeXuHKkXLUKd5afP6IPVMAdZC6xQ3rkm633zx73
 z6zwUQbeqGiSc/63WcAy+Yo=
X-Google-Smtp-Source: AFSGD/UeriZm3dGS9tCBzpYxA7rpbmXrfQX1F0JOK2nh+CYjH42tAqUmnMIrE7uZXc1Fi7e+azPNoQ==
X-Received: by 2002:a2e:4218:: with SMTP id
 p24-v6mr16364333lja.58.1544034274785; 
 Wed, 05 Dec 2018 10:24:34 -0800 (PST)
Received: from localhost.localdomain (84-253-205-125.bb.dnainternet.fi.
 [84.253.205.125])
 by smtp.gmail.com with ESMTPSA id l21-v6sm3877851ljj.48.2018.12.05.10.24.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 10:24:34 -0800 (PST)
Date: Wed, 5 Dec 2018 20:24:30 +0200
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v6 10/10] clk: bd718x7: Initial support for ROHM
 bd71837/bd71847 PMIC clock
Message-ID: <20181205182430.GG31204@localhost.localdomain>
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <b1a7aa06389ccd46f60db3e63bdf1e9ce9781d49.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <154403090130.88331.18352581261422337586@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <154403090130.88331.18352581261422337586@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_102446_726503_B2FD5E5B 
X-CRM114-Status: GOOD (  19.77  )
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
Cc: david.brown@linaro.org, rafael.j.wysocki@intel.com,
 linux-clk@vger.kernel.org, b.zolnierkie@samsung.com, andrew.smirnov@gmail.com,
 linux-kernel@vger.kernel.org, mturquette@baylibre.com,
 mazziesaccount@gmail.com, linux-doc@vger.kernel.org, linux@armlinux.org.uk,
 krzk@kernel.org, akshu.agrawal@amd.com, cw00.choi@samsung.com,
 djkurtz@chromium.org, pavel@ucw.cz, pombredanne@nexb.com,
 andy.gross@linaro.org, sjhuang@iluvatar.ai,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Thanks again Stephen.

On Wed, Dec 05, 2018 at 09:28:21AM -0800, Stephen Boyd wrote:
> Quoting Matti Vaittinen (2018-12-04 03:39:38)
> > diff --git a/drivers/clk/clk-bd718x7.c b/drivers/clk/clk-bd718x7.c
> > new file mode 100644
> > index 000000000000..d486859526ed
> > --- /dev/null
> > +++ b/drivers/clk/clk-bd718x7.c
> > @@ -0,0 +1,131 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (C) 2018 ROHM Semiconductors
> > +// bd71837.c  -- ROHM BD71837MWV clock driver
> 
> This isn't even the name of the file. Please remove. Also, only the SPDX
> tag is supposed to have // on it and the other things should be normal
> /* */ comment style.

I'll drop this name.

> 
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/err.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/mfd/rohm-bd718x7.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/clkdev.h>
> > +#include <linux/regmap.h>
> [....]
> > +
> > +static int bd71837_clk_probe(struct platform_device *pdev)
> > +{
> > +       struct bd718xx_clk *c;
> > +       int rval = -ENOMEM;
> > +       const char *parent_clk;
> > +       struct device *parent = pdev->dev.parent;
> > +       struct bd718xx *mfd = dev_get_drvdata(parent);
> > +       struct clk_init_data init = {
> > +               .name = "bd718xx-32k-out",
> > +               .ops = &bd71837_clk_ops,
> > +       };
> > +
> > +       c = devm_kzalloc(&pdev->dev, sizeof(*c), GFP_KERNEL);
> > +       if (!c)
> > +               return -ENOMEM;
> > +
> > +       init.num_parents = 1;
> > +       parent_clk = of_clk_get_parent_name(parent->of_node, 0);
> > +
> > +       init.parent_names = &parent_clk;
> > +       if (!parent_clk) {
> > +               dev_err(&pdev->dev, "No parent clk found\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       c->reg = BD718XX_REG_OUT32K;
> > +       c->mask = BD718XX_OUT32K_EN;
> > +       c->mfd = mfd;
> > +       c->pdev = pdev;
> > +       c->hw.init = &init;
> > +
> > +       of_property_read_string_index(parent->of_node,
> > +                                     "clock-output-names", 0, &init.name);
> > +
> > +       rval = devm_clk_hw_register(&pdev->dev, &c->hw);
> > +       if (!rval) {
> > +               rval = devm_clk_hw_register_clkdev(&pdev->dev,
> > +                                                  &c->hw, init.name, NULL);
> 
> Do you plan to use the clkdev lookup? This driver looks fairly DT
> dependent, so I would prefer to remove the clkdev part and only add it
> later if anyone needs it.

Right. We depend heavily on DT so I guess I can drop the clkdev portion.

> > +               if (rval)
> > +                       dev_warn(&pdev->dev, "Failed to register clkdev\n");
> > +               if (parent->of_node) {
> > +                       rval = devm_of_clk_add_hw_provider(&pdev->dev,
> > +                                            of_clk_hw_simple_get, &c->hw);
> > +                       if (rval)
> > +                               dev_err(&pdev->dev,
> > +                                       "adding clk provider failed\n");
> > +               }

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
