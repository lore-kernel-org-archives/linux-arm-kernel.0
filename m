Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62B5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 02:51:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A53F8218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 02:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oY6V818/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53F8218D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ldGmc0Pp5+IVzZ+CPqgI636krdhmlFcG1d/JYiNTPWA=; b=oY6V818/6nEs3+
	qU4ovP1qX6F0q/o+vI3E+nGGsI8jJVDBsSO0xx/QPnBOnA9AF1Z54vD2XM1D/P7chjoQ+A7OENeeh
	W34H2WappeSNvuZAUEqTlAXopscC/iOjlAo9Yq2egV0Q25jcS9O0v064up53kMv7o1Si5L4xAj+Dg
	bYQ7OkhsyOlZP45or38Z1Vp50yrRO4tw/Au7so8gjZaPDRUy+8RKJHcyTzJeMpF2q0t8lsKvoivxw
	mDzyXVTfLivTHV2d7/lv+p4iP5gocjilr6PuTgu6vkc1L4FDYiq9XwvTdENVa8HYyHC6xJ7H57oui
	RkCmINaETSfuPAtUCv9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gypK0-00032m-0Z; Wed, 27 Feb 2019 02:51:48 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gypJv-00032J-U5; Wed, 27 Feb 2019 02:51:46 +0000
X-UUID: faf103a4ae404865a65a011249da1db3-20190226
X-UUID: faf103a4ae404865a65a011249da1db3-20190226
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <weiyi.lu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 253445878; Tue, 26 Feb 2019 18:51:40 -0800
Received: from MTKMBS01N1.mediatek.inc (172.21.101.68) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 26 Feb 2019 18:51:39 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Feb 2019 10:51:37 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Feb 2019 10:51:37 +0800
Message-ID: <1551235897.1047.11.camel@mtksdaap41>
Subject: Re: [PATCH v4 08/12] clk: mediatek: Add MT8183 clock support
From: Weiyi Lu <weiyi.lu@mediatek.com>
To: Stephen Boyd <sboyd@kernel.org>
Date: Wed, 27 Feb 2019 10:51:37 +0800
In-Reply-To: <155120345816.260864.13433355004684800350@swboyd.mtv.corp.google.com>
References: <20190201083016.25856-1-weiyi.lu@mediatek.com>
 <20190201083016.25856-10-weiyi.lu@mediatek.com>
 <155120345816.260864.13433355004684800350@swboyd.mtv.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_185143_973291_EC0D3BC0 
X-CRM114-Status: GOOD (  15.21  )
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
Cc: Rob Herring <robh@kernel.org>, Nicolas Boichat <drinkcat@chromium.org>,
 srv_heupstream@mediatek.com, James Liao <jamesjj.liao@mediatek.com>,
 Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Fan Chen <fan.chen@mediatek.com>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2019-02-26 at 09:50 -0800, Stephen Boyd wrote:
> Quoting Weiyi Lu (2019-02-01 00:30:12)
> > diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
> > new file mode 100644
> > index 000000000000..e9de9fe774ca
> > --- /dev/null
> > +++ b/drivers/clk/mediatek/clk-mt8183.c
> > @@ -0,0 +1,1285 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// Copyright (c) 2018 MediaTek Inc.
> > +// Author: Weiyi Lu <weiyi.lu@mediatek.com>
> > +
> > +#include <linux/delay.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +
> [....]
> > +
> > +static int clk_mt8183_top_probe(struct platform_device *pdev)
> > +{
> > +       struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       void __iomem *base;
> > +       struct clk_onecell_data *clk_data;
> > +       struct device_node *node = pdev->dev.of_node;
> > +
> > +       base = devm_ioremap_resource(&pdev->dev, res);
> > +       if (IS_ERR(base)) {
> > +               pr_err("%s(): ioremap failed\n", __func__);
> 
> This API already prints an error so please remove this duplicate error
> message
> 

ok, I'll remove those duplicate error message in next version.

> > +               return PTR_ERR(base);
> > +       }
> > +
> > +       clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
> > +
> > +       mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
> > +               clk_data);
> > +
> > +       mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
> > +
> > +       mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes),
> > +               node, &mt8183_clk_lock, clk_data);
> > +
> > +       mtk_clk_register_composites(top_aud_muxes, ARRAY_SIZE(top_aud_muxes),
> > +               base, &mt8183_clk_lock, clk_data);
> > +
> > +       mtk_clk_register_composites(top_aud_divs, ARRAY_SIZE(top_aud_divs),
> > +               base, &mt8183_clk_lock, clk_data);
> > +
> > +       mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
> > +               clk_data);
> > +
> > +       return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> > +}
> > +
> > +static int clk_mt8183_infra_probe(struct platform_device *pdev)
> > +{
> > +       struct clk_onecell_data *clk_data;
> > +       struct device_node *node = pdev->dev.of_node;
> > +
> > +       clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
> > +
> > +       mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
> > +               clk_data);
> > +
> > +       return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> > +}
> > +
> > +static int clk_mt8183_mcu_probe(struct platform_device *pdev)
> > +{
> > +       struct clk_onecell_data *clk_data;
> > +       struct device_node *node = pdev->dev.of_node;
> > +       void __iomem *base;
> > +       struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +
> > +       base = devm_ioremap_resource(&pdev->dev, res);
> > +       if (IS_ERR(base)) {
> > +               pr_err("%s(): ioremap failed\n", __func__);
> > +               return PTR_ERR(base);
> > +       }
> > +
> > +       clk_data = mtk_alloc_clk_data(CLK_MCU_NR_CLK);
> 
> Can this fail? It doesn't seem to be checked for failure so I guess we
> don't care?
> 

It might fail but we have data validity checks in all the
mtk_clk_register APIs.

> > +
> > +       mtk_clk_register_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes), base,
> > +                       &mt8183_clk_lock, clk_data);
> > +
> > +       return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> > +}
> > +
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
