Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A88BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:02:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDFCD21934
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PyIbOW1+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="htdykzQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDFCD21934
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aO4Pih9ww3HwzuZS/Xh6grXljLO9pV1zYZKU+gOTMro=; b=PyIbOW1+O4DIVo
	1VpwhycAsNwqXJIclObdOE9LRB2sltdC5rVcqD8O05aDdBfmzuOzh6+hOGcm+30ljJtwm+O79Iw9A
	pD/pN6lfYHgWf4zHAFeadGeCuDFHPMHgY/YBPhOZ9QmO2byjrkr65THIapeFEt1Ac8PYxebyVF3Z0
	Yj/fGGpiUMggBthCzIVQz4XgiVh1wn5pjEVj5ngdJ2ddotZyxtxhRhdUECjp7gWFJxHvI08uVwEND
	k3+BsXW3E7aIWUhHJjsFkRDeD4cLXEQrIfW+hK6SR0wgzsyPlqZRKH+AAIG6PYK/oxwWRJxLFdanK
	z6MotLdBWVWS7qgQsAHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guA6a-0004DV-Rf; Thu, 14 Feb 2019 06:02:40 +0000
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guA6W-0004CK-Rz
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 06:02:38 +0000
Received: by mail-qk1-x744.google.com with SMTP id p15so2936890qkl.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 22:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fjYk8M+ZpYBHIdl3SpuI+eMPnvXJ1FTwPx90gKG5ags=;
 b=htdykzQ6xRtqzlK300swdx4zlf+eSRWKvGd++NszWWrVAyevn5sSGjQoFRgg53bRt3
 ODwpAL2JsbRsFvSlgHHkg4s1+qIX1HzXzHJtKmgzuGWqNgc29TKbBAlgmPc2Dxr6XWi5
 cLo/mQsXn0b4UBcivhHQG1LMWDCEvVM+hQOUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fjYk8M+ZpYBHIdl3SpuI+eMPnvXJ1FTwPx90gKG5ags=;
 b=D/05M0OnjQV79+oOFTrZ21r9JfIMctlkS4KshstxAN9Koxu4XXHz8sepV1dUsQ6T2D
 YMCmof8P8JxgyhS3vt7Ux4OpZm+VuR59dPb6JyN56vMDDqvXxgT5ez03ygnoytkwY4Nd
 0wEyzks82e2Z8ceLNSeP7YXYxhsXjh9vsS4cGvKX8A09c5Q8uznzFcmk68VATLdCUkH2
 Vy7TMqNeonkZK8Tm8n3J8y3JFmQpdRfxvITGowJA7uGjN8Bby1Y4+thUGNpfLhkGJlpS
 2ceq493gfH7CQPfVeViISymevqiEnvi0cteJPfU3ew2RboKwo/Hc5xQ6oQlRtNdKwI8J
 I0OQ==
X-Gm-Message-State: AHQUAuYaGoar9VDvTGRo5puP49SvszWWiHLjxeWRiv3wpOaxt6DIw+I8
 w7F+nLLd3NaUaI4mH8FalWo130Xpc+BgYKYxGPP8nQ==
X-Google-Smtp-Source: AHgI3Iby8fhzCIwktkWL4Ujf0oyJahj4kZsiZDwr2lsB2cT0Yffc5bVfRKg2O4WsTWc1D/2jb9WkzHFYqVAoonPJNDw=
X-Received: by 2002:a37:4d57:: with SMTP id a84mr1433821qkb.288.1550124152382; 
 Wed, 13 Feb 2019 22:02:32 -0800 (PST)
MIME-Version: 1.0
References: <20190214044243.129920-1-jitao.shi@mediatek.com>
In-Reply-To: <20190214044243.129920-1-jitao.shi@mediatek.com>
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Thu, 14 Feb 2019 14:02:21 +0800
Message-ID: <CANMq1KC+ga-Sjxj6eD51nLmq_54Y-gpJR_8qOLQee5gAy7ypkQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/mediatek: move mipi_dsi_host_register to probe
To: Jitao Shi <jitao.shi@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_220236_951479_AD852AA4 
X-CRM114-Status: GOOD (  21.03  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 David Airlie <airlied@linux.ie>, stonea168@163.com,
 dri-devel@lists.freedesktop.org, Yingjoe Chen <yingjoe.chen@mediatek.com>,
 Ajay Kumar <ajaykumar.rs@samsung.com>, Vincent Palatin <vpalatin@chromium.org>,
 cawa cheng <cawa.cheng@mediatek.com>,
 =?UTF-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <bibby.hsieh@mediatek.com>,
 CK HU <ck.hu@mediatek.com>, Russell King <rmk+kernel@arm.linux.org.uk>,
 Thierry Reding <treding@nvidia.com>, linux-pwm@vger.kernel.org,
 Sascha Hauer <kernel@pengutronix.de>, Pawel Moll <pawel.moll@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>, Inki Dae <inki.dae@samsung.com>,
 Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Andy Yan <andy.yan@rock-chips.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Eddie Huang <eddie.huang@mediatek.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 Rahul Sharma <rahul.sharma@samsung.com>, srv_heupstream@mediatek.com,
 lkml <linux-kernel@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Kumar Gala <galak@codeaurora.org>, Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Just some comments on the error path, I'm not sure about the change itself.

On Thu, Feb 14, 2019 at 12:42 PM Jitao Shi <jitao.shi@mediatek.com> wrote:
>
> DSI panel driver need attach function which is inculde in
> mipi_dsi_host_ops.
>
> If mipi_dsi_host_register is not in probe, dsi panel will
> probe fail or more delay.
>
> So move the mipi_dsi_host_register to probe from bind.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 49 ++++++++++++++++++------------
>  1 file changed, 30 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 27b507eb4a99..93fa255b4aad 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -1045,12 +1045,6 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
>                 return ret;
>         }
>
> -       ret = mipi_dsi_host_register(&dsi->host);
> -       if (ret < 0) {
> -               dev_err(dev, "failed to register DSI host: %d\n", ret);
> -               goto err_ddp_comp_unregister;
> -       }
> -
>         ret = mtk_dsi_create_conn_enc(drm, dsi);
>         if (ret) {
>                 DRM_ERROR("Encoder create failed with %d\n", ret);
> @@ -1060,8 +1054,6 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
>         return 0;
>
>  err_unregister:
> -       mipi_dsi_host_unregister(&dsi->host);
> -err_ddp_comp_unregister:
>         mtk_ddp_comp_unregister(drm, &dsi->ddp_comp);
>         return ret;
>  }
> @@ -1097,31 +1089,37 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>
>         dsi->host.ops = &mtk_dsi_ops;
>         dsi->host.dev = dev;
> +       dsi->dev = dev;
> +       ret = mipi_dsi_host_register(&dsi->host);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to register DSI host: %d\n", ret);
> +               return -EPROBE_DEFER;

