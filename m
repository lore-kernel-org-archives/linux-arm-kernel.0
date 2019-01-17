Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDF5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:34:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4768120855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cjqdYjD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4768120855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=myjAhOuXolc6B1t0mdKzgfiGCUTFaZa7mEjPxzzJrE0=; b=cjqdYjD3S0iWXP
	VrilNNozIdFS4i1PKE7LZSHUVsKeimjUzbQuKlPHUt5WgY2xXZb87QX929jfNuCpG76Cr9vK+QR1h
	1/lnoBuaH+zy+oxhuiqRdSqmkkr8z1VWGKEU84YppCjd5c2bxYdrstp/fq3IYJTPlTQbhLttH0jtV
	rKArYz00uF5L9uUfE9/baWGNZ8c/tZKRJTCHBf5oQh+nFR0KoFLL0/envyVchkSSqWi4pIjKcF2Dv
	3011WCN9S5R1pKkqSZ5awuq2tF6m8GJtkH5Lp8cAio86scqh6fHy4iehPiWZB7+Z05P0PdA5lYlgj
	rpxheVM9Ug9ZzO2l9F+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk38Z-0004g8-BK; Thu, 17 Jan 2019 08:34:55 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk38R-0004ev-Mz; Thu, 17 Jan 2019 08:34:53 +0000
X-UUID: f5b39842558e4cda93b8c5c5bde780b1-20190117
X-UUID: f5b39842558e4cda93b8c5c5bde780b1-20190117
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <chunhui.dai@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1973095798; Thu, 17 Jan 2019 00:34:39 -0800
Received: from MTKMBS33N2.mediatek.inc (172.27.4.76) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 17 Jan 2019 00:34:38 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Thu, 17 Jan 2019 16:34:36 +0800
Received: from [10.16.6.141] (10.16.6.141) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 17 Jan 2019 16:34:35 +0800
Message-ID: <1547714075.4664.1.camel@mszsdaap41>
Subject: Re: [PATCH 4/9] drm/mediatek: fix the rate and divder of hdmi phy
 for MT2701
From: Chunhui Dai <chunhui.dai@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Date: Thu, 17 Jan 2019 16:34:35 +0800
In-Reply-To: <a3e37dde-2bab-be02-27ec-d15784bd560b@gmail.com>
References: <1546585439-30455-1-git-send-email-chunhui.dai@mediatek.com>
 <1546585439-30455-5-git-send-email-chunhui.dai@mediatek.com>
 <a3e37dde-2bab-be02-27ec-d15784bd560b@gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_003447_755590_7AF22779 
X-CRM114-Status: GOOD (  14.46  )
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
 jitao.shi@mediatek.com, bibby.hsieh@mediatek.com, srv_heupstream@mediatek.com,
 Stephen Boyd <sboyd@kernel.org>,
 --to=Michael Turquette <mturquette@baylibre.com>,
 Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
 wangyan.wang@mediatek.com, David Airlie <airlied@linux.ie>,
 linux-mediatek@lists.infradead.org, dri-devel@lists.freedesktop.org,
 Philipp Zabel <p.zabel@pengutronix.de>, CK Hu <ck.hu@mediatek.com>,
 Colin Ian King <colin.king@canonical.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 2019-01-09 at 17:54 +0100, Matthias Brugger wrote:
> 
> On 04/01/2019 08:03, chunhui dai wrote:
> > fix the rate and divder of hdmi phy for MT2701.
> 
> This is a bug? Then we would need a fixes tag.

yes, we would add the tag in V2.

> Otherwise you should explain in the commit, that you need to change the
> calculation due to previous commits.
> 
> Regards,
> Matthias
> 
> > 
> > Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> > index a28a32d..10b6235 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> > @@ -114,8 +114,8 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> >  
> >  	if (rate <= 64000000)
> >  		pos_div = 3;
> > -	else if (rate <= 12800000)
> > -		pos_div = 1;
> > +	else if (rate <= 128000000)
> > +		pos_div = 2;
> >  	else
> >  		pos_div = 1;
> >  
> > 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
