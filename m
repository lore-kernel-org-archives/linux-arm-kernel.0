Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AAAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:10:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05BE321871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JqEYlWHp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZS8+vmjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05BE321871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9nlWQUOruBXP315fRuwxNb4e5xvwc3bXknSBPPldZeI=; b=JqEYlWHpsK/Y5I
	W3lA1QxE6vp8Z9PGmWd8u93Vogc7URy1/guCL8iMu9tTfk4PY6A50QR3y5gJHonWqCx0eKgxhHLHJ
	KUTAp9WagXoiKX7Bq2VFQ2dtOCWEzcAL3udvN1stDaNuSolrJBxoW4a9e5ylA+699aHhFaTkomx3W
	Pid91vLgGPk+In4twPKMLgrCIz3kROIam7LoSpFR3dk4mL6ueugku7khs/mpN7ZjZX7yBYAiGHb4T
	Co9//7XSnke0vkq8XZzVQIoh/MbG2XJSCwH+SV6DkjkmxFiIWqEKkvuztqpwMcewg5YDaaRNVmT8V
	+dN0jffbt79ZFZU+SUAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfMQf-0004Ue-6m; Fri, 04 Jan 2019 10:10:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfMQb-0004Pj-KN; Fri, 04 Jan 2019 10:10:11 +0000
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A361D21874;
 Fri,  4 Jan 2019 10:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546596608;
 bh=/ATKXxpPYYanELSr+T0wqMipesNZcLGZffwCDyYxhng=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ZS8+vmjjrEOefLzEA0lB0fQNlrI68cyvqAmeNGjMsj+yGVSS0Se1GmNCynBxIzHEM
 q31XhETiTPPqitbpdN4P93dfFqCi5CVo9+19ZOEUI8iFLoYkANuNUOEKu8pJZr+Myh
 BzD7OoxrJ7oerAEPRNLKRu9NgHIUklqmO3AgknT8=
Received: by mail-wm1-f46.google.com with SMTP id a62so660761wmh.4;
 Fri, 04 Jan 2019 02:10:08 -0800 (PST)
X-Gm-Message-State: AJcUukcAShAkIRs9W3BsbbpyjeewTTzzVY7EFPEzvw1ie0dOo0lg7oqT
 bnIebDEJq2HlVvHz/jhYed/GiDPjsWvX/+Jix1Y=
X-Google-Smtp-Source: ALg8bN4C7DEtDx0duBL1+r5A1UN08eiRqD1PYTQV3EUEBFs9UD5I1oQBE1vbrOwhIvhic9RCUG4yquVY2syBzqAJdsU=
X-Received: by 2002:a1c:e18a:: with SMTP id y132mr933389wmg.48.1546596607052; 
 Fri, 04 Jan 2019 02:10:07 -0800 (PST)
MIME-Version: 1.0
References: <20181211080123.1397-1-zhiyong.tao@mediatek.com>
 <20181211080123.1397-2-zhiyong.tao@mediatek.com>
 <CAGp9Lzo89syaHWDgtS2JpDzSS-_AAbHENFmXrxttUqcQhMj04g@mail.gmail.com>
 <1546591686.21915.12.camel@mhfsdcap03>
