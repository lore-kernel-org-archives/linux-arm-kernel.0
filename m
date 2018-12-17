Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DFBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:09:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E066206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kHeflqWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E066206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X2eA7kH5cvEX0K5u1YohuEla4QItNlezLrLi/XEVCo0=; b=kHeflqWpScY0DQ
	WH8gr3+9SVy30GfSk6N3lS6bUdWihaVHQ7hFBF4X2ABvHYK9LwfLsWVpoZ7i+A+NuQLbI0hrvCQxi
	cmgGCsKlYspGmlMCNlp9l2z17cfSoAK3GcCLGj9orpGiGRg1a1t3d/3KQwS6CBk6sxih8yC5noqPx
	GoN8J8afS23KhDQqGuOcFqOl3F6iPgpNXFbEBZGj8yLqn0coQL5Si6JOPa3nt8ePf4BOU2/rKejbC
	H8WmBMlbv0htfoZO9Bx2yBfCLPURDaHrgOt0kA6+KdQvOwzb8D7MKJcs27f42p0ToRGlEcFV0Jorj
	lGQEo7YDRS2V8X4IIdMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYqmX-00058z-VQ; Mon, 17 Dec 2018 11:09:53 +0000
Received: from [1.203.163.81] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYqmT-000571-SC; Mon, 17 Dec 2018 11:09:52 +0000
X-UUID: 54ce35dccf384a0bb4b92223aaa3e8c5-20181217
X-UUID: 54ce35dccf384a0bb4b92223aaa3e8c5-20181217
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
 (envelope-from <chuanjia.liu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 990765218; Mon, 17 Dec 2018 19:09:31 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Mon, 17 Dec 2018 19:09:30 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Dec 2018 19:09:29 +0800
Message-ID: <1545044969.15380.1.camel@mhfsdcap03>
Subject: Re: [PATCH] eint: add gpio vritual number select
From: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
To: Sean Wang <sean.wang@kernel.org>
Date: Mon, 17 Dec 2018 19:09:29 +0800
In-Reply-To: <CAGp9LzoiVQyWMbBx3X2SscnSrS5OPT2O+NbW+yq6p2qtfsnFag@mail.gmail.com>
References: <1544693783-25079-1-git-send-email-chuanjia.liu@mediatek.com>
 <CAGp9LzpcRCMWSn-u6K6+eRT=Zr8PR22Vd381miyhVYbF87N02g@mail.gmail.com>
 <1545016504.29293.10.camel@mhfsdcap03>
 <CAGp9LzoiVQyWMbBx3X2SscnSrS5OPT2O+NbW+yq6p2qtfsnFag@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_030950_666521_1FD00082 
X-CRM114-Status: GOOD (  29.05  )
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
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, hailong.fan@mediatek.com,
 Matthias Brugger <matthias.bgg@gmail.com>, eddie.huang@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, 2018-12-16 at 23:59 -0800, Sean Wang wrote:
> On Sun, Dec 16, 2018 at 7:15 PM Chuanjia Liu <Chuanjia.Liu@mediatek.com> wrote:
> >
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
> >         err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT,
> >                                         MTK_ENABLE);
> >         if (err && err != -ENOTSUPP)
> >                   return err;
> > I wonder if system will lose -ENOTSUPP information when smt was not
> > successfully set by real gpio?
> 
> -ENOTSUPP shouldn't happen in a real pin as SMT is supposed to be
> supported by every real pin.
> 
> If it is not true or there are more special on certain pins, and then
> we consider to add a flag to struct mtk_pin_desc to group these pins
> with their characteristics and to split and reuse the common code flow
> with the extra flag.
> 
> So for now, I thought it's enough to handle your case with adding a
> few well self-explained comments for the exclusion condition. These
> words help us remember we should add adding an extra flag to pin
> description as one of TODO if more needs like you come out.
> 
 Thanks for your advice,I will update new patch
> > >
> > > >
> > > >         return 0;
> > > >  }
> > > > --
> > > > 1.7.9.5
> >
> >



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