return ret

> +       }
>
>         ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
>                                           &dsi->panel, &dsi->bridge);
>         if (ret)
> -               return ret;
> +               goto err_unregister_host;
>
>         dsi->engine_clk = devm_clk_get(dev, "engine");
>         if (IS_ERR(dsi->engine_clk)) {
>                 ret = PTR_ERR(dsi->engine_clk);
>                 dev_err(dev, "Failed to get engine clock: %d\n", ret);
> -               return ret;
> +               goto err_unregister_host;
>         }
>
>         dsi->digital_clk = devm_clk_get(dev, "digital");
>         if (IS_ERR(dsi->digital_clk)) {
>                 ret = PTR_ERR(dsi->digital_clk);
>                 dev_err(dev, "Failed to get digital clock: %d\n", ret);
> -               return ret;
> +               goto err_unregister_host;
>         }
>
>         dsi->hs_clk = devm_clk_get(dev, "hs");
>         if (IS_ERR(dsi->hs_clk)) {
>                 ret = PTR_ERR(dsi->hs_clk);
>                 dev_err(dev, "Failed to get hs clock: %d\n", ret);
> -               return ret;
> +               goto err_unregister_host;
>         }
>
>         regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -1129,33 +1127,35 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>         if (IS_ERR(dsi->regs)) {
>                 ret = PTR_ERR(dsi->regs);
>                 dev_err(dev, "Failed to ioremap memory: %d\n", ret);
> -               return ret;
> +               goto err_unregister_host;
>         }
>
>         dsi->phy = devm_phy_get(dev, "dphy");
>         if (IS_ERR(dsi->phy)) {
>                 ret = PTR_ERR(dsi->phy);
>                 dev_err(dev, "Failed to get MIPI-DPHY: %d\n", ret);
> -               return ret;
> +               goto err_unregister_host;
>         }
>
>         comp_id = mtk_ddp_comp_get_id(dev->of_node, MTK_DSI);
>         if (comp_id < 0) {
>                 dev_err(dev, "Failed to identify by alias: %d\n", comp_id);
> -               return comp_id;
> +               ret = comp_id;
> +               goto err_unregister_host;
>         }
>
>         ret = mtk_ddp_comp_init(dev, dev->of_node, &dsi->ddp_comp, comp_id,
>                                 &mtk_dsi_funcs);
>         if (ret) {
>                 dev_err(dev, "Failed to initialize component: %d\n", ret);
> -               return ret;
> +               goto err_unregister_host;
>         }
>
>         irq_num = platform_get_irq(pdev, 0);
>         if (irq_num < 0) {
>                 dev_err(&pdev->dev, "failed to request dsi irq resource\n");
> -               return -EPROBE_DEFER;
> +               ret = -EPROBE_DEFER;

I think you need to do ret = irq_num here, too (and yes, it was
probably wrong before?)

> +               goto err_unregister_host;
>         }
>
>         irq_set_status_flags(irq_num, IRQ_TYPE_LEVEL_LOW);
> @@ -1163,14 +1163,25 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>                                IRQF_TRIGGER_LOW, dev_name(&pdev->dev), dsi);
>         if (ret) {
>                 dev_err(&pdev->dev, "failed to request mediatek dsi irq\n");
> -               return -EPROBE_DEFER;
> +               ret = -EPROBE_DEFER;

Ditto, I'd not reassign ret.

> +               goto err_unregister_host;
>         }
>
>         init_waitqueue_head(&dsi->irq_wait_queue);
>
>         platform_set_drvdata(pdev, dsi);
>
> -       return component_add(&pdev->dev, &mtk_dsi_component_ops);
> +       ret = component_add(&pdev->dev, &mtk_dsi_component_ops);
> +       if (ret) {
> +               ret = -EPROBE_DEFER;

Ditto (this one _was_ right before).

> +               goto err_unregister_host;
> +       }
> +
> +       return 0;
> +
> +err_unregister_host:
> +       mipi_dsi_host_unregister(&dsi->host);
> +       return ret;
>  }
>
>  static int mtk_dsi_remove(struct platform_device *pdev)
> --
> 2.20.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
