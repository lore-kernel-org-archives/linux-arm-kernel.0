Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70F5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:00:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68CB82086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kxaMS7sM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeaCyJ47"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68CB82086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pF0O+uE3fJcxxjOXV03lLd+UsUAAw1R98VPxnGgmEt0=; b=kxaMS7sMa8hkF9
	Re5jCWVBwToAqjuYwlajGrCRqZiRSXvQqYMuzxqqCR6+pEh35CKCQ0VTcX9XMowDBOJu/QD4cXo+K
	zpgkc7SZWNEZtbTqx+L8HCKG0gj1FKm5F4s6eiabQFP4ZDQHsuvX3WEw2cq8zGvLHfmC53s+EuFbu
	4JvGgnik1ts1zGDozQ+NkbdhZFkSERbkFWwsK8p7yzVS5WxB1+tDVScnl/9UBvlY+HpzV45hXKupv
	Rx4N2AKbZvkSW2GCLQaZczBJDcbgr98A1ASneLHVLAx261V+Hd58xF0VW9XTi/fu4ToiTR+kafilu
	xukN6zahTnoFpFRuxVrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYnox-0006GV-TK; Mon, 17 Dec 2018 08:00:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYnos-00050Y-EX; Mon, 17 Dec 2018 08:00:09 +0000
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3712B2086C;
 Mon, 17 Dec 2018 07:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545033594;
 bh=4E0nw7zHo+hT4FOivCKZFno0wGpLhHdHPlV05qNtUDA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=qeaCyJ47aSLL3TuGQD6QGsXBwltLvX7S94dqSxpSRc0wb7i9V3+iLNB95ccADcGEM
 i0Yujt5arBQvY5vAXAf9HXL0KaV9+lTtruDcTRM1IgVvo1DL35aMUxGrd0GovAVnO5
 buOhzAX3WLNyQx1a0Brrhm4biyYGpwISrb6SSHOU=
Received: by mail-wm1-f51.google.com with SMTP id a62so11311572wmh.4;
 Sun, 16 Dec 2018 23:59:54 -0800 (PST)
X-Gm-Message-State: AA+aEWYYMEysN12ErtsOq4iauZLDgjWOlSH5QEuvo8ehkDbuZI12hQt7
 4sTvfwF+dzi+49fXJQaz7e7uQnDDU9aGl6iGf10=
X-Google-Smtp-Source: AFSGD/VxGVdQHnMEJ7aVYtT5Dakqrcpg/kf/HWtSnYc5hCuUUuyzbufa39ZvTrmjHF0cZQfTDB+sAz5sT9Szt9en8bc=
X-Received: by 2002:a1c:66c5:: with SMTP id
 a188mr10215259wmc.129.1545033592704; 
 Sun, 16 Dec 2018 23:59:52 -0800 (PST)
MIME-Version: 1.0
References: <1544693783-25079-1-git-send-email-chuanjia.liu@mediatek.com>
 <CAGp9LzpcRCMWSn-u6K6+eRT=Zr8PR22Vd381miyhVYbF87N02g@mail.gmail.com>
 <1545016504.29293.10.camel@mhfsdcap03>
In-Reply-To: <1545016504.29293.10.camel@mhfsdcap03>
From: Sean Wang <sean.wang@kernel.org>
Date: Sun, 16 Dec 2018 23:59:20 -0800
X-Gmail-Original-Message-ID: <CAGp9LzoiVQyWMbBx3X2SscnSrS5OPT2O+NbW+yq6p2qtfsnFag@mail.gmail.com>
Message-ID: <CAGp9LzoiVQyWMbBx3X2SscnSrS5OPT2O+NbW+yq6p2qtfsnFag@mail.gmail.com>
Subject: Re: [PATCH] eint: add gpio vritual number select
To: Chuanjia.Liu@mediatek.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_000006_532793_07A7EABC 
X-CRM114-Status: GOOD (  27.33  )
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

