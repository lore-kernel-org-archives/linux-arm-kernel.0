Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA027C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:33:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5916218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JqAJAEXu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5916218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ry25CUX4R2VZuXo25AOLiAmTH4zjXLjo5wfVtCMNiE0=; b=JqAJAEXuGG6+Tp
	3pXXL0P3xzcj8K44xRlx9bBxddind6c8NkvkHV/zrTUM8HPaXrI7cX2lTqeg8x7PUgHqux+7ezvah
	TwIEBVO8FifW+egivRqCXTeZfr6Rw1T9Wxy/mrZ/Jhe2xlB4coBflpdQBPJR4oabW336T6COhNsp6
	iLfpzta5H1f8bNHm51dO8hRFdUhOksAm9UDqfFNvq88l+TehyYRiph5oaHhvZFdPLS2iGXsy5uz7/
	QL8AEHb1/1hD1rg1egFCMooe5HEvwA/yF2lalshlXzvs/DBlCY6trXKsK9zrNfm+7cIhe65hfj8oi
	MGdLYXI2gQjkr/uVRRoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvNVV-000086-EM; Sun, 17 Feb 2019 14:33:25 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvNVR-00007G-Jn; Sun, 17 Feb 2019 14:33:23 +0000
X-UUID: 7b06f22cffa746c4b17ac80b6875bd97-20190217
X-UUID: 7b06f22cffa746c4b17ac80b6875bd97-20190217
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <jitao.shi@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 706559272; Sun, 17 Feb 2019 06:33:08 -0800
Received: from MTKMBS32N1.mediatek.inc (172.27.4.71) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 17 Feb 2019 06:33:06 -0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Sun, 17 Feb 2019 22:33:03 +0800
Received: from [10.16.6.141] (10.16.6.141) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 17 Feb 2019 22:33:02 +0800
Message-ID: <1550413981.5194.8.camel@mszsdaap41>
Subject: Re: [PATCH 1/3] drm/mediatek: move mipi_dsi_host_register to probe
From: Jitao Shi <jitao.shi@mediatek.com>
To: Sean Paul <sean@poorly.run>
Date: Sun, 17 Feb 2019 22:33:01 +0800
In-Reply-To: <20190214204821.GP114153@art_vandelay>
References: <20190214044243.129920-1-jitao.shi@mediatek.com>
 <20190214204821.GP114153@art_vandelay>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_063321_654095_ECC7C809 
X-CRM114-Status: GOOD (  18.84  )
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
 dri-devel@lists.freedesktop.org, Ajay Kumar <ajaykumar.rs@samsung.com>,
 drinkcat@chromium.org, Vincent Palatin <vpalatin@chromium.org>,
 linux-mediatek@lists.infradead.org, cawa.cheng@mediatek.com,
 bibby.hsieh@mediatek.com, ck.hu@mediatek.com, Russell
 King <rmk+kernel@arm.linux.org.uk>, Thierry Reding <treding@nvidia.com>,
 linux-pwm@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>,
 Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Inki Dae <inki.dae@samsung.com>, Rob Herring <robh+dt@kernel.org>,
 Sean Paul <seanpaul@chromium.org>, yingjoe.chen@mediatek.com, Matthias
 Brugger <matthias.bgg@gmail.com>, eddie.huang@mediatek.com,
 linux-arm-kernel@lists.infradead.org, Rahul Sharma <rahul.sharma@samsung.com>,
 srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
 Philipp Zabel <p.zabel@pengutronix.de>, Kumar Gala <galak@codeaurora.org>,
 Andy Yan <andy.yan@rock-chips.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 2019-02-14 at 15:48 -0500, Sean Paul wrote:
> On Thu, Feb 14, 2019 at 12:42:41PM +0800, Jitao Shi wrote:
> > DSI panel driver need attach function which is inculde in
> > mipi_dsi_host_ops.
> 
> Which function is required from dsi_host?
> 
> Sean
> 

mipi_dsi_attach request the mipi_dsi_host_register ready.

for example.

mipi_dsi_attach is called by panel_simple_dsi_probe. 

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/panel/panel-simple.c?h=v5.0-rc6#n2987

jitao

