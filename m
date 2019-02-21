Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91420C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 02:35:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 607DF2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 02:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E+BoJtV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607DF2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NcyOCdkT2k1aceuwe9dZsghJGShjlW8AUVO3RHyhmYw=; b=E+BoJtV8qgKDHX
	6PKS5Wgbks9PZNQrtjn0uhS7XjnkbqzIfWTdFogA2/fHFCaCNbqZCBmJM8G8CxQW/aTUqBzVe/lUG
	GpKQWZOVNa0xNEoCemE2wO7tfpJUKS0+kSe4rCogTro7dvy7PEJR0KARIlXJascPvFaVcUK0V3QsU
	XF1eBYWWWKKR+9uJ0OlV0xiKtPEIJKk8TgbnPqL04mPK2LwpYPjH5kbpeC2a9l3ql5XEhL8YTedGx
	j39n+IKypDrsfHMgN0Ifn0Tg/aNEun2B3c/HZbuo4+9xy/1+bk7qU0CzsF4pfCsk9qjqqsaVteaiK
	T18Rrh3Zq5EXwsrQ4//A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gweCI-0005q5-8x; Thu, 21 Feb 2019 02:34:50 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gweCE-0005p8-1F; Thu, 21 Feb 2019 02:34:48 +0000
X-UUID: 218c1d4cf880455fa364f09b1b811b8c-20190220
X-UUID: 218c1d4cf880455fa364f09b1b811b8c-20190220
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <wangyan.wang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 863735134; Wed, 20 Feb 2019 18:34:17 -0800
Received: from mtkmbs03n2.mediatek.inc (172.21.101.182) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 20 Feb 2019 18:34:15 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs03n2.mediatek.inc
 (172.21.101.182) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Thu, 21 Feb 2019 10:34:13 +0800
Received: from [10.16.6.141] (10.16.6.141) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Feb 2019 10:34:11 +0800
Message-ID: <1550716451.23876.5.camel@mszsdaap41>
Subject: Re: [PATCH V5 5/8] clk: mediatek: add MUX_GATE_FLAGS_2
From: mtk14994 <wangyan.wang@mediatek.com>
To: Stephen Boyd <sboyd@kernel.org>
Date: Thu, 21 Feb 2019 10:34:11 +0800
In-Reply-To: <155069142918.77512.15726787055211591362@swboyd.mtv.corp.google.com>
References: <20190220025357.7354-1-wangyan.wang@mediatek.com>
 <20190220025357.7354-6-wangyan.wang@mediatek.com>
 <155069142918.77512.15726787055211591362@swboyd.mtv.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 6B35865B27218DA5E0ACF1A9CEF1EFCB5B08DDBD136AEA6993247B1A9DBD11432000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_183446_080227_A05C5465 
X-CRM114-Status: GOOD (  14.26  )
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
Cc: Ryder Lee <ryder.lee@mediatek.com>, Daniel Vetter <daniel@ffwll.ch>,
 srv_heupstream@mediatek.com, chunhui dai <chunhui.dai@mediatek.com>, David
 Airlie <airlied@linux.ie>, Michael Turquette <mturquette@baylibre.com>,
 Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-mediatek@lists.infradead.org, Philipp Zabel <p.zabel@pengutronix.de>,
 CK Hu <ck.hu@mediatek.com>, Colin Ian King <colin.king@canonical.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Dear Stephen,
> +       unsigned char mux_flags;
> 
> Why isn't it an unsigned long? Isn't this supposed to match the
> frameworks version of the clk flags?

---->   it is unsigned char mux_flags ,becasuse struct clk_mux {

....
....
u8 flags;
....
}

it is matched when use " mux->flags = mc->mux_flags;"

Best Regards
Wangyan



On Wed, 2019-02-20 at 11:37 -0800, Stephen Boyd wrote:
> Quoting wangyan wang (2019-02-19 18:53:54)
> > From: chunhui dai <chunhui.dai@mediatek.com>
> > 
> > Add MUX_GATE_FLAGS_2 for the clock which needs to set two falgs.
> 
> s/falgs/flags/
> 
> > Such as some mux need to set the flags of "CLK_MUX_ROUND_CLOSEST".
> > 
> > Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> > Signed-off-by: wangyan wang <wangyan.wang@mediatek.com>
> > ---
> >  drivers/clk/mediatek/clk-mtk.c |  2 +-
> >  drivers/clk/mediatek/clk-mtk.h | 20 ++++++++++++++------
> >  2 files changed, 15 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
> > index 9c0ae4278a94..2ed996404804 100644
> > --- a/drivers/clk/mediatek/clk-mtk.c
> > +++ b/drivers/clk/mediatek/clk-mtk.c
> > @@ -167,7 +167,7 @@ struct clk *mtk_clk_register_composite(const struct mtk_composite *mc,
> >                 mux->mask = BIT(mc->mux_width) - 1;
> >                 mux->shift = mc->mux_shift;
> >                 mux->lock = lock;
> > -
> > +               mux->flags = mc->mux_flags;
> >                 mux_hw = &mux->hw;
> >                 mux_ops = &clk_mux_ops;
> >  
> > diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
> > index f83c2bbb677e..4b88d196d52f 100644
> > --- a/drivers/clk/mediatek/clk-mtk.h
> > +++ b/drivers/clk/mediatek/clk-mtk.h
> > @@ -81,15 +81,13 @@ struct mtk_composite {
> >         signed char divider_shift;
> >         signed char divider_width;
> >  
> > +       unsigned char mux_flags;
> 
> Why isn't it an unsigned long? Isn't this supposed to match the
> frameworks version of the clk flags?
> 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
