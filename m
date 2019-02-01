Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B43C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:27:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5B4020863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="di2orv0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B4020863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C70bBWLNOdj1H7qn9NoW9uyUitBYIbWkWedCqH7I0XU=; b=di2orv0ckB5Vbc
	KaYJJvwM8p+kQhOa+g8Pum38fu3s49JZnsSKgsemSIsm5XlKD4LvWKW8hzjCzyh8PLOa9h1t6nFAA
	aJrQiH5DGnxchMIZPwYKungVrCN00OqS4Cw2IYDd12tS7vXWmwGKQLU94jEeCwm73n28pF7sBg6So
	kUKmKb1VbP9aukeJo8HCIYExGDwaQuxXoFZhN31r74G4k/76a6Wv16EU/JNut60OwJ7QjMdpdgvDc
	K+mSiYIVWfUeupzUFgTnZMjxtkRf2dzhpdUCpNARegUqNzKzp0wdZetawCF2FhAxZkoVtKJqHTGit
	1H5QBWN6u+Ow7mCM7v2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpUA6-0003dj-1h; Fri, 01 Feb 2019 08:26:58 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpU9q-0003Su-Hk; Fri, 01 Feb 2019 08:26:43 +0000
X-UUID: 810b5fe008ee46efa65f015bdd015d26-20190201
X-UUID: 810b5fe008ee46efa65f015bdd015d26-20190201
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <weiyi.lu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1824666384; Fri, 01 Feb 2019 00:22:16 -0800
Received: from mtkmbs03n1.mediatek.inc (172.21.101.181) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 00:22:15 -0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 16:22:13 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 16:22:13 +0800
Message-ID: <1549009333.22634.2.camel@mtksdaap41>
Subject: Re: [PATCH v3 03/12] clk: mediatek: add configurable pcwibits and
 fmin to mtk_pll_data
From: Weiyi Lu <weiyi.lu@mediatek.com>
To: Stephen Boyd <sboyd@kernel.org>
Date: Fri, 1 Feb 2019 16:22:13 +0800
In-Reply-To: <154482494548.19322.11090762587126084086@swboyd.mtv.corp.google.com>
References: <20181210073240.32278-1-weiyi.lu@mediatek.com>
 <20181210073240.32278-5-weiyi.lu@mediatek.com>
 <154482494548.19322.11090762587126084086@swboyd.mtv.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_002642_587908_03EF1190 
X-CRM114-Status: GOOD (  13.11  )
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
 Owen Chen <owen.chen@mediatek.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On Fri, 2018-12-14 at 14:02 -0800, Stephen Boyd wrote:
> Quoting Weiyi Lu (2018-12-09 23:32:31)
> > diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> > index f0ff5f535c7e..81400601f107 100644
> > --- a/drivers/clk/mediatek/clk-pll.c
> > +++ b/drivers/clk/mediatek/clk-pll.c
> > @@ -69,11 +71,13 @@ static unsigned long __mtk_pll_recalc_rate(struct mtk_clk_pll *pll, u32 fin,
> >  {
> >         int pcwbits = pll->data->pcwbits;
> >         int pcwfbits;
> > +       int ibits;
> >         u64 vco;
> >         u8 c = 0;
> >  
> >         /* The fractional part of the PLL divider. */
> > -       pcwfbits = pcwbits > INTEGER_BITS ? pcwbits - INTEGER_BITS : 0;
> > +       ibits = pll->data->pcwibits ? pll->data->pcwibits : INTEGER_BITS;
> > +       pcwfbits = pcwbits > ibits ? pcwbits - ibits : 0;
> 
> This is practically unreadable. It should be changed to an if statement.
> 

OK, will be fixed in next version.

> >  
> >         vco = (u64)fin * pcw;
> >  
> > @@ -167,9 +171,10 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
> >  static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
> >                 u32 freq, u32 fin)
> >  {
> > -       unsigned long fmin = 1000 * MHZ;
> > +       unsigned long fmin = pll->data->fmin ? pll->data->fmin : (1000 * MHZ);
> >         const struct mtk_pll_div_table *div_table = pll->data->div_table;
> >         u64 _pcw;
> > +       int ibits;
> >         u32 val;
> >  
> >         if (freq > pll->data->fmax)
> > @@ -193,7 +198,8 @@ static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
> >         }
> >  
> >         /* _pcw = freq * postdiv / fin * 2^pcwfbits */
> > -       _pcw = ((u64)freq << val) << (pll->data->pcwbits - INTEGER_BITS);
> > +       ibits = pll->data->pcwibits ? pll->data->pcwibits : INTEGER_BITS;
> > +       _pcw = ((u64)freq << val) << (pll->data->pcwbits - ibits);
> 
> Similar comment. Readability is low here.

I thought these two lines here are clean enough. Just simple conditional
assignment and shift operation. I'd like to not to change it.

> 





_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
