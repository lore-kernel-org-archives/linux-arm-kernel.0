Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E9BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:48:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C280B20665
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YZmvTv0q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C280B20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wkVc2DPredFBlQuGrjj5pRNVUVln4CByYtNF9fxBb3E=; b=YZmvTv0q0wmQKW
	4hEbMGtE6q2PM5ZmUv1QFdSDCXy/oHWBTimgKCLs445Kgqp5OGlzETlowUxnMJdJCfh8k1lAEzA9T
	464n1zyT8e0rK/CI+GIT3qdDuDxTzcNLia/dxGQwDGPfXFjWg+QrdtdDj0YmtphyIkd3brXy/4o6U
	Gs3qLS3xXXiQqXQyS0apzIeImWrSDoVIQDKbr0gfCQWMFedj8rVyuJmfvQ4CosiXGVwK5I//UZEj0
	gfed/0Sm2zsJV/VVt8+F0+CDBsZc6UDjbmBj5usgc9npzanx9nDnBa+6qyQF4BZWfBf1A0qGx2j2e
	lZBqxNx8F4/U0VnYhxkQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfL9S-0003rr-0Z; Fri, 04 Jan 2019 08:48:22 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfL9N-0003r4-PA; Fri, 04 Jan 2019 08:48:19 +0000
X-UUID: 8cb8196019f84bee8769985119fc6140-20190104
X-UUID: 8cb8196019f84bee8769985119fc6140-20190104
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <zhiyong.tao@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 715310509; Fri, 04 Jan 2019 00:48:11 -0800
Received: from MTKMBS31DR.mediatek.inc (172.27.6.102) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 4 Jan 2019 00:48:09 -0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Fri, 4 Jan 2019 16:48:06 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 4 Jan 2019 16:48:06 +0800
Message-ID: <1546591686.21915.12.camel@mhfsdcap03>
Subject: Re: [PATCH] pinctrl: add drive for I2C related pins on MT8183
From: Zhiyong Tao <zhiyong.tao@mediatek.com>
To: Sean Wang <sean.wang@kernel.org>
Date: Fri, 4 Jan 2019 16:48:06 +0800
In-Reply-To: <CAGp9Lzo89syaHWDgtS2JpDzSS-_AAbHENFmXrxttUqcQhMj04g@mail.gmail.com>
References: <20181211080123.1397-1-zhiyong.tao@mediatek.com>
 <20181211080123.1397-2-zhiyong.tao@mediatek.com>
 <CAGp9Lzo89syaHWDgtS2JpDzSS-_AAbHENFmXrxttUqcQhMj04g@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_004817_822552_0570CD82 
X-CRM114-Status: GOOD (  28.83  )
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
 Hongkun Cao =?UTF-8?Q?=28=E6=9B=B9=E6=B4=AA=E5=9D=A4=29?=
 <Hongkun.Cao@mediatek.com>, srv_heupstream <srv_heupstream@mediatek.com>,
 Chuanjia Liu =?UTF-8?Q?=28=E6=9F=B3=E4=BC=A0=E5=98=89=29?=
 <Chuanjia.Liu@mediatek.com>,
 Biao Huang =?UTF-8?Q?=28=E9=BB=84=E5=BD=AA=29?= <Biao.Huang@mediatek.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Liguo Zhang =?UTF-8?Q?=28=E5=BC=A0=E7=AB=8B=E5=9B=BD=29?=
 <Liguo.Zhang@mediatek.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Hongzhou Yang <hongzhou.yang@mediatek.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Eddie Huang =?UTF-8?Q?=28=E9=BB=83=E6=99=BA=E5=82=91=29?=
 <eddie.huang@mediatek.com>,
 Erin Lo =?UTF-8?Q?=28=E7=BE=85=E9=9B=85=E9=BD=A1=29?= <erin.lo@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 2018-12-12 at 04:51 +0800, Sean Wang wrote:
