Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC907C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:48:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B641C21929
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M3ZsIjHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B641C21929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Je2rGCk4BNdLghhpua2f6lgCJ1Nysuw2df4igWiR9D0=; b=M3ZsIjHiThM2/D
	X7uAgYgIwZp8X2zxLkF8bjC5tTeYfC3R7aq3uBOLL2eePIp4JMBLIgHqme1InlJegPZjz51H332Gc
	pcYkahHB8ilKzcx2RB7232nvYeYtaZhAh1yyHYQXxYJ7uNe9xcpYvY2kw16WQlcfso4dpjps2MiOt
	7AB9AYIsP6/+9AgCdT7/sWHdtjkVHZdGZfZLL8kz1dvQ97nAnqSeXaM76viD76CQX2iQN55aCSxSR
	5f/igOCxxm62pTzjhx9MkKAXdEwMysjAEgCxyEFJZWGkLj5NAtWuKErlhzAjmWV36rRVWfHN96CMQ
	vPk2plf5hc+gnz46ANRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvNk2-0005tm-71; Sun, 17 Feb 2019 14:48:26 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvNjy-0005sr-Hm; Sun, 17 Feb 2019 14:48:23 +0000
X-UUID: 37d7dbce732a41b6a5dd7a146960ceee-20190217
X-UUID: 37d7dbce732a41b6a5dd7a146960ceee-20190217
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <jitao.shi@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1295072162; Sun, 17 Feb 2019 06:48:18 -0800
Received: from MTKMBS33DR.mediatek.inc (172.27.6.106) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 17 Feb 2019 06:48:17 -0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Sun, 17 Feb 2019 22:48:14 +0800
Received: from [10.16.6.141] (10.16.6.141) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 17 Feb 2019 22:48:13 +0800
Message-ID: <1550414892.5194.17.camel@mszsdaap41>
Subject: Re: [PATCH 3/3] drm/mediatek: add mt8183 dsi driver support
From: Jitao Shi <jitao.shi@mediatek.com>
To: Nicolas Boichat <drinkcat@chromium.org>
Date: Sun, 17 Feb 2019 22:48:12 +0800
In-Reply-To: <CANMq1KBR-CpjAtj6qTEjK8PA2DUW3w_-OP_EyE7uoaojGLoGLg@mail.gmail.com>
References: <20190214044243.129920-1-jitao.shi@mediatek.com>
 <20190214044243.129920-3-jitao.shi@mediatek.com>
 <CANMq1KBR-CpjAtj6qTEjK8PA2DUW3w_-OP_EyE7uoaojGLoGLg@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_064822_592912_31B1CDF0 
X-CRM114-Status: GOOD (  21.15  )
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

On Thu, 2019-02-14 at 13:54 +0800, Nicolas Boichat wrote:
> On Thu, Feb 14, 2019 at 12:43 PM Jitao Shi <jitao.shi@mediatek.com> wrote:
> >
> > MT8183 dsi has two changes with mt8173.
> > 1. Add the register double buffer control, but we no need it, So make
> >    it default off.
> 
> Can you describe a little bit more what this is about? That's shadow
> registers, right?
> 

Yes, it is shadow registers.

Jitao

> > 2. Add picture size control.
> >
> > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dsi.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > index 80db02a25cb0..20cb53f05d42 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > @@ -78,6 +78,7 @@
> >  #define DSI_VBP_NL             0x24
> >  #define DSI_VFP_NL             0x28
> >  #define DSI_VACT_NL            0x2C
> > +#define DSI_SIZE_CON           0x38
> >  #define DSI_HSA_WC             0x50
> >  #define DSI_HBP_WC             0x54
> >  #define DSI_HFP_WC             0x58
> > @@ -131,7 +132,10 @@
> >  #define VM_CMD_EN                      BIT(0)
> >  #define TS_VFP_EN                      BIT(5)
> >
> > -#define DSI_CMDQ0              0x180
> 
> As I said earlier, move this to 2/3.
> 

Thank for you review.
I'll move it to 2/3 next version.

Best Regards
Jitao

> > +#define DSI_SHADOW_DEBUG       0x190U
> > +#define FORCE_COMMIT           BIT(0)
> > +#define BYPASS_SHADOW          BIT(1)
> > +
> >  #define CONFIG                         (0xff << 0)
> >  #define SHORT_PACKET                   0
> >  #define LONG_PACKET                    2
> > @@ -158,6 +162,7 @@ struct phy;
> >
> >  struct mtk_dsi_driver_data {
> >         const u32 reg_cmdq_off;
> > +       bool has_size_ctl;
> >  };
> >
> >  struct mtk_dsi {
> > @@ -426,6 +431,9 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
> >         writel(vm->vfront_porch, dsi->regs + DSI_VFP_NL);
> >         writel(vm->vactive, dsi->regs + DSI_VACT_NL);
> >
> > +       if (dsi->driver_data->has_size_ctl)
> > +               writel(vm->vactive << 16 | vm->hactive, dsi->regs + DSI_SIZE_CON);
> > +
> >         horizontal_sync_active_byte = (vm->hsync_len * dsi_tmp_buf_bpp - 10);
> >
> >         if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
> > @@ -595,6 +603,9 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
> >         }
> >
> >         mtk_dsi_enable(dsi);
> > +
> > +       /* DSI no need this double buffer, disable it when writing register */
> 
> "DSI does not need double buffering, disable it when writing register"
> 

I'll fix it next version.


> > +       writel(FORCE_COMMIT | BYPASS_SHADOW, dsi->regs + DSI_SHADOW_DEBUG);
> 
> So you do this on all MT* variants, is that ok?
> 
> >         mtk_dsi_reset_engine(dsi);
> >         mtk_dsi_phy_timconfig(dsi);
> >
> > @@ -1090,11 +1101,18 @@ static const struct mtk_dsi_driver_data mt2701_dsi_driver_data = {
> >         .reg_cmdq_off = 0x180,
> >  };
> >
> > +static const struct mtk_dsi_driver_data mt8183_dsi_driver_data = {
> > +       .reg_cmdq_off = 0x200,
> > +       .has_size_ctl = true,
> > +};
> > +
> >  static const struct of_device_id mtk_dsi_of_match[] = {
> >         { .compatible = "mediatek,mt2701-dsi",
> >           .data = &mt2701_dsi_driver_data },
> >         { .compatible = "mediatek,mt8173-dsi",
> >           .data = &mt8173_dsi_driver_data },
> > +       { .compatible = "mediatek,mt8183-dsi",
> > +         .data = &mt8183_dsi_driver_data },
> >         { },
> >  };
> >
> > --
> > 2.20.1
> >



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
