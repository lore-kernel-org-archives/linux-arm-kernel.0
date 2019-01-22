Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB9EC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:04:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08AA020854
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UuKFzUQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08AA020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pQBln5SsfC7pzTHFZBNuHvq1SkVAd3rlvxCdp9aRsB4=; b=UuKFzUQKjCKSpQ
	2Si1AUHblBQ7MfbFdEfw+29llniE/GXTmPHIWhmLPal/7Yc8EexA8yPpcp7QELRX0XQp8f4VHyfG3
	MjgqInHfq/dQ4ehiX51KTVzJh8Mk0L2yZB3dUIek+XyyelvI0dHVQQtgbeKPA4gOf+nda0fgXMjhA
	pnGy2jFwsXF60YBWjQuGbOOm57JLHbgzOEL+OvLeH8Bj4gg8WeZRHGGHBag9JsfxFCBCwJ1m16tuU
	TYcGu4gYu+q4dk3BeBZWNQPB/oWLM01T/uBWg1DoikY6XZkGoUE1JYg612GYZx1Gt2QVGZLgkRvSt
	GmPmc6wdVLLY0bQH+FOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glq6K-0005p2-Ke; Tue, 22 Jan 2019 07:04:00 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glq6H-0005ma-OR; Tue, 22 Jan 2019 07:03:59 +0000
X-UUID: 81e5d8f69d564d0fbd9c99e5e8da147a-20190121
X-UUID: 81e5d8f69d564d0fbd9c99e5e8da147a-20190121
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <jitao.shi@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 884886631; Mon, 21 Jan 2019 23:03:23 -0800
Received: from MTKMBS01N1.mediatek.inc (172.21.101.68) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 21 Jan 2019 23:03:21 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs01n1.mediatek.inc
 (172.21.101.68) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Tue, 22 Jan 2019 15:03:19 +0800
Received: from [10.16.6.141] (10.16.6.141) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 22 Jan 2019 15:03:18 +0800
Message-ID: <1548140598.5648.1.camel@mszsdaap41>
Subject: Re: [PATCH 9/9] drm/mediatek: add dpi dual edge support
From: Jitao Shi <jitao.shi@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Date: Tue, 22 Jan 2019 15:03:18 +0800
In-Reply-To: <ae8eeb33-43cd-f4b8-a564-95eeecea7d31@gmail.com>
References: <1546585439-30455-1-git-send-email-chunhui.dai@mediatek.com>
 <1546585439-30455-10-git-send-email-chunhui.dai@mediatek.com>
 <ae8eeb33-43cd-f4b8-a564-95eeecea7d31@gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_230357_861249_BD5434A2 
X-CRM114-Status: GOOD (  17.08  )
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
Cc: jamesjj.liao@mediatek.com, Ryder Lee <ryder.lee@mediatek.com>,
 bibby.hsieh@mediatek.com, srv_heupstream@mediatek.com,
 chunhui dai <chunhui.dai@mediatek.com>, Stephen Boyd <sboyd@kernel.org>,
 --to=Michael Turquette <mturquette@baylibre.com>,
 Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 linux-mediatek@lists.infradead.org, Philipp Zabel <p.zabel@pengutronix.de>,
 CK Hu <ck.hu@mediatek.com>, Colin Ian King <colin.king@canonical.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 2019-01-09 at 17:58 +0100, Matthias Brugger wrote:
> 
> On 04/01/2019 08:03, chunhui dai wrote:
> > DPI sample on rising and falling edge. It can reduce half data io.
> > 
> > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dpi.c | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > index 4a2f4a6..acb4f47 100644
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
> > @@ -353,6 +354,15 @@ static void mtk_dpi_config_disable_edge(struct mtk_dpi *dpi)
> >  		mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, 0, EDGE_SEL_EN);
> >  }
> >  
> > +static void mtk_dpi_config_dual_edge(struct mtk_dpi *dpi)
> 
> I think it is clearer if you rename the function to something like:
> mtk_dpi_enable_dual_edge and call it in mtk_dpi_set_display_mode if
> dpi->conf->dual_edge is true.
> 
> Regards,
> Matthias
> 

I'll fix it in next patch.

Best Regards
Jitao

> > +{
> > +	if (dpi->conf->dual_edge) {
> > +		mtk_dpi_mask(dpi, DPI_DDR_SETTING, DDR_EN |
> > +				DDR_4PHASE, DDR_EN | DDR_4PHASE);
> > +		mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING, EDGE_SEL, EDGE_SEL);
> > +	}
> > +}
> > +
> >  static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
> >  					enum mtk_dpi_out_color_format format)
> >  {
> > @@ -509,6 +519,7 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
> >  	mtk_dpi_config_color_format(dpi, dpi->color_format);
> >  	mtk_dpi_config_2n_h_fre(dpi);
> >  	mtk_dpi_config_disable_edge(dpi);
> > +	mtk_dpi_config_dual_edge(dpi);
> >  	mtk_dpi_sw_reset(dpi, false);
> >  
> >  	return 0;
> > @@ -669,6 +680,16 @@ static unsigned int mt2701_calculate_factor(int clock)
> >  		return 1;
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
> > @@ -680,6 +701,12 @@ static unsigned int mt2701_calculate_factor(int clock)
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
> > @@ -775,6 +802,9 @@ static int mtk_dpi_remove(struct platform_device *pdev)
> >  	{ .compatible = "mediatek,mt8173-dpi",
> >  	  .data = &mt8173_conf,
> >  	},
> > +	{ .compatible = "mediatek,mt8183-dpi",
> > +	  .data = &mt8183_conf,
> > +	},
> >  	{ },
> >  };
> >  
> > 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
