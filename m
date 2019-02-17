Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B44C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 15:17:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4A4921A4A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 15:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kDuJGD5D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A4921A4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2Yfbhcfp7tbniqZtF4EnSPBZuEo/9kYYJGuInvQg+OM=; b=kDuJGD5DJsJBZM
	XfWAY79WsOGZe64PxCg3xQM4ZqAp/RZyZi3aET7iEqxho1DUZlsFmQNpQHH0CAgEZ7EVUXUpLose4
	Aau+xClS2qQ6QqVoAIRpyWRRV/XnsQ09RQ8QhCRajFUZjsnNpt3e2jgfUQPyvWb/G2aTVcjQVPtE+
	y7/S06DxQasCeEFFm7rnxajh8RUWoJ18gTUrGI3AVJgIp9bW6uRXfj1//kLD8nLplVcMXpuFWePrc
	brxj50cBTsbEkSjGvPk3dDdZ6Ndy9wF6b6b23PJ8M9EMY5BcDWnf+oHPTqtvAc4o24S91W1uipPO6
	v6FPk6EBICE5X7QkB+Yg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvOCG-0006hP-3I; Sun, 17 Feb 2019 15:17:36 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvOCB-0006gX-Lo; Sun, 17 Feb 2019 15:17:33 +0000
X-UUID: d8bc479be4d24e5ea4156a840e02ecb5-20190217
X-UUID: d8bc479be4d24e5ea4156a840e02ecb5-20190217
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <jitao.shi@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 754335085; Sun, 17 Feb 2019 07:17:26 -0800
Received: from MTKMBS31N2.mediatek.inc (172.27.4.87) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 17 Feb 2019 07:17:25 -0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Sun, 17 Feb 2019 23:17:22 +0800
Received: from [10.16.6.141] (10.16.6.141) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 17 Feb 2019 23:17:21 +0800
Message-ID: <1550416640.5194.33.camel@mszsdaap41>
Subject: Re: [PATCH 2/3] drm/mediatek: CMDQ reg address of mt8173 is
 different with mt2701
From: Jitao Shi <jitao.shi@mediatek.com>
To: Nicolas Boichat <drinkcat@chromium.org>
Date: Sun, 17 Feb 2019 23:17:20 +0800
In-Reply-To: <CANMq1KAua2mEfT81Mos5JyxHwUfVmgi5Se3fTPy9QcXyh23Urg@mail.gmail.com>
References: <20190214044243.129920-1-jitao.shi@mediatek.com>
 <20190214044243.129920-2-jitao.shi@mediatek.com>
 <CANMq1KAua2mEfT81Mos5JyxHwUfVmgi5Se3fTPy9QcXyh23Urg@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_071731_713791_28E3DFCD 