On Sun, Dec 16, 2018 at 7:15 PM Chuanjia Liu <Chuanjia.Liu@mediatek.com> wrote:
>
> On Thu, 2018-12-13 at 11:33 -0800, Sean Wang wrote:
> > On Thu, Dec 13, 2018 at 1:36 AM <chuanjia.liu@mediatek.com> wrote:
> > >
> > > From: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
> > >
> > > This patch add gpio vritual number select,avoid virtual gpio set SMT.
> >
> > s/gpio/GPIO/
> > s/vritual/virtual/
> >
> > Virtual GPIOs you said here that means these pins only used inside SoC
> > and not being exported to outside SoC, right? It seems this kind of
> > pins doesn't need SMT.
> >
> Yes,virtual gpio only used inside SOC and these pins doesn't need set
> SMT
> > >
> > > Signed-off-by: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
> > > ---
> > >  drivers/pinctrl/mediatek/mtk-eint.h              |    1 +
> > >  drivers/pinctrl/mediatek/pinctrl-mt8183.c        |    1 +
> > >  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c |    9 ++++++---
> > >  3 files changed, 8 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/pinctrl/mediatek/mtk-eint.h b/drivers/pinctrl/mediatek/mtk-eint.h
> > > index 48468d0..c16beaf 100644
> > > --- a/drivers/pinctrl/mediatek/mtk-eint.h
> > > +++ b/drivers/pinctrl/mediatek/mtk-eint.h
> > > @@ -37,6 +37,7 @@ struct mtk_eint_hw {
> > >         u8              ports;
> > >         unsigned int    ap_num;
> > >         unsigned int    db_cnt;
> > > +       unsigned int    vir_start;
> > >  };
> > >
> > >  struct mtk_eint;
> > > diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8183.c b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> > > index 6262fd3..bbeafd3 100644
> > > --- a/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> > > +++ b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> > > @@ -497,6 +497,7 @@
> > >         .ports     = 6,
> > >         .ap_num    = 212,
> > >         .db_cnt    = 13,
> > > +       .vir_start = 180,
> > >  };
> > >
> > >  static const struct mtk_pin_soc mt8183_data = {
> > > diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > > index 4a9e0d4..ca3bae1 100644
> > > --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > > +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > > @@ -289,9 +289,12 @@ static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
> > >         if (err)
> > >                 return err;
> > >
> > > -       err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT, MTK_ENABLE);
> > > -       if (err)
> > > -               return err;
> > > +       if (gpio_n < hw->eint->hw->vir_start) {
> > > +               err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT,
> > > +                                      MTK_ENABLE);
> > > +               if (err)
> > > +                       return err;
> > > +       }
> >
> > The changes will break these SoCs without a properly configured vir_start.
> >
> > If SMT seems unnecessary for these kinds of virtual GPIOs pin in the
> > path, we can do it as
> >
> > err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT,
> >                                         MTK_ENABLE);
> > /* please add comments for the exclusion condition */
> > if (err && err != -ENOTSUPP)
> >         return err;
> >
> > If there is getting much special on certain pins between SoCs, and
> > then we can consider creating a desc->flag to split logic.
>
> Yes,SMT unnecessary for these kinds of virtual GPIOS pin in the path,if
> do it as
>         err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT,
>                                         MTK_ENABLE);
>         if (err && err != -ENOTSUPP)
>                   return err;
> I wonder if system will lose -ENOTSUPP information when smt was not
> successfully set by real gpio?

-ENOTSUPP shouldn't happen in a real pin as SMT is supposed to be
supported by every real pin.

If it is not true or there are more special on certain pins, and then
we consider to add a flag to struct mtk_pin_desc to group these pins
with their characteristics and to split and reuse the common code flow
with the extra flag.

So for now, I thought it's enough to handle your case with adding a
few well self-explained comments for the exclusion condition. These
words help us remember we should add adding an extra flag to pin
description as one of TODO if more needs like you come out.

> >
> > >
> > >         return 0;
> > >  }
> > > --
> > > 1.7.9.5
>
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