> > 
> > If mipi_dsi_host_register is not in probe, dsi panel will
> > probe fail or more delay.
> > 
> > So move the mipi_dsi_host_register to probe from bind.
> > 
> > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dsi.c | 49 ++++++++++++++++++------------
> >  1 file changed, 30 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > index 27b507eb4a99..93fa255b4aad 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > @@ -1045,12 +1045,6 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
> >  		return ret;
> >  	}
> >  
> > -	ret = mipi_dsi_host_register(&dsi->host);
> > -	if (ret < 0) {
> > -		dev_err(dev, "failed to register DSI host: %d\n", ret);
> > -		goto err_ddp_comp_unregister;
> > -	}
> > -
> >  	ret = mtk_dsi_create_conn_enc(drm, dsi);
> >  	if (ret) {
> >  		DRM_ERROR("Encoder create failed with %d\n", ret);
> > @@ -1060,8 +1054,6 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
> >  	return 0;
> >  
> >  err_unregister:
> > -	mipi_dsi_host_unregister(&dsi->host);
> > -err_ddp_comp_unregister:
> >  	mtk_ddp_comp_unregister(drm, &dsi->ddp_comp);
> >  	return ret;
> >  }
> > @@ -1097,31 +1089,37 @@ static int mtk_dsi_probe(struct platform_device *pdev)
> >  
> >  	dsi->host.ops = &mtk_dsi_ops;
> >  	dsi->host.dev = dev;
> > +	dsi->dev = dev;
> > +	ret = mipi_dsi_host_register(&dsi->host);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to register DSI host: %d\n", ret);
> > +		return -EPROBE_DEFER;
> > +	}
> >  
> >  	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
> >  					  &dsi->panel, &dsi->bridge);
> >  	if (ret)
> > -		return ret;
> > +		goto err_unregister_host;
> >  
> >  	dsi->engine_clk = devm_clk_get(dev, "engine");
> >  	if (IS_ERR(dsi->engine_clk)) {
> >  		ret = PTR_ERR(dsi->engine_clk);
> >  		dev_err(dev, "Failed to get engine clock: %d\n", ret);
> > -		return ret;
> > +		goto err_unregister_host;
> >  	}
> >  
> >  	dsi->digital_clk = devm_clk_get(dev, "digital");
> >  	if (IS_ERR(dsi->digital_clk)) {
> >  		ret = PTR_ERR(dsi->digital_clk);
> >  		dev_err(dev, "Failed to get digital clock: %d\n", ret);
> > -		return ret;
> > +		goto err_unregister_host;
> >  	}
> >  
> >  	dsi->hs_clk = devm_clk_get(dev, "hs");
> >  	if (IS_ERR(dsi->hs_clk)) {
> >  		ret = PTR_ERR(dsi->hs_clk);
> >  		dev_err(dev, "Failed to get hs clock: %d\n", ret);
> > -		return ret;
> > +		goto err_unregister_host;
> >  	}
> >  
> >  	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > @@ -1129,33 +1127,35 @@ static int mtk_dsi_probe(struct platform_device *pdev)
> >  	if (IS_ERR(dsi->regs)) {
> >  		ret = PTR_ERR(dsi->regs);
> >  		dev_err(dev, "Failed to ioremap memory: %d\n", ret);
> > -		return ret;
> > +		goto err_unregister_host;
> >  	}
> >  
> >  	dsi->phy = devm_phy_get(dev, "dphy");
> >  	if (IS_ERR(dsi->phy)) {
> >  		ret = PTR_ERR(dsi->phy);
> >  		dev_err(dev, "Failed to get MIPI-DPHY: %d\n", ret);
> > -		return ret;
> > +		goto err_unregister_host;
> >  	}
> >  
> >  	comp_id = mtk_ddp_comp_get_id(dev->of_node, MTK_DSI);
> >  	if (comp_id < 0) {
> >  		dev_err(dev, "Failed to identify by alias: %d\n", comp_id);
> > -		return comp_id;
> > +		ret = comp_id;
> > +		goto err_unregister_host;
> >  	}
> >  
> >  	ret = mtk_ddp_comp_init(dev, dev->of_node, &dsi->ddp_comp, comp_id,
> >  				&mtk_dsi_funcs);
> >  	if (ret) {
> >  		dev_err(dev, "Failed to initialize component: %d\n", ret);
> > -		return ret;
> > +		goto err_unregister_host;
> >  	}
> >  
> >  	irq_num = platform_get_irq(pdev, 0);
> >  	if (irq_num < 0) {
> >  		dev_err(&pdev->dev, "failed to request dsi irq resource\n");
> > -		return -EPROBE_DEFER;
> > +		ret = -EPROBE_DEFER;
> > +		goto err_unregister_host;
> >  	}
> >  
> >  	irq_set_status_flags(irq_num, IRQ_TYPE_LEVEL_LOW);
> > @@ -1163,14 +1163,25 @@ static int mtk_dsi_probe(struct platform_device *pdev)
> >  			       IRQF_TRIGGER_LOW, dev_name(&pdev->dev), dsi);
> >  	if (ret) {
> >  		dev_err(&pdev->dev, "failed to request mediatek dsi irq\n");
> > -		return -EPROBE_DEFER;
> > +		ret = -EPROBE_DEFER;
> > +		goto err_unregister_host;
> >  	}
> >  
> >  	init_waitqueue_head(&dsi->irq_wait_queue);
> >  
> >  	platform_set_drvdata(pdev, dsi);
> >  
> > -	return component_add(&pdev->dev, &mtk_dsi_component_ops);
> > +	ret = component_add(&pdev->dev, &mtk_dsi_component_ops);
> > +	if (ret) {
> > +		ret = -EPROBE_DEFER;
> > +		goto err_unregister_host;
> > +	}
> > +
> > +	return 0;
> > +
> > +err_unregister_host:
> > +	mipi_dsi_host_unregister(&dsi->host);
> > +	return ret;
> >  }
> >  
> >  static int mtk_dsi_remove(struct platform_device *pdev)
> > -- 
> > 2.20.1
> > 
> 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