X-CRM114-Status: GOOD (  22.10  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 David Airlie <airlied@linux.ie>, stonea168@163.com,
 dri-devel@lists.freedesktop.org, Yingjoe
 Chen <yingjoe.chen@mediatek.com>, Ajay
 Kumar <ajaykumar.rs@samsung.com>, Vincent Palatin <vpalatin@chromium.org>,
 cawa cheng <cawa.cheng@mediatek.com>,
 Bibby Hsieh =?UTF-8?Q?=28=E8=AC=9D=E6=BF=9F=E9=81=A0=29?=
 <bibby.hsieh@mediatek.com>, CK
 HU <ck.hu@mediatek.com>, Russell King <rmk+kernel@arm.linux.org.uk>,
 Thierry Reding <treding@nvidia.com>, linux-pwm@vger.kernel.org,
 Sascha Hauer <kernel@pengutronix.de>, Pawel Moll <pawel.moll@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>, Inki Dae <inki.dae@samsung.com>,
 Rob Herring <robh+dt@kernel.org>, "moderated
 list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Andy Yan <andy.yan@rock-chips.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, Eddie Huang <eddie.huang@mediatek.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Rahul
 Sharma <rahul.sharma@samsung.com>, srv_heupstream@mediatek.com,
 lkml <linux-kernel@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Kumar Gala <galak@codeaurora.org>, Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 2019-02-14 at 13:48 +0800, Nicolas Boichat wrote:
> On Thu, Feb 14, 2019 at 12:42 PM Jitao Shi <jitao.shi@mediatek.com> wrote:
> >
> > Config the different CMDQ reg address in driver data.
> >
> > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dsi.c | 39 ++++++++++++++++++++++++------
> >  1 file changed, 31 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > index 93fa255b4aad..80db02a25cb0 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > @@ -156,6 +156,10 @@
> >
> >  struct phy;
> >
> > +struct mtk_dsi_driver_data {
> > +       const u32 reg_cmdq_off;
> > +};
> > +
> >  struct mtk_dsi {
> >         struct mtk_ddp_comp ddp_comp;
> >         struct device *dev;
> > @@ -182,6 +186,7 @@ struct mtk_dsi {
> >         bool enabled;
> >         u32 irq_data;
> >         wait_queue_head_t irq_wait_queue;
> > +       struct mtk_dsi_driver_data *driver_data;
> >  };
> >
> >  static inline struct mtk_dsi *encoder_to_dsi(struct drm_encoder *e)
> > @@ -934,6 +939,7 @@ static void mtk_dsi_cmdq(struct mtk_dsi *dsi, const struct mipi_dsi_msg *msg)
> >         const char *tx_buf = msg->tx_buf;
> >         u8 config, cmdq_size, cmdq_off, type = msg->type;
> >         u32 reg_val, cmdq_mask, i;
> > +       u32 reg_cmdq_off = dsi->driver_data->reg_cmdq_off;
> >
> >         if (MTK_DSI_HOST_IS_READ(type))
> >                 config = BTA;
> > @@ -953,9 +959,11 @@ static void mtk_dsi_cmdq(struct mtk_dsi *dsi, const struct mipi_dsi_msg *msg)
> >         }
> >
> >         for (i = 0; i < msg->tx_len; i++)
> > -               writeb(tx_buf[i], dsi->regs + DSI_CMDQ0 + cmdq_off + i);
> > +               mtk_dsi_mask(dsi, (reg_cmdq_off + cmdq_off + i) & (~0x3U),
> > +                            (0xffUL << (((i + cmdq_off) & 3U) * 8U)),
> > +                            tx_buf[i] << (((i + cmdq_off) & 3U) * 8U));
> 
> I found the writeb call _much_ clearer ... Either switch back to that,
> or create a new mtk_disk_mask_byte function maybe?

I'll fix it next version.

> 
> >
> > -       mtk_dsi_mask(dsi, DSI_CMDQ0, cmdq_mask, reg_val);
> > +       mtk_dsi_mask(dsi, reg_cmdq_off, cmdq_mask, reg_val);
> 
> You're removing DSI_CMDQ0 usage in this patch, so remove the #define
> in this patch too (instead of doing that in 3/3).

I'll fix it next version.
> 
> >         mtk_dsi_mask(dsi, DSI_CMDQ_SIZE, CMDQ_SIZE, cmdq_size);
> >  }
> >
> > @@ -1074,10 +1082,27 @@ static const struct component_ops mtk_dsi_component_ops = {
> >         .unbind = mtk_dsi_unbind,
> >  };
> >
> > +static const struct mtk_dsi_driver_data mt8173_dsi_driver_data = {
> > +       .reg_cmdq_off = 0x200,
> > +};
> > +
> > +static const struct mtk_dsi_driver_data mt2701_dsi_driver_data = {
> > +       .reg_cmdq_off = 0x180,
> > +};
> > +
> > +static const struct of_device_id mtk_dsi_of_match[] = {
> > +       { .compatible = "mediatek,mt2701-dsi",
> > +         .data = &mt2701_dsi_driver_data },
> > +       { .compatible = "mediatek,mt8173-dsi",
> > +         .data = &mt8173_dsi_driver_data },
> > +       { },
> > +};
> > +
> >  static int mtk_dsi_probe(struct platform_device *pdev)
> >  {
> >         struct mtk_dsi *dsi;
> >         struct device *dev = &pdev->dev;
> > +       const struct of_device_id *of_id;
> >         struct resource *regs;
> >         int irq_num;
> >         int comp_id;
> > @@ -1101,6 +1126,10 @@ static int mtk_dsi_probe(struct platform_device *pdev)
> >         if (ret)
> >                 goto err_unregister_host;
> >
> > +       of_id = of_match_device(mtk_dsi_of_match, &pdev->dev);
> > +       dsi->driver_data = (struct mtk_dsi_driver_data *)
> > +                           of_id->data;
> 
> This fits in 80 chars. Also, of_id->data is a void*, so no cast needed.

I'll fix it next version.

> 
> > +
> >         dsi->engine_clk = devm_clk_get(dev, "engine");
> >         if (IS_ERR(dsi->engine_clk)) {
> >                 ret = PTR_ERR(dsi->engine_clk);
> > @@ -1194,12 +1223,6 @@ static int mtk_dsi_remove(struct platform_device *pdev)
> >         return 0;
> >  }
> >
> > -static const struct of_device_id mtk_dsi_of_match[] = {
> > -       { .compatible = "mediatek,mt2701-dsi" },
> > -       { .compatible = "mediatek,mt8173-dsi" },
> > -       { },
> > -};
> 
> Any reason you moved this up?

of_match_device is called by mtk_dsi_probe.

Best regards
Jitao
> 
> > -
> >  struct platform_driver mtk_dsi_driver = {
> >         .probe = mtk_dsi_probe,
> >         .remove = mtk_dsi_remove,
> > --
> > 2.20.1
> >



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
