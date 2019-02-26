Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68477C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:51:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D1D22173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KMMijRwx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eU7Tu+U4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D1D22173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:In-Reply-To:From:Subject:
	Message-ID:References:To:MIME-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rXw/EFovOWPkaEanJnj/xTs65qv7OaamwikstjwWpOc=; b=KMMijRwx2lDVoV
	PL/d+rBhfayf3spE3Ugng0Cm3g0A6RTlDu8m0sYqO11YxcRdfucMdm9oi7Uy1+YPfq52Gv7vVQ5o+
	plpqSl/BqTj0Ut6TCzqGOy/nWmc/jqc4rREXq6BPF4Zb97+OCnVXe3Spo3F7SRI4wIPn3qGKNe+0A
	Rfdg+KThemJd4MqPnH3ba2SW6GIqOSNSwHRoCk79h2H6Ul6dhismhZZHbp2H+N/jIzHCfEm22DJs9
	awhPBZGILFrKHOoxUinytMszgqYSuJHABNJNCBQEE9pAJ9VLDBCIDQ9kv6r6hSVxIThw1a8qezPye
	OU3DpyJJ4Y9Bdw1anJXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gygsg-0003TI-OE; Tue, 26 Feb 2019 17:51:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gygsd-0003Rz-Al; Tue, 26 Feb 2019 17:51:00 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EB8352173C;
 Tue, 26 Feb 2019 17:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551203459;
 bh=3nANAhLFyGRirluaGDEeKEuf9286NQe83pDNkn3J9cs=;
 h=To:References:Cc:Subject:From:In-Reply-To:Date:From;
 b=eU7Tu+U4qF5KIUncNyhZSeY/wqfVC2NtvtPhW8Vgp61WDzK1OOnj9df3Ved0morI9
 ADal/JolADUMjFEeDzhztiednhGKX0AR/CaewISTFaZKW4bjvHJcp2P2OmYr500781
 WowW3sDEvrvrRrYeMJAfU6hPJlFn9gmF/CsycrKk=
MIME-Version: 1.0
To: Matthias Brugger <matthias.bgg@gmail.com>,
 Nicolas Boichat <drinkcat@chromium.org>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@codeaurora.org>, Weiyi Lu <weiyi.lu@mediatek.com>
References: <20190201083016.25856-1-weiyi.lu@mediatek.com>
 <20190201083016.25856-10-weiyi.lu@mediatek.com>
Message-ID: <155120345816.260864.13433355004684800350@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Subject: Re: [PATCH v4 08/12] clk: mediatek: Add MT8183 clock support
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190201083016.25856-10-weiyi.lu@mediatek.com>
Date: Tue, 26 Feb 2019 09:50:58 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_095059_419632_B0F72F95 
X-CRM114-Status: GOOD (  10.60  )
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
Cc: James Liao <jamesjj.liao@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
 srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Fan Chen <fan.chen@mediatek.com>,
 linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Weiyi Lu (2019-02-01 00:30:12)
> diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
> new file mode 100644
> index 000000000000..e9de9fe774ca
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8183.c
> @@ -0,0 +1,1285 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2018 MediaTek Inc.
> +// Author: Weiyi Lu <weiyi.lu@mediatek.com>
> +
> +#include <linux/delay.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
[....]
> +
> +static int clk_mt8183_top_probe(struct platform_device *pdev)
> +{
> +       struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       void __iomem *base;
> +       struct clk_onecell_data *clk_data;
> +       struct device_node *node = pdev->dev.of_node;
> +
> +       base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(base)) {
> +               pr_err("%s(): ioremap failed\n", __func__);

This API already prints an error so please remove this duplicate error
message

> +               return PTR_ERR(base);
> +       }
> +
> +       clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
> +
> +       mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
> +               clk_data);
> +
> +       mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
> +
> +       mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes),
> +               node, &mt8183_clk_lock, clk_data);
> +
> +       mtk_clk_register_composites(top_aud_muxes, ARRAY_SIZE(top_aud_muxes),
> +               base, &mt8183_clk_lock, clk_data);
> +
> +       mtk_clk_register_composites(top_aud_divs, ARRAY_SIZE(top_aud_divs),
> +               base, &mt8183_clk_lock, clk_data);
> +
> +       mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
> +               clk_data);
> +
> +       return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +}
> +
> +static int clk_mt8183_infra_probe(struct platform_device *pdev)
> +{
> +       struct clk_onecell_data *clk_data;
> +       struct device_node *node = pdev->dev.of_node;
> +
> +       clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
> +
> +       mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
> +               clk_data);
> +
> +       return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +}
> +
> +static int clk_mt8183_mcu_probe(struct platform_device *pdev)
> +{
> +       struct clk_onecell_data *clk_data;
> +       struct device_node *node = pdev->dev.of_node;
> +       void __iomem *base;
> +       struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +       base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(base)) {
> +               pr_err("%s(): ioremap failed\n", __func__);
> +               return PTR_ERR(base);
> +       }
> +
> +       clk_data = mtk_alloc_clk_data(CLK_MCU_NR_CLK);

Can this fail? It doesn't seem to be checked for failure so I guess we
don't care?

> +
> +       mtk_clk_register_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes), base,
> +                       &mt8183_clk_lock, clk_data);
> +
> +       return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +}
> +

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
