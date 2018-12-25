Return-Path: <SRS0=E6tZ=PC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796E5C64E79
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 03:41:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46B6C21773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 03:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pMuVGEwv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B6C21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1jTIuObMVNf7d6Rbe7sWKWZ1Qx1EHwomi/gJnNuoudc=; b=pMuVGEwvEskRMk
	CsHnWRM1CDX/n+KE4rZ3twxwKfxuQaB6LDBWVCBAcz86ZCJY0LCR3bNtzb7HNMR87XIwgMPYaTDbJ
	abJH+n1tZLkRBnPVI8JFP9DXbTf4Q2T1cFyBygKHs9ecTks7YJY9emrwun7024uj43YUt6yEkqbrF
	OcGM5VfTWea+LCl0DZYgy9NWQCNiCZsE050H4dZ9adFdzZgPUiSTxPGo4hsolg8wnhhvk2aO2JGgl
	w5qvMtnlQ31EFwlBs9K1IY7HWKF6ErznleGYJuTlezoCge4njEVfNj46uSkaBxaByphth5an+ZZZJ
	A8WBJ0eewjOwUwz/uOIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbdaf-0003xa-HA; Tue, 25 Dec 2018 03:41:09 +0000
Received: from [1.203.163.81] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbdaX-0003vx-Q1; Tue, 25 Dec 2018 03:41:07 +0000
X-UUID: a667d26d997f4fc5a6d8be18d49074c8-20181225
X-UUID: a667d26d997f4fc5a6d8be18d49074c8-20181225
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
 (envelope-from <chuanjia.liu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 1806135897; Tue, 25 Dec 2018 11:40:36 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Tue, 25 Dec 2018 11:40:35 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 25 Dec 2018 11:40:34 +0800
Message-ID: <1545709234.17628.1.camel@mhfsdcap03>
Subject: Re: [PATCH v2] pinctrl:mediatek:add judgment conditions
From: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
To: Sean Wang <sean.wang@kernel.org>
Date: Tue, 25 Dec 2018 11:40:34 +0800
In-Reply-To: <CAGp9Lzoo6bw-3Hr56rgbL6EhrRvXX2y5pajaOo13c5MV9FsO7Q@mail.gmail.com>
References: <1545100282-15756-1-git-send-email-chuanjia.liu@mediatek.com>
 <CAGp9Lzoo6bw-3Hr56rgbL6EhrRvXX2y5pajaOo13c5MV9FsO7Q@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_194102_067864_91D3D37F 
X-CRM114-Status: GOOD (  22.16  )
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
Cc: Youlin Pei =?UTF-8?Q?=28=E8=A3=B4=E5=8F=8B=E6=9E=97=29?=
 <youlin.pei@mediatek.com>, Zhiyong Tao
 =?UTF-8?Q?=28=E9=99=B6=E5=BF=97=E5=8B=87=29?= <Zhiyong.Tao@mediatek.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 Hailong Fan
 =?UTF-8?Q?=28=E8=8C=83=E6=B5=B7=E9=BE=99=29?= <Hailong.Fan@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Eddie Huang =?UTF-8?Q?=28=E9=BB=83=E6=99=BA=E5=82=91=29?=
 <eddie.huang@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, 2018-12-23 at 02:50 +0800, Sean Wang wrote:
> On Mon, Dec 17, 2018 at 6:32 PM <chuanjia.liu@mediatek.com> wrote:
> >
> 
> I thought the subject still is much general, it should be further
> improved with something like "add EINT support to virtual GPIOs" and
> should say more about what virtual GPIOs means by MTKers in the patch
> description because "virtual" is a usual term used throughout the
> kernel and that would easily cause others to fail to interpret
> correctly.
> 
Thank you for your advice,I will modify subject and description.
> > From: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
> >
> > This patch avoid return err when virtual gpio set SMT.
> >
> > Signed-off-by: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
> > ---
> > change note:
> > v2 : 1. delete virtual gpio number
> >      2. add judgment conditions
> > ---
> >  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > index 4a9e0d4c2bbc..a576e417744a 100644
> > --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > @@ -290,7 +290,11 @@ static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
> >                 return err;
> >
> >         err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT, MTK_ENABLE);
> > -       if (err)
> > +
> > +       /* SMT doesn't support virtual GPIO, add err != -ENOTSUPP is used for
> > +        * avoid return err when virtual gpio set SMT.
> > +        */
> 
> I'd prefer to the comments as the below
> 
> /*
> SMT is supposed to be supported by every real GPIO and doesn't support
> virtual GPIOs, so the extra condition err != -ENOTSUPP is just for
> adding EINT support to these virtual GPIOs. It should add an extra
> flag in the pin descriptor when more pins with distinctive
> characteristic come out.
> */
> 
Thank you for your advice,I will modify comments.
> > +       if (err && err != -ENOTSUPP)
> >                 return err;
> >
> >         return 0;
> > --
> > 2.19.1
> >



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