> The subject should be refined to be close to the content
> 
> On Tue, Dec 11, 2018 at 12:02 AM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:
> >
> > This patch provides the advanced drive for I2C used pins on MT8183.
> >
> 
> Additionally, you should state more how much strength in mA given on
> each step E1, E0 move forward. This way would help to reuse the scheme
> on the similar SoCs.

==> 
Hi sean,
Thanks for your suggestion. 
when E1=0/E0=0, the strength is 0.125mA;
when E1=0/E0=1, the strength is 0.25mA;
when E1=1/E0=0, the strength is 0.5mA;
when E1=1/E0=1, the strength is 1mA;
we will add it in the commit message in the next version.

Thanks.
> 
> > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > ---
> >  drivers/pinctrl/mediatek/pinctrl-mt8183.c        | 50 ++++++++++++++++++++++++
> >  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 45 +++++++++++++++++++++
> >  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h | 13 ++++++
> >  drivers/pinctrl/mediatek/pinctrl-paris.c         | 20 ++++++++++
> >  4 files changed, 128 insertions(+)
> >
> > diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8183.c b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> > index 6262fd3678ea..5244e1b27b1d 100644
> > --- a/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> > +++ b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> > @@ -472,6 +472,51 @@ static const struct mtk_pin_field_calc mt8183_pin_r1_range[] = {
> >         PIN_FIELD_BASE(133, 133, 8, 0x0D0, 0x10, 13, 1),
> >  };
> >
> > +static const struct mtk_pin_field_calc mt8183_pin_drv_en_dis_range[] = {
> 
> I'd prefer using the word mt8183_pin_e1e0en_range to keep people away from
> be confused the relationship with the existing mt8183_pin_drv_range.
> 
> > +       PIN_FIELD_BASE(48, 48, 3, 0x0F0, 0x10, 20, 1),
> > +       PIN_FIELD_BASE(49, 49, 3, 0x0F0, 0x10, 15, 1),
> > +       PIN_FIELD_BASE(50, 50, 4, 0x0F0, 0x10, 12, 1),
> > +       PIN_FIELD_BASE(51, 51, 4, 0x0F0, 0x10, 7, 1),
> > +       PIN_FIELD_BASE(81, 81, 5, 0x0F0, 0x10, 12, 1),
> > +       PIN_FIELD_BASE(82, 82, 5, 0x0F0, 0x10, 9, 1),
> > +       PIN_FIELD_BASE(83, 83, 5, 0x0F0, 0x10, 19, 1),
> > +       PIN_FIELD_BASE(84, 84, 5, 0x0F0, 0x10, 22, 1),
> > +       PIN_FIELD_BASE(103, 103, 6, 0x0F0, 0x10, 24, 1),
> > +       PIN_FIELD_BASE(104, 104, 6, 0x0F0, 0x10, 14, 1),
> > +       PIN_FIELD_BASE(105, 105, 6, 0x0F0, 0x10, 27, 1),
> > +       PIN_FIELD_BASE(106, 106, 6, 0x0F0, 0x10, 17, 1),
> > +};
> > +
> > +static const struct mtk_pin_field_calc mt8183_pin_drv_e0_range[] = {
> 
> Ditto, I'd prefer using the word mt8183_pin_e0_range
> 
> > +       PIN_FIELD_BASE(48, 48, 3, 0x0F0, 0x10, 21, 1),
> > +       PIN_FIELD_BASE(49, 49, 3, 0x0F0, 0x10, 16, 1),
> > +       PIN_FIELD_BASE(50, 50, 4, 0x0F0, 0x10, 13, 1),
> > +       PIN_FIELD_BASE(51, 51, 4, 0x0F0, 0x10, 8, 1),
> > +       PIN_FIELD_BASE(81, 81, 5, 0x0F0, 0x10, 13, 1),
> > +       PIN_FIELD_BASE(82, 82, 5, 0x0F0, 0x10, 10, 1),
> > +       PIN_FIELD_BASE(83, 83, 5, 0x0F0, 0x10, 20, 1),
> > +       PIN_FIELD_BASE(84, 84, 5, 0x0F0, 0x10, 23, 1),
> > +       PIN_FIELD_BASE(103, 103, 6, 0x0F0, 0x10, 25, 1),
> > +       PIN_FIELD_BASE(104, 104, 6, 0x0F0, 0x10, 15, 1),
> > +       PIN_FIELD_BASE(105, 105, 6, 0x0F0, 0x10, 28, 1),
> > +       PIN_FIELD_BASE(106, 106, 6, 0x0F0, 0x10, 18, 1),
> > +};
> > +
> > +static const struct mtk_pin_field_calc mt8183_pin_drv_e1_range[] = {
> 
> Ditto, I'd prefer using the word mt8183_pin_e1_range
> 
> > +       PIN_FIELD_BASE(48, 48, 3, 0x0F0, 0x10, 22, 1),
> > +       PIN_FIELD_BASE(49, 49, 3, 0x0F0, 0x10, 17, 1),
> > +       PIN_FIELD_BASE(50, 50, 4, 0x0F0, 0x10, 14, 1),
> > +       PIN_FIELD_BASE(51, 51, 4, 0x0F0, 0x10, 9, 1),
> > +       PIN_FIELD_BASE(81, 81, 5, 0x0F0, 0x10, 14, 1),
> > +       PIN_FIELD_BASE(82, 82, 5, 0x0F0, 0x10, 11, 1),
> > +       PIN_FIELD_BASE(83, 83, 5, 0x0F0, 0x10, 21, 1),
> > +       PIN_FIELD_BASE(84, 84, 5, 0x0F0, 0x10, 24, 1),
> > +       PIN_FIELD_BASE(103, 103, 6, 0x0F0, 0x10, 26, 1),
> > +       PIN_FIELD_BASE(104, 104, 6, 0x0F0, 0x10, 16, 1),
> > +       PIN_FIELD_BASE(105, 105, 6, 0x0F0, 0x10, 29, 1),
> > +       PIN_FIELD_BASE(106, 106, 6, 0x0F0, 0x10, 19, 1),
> > +};
> > +
> >  static const struct mtk_pin_reg_calc mt8183_reg_cals[PINCTRL_PIN_REG_MAX] = {
> >         [PINCTRL_PIN_REG_MODE] = MTK_RANGE(mt8183_pin_mode_range),
> >         [PINCTRL_PIN_REG_DIR] = MTK_RANGE(mt8183_pin_dir_range),
> > @@ -485,6 +530,9 @@ static const struct mtk_pin_reg_calc mt8183_reg_cals[PINCTRL_PIN_REG_MAX] = {
> >         [PINCTRL_PIN_REG_PUPD] = MTK_RANGE(mt8183_pin_pupd_range),
> >         [PINCTRL_PIN_REG_R0] = MTK_RANGE(mt8183_pin_r0_range),
> >         [PINCTRL_PIN_REG_R1] = MTK_RANGE(mt8183_pin_r1_range),
> > +       [PINCTRL_PIN_REG_DRV_EN_DIS] = MTK_RANGE(mt8183_pin_drv_en_dis_range),
> > +       [PINCTRL_PIN_REG_DRV_E0] = MTK_RANGE(mt8183_pin_drv_e0_range),
> > +       [PINCTRL_PIN_REG_DRV_E1] = MTK_RANGE(mt8183_pin_drv_e1_range),
> >  };
> >
> >  static const char * const mt8183_pinctrl_register_base_names[] = {
> > @@ -517,6 +565,8 @@ static const struct mtk_pin_soc mt8183_data = {
> >         .drive_get = mtk_pinconf_drive_get_rev1,
> >         .adv_pull_get = mtk_pinconf_adv_pull_get,
> >         .adv_pull_set = mtk_pinconf_adv_pull_set,
> > +       .adv_drive_get = mtk_pinconf_adv_drive_get,
> > +       .adv_drive_set = mtk_pinconf_adv_drive_set,
> 
> DT property drive-strength is generic enough to all SoCs so we don't
> need to create extra callbacks to serve the extra property about the
> driving adjustment.
> 
> And DRV register working for i2c pins 48-51, 81-84 and 103-106 implies
> that E1 and E0 work like more an extra fine adjustment related to DRV
> register have done to give more accurate strength than only DRV
> register can support. Thus, DRV, E0, and E1 should be more
> consolidated to in the same function instead of making them apart.
> 
> If we know how much driving strength on each step of e1, e0, it would
> be easy to add E1 and E0 support into current driving adjustment
> procedure mtk_pinconf_drive_set_rev1 and mtk_pinconf_drive_get_rev1.
> 
> >  };
> >
> >  static const struct of_device_id mt8183_pinctrl_of_match[] = {
> > diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > index 4a9e0d4c2bbc..da024279ec59 100644
> > --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > @@ -668,3 +668,48 @@ int mtk_pinconf_adv_pull_get(struct mtk_pinctrl *hw,
> >
> >         return 0;
> >  }
> > +
> > +int mtk_pinconf_adv_drive_set(struct mtk_pinctrl *hw,
> > +                             const struct mtk_pin_desc *desc, bool enable,
> > +                             u32 arg)
> > +{
> > +       int err;
> > +
> > +       err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DRV_E0, arg & 1);
> > +       if (err)
> > +               return 0;
> > +
> > +       err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DRV_E1,
> > +                              !!(arg & 2));
> > +       if (err)
> > +               return 0;
> > +
> > +       arg = enable ? 1 : 0;
> > +
> > +       err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DRV_EN_DIS, arg);
> > +
> > +       return err;
> > +}
> > +
> > +int mtk_pinconf_adv_drive_get(struct mtk_pinctrl *hw,
> > +                             const struct mtk_pin_desc *desc, u32 *val)
> > +{
> > +       u32 en, e0, e1;
> > +       int err;
> > +
> > +       err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DRV_EN_DIS, &en);
> > +       if (err)
> > +               return err;
> > +
> > +       err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DRV_E0, &e0);
> > +       if (err)
> > +               return err;
> > +
> > +       err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DRV_E1, &e1);
> > +       if (err)
> > +               return err;
> > +
> > +       *val = (e0 | e1 << 1 | en << 2) & 0x7;
> > +
> > +       return 0;
> > +}
> > diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
> > index 6d24522739d9..795a3b10d54e 100644
> > --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
> > +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
> > @@ -63,6 +63,9 @@ enum {
> >         PINCTRL_PIN_REG_IES,
> >         PINCTRL_PIN_REG_PULLEN,
> >         PINCTRL_PIN_REG_PULLSEL,
> > +       PINCTRL_PIN_REG_DRV_EN_DIS,
> > +       PINCTRL_PIN_REG_DRV_E0,
> > +       PINCTRL_PIN_REG_DRV_E1,
> >         PINCTRL_PIN_REG_MAX,
> >  };
> >
> > @@ -224,6 +227,11 @@ struct mtk_pin_soc {
> >         int (*adv_pull_get)(struct mtk_pinctrl *hw,
> >                             const struct mtk_pin_desc *desc, bool pullup,
> >                             u32 *val);
> > +       int (*adv_drive_set)(struct mtk_pinctrl *hw,
> > +                            const struct mtk_pin_desc *desc, bool enable,
> > +                            u32 arg);
> > +       int (*adv_drive_get)(struct mtk_pinctrl *hw,
> > +                            const struct mtk_pin_desc *desc, u32 *val);
> >
> >         /* Specific driver data */
> >         void                            *driver_data;
> > @@ -287,5 +295,10 @@ int mtk_pinconf_adv_pull_set(struct mtk_pinctrl *hw,
> >  int mtk_pinconf_adv_pull_get(struct mtk_pinctrl *hw,
> >                              const struct mtk_pin_desc *desc, bool pullup,
> >                              u32 *val);
> > +int mtk_pinconf_adv_drive_set(struct mtk_pinctrl *hw,
> > +                             const struct mtk_pin_desc *desc, bool enable,
> > +                            u32 arg);
> > +int mtk_pinconf_adv_drive_get(struct mtk_pinctrl *hw,
> > +                             const struct mtk_pin_desc *desc, u32 *val);
> >
> >  #endif /* __PINCTRL_MTK_COMMON_V2_H */
> > diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
> > index d2179028f134..ef4ccaa59e55 100644
> > --- a/drivers/pinctrl/mediatek/pinctrl-paris.c
> > +++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
> > @@ -20,12 +20,16 @@
> >  #define MTK_PIN_CONFIG_RDSEL   (PIN_CONFIG_END + 2)
> >  #define MTK_PIN_CONFIG_PU_ADV  (PIN_CONFIG_END + 3)
> >  #define MTK_PIN_CONFIG_PD_ADV  (PIN_CONFIG_END + 4)
> > +#define MTK_PIN_CONFIG_DRV_EN_ADV      (PIN_CONFIG_END + 5)
> > +#define MTK_PIN_CONFIG_DRV_DIS_ADV     (PIN_CONFIG_END + 6)
> >
> >  static const struct pinconf_generic_params mtk_custom_bindings[] = {
> >         {"mediatek,tdsel",      MTK_PIN_CONFIG_TDSEL,           0},
> >         {"mediatek,rdsel",      MTK_PIN_CONFIG_RDSEL,           0},
> >         {"mediatek,pull-up-adv", MTK_PIN_CONFIG_PU_ADV,         1},
> >         {"mediatek,pull-down-adv", MTK_PIN_CONFIG_PD_ADV,       1},
> > +       {"mediatek,drive-enable-adv", MTK_PIN_CONFIG_DRV_EN_ADV,        2},
> > +       {"mediatek,drive-disable-adv", MTK_PIN_CONFIG_DRV_DIS_ADV,      2},
> >  };
> >
> >  #ifdef CONFIG_DEBUG_FS
> > @@ -34,6 +38,8 @@ static const struct pin_config_item mtk_conf_items[] = {
> >         PCONFDUMP(MTK_PIN_CONFIG_RDSEL, "rdsel", NULL, true),
> >         PCONFDUMP(MTK_PIN_CONFIG_PU_ADV, "pu-adv", NULL, true),
> >         PCONFDUMP(MTK_PIN_CONFIG_PD_ADV, "pd-adv", NULL, true),
> > +       PCONFDUMP(MTK_PIN_CONFIG_DRV_EN_ADV, "drive-enable-adv", NULL, true),
> > +       PCONFDUMP(MTK_PIN_CONFIG_DRV_DIS_ADV, "drive-disable-adv", NULL, true),
> >  };
> >  #endif
> >
> > @@ -311,6 +317,20 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
> >                         return -ENOTSUPP;
> >                 }
> >                 break;
> > +       case MTK_PIN_CONFIG_DRV_EN_ADV:
> > +       case MTK_PIN_CONFIG_DRV_DIS_ADV:
> > +               if (hw->soc->adv_drive_set) {
> > +                       bool enable;
> > +
> > +                       enable = param == MTK_PIN_CONFIG_DRV_EN_ADV;
> > +                       err = hw->soc->adv_drive_set(hw, desc, enable,
> > +                                                   arg);
> > +                       if (err)
> > +                               return err;
> > +               } else {
> > +                       return -ENOTSUPP;
> > +               }
> > +               break;
> >         default:
> >                 err = -ENOTSUPP;
> >         }
> > --
> > 2.12.5
> >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
