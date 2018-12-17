Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B602EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:25:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A3EB2146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XgMP3uzV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3EB2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FGbEZOAQtqHFK7ScSgftJdUiIgToHH8sMOk4t3x9NtU=; b=XgMP3uzVqfp2JE
	Eo5PN09IX8OCJ0NE/v9NTv3JK9N+JgPwhEAE0uu/gI6zOKzyTJIc79DZRDi5sWgsBMg105sRsFXZF
	jlZTII13n29L47pNiKGDbAzgkfWG/OINLjPmnfDaD/3gxoYcplZQcygB9ePe+AbdF/E12lEND8RbD
	PvsdUBBv2EKjHLEJJIgFdUkakLP3Pi4+chuWP85IGvoWfZs4Yxf+sfnvOZOYt4Z1Jx/JY1hVBSphF
	77jFl3EUw3o8I+iJIv2RNKkt6mk0P1t7xtGLhOM1Btru+C9HSs1YvxS0ukEeXKu4W3XWaSIhoabs3
	MwajqA/GGoVwEa2LaH2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYr18-0003gQ-6Y; Mon, 17 Dec 2018 11:24:58 +0000
Received: from [1.203.163.81] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYr12-0003cT-Hs; Mon, 17 Dec 2018 11:24:54 +0000
X-UUID: af6f1ed9a8024aada057c7fcdc1fc64a-20181217
X-UUID: af6f1ed9a8024aada057c7fcdc1fc64a-20181217
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
 (envelope-from <chuanjia.liu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 1131579166; Mon, 17 Dec 2018 19:24:39 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Mon, 17 Dec 2018 19:24:37 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Dec 2018 19:24:37 +0800
Message-ID: <1545045877.15380.8.camel@mhfsdcap03>
Subject: Re: [PATCH] eint: add gpio vritual number select
From: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
To: Yingjoe Chen <yingjoe.chen@mediatek.com>
Date: Mon, 17 Dec 2018 19:24:37 +0800
In-Reply-To: <1545019482.27863.8.camel@mtksdaap41>
References: <1544693783-25079-1-git-send-email-chuanjia.liu@mediatek.com>
 <CAGp9LzpcRCMWSn-u6K6+eRT=Zr8PR22Vd381miyhVYbF87N02g@mail.gmail.com>
 <1545016504.29293.10.camel@mhfsdcap03>
 <1545019482.27863.8.camel@mtksdaap41>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_032453_111457_02E258B9 
X-CRM114-Status: GOOD (  29.17  )
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
Cc: youlin.pei@mediatek.com, hongkun.cao@mediatek.com, zhiyong.tao@mediatek.com,
 Linus Walleij <linus.walleij@linaro.org>, Sean Wang <sean.wang@kernel.org>,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 hailong.fan@mediatek.com, Matthias
 Brugger <matthias.bgg@gmail.com>, eddie.huang@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 2018-12-17 at 12:04 +0800, Yingjoe Chen wrote:
> On Mon, 2018-12-17 at 11:15 +0800, Chuanjia Liu wrote:
> > On Thu, 2018-12-13 at 11:33 -0800, Sean Wang wrote:
> > > On Thu, Dec 13, 2018 at 1:36 AM <chuanjia.liu@mediatek.com> wrote:
> > > >
> > > > From: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
> > > >
> > > > This patch add gpio vritual number select,avoid virtual gpio set SMT.
> > > 
> > > s/gpio/GPIO/
> > > s/vritual/virtual/
> > > 
> > > Virtual GPIOs you said here that means these pins only used inside SoC
> > > and not being exported to outside SoC, right? It seems this kind of
> > > pins doesn't need SMT.
> > > 
> > Yes,virtual gpio only used inside SOC and these pins doesn't need set
> > SMT
> 
> Hi,
> 
> I don't see full patch in linux-mediatek archive. Maybe you are not
> subscribed so it is rejected?
Some groups failed to send because of permission issues,I will update
new patch.
> 
> Please add this description to commit message and/or code comment.
> I think 'internal GPIO' might be a better name for this. Does the name
> 'virtual GPIO' come from datasheet?
MTKer call it virtyal gpio When some pins only used inside soc.
> 
> 
> > > >
> > > > Signed-off-by: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
> > > > ---
> > > >  drivers/pinctrl/mediatek/mtk-eint.h              |    1 +
> > > >  drivers/pinctrl/mediatek/pinctrl-mt8183.c        |    1 +
> > > >  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c |    9 ++++++---
> > > >  3 files changed, 8 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/pinctrl/mediatek/mtk-eint.h b/drivers/pinctrl/mediatek/mtk-eint.h
> > > > index 48468d0..c16beaf 100644
> > > > --- a/drivers/pinctrl/mediatek/mtk-eint.h
> > > > +++ b/drivers/pinctrl/mediatek/mtk-eint.h
> > > > @@ -37,6 +37,7 @@ struct mtk_eint_hw {
> > > >         u8              ports;
> > > >         unsigned int    ap_num;
> > > >         unsigned int    db_cnt;
> > > > +       unsigned int    vir_start;

> Since it is about GPIO and SMT, maybe it should be added to mtk_pin_soc
> instead of mtk_eint_hw ?
> 
> Joe.C

I will delete this change,thanks
> > > >  };
> > > >
> > > >  struct mtk_eint;
> > > > diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8183.c b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> > > > index 6262fd3..bbeafd3 100644
> > > > --- a/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> > > > +++ b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> > > > @@ -497,6 +497,7 @@
> > > >         .ports     = 6,
> > > >         .ap_num    = 212,
> > > >         .db_cnt    = 13,
> > > > +       .vir_start = 180,
> > > >  };
> > > >
> > > >  static const struct mtk_pin_soc mt8183_data = {
> > > > diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > > > index 4a9e0d4..ca3bae1 100644
> > > > --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > > > +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > > > @@ -289,9 +289,12 @@ static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
> > > >         if (err)
> > > >                 return err;
> > > >
> > > > -       err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT, MTK_ENABLE);
> > > > -       if (err)
> > > > -               return err;
> > > > +       if (gpio_n < hw->eint->hw->vir_start) {
> > > > +               err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT,
> > > > +                                      MTK_ENABLE);
> > > > +               if (err)
> > > > +                       return err;
> > > > +       }
> > > 
> > > The changes will break these SoCs without a properly configured vir_start.
> > > 
> > > If SMT seems unnecessary for these kinds of virtual GPIOs pin in the
> > > path, we can do it as
> > > 
> > > err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT,
> > >                                         MTK_ENABLE);
> > > /* please add comments for the exclusion condition */
> > > if (err && err != -ENOTSUPP)
> > >         return err;
> > > 
> > > If there is getting much special on certain pins between SoCs, and
> > > then we can consider creating a desc->flag to split logic.
> > 
> > Yes,SMT unnecessary for these kinds of virtual GPIOS pin in the path,if
> > do it as
> > 	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT,
> >                                         MTK_ENABLE);
> > 	if (err && err != -ENOTSUPP)
> >       		  return err;
> > I wonder if system will lose -ENOTSUPP information when smt was not
> > successfully set by real gpio?
> > > 
> > > >
> > > >         return 0;
> > > >  }
> > > > --
> > > > 1.7.9.5
> > 
> > 
> > 
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
> 
> 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