In-Reply-To: <1546591686.21915.12.camel@mhfsdcap03>
From: Sean Wang <sean.wang@kernel.org>
Date: Fri, 4 Jan 2019 02:11:00 -0800
X-Gmail-Original-Message-ID: <CAGp9Lzrh6gSJ6SF6CpuPvA6+TpH1Jb70aotA6twSn1Cd_=xpkA@mail.gmail.com>
Message-ID: <CAGp9Lzrh6gSJ6SF6CpuPvA6+TpH1Jb70aotA6twSn1Cd_=xpkA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: add drive for I2C related pins on MT8183
To: Zhiyong Tao <zhiyong.tao@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_021009_710481_A2010CBD 
X-CRM114-Status: GOOD (  34.76  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 =?UTF-8?B?SG9uZ2t1biBDYW8gKOabuea0quWdpCk=?= <Hongkun.Cao@mediatek.com>,
 srv_heupstream <srv_heupstream@mediatek.com>,
 =?UTF-8?B?Q2h1YW5qaWEgTGl1ICjmn7PkvKDlmIkp?= <Chuanjia.Liu@mediatek.com>,
 =?UTF-8?B?QmlhbyBIdWFuZyAo6buE5b2qKQ==?= <Biao.Huang@mediatek.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 =?UTF-8?B?TGlndW8gWmhhbmcgKOW8oOeri+WbvSk=?= <Liguo.Zhang@mediatek.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Hongzhou Yang <hongzhou.yang@mediatek.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 =?UTF-8?B?RWRkaWUgSHVhbmcgKOm7g+aZuuWCkSk=?= <eddie.huang@mediatek.com>,
 =?UTF-8?B?RXJpbiBMbyAo576F6ZuF6b2hKQ==?= <erin.lo@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 4, 2019 at 12:48 AM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:
>
> On Wed, 2018-12-12 at 04:51 +0800, Sean Wang wrote:
> > The subject should be refined to be close to the content
> >
> > On Tue, Dec 11, 2018 at 12:02 AM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:
> > >
> > > This patch provides the advanced drive for I2C used pins on MT8183.
> > >
> >
> > Additionally, you should state more how much strength in mA given on
> > each step E1, E0 move forward. This way would help to reuse the scheme
> > on the similar SoCs.
>
> ==>
> Hi sean,
> Thanks for your suggestion.
> when E1=0/E0=0, the strength is 0.125mA;
> when E1=0/E0=1, the strength is 0.25mA;
> when E1=1/E0=0, the strength is 0.5mA;
> when E1=1/E0=1, the strength is 1mA;
> we will add it in the commit message in the next version.
>

Does the extra fine-tuned strength always plus on regular drive
strength? or the device can be minus from regular drive strength.

Because the generic property drive-strength seems not able to accept a
floating point as the argument, so it should probably be fine to use
additional vendor property to indicate the extra fine-tuned strength.

I'd prefer to add only one vendor property
"mediatek,drive-strength-extra" in a human-readable way which only
accepts an integer in mA to reach your goal and where the "extra" in
the naming is that I am supposed the property can't work
independently, it has to work together with general driving strength
to determine the final driving strength.

For example:
mediatek,drive-strenth-extra=<125>;
mediatek,drive-strenth-extra=<250>;
mediatek,drive-strenth-extra=<500>;
mediatek,drive-strenth-extra=<1000>;
mediatek,drive-strenth-extra=<-250>; /* if a minus can supported */

About the driver implementation, the driver can round down or up to
the closest value the user expects to (that can be done easily with
macro DIV_ROUND_CLOSEST) and we have to state clearly what range can
be supported for the SoC and the relationship with generic property
drive-strength in both the dt-binding and the driver with proper
comments.

> Thanks.
> >
> > > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > > ---
> > >  drivers/pinctrl/mediatek/pinctrl-mt8183.c        | 50 ++++++++++++++++++++++++
> > >  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 45 +++++++++++++++++++++
> > >  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h | 13 ++++++
> > >  drivers/pinctrl/mediatek/pinctrl-paris.c         | 20 ++++++++++
> > >  4 files changed, 128 insertions(+)
> > >
> > > diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8183.c b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> > > index 6262fd3678ea..5244e1b27b1d 100644
> > > --- a/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> > > +++ b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> > > @@ -472,6 +472,51 @@ static const struct mtk_pin_field_calc mt8183_pin_r1_range[] = {
> > >         PIN_FIELD_BASE(133, 133, 8, 0x0D0, 0x10, 13, 1),
> > >  };
> > >
> > > +static const struct mtk_pin_field_calc mt8183_pin_drv_en_dis_range[] = {
> >
> > I'd prefer using the word mt8183_pin_e1e0en_range to keep people away from
> > be confused the relationship with the existing mt8183_pin_drv_range.
> >
> > > +       PIN_FIELD_BASE(48, 48, 3, 0x0F0, 0x10, 20, 1),
> > > +       PIN_FIELD_BASE(49, 49, 3, 0x0F0, 0x10, 15, 1),
> > > +       PIN_FIELD_BASE(50, 50, 4, 0x0F0, 0x10, 12, 1),
> > > +       PIN_FIELD_BASE(51, 51, 4, 0x0F0, 0x10, 7, 1),
> > > +       PIN_FIELD_BASE(81, 81, 5, 0x0F0, 0x10, 12, 1),
> > > +       PIN_FIELD_BASE(82, 82, 5, 0x0F0, 0x10, 9, 1),
> > > +       PIN_FIELD_BASE(83, 83, 5, 0x0F0, 0x10, 19, 1),
> > > +       PIN_FIELD_BASE(84, 84, 5, 0x0F0, 0x10, 22, 1),
> > > +       PIN_FIELD_BASE(103, 103, 6, 0x0F0, 0x10, 24, 1),
> > > +       PIN_FIELD_BASE(104, 104, 6, 0x0F0, 0x10, 14, 1),
> > > +       PIN_FIELD_BASE(105, 105, 6, 0x0F0, 0x10, 27, 1),
> > > +       PIN_FIELD_BASE(106, 106, 6, 0x0F0, 0x10, 17, 1),
> > > +};
> > > +
> > > +static const struct mtk_pin_field_calc mt8183_pin_drv_e0_range[] = {
> >
> > Ditto, I'd prefer using the word mt8183_pin_e0_range
> >
> > > +       PIN_FIELD_BASE(48, 48, 3, 0x0F0, 0x10, 21, 1),
> > > +       PIN_FIELD_BASE(49, 49, 3, 0x0F0, 0x10, 16, 1),
> > > +       PIN_FIELD_BASE(50, 50, 4, 0x0F0, 0x10, 13, 1),
> > > +       PIN_FIELD_BASE(51, 51, 4, 0x0F0, 0x10, 8, 1),
> > > +       PIN_FIELD_BASE(81, 81, 5, 0x0F0, 0x10, 13, 1),
> > > +       PIN_FIELD_BASE(82, 82, 5, 0x0F0, 0x10, 10, 1),
> > > +       PIN_FIELD_BASE(83, 83, 5, 0x0F0, 0x10, 20, 1),
> > > +       PIN_FIELD_BASE(84, 84, 5, 0x0F0, 0x10, 23, 1),
> > > +       PIN_FIELD_BASE(103, 103, 6, 0x0F0, 0x10, 25, 1),
> > > +       PIN_FIELD_BASE(104, 104, 6, 0x0F0, 0x10, 15, 1),
> > > +       PIN_FIELD_BASE(105, 105, 6, 0x0F0, 0x10, 28, 1),
> > > +       PIN_FIELD_BASE(106, 106, 6, 0x0F0, 0x10, 18, 1),
> > > +};
> > > +
> > > +static const struct mtk_pin_field_calc mt8183_pin_drv_e1_range[] = {
> >
> > Ditto, I'd prefer using the word mt8183_pin_e1_range
> >
> > > +       PIN_FIELD_BASE(48, 48, 3, 0x0F0, 0x10, 22, 1),
> > > +       PIN_FIELD_BASE(49, 49, 3, 0x0F0, 0x10, 17, 1),
> > > +       PIN_FIELD_BASE(50, 50, 4, 0x0F0, 0x10, 14, 1),
> > > +       PIN_FIELD_BASE(51, 51, 4, 0x0F0, 0x10, 9, 1),
> > > +       PIN_FIELD_BASE(81, 81, 5, 0x0F0, 0x10, 14, 1),
> > > +       PIN_FIELD_BASE(82, 82, 5, 0x0F0, 0x10, 11, 1),
> > > +       PIN_FIELD_BASE(83, 83, 5, 0x0F0, 0x10, 21, 1),
> > > +       PIN_FIELD_BASE(84, 84, 5, 0x0F0, 0x10, 24, 1),
> > > +       PIN_FIELD_BASE(103, 103, 6, 0x0F0, 0x10, 26, 1),
> > > +       PIN_FIELD_BASE(104, 104, 6, 0x0F0, 0x10, 16, 1),
> > > +       PIN_FIELD_BASE(105, 105, 6, 0x0F0, 0x10, 29, 1),
> > > +       PIN_FIELD_BASE(106, 106, 6, 0x0F0, 0x10, 19, 1),
> > > +};
> > > +
> > >  static const struct mtk_pin_reg_calc mt8183_reg_cals[PINCTRL_PIN_REG_MAX] = {
> > >         [PINCTRL_PIN_REG_MODE] = MTK_RANGE(mt8183_pin_mode_range),
> > >         [PINCTRL_PIN_REG_DIR] = MTK_RANGE(mt8183_pin_dir_range),
> > > @@ -485,6 +530,9 @@ static const struct mtk_pin_reg_calc mt8183_reg_cals[PINCTRL_PIN_REG_MAX] = {
> > >         [PINCTRL_PIN_REG_PUPD] = MTK_RANGE(mt8183_pin_pupd_range),
> > >         [PINCTRL_PIN_REG_R0] = MTK_RANGE(mt8183_pin_r0_range),
> > >         [PINCTRL_PIN_REG_R1] = MTK_RANGE(mt8183_pin_r1_range),
> > > +       [PINCTRL_PIN_REG_DRV_EN_DIS] = MTK_RANGE(mt8183_pin_drv_en_dis_range),
> > > +       [PINCTRL_PIN_REG_DRV_E0] = MTK_RANGE(mt8183_pin_drv_e0_range),
> > > +       [PINCTRL_PIN_REG_DRV_E1] = MTK_RANGE(mt8183_pin_drv_e1_range),
> > >  };
> > >
> > >  static const char * const mt8183_pinctrl_register_base_names[] = {
> > > @@ -517,6 +565,8 @@ static const struct mtk_pin_soc mt8183_data = {
> > >         .drive_get = mtk_pinconf_drive_get_rev1,
> > >         .adv_pull_get = mtk_pinconf_adv_pull_get,
> > >         .adv_pull_set = mtk_pinconf_adv_pull_set,
> > > +       .adv_drive_get = mtk_pinconf_adv_drive_get,
> > > +       .adv_drive_set = mtk_pinconf_adv_drive_set,
> >
> > DT property drive-strength is generic enough to all SoCs so we don't
> > need to create extra callbacks to serve the extra property about the
> > driving adjustment.
> >
> > And DRV register working for i2c pins 48-51, 81-84 and 103-106 implies
> > that E1 and E0 work like more an extra fine adjustment related to DRV
> > register have done to give more accurate strength than only DRV
> > register can support. Thus, DRV, E0, and E1 should be more
> > consolidated to in the same function instead of making them apart.
> >
> > If we know how much driving strength on each step of e1, e0, it would
> > be easy to add E1 and E0 support into current driving adjustment
> > procedure mtk_pinconf_drive_set_rev1 and mtk_pinconf_drive_get_rev1.
> >
> > >  };
> > >
> > >  static const struct of_device_id mt8183_pinctrl_of_match[] = {
> > > diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > > index 4a9e0d4c2bbc..da024279ec59 100644
> > > --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > > +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > > @@ -668,3 +668,48 @@ int mtk_pinconf_adv_pull_get(struct mtk_pinctrl *hw,
> > >
> > >         return 0;
> > >  }
> > > +
> > > +int mtk_pinconf_adv_drive_set(struct mtk_pinctrl *hw,
> > > +                             const struct mtk_pin_desc *desc, bool enable,
> > > +                             u32 arg)
> > > +{
> > > +       int err;
> > > +
> > > +       err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DRV_E0, arg & 1);
> > > +       if (err)
> > > +               return 0;
> > > +
> > > +       err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DRV_E1,
> > > +                              !!(arg & 2));
> > > +       if (err)
> > > +               return 0;
> > > +
> > > +       arg = enable ? 1 : 0;
> > > +
> > > +       err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DRV_EN_DIS, arg);
> > > +
> > > +       return err;
> > > +}
> > > +
> > > +int mtk_pinconf_adv_drive_get(struct mtk_pinctrl *hw,
> > > +                             const struct mtk_pin_desc *desc, u32 *val)
> > > +{
> > > +       u32 en, e0, e1;
> > > +       int err;
> > > +
> > > +       err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DRV_EN_DIS, &en);
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DRV_E0, &e0);
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DRV_E1, &e1);
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       *val = (e0 | e1 << 1 | en << 2) & 0x7;
> > > +
> > > +       return 0;
> > > +}
> > > diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
> > > index 6d24522739d9..795a3b10d54e 100644
> > > --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
> > > +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
> > > @@ -63,6 +63,9 @@ enum {
> > >         PINCTRL_PIN_REG_IES,
> > >         PINCTRL_PIN_REG_PULLEN,
> > >         PINCTRL_PIN_REG_PULLSEL,
> > > +       PINCTRL_PIN_REG_DRV_EN_DIS,
> > > +       PINCTRL_PIN_REG_DRV_E0,
> > > +       PINCTRL_PIN_REG_DRV_E1,
> > >         PINCTRL_PIN_REG_MAX,
> > >  };
> > >
> > > @@ -224,6 +227,11 @@ struct mtk_pin_soc {
> > >         int (*adv_pull_get)(struct mtk_pinctrl *hw,
> > >                             const struct mtk_pin_desc *desc, bool pullup,
> > >                             u32 *val);
> > > +       int (*adv_drive_set)(struct mtk_pinctrl *hw,
> > > +                            const struct mtk_pin_desc *desc, bool enable,
> > > +                            u32 arg);
> > > +       int (*adv_drive_get)(struct mtk_pinctrl *hw,
> > > +                            const struct mtk_pin_desc *desc, u32 *val);
> > >
> > >         /* Specific driver data */
> > >         void                            *driver_data;
> > > @@ -287,5 +295,10 @@ int mtk_pinconf_adv_pull_set(struct mtk_pinctrl *hw,
> > >  int mtk_pinconf_adv_pull_get(struct mtk_pinctrl *hw,
> > >                              const struct mtk_pin_desc *desc, bool pullup,
> > >                              u32 *val);
> > > +int mtk_pinconf_adv_drive_set(struct mtk_pinctrl *hw,
> > > +                             const struct mtk_pin_desc *desc, bool enable,
> > > +                            u32 arg);
> > > +int mtk_pinconf_adv_drive_get(struct mtk_pinctrl *hw,
> > > +                             const struct mtk_pin_desc *desc, u32 *val);
> > >
> > >  #endif /* __PINCTRL_MTK_COMMON_V2_H */
> > > diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
> > > index d2179028f134..ef4ccaa59e55 100644
> > > --- a/drivers/pinctrl/mediatek/pinctrl-paris.c
> > > +++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
> > > @@ -20,12 +20,16 @@
> > >  #define MTK_PIN_CONFIG_RDSEL   (PIN_CONFIG_END + 2)
> > >  #define MTK_PIN_CONFIG_PU_ADV  (PIN_CONFIG_END + 3)
> > >  #define MTK_PIN_CONFIG_PD_ADV  (PIN_CONFIG_END + 4)
> > > +#define MTK_PIN_CONFIG_DRV_EN_ADV      (PIN_CONFIG_END + 5)
> > > +#define MTK_PIN_CONFIG_DRV_DIS_ADV     (PIN_CONFIG_END + 6)
> > >
> > >  static const struct pinconf_generic_params mtk_custom_bindings[] = {
> > >         {"mediatek,tdsel",      MTK_PIN_CONFIG_TDSEL,           0},
> > >         {"mediatek,rdsel",      MTK_PIN_CONFIG_RDSEL,           0},
> > >         {"mediatek,pull-up-adv", MTK_PIN_CONFIG_PU_ADV,         1},
> > >         {"mediatek,pull-down-adv", MTK_PIN_CONFIG_PD_ADV,       1},
> > > +       {"mediatek,drive-enable-adv", MTK_PIN_CONFIG_DRV_EN_ADV,        2},
> > > +       {"mediatek,drive-disable-adv", MTK_PIN_CONFIG_DRV_DIS_ADV,      2},
> > >  };
> > >
> > >  #ifdef CONFIG_DEBUG_FS
> > > @@ -34,6 +38,8 @@ static const struct pin_config_item mtk_conf_items[] = {
> > >         PCONFDUMP(MTK_PIN_CONFIG_RDSEL, "rdsel", NULL, true),
> > >         PCONFDUMP(MTK_PIN_CONFIG_PU_ADV, "pu-adv", NULL, true),
> > >         PCONFDUMP(MTK_PIN_CONFIG_PD_ADV, "pd-adv", NULL, true),
> > > +       PCONFDUMP(MTK_PIN_CONFIG_DRV_EN_ADV, "drive-enable-adv", NULL, true),
> > > +       PCONFDUMP(MTK_PIN_CONFIG_DRV_DIS_ADV, "drive-disable-adv", NULL, true),
> > >  };
> > >  #endif
> > >
> > > @@ -311,6 +317,20 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
> > >                         return -ENOTSUPP;
> > >                 }
> > >                 break;
> > > +       case MTK_PIN_CONFIG_DRV_EN_ADV:
> > > +       case MTK_PIN_CONFIG_DRV_DIS_ADV:
> > > +               if (hw->soc->adv_drive_set) {
> > > +                       bool enable;
> > > +
> > > +                       enable = param == MTK_PIN_CONFIG_DRV_EN_ADV;
> > > +                       err = hw->soc->adv_drive_set(hw, desc, enable,
> > > +                                                   arg);
> > > +                       if (err)
> > > +                               return err;
> > > +               } else {
> > > +                       return -ENOTSUPP;
> > > +               }
> > > +               break;
> > >         default:
> > >                 err = -ENOTSUPP;
> > >         }
> > > --
> > > 2.12.5
> > >
> > >
> > > _______________________________________________
> > > Linux-mediatek mailing list
> > > Linux-mediatek@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-mediatek
>
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
