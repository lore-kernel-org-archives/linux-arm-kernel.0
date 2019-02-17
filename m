Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB27DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 15:20:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9743921A4A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 15:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WK3LpV/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9743921A4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IhNmzrtx1yD0O6U4lM1/l7riX7MP2bS0I9E9GQPRJn8=; b=WK3LpV/iwU2UOm
	y8KiFVT83O/loKlTI2iAAvN/eNkFtBZQfcGSe7oYxnSenyhYtnI1i1izwHMY6nIJE/TbxWwToxu/+
	yZ4+Z09LNo9L/xWIbRe8DInH1O/V25CzZWOMrtb+YGH1AypU+hwvaMBvNrwBs28pwXrgQFRbvp8J6
	s5EtKUlp7zcu6ELW32SpHxsFlv6wUY0lm3q83k7zLxAZTi76RjSX++A82W1M0LNPEIPnI4s8RLOa+
	fKYbsdPTmoj5n2dCUiDBaln4yqRFWEKTgob8X2rp7avY/7C3xDLcgte0t7ATaSkDxx7VhiJWXsHon
	7OHZq+m/BCIgyyS5+WTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvOEu-00008L-VS; Sun, 17 Feb 2019 15:20:20 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvOEq-00006T-Js; Sun, 17 Feb 2019 15:20:18 +0000
X-UUID: 7b4547879df34e4f9bda832b805a6fdd-20190217
X-UUID: 7b4547879df34e4f9bda832b805a6fdd-20190217
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <jitao.shi@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1775474087; Sun, 17 Feb 2019 07:20:11 -0800
Received: from MTKMBS31N1.mediatek.inc (172.27.4.69) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 17 Feb 2019 07:20:10 -0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Sun, 17 Feb 2019 23:20:06 +0800
Received: from [10.16.6.141] (10.16.6.141) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 17 Feb 2019 23:20:05 +0800
Message-ID: <1550416804.5194.35.camel@mszsdaap41>
Subject: Re: [PATCH] drm/mediatek: add mt8183 dpi support
From: Jitao Shi <jitao.shi@mediatek.com>
To: Sean Paul <sean@poorly.run>
Date: Sun, 17 Feb 2019 23:20:04 +0800
In-Reply-To: <20190214204149.GO114153@art_vandelay>
References: <20190211045059.11821-1-jitao.shi@mediatek.com>
 <20190214204149.GO114153@art_vandelay>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_072016_915602_9DF77B4F 
X-CRM114-Status: GOOD (  19.41  )
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
 cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com, ck.hu@mediatek.com,
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

On Thu, 2019-02-14 at 15:41 -0500, Sean Paul wrote:
> On Mon, Feb 11, 2019 at 12:50:59PM +0800, Jitao Shi wrote:
> > MT8183 sample on rising and falling edge. It can reduce half data io.
> > 
> > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dpi.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > index 62a9d47df948..610c23334047 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > @@ -117,6 +117,7 @@ struct mtk_dpi_conf {
> >  	unsigned int (*cal_factor)(int clock);
> >  	u32 reg_h_fre_con;
> >  	bool edge_sel_en;
> > +	bool dual_edge;
> >  };
> >  
> >  static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val, u32 mask)
> > @@ -353,6 +354,13 @@ static void mtk_dpi_config_disable_edge(struct mtk_dpi *dpi)
> >  		mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, 0, EDGE_SEL_EN);
> >  }
> >  
> > +static void mtk_dpi_enable_dual_edge(struct mtk_dpi *dpi)
> > +{
> > +	mtk_dpi_mask(dpi, DPI_DDR_SETTING, DDR_EN | DDR_4PHASE,
> > +		     DDR_EN | DDR_4PHASE);
> > +	mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING, EDGE_SEL, EDGE_SEL);
> > +}
> > +
> >  static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
> >  					enum mtk_dpi_out_color_format format)
> >  {
> > @@ -509,6 +517,8 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
> >  	mtk_dpi_config_color_format(dpi, dpi->color_format);
> >  	mtk_dpi_config_2n_h_fre(dpi);
> >  	mtk_dpi_config_disable_edge(dpi);
> > +	if (dpi->conf->dual_edge)
> > +		mtk_dpi_enable_dual_edge(dpi);
> >  	mtk_dpi_sw_reset(dpi, false);
> >  
> >  	return 0;
> > @@ -671,6 +681,16 @@ static unsigned int mt2701_calculate_factor(int clock)
> >  		return 2;
> >  }
> >  
> > +static unsigned int mt8183_calculate_factor(int clock)
> > +{
> > +	if (clock <= 27000)
> > +		return 8;
> > +	else if (clock <= 167000)
> > +		return 4;
> > +	else
> > +		return 2;
> > +}
> > +
> >  static const struct mtk_dpi_conf mt8173_conf = {
> >  	.cal_factor = mt8173_calculate_factor,
> >  	.reg_h_fre_con = 0xe0,
> > @@ -682,6 +702,12 @@ static const struct mtk_dpi_conf mt2701_conf = {
> >  	.edge_sel_en = true,
> >  };
> >  
> > +static const struct mtk_dpi_conf mt8183_conf = {
> > +	.cal_factor = mt8183_calculate_factor,
> > +	.reg_h_fre_con = 0xe0,
> > +	.dual_edge = true,
> > +};
> > +
> >  static int mtk_dpi_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev = &pdev->dev;
> > @@ -777,6 +803,9 @@ static const struct of_device_id mtk_dpi_of_ids[] = {
> >  	{ .compatible = "mediatek,mt8173-dpi",
> >  	  .data = &mt8173_conf,
> >  	},
> > +	{ .compatible = "mediatek,mt8183-dpi",
> 
> Do you need to add this compatible value to the dt binding? If you can do as CK
> suggested, maybe you don't need this at all (and mt8183 can use the mt8173
> compatible string in the dt).
> 
> Sean
> 

Yes, CK is right. 

I'll move it to mt8173.

> > +	  .data = &mt8183_conf,
> > +	},
> >  	{ },
> >  };
> >  
> > -- 
> > 2.12.5
> > 
> 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
