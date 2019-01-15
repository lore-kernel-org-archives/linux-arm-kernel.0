Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3B7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:29:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B9BF20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WpTbt8mV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9BF20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:Subject:From:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rfxpPrHLfcJVFN4LCCSEtCVZuFtscMEIZtnHN21wGEo=; b=WpTbt8mVEiSeIb
	ljjbBM2eGYo3RNa585YhnLoI/TZEIhNhMQXyozH/WYrKqRg8QCq4oYVzfL1KKgFOMeLyqYdSXCHS7
	3pbqrmFT7DnZV2GD1fyoZDUTXU101JqG5gcvBuU9vv1GPH7I9oZxOA312CLRsn5Oz8X/C7tcCjlDS
	2pwmtT5ryY/s1e92e/oZdCxXytXahm9rczdpPVdws+Px+ujgMmpR75m2Ncs2bV09K+v+/LSK11jE/
	u2rrUA9G4j4nTpp3R/Kbyhdi9sHn3F2m+ZOHRPMAxMf6iNSsNkV0tCoIPeuHe0+PAPQVGaaxH8nzS
	sZoz14VGmMK5l8PS8j1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjRaV-0002aZ-R4; Tue, 15 Jan 2019 16:29:15 +0000
Received: from mail-sh.amlogic.com ([58.32.228.43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjRaS-0002ZU-4F; Tue, 15 Jan 2019 16:29:13 +0000
Received: from [192.168.0.111] (223.166.104.240) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1591.10; Wed, 16 Jan
 2019 00:29:52 +0800
From: Jianxin Pan <jianxin.pan@amlogic.com>
Subject: Re: [PATCH v8 4/4] clk: meson: add sub MMC clock controller driver
To: Stephen Boyd <sboyd@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>,
 Neil Armstrong <narmstrong@baylibre.com>
References: <1545063850-21504-1-git-send-email-jianxin.pan@amlogic.com>
 <1545063850-21504-5-git-send-email-jianxin.pan@amlogic.com>
 <154706693724.15366.10802936604309826132@swboyd.mtv.corp.google.com>
Message-ID: <5d25f6a4-7a5f-b2c7-f8b3-c59fa36fe989@amlogic.com>
Date: Wed, 16 Jan 2019 00:29:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <154706693724.15366.10802936604309826132@swboyd.mtv.corp.google.com>
Content-Language: en-US
X-Originating-IP: [223.166.104.240]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh.amlogic.com
 (10.18.11.5)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_082912_171623_C07AD4A7 
X-CRM114-Status: GOOD (  12.68  )
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
 Victor Wan <victor.wan@amlogic.com>,
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

Hi Stephen,

Thank you for your time.
Please see my comments below.

On 2019/1/10 4:48, Stephen Boyd wrote:
> Quoting Jianxin Pan (2018-12-17 08:24:10)
>> diff --git a/drivers/clk/meson/mmc-clkc.c b/drivers/clk/meson/mmc-clkc.c
>> new file mode 100644
>> index 0000000..2582a98
>> --- /dev/null
>> +++ b/drivers/clk/meson/mmc-clkc.c
>> @@ -0,0 +1,304 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Amlogic Meson MMC Sub Clock Controller Driver
>> + *
>> + * Copyright (c) 2017 Baylibre SAS.
>> + * Author: Jerome Brunet <jbrunet@baylibre.com>
>> + *
>> + * Copyright (c) 2018 Amlogic, inc.
>> + * Author: Yixun Lan <yixun.lan@amlogic.com>
>> + * Author: Jianxin Pan <jianxin.pan@amlogic.com>
>> + */
>> +
>> +#include <linux/clk.h>
> 
> Do you need this include?
> 
Yes, It's also a clock-consumer. 
devm_clk_get() gets clock from dts as the parent of mux.
Thank you for your review.
>> +#include <linux/clk-provider.h>
>> +#include <linux/module.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>> +#include <linux/of_device.h>
>> +#include <linux/mfd/syscon.h>
> 
> Is this used?
Yes, syscon_node_to_regmap() is used in mmc_clkc_probe().
> 
>> +#include <linux/platform_device.h>
> [...]
>> +       init.num_parents = 1;
>> +
>> +       clk = mmc_clkc_register_clk(dev, map, &init, suffix, data);
>> +       if (IS_ERR(clk))
>> +               dev_err(dev, "%s clock registration failed\n", suffix);
>> +
>> +       return clk;
>> +}
>> +
>> +static int mmc_clkc_probe(struct platform_device *pdev)
>> +{
>> +       struct clk_hw_onecell_data *onecell_data;
>> +       struct device *dev = &pdev->dev;
>> +       struct mmc_clkc_data *data;
>> +       struct regmap *map;
>> +       struct clk_regmap *clk, *core;
>> +       struct meson_sclk_div_data *div_data;
>> +
>> +       /*cast to drop the const in match->data*/
>> +       data = (struct mmc_clkc_data *)of_device_get_match_data(dev);
> 
> Is that necessary? Maybe the users of this should take a const argument
> and copy things?
OK, I can alloc two extra memory for PHASE_RX and PHASE_TX data, and then copy from const data to them.
> 
>> +       if (!data)
>> +               return -ENODEV;
>> +
>> +       map = syscon_node_to_regmap(dev->of_node);
>> +       if (IS_ERR(map)) {
>> +               dev_err(dev, "could not find mmc clock controller\n");
>> +               return PTR_ERR(map);
>> +       }
>> +
>> +       onecell_data = devm_kzalloc(dev, sizeof(*onecell_data) +
>> +                                   sizeof(*onecell_data->hws) * MMC_MAX_CLKS,
> 
> struct_size()?
> 
OK, I will change it in the next version.
Thank you for your review.
> .
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
