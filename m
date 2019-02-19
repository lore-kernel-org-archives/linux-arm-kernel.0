Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DF6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:37:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4513B2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W/W5boEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4513B2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HzWeVlFa4jYK3oFn5qacQntiEp62rnFvhvNRfCooNxE=; b=W/W5boEaXU7GnQ
	R/n/3LgH8sIc7EPdO6zqJuTIDxGCfraCVlwMUjKBIhWVvaZfmq7GC9mCSJ1Jg4d2VH5H64XGWGVol
	0jbREXt4WQ0kgQbQTwkL2dkfhU/tjTDPvk0W+2rjYI4ni1kLVizoWjBSGk6KtNZiJXq5jXQ/attYY
	3uC/1i80q5tBnvoj6j2hS4m9fnzW6DhCgojYAOIWWYou44YUqo+FEOmd/SFj8M/LkM9xNd8COnDdn
	N8R+Yrak5SdMV5L1xjZgS6am73RyZOw18rIAdRJiuS9tiyoiaES/CaEDGIzWe4vBqZHgqHXyabI1Z
	83oj4W7YMdeZO/eZGyEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvvHF-0007gZ-HW; Tue, 19 Feb 2019 02:36:57 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvvHB-0007g8-TT; Tue, 19 Feb 2019 02:36:55 +0000
X-UUID: 1080ae0293b54e0f9d3529bb5f7acd4f-20190218
X-UUID: 1080ae0293b54e0f9d3529bb5f7acd4f-20190218
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <ck.hu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1666428587; Mon, 18 Feb 2019 18:36:40 -0800
Received: from MTKMBS33DR.mediatek.inc (172.27.6.106) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 18 Feb 2019 18:36:39 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS33DR.mediatek.inc (172.27.6.106) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 19 Feb 2019 10:36:36 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 19 Feb 2019 10:36:35 +0800
Message-ID: <1550543795.4018.3.camel@mtksdaap41>
Subject: Re: [PATCH] drm/mediatek: add mt8183 dpi support
From: CK Hu <ck.hu@mediatek.com>
To: Jitao Shi <jitao.shi@mediatek.com>
Date: Tue, 19 Feb 2019 10:36:35 +0800
In-Reply-To: <1550541190.13121.2.camel@mszsdaap41>
References: <20190211045059.11821-1-jitao.shi@mediatek.com>
 <1550160809.6862.13.camel@mtksdaap41> <1550541190.13121.2.camel@mszsdaap41>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_183653_957097_502DDE20 
X-CRM114-Status: GOOD (  18.69  )
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
 dri-devel@lists.freedesktop.org, yingjoe.chen@mediatek.com, Ajay
 Kumar <ajaykumar.rs@samsung.com>, Vincent Palatin <vpalatin@chromium.org>,
 cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Thierry Reding <treding@nvidia.com>, linux-pwm@vger.kernel.org,
 Sascha Hauer <kernel@pengutronix.de>, Pawel Moll <pawel.moll@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>, Inki Dae <inki.dae@samsung.com>,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Andy Yan <andy.yan@rock-chips.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, eddie.huang@mediatek.com,
 linux-arm-kernel@lists.infradead.org, Rahul
 Sharma <rahul.sharma@samsung.com>, srv_heupstream@mediatek.com,
 linux-kernel@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
 Kumar Gala <galak@codeaurora.org>, Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi, Jitao:

On Tue, 2019-02-19 at 09:53 +0800, Jitao Shi wrote:
> On Fri, 2019-02-15 at 00:13 +0800, CK Hu wrote:
> > Hi, Jitao:
> > 
> > On Mon, 2019-02-11 at 12:50 +0800, Jitao Shi wrote:
> > > MT8183 sample on rising and falling edge. It can reduce half data io.
> > > 
> > > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > > ---
> > >  drivers/gpu/drm/mediatek/mtk_dpi.c | 29 +++++++++++++++++++++++++++++
> > >  1 file changed, 29 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > > index 62a9d47df948..610c23334047 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > > @@ -117,6 +117,7 @@ struct mtk_dpi_conf {
> > >  	unsigned int (*cal_factor)(int clock);
> > >  	u32 reg_h_fre_con;
> > >  	bool edge_sel_en;
> > > +	bool dual_edge;
> > >  };
> > >  
> > >  static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val, u32 mask)
> > > @@ -353,6 +354,13 @@ static void mtk_dpi_config_disable_edge(struct mtk_dpi *dpi)
> > >  		mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, 0, EDGE_SEL_EN);
> > >  }
> > >  
> > > +static void mtk_dpi_enable_dual_edge(struct mtk_dpi *dpi)
> > > +{
> > > +	mtk_dpi_mask(dpi, DPI_DDR_SETTING, DDR_EN | DDR_4PHASE,
> > > +		     DDR_EN | DDR_4PHASE);
> > > +	mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING, EDGE_SEL, EDGE_SEL);
> > > +}
> > 
> > All these register exist in MT8173, if you do the same setting in
> > MT8173, could it also sample on rising edge and falling edge?
> > 
> > Regards,
> > CK
> 
> Hi CK,
> 
> MT8173 has those registers. But the hw function is removed.
> So MT8173 doesn't support DPI dual edge sample.

OK, please add this information in commit message.

Regards,
CK

> 
> Best Regards
> Jitao
> 
> > 
> > > +
> > >  static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
> > >  					enum mtk_dpi_out_color_format format)
> > >  {
> > > @@ -509,6 +517,8 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
> > >  	mtk_dpi_config_color_format(dpi, dpi->color_format);
> > >  	mtk_dpi_config_2n_h_fre(dpi);
> > >  	mtk_dpi_config_disable_edge(dpi);
> > > +	if (dpi->conf->dual_edge)
> > > +		mtk_dpi_enable_dual_edge(dpi);
> > >  	mtk_dpi_sw_reset(dpi, false);
> > >  
> > >  	return 0;
> > > @@ -671,6 +681,16 @@ static unsigned int mt2701_calculate_factor(int clock)
> > >  		return 2;
> > >  }
> > >  
> > > +static unsigned int mt8183_calculate_factor(int clock)
> > > +{
> > > +	if (clock <= 27000)
> > > +		return 8;
> > > +	else if (clock <= 167000)
> > > +		return 4;
> > > +	else
> > > +		return 2;
> > > +}
> > > +
> > >  static const struct mtk_dpi_conf mt8173_conf = {
> > >  	.cal_factor = mt8173_calculate_factor,
> > >  	.reg_h_fre_con = 0xe0,
> > > @@ -682,6 +702,12 @@ static const struct mtk_dpi_conf mt2701_conf = {
> > >  	.edge_sel_en = true,
> > >  };
> > >  
> > > +static const struct mtk_dpi_conf mt8183_conf = {
> > > +	.cal_factor = mt8183_calculate_factor,
> > > +	.reg_h_fre_con = 0xe0,
> > > +	.dual_edge = true,
> > > +};
> > > +
> > >  static int mtk_dpi_probe(struct platform_device *pdev)
> > >  {
> > >  	struct device *dev = &pdev->dev;
> > > @@ -777,6 +803,9 @@ static const struct of_device_id mtk_dpi_of_ids[] = {
> > >  	{ .compatible = "mediatek,mt8173-dpi",
> > >  	  .data = &mt8173_conf,
> > >  	},
> > > +	{ .compatible = "mediatek,mt8183-dpi",
> > > +	  .data = &mt8183_conf,
> > > +	},
> > >  	{ },
> > >  };
> > >  
> > 
> > 
> 
> 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
