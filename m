Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732D1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 05:48:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 424EB222A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 05:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BQ7EDNPv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VIDT/RpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424EB222A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3AeVrjPtFLybZQBu7H+ait9cjZfAOkTbNDkJnm6YSrA=; b=BQ7EDNPva+X8j6
	ysw8O7EAKDVXkCTX+glBEwGKgydZooeEg5/l2p+hQLRWeb+KRibb28vc2AIn/btgAcWbc1299qz34
	3MHFwcWQfn4ZzYXrFQIViTOIylVDpn69tr7nmuUCggaYC1ti95/e2B77I3dQDtUvRUnauPovDxsIU
	ZrFIBQ3Gv750WDLD22qNlcJUoqunbh8bUT2xz5zMKYjqEz2tX6yo2ufQD1VijhqSt4Z/pSnfntJMX
	ioYV32R237qXYpabz4dI6BRotR5ev+kVl4/596m/in1OwX4Ue21h5R6zzX3az/oHOSP2LSUunhkm5
	ONZ5F4WDfzAoeMGt/t5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu9t1-0007UY-Q3; Thu, 14 Feb 2019 05:48:39 +0000
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu9sx-0007RI-Nl
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 05:48:37 +0000
Received: by mail-qt1-x841.google.com with SMTP id y4so5573518qtc.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 21:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fXXN+zBH7ya8AtNFt4E26NRGi0gZRs0b5mumGwT/hcw=;
 b=VIDT/RpYJfOYxfktW+XoCEI83+hJWm1DoZeyH0P/aw85e/jhCEsaqcxWbgW8o+xmWe
 L5ztVbm+bnZt8pLAia/lH285ZuPW3jhC6zyOCNjq2/2fDInVdKFFIudwUwm8Fwcjou1L
 2kK1WNvNzeMuzFPlBQchdBpXT9PIu50oZUk8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fXXN+zBH7ya8AtNFt4E26NRGi0gZRs0b5mumGwT/hcw=;
 b=IHvcIHfzwRDMByQrPt8jDsUnXSXRh42A889Nw1r5vh3VyZeMuGzaZ0SxPzdcCgVbuk
 77+WenPSBZ/ssQYWKlFGp3AMHdkU8Nq8ihs7IAksfuGgP8TDEikCn11NWUHCZy22Mh7J
 P9O86xkZCJtCmZ3N1gxVghsGLAXHZxGAts+4yvwfKapICBGKXiXB3MMduFwT/Iva6Lfr
 RKEsK+CTNnbNMPT7vn/KiKU1fQD3dPbANRvHHKucceJ0nK75ed1r/3US4K0Btc0A97rk
 nrQnTOoYLpWQLzfoV0J4W73uLdQEfA+33HLIOoqOAJJuIsum2MC0xijPMMfECxLTvvKL
 qXtg==
X-Gm-Message-State: AHQUAuaBX1gMfrzK1jjzrlnwO2k2ozyQP7ZysN6NSMeMHzDeyx9paKvr
 danC3kqqrtiFoENQyphbpdGsquxh5InYvNjyaUK79g==
X-Google-Smtp-Source: AHgI3Iakm5n4cPRUkjKVkKeyqiJeOKC/OiiOo0qoewgbj5eveM2fZw+lnLAVoxSRMmirXgDe4cfMAgoKwh1VP0iHQK0=
X-Received: by 2002:a0c:8425:: with SMTP id l34mr1562175qva.101.1550123313824; 
 Wed, 13 Feb 2019 21:48:33 -0800 (PST)
MIME-Version: 1.0
References: <20190214044243.129920-1-jitao.shi@mediatek.com>
 <20190214044243.129920-2-jitao.shi@mediatek.com>
In-Reply-To: <20190214044243.129920-2-jitao.shi@mediatek.com>
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Thu, 14 Feb 2019 13:48:22 +0800
Message-ID: <CANMq1KAua2mEfT81Mos5JyxHwUfVmgi5Se3fTPy9QcXyh23Urg@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/mediatek: CMDQ reg address of mt8173 is different
 with mt2701
To: Jitao Shi <jitao.shi@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_214835_821748_BBF3C9B6 
X-CRM114-Status: GOOD (  22.00  )
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
 dri-devel@lists.freedesktop.org, Yingjoe Chen <yingjoe.chen@mediatek.com>,
 Ajay Kumar <ajaykumar.rs@samsung.com>, Vincent Palatin <vpalatin@chromium.org>,
 cawa cheng <cawa.cheng@mediatek.com>,
 =?UTF-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <bibby.hsieh@mediatek.com>,
 CK HU <ck.hu@mediatek.com>, Russell King <rmk+kernel@arm.linux.org.uk>,
 Thierry Reding <treding@nvidia.com>, linux-pwm@vger.kernel.org,
 Sascha Hauer <kernel@pengutronix.de>, Pawel Moll <pawel.moll@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>, Inki Dae <inki.dae@samsung.com>,
 Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Andy Yan <andy.yan@rock-chips.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Eddie Huang <eddie.huang@mediatek.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 Rahul Sharma <rahul.sharma@samsung.com>, srv_heupstream@mediatek.com,
 lkml <linux-kernel@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Kumar Gala <galak@codeaurora.org>, Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 12:42 PM Jitao Shi <jitao.shi@mediatek.com> wrote:
>
> Config the different CMDQ reg address in driver data.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 39 ++++++++++++++++++++++++------
>  1 file changed, 31 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 93fa255b4aad..80db02a25cb0 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -156,6 +156,10 @@
>
>  struct phy;
>
> +struct mtk_dsi_driver_data {
> +       const u32 reg_cmdq_off;
> +};
> +
>  struct mtk_dsi {
>         struct mtk_ddp_comp ddp_comp;
>         struct device *dev;
> @@ -182,6 +186,7 @@ struct mtk_dsi {
>         bool enabled;
>         u32 irq_data;
>         wait_queue_head_t irq_wait_queue;
> +       struct mtk_dsi_driver_data *driver_data;
>  };
>
>  static inline struct mtk_dsi *encoder_to_dsi(struct drm_encoder *e)
> @@ -934,6 +939,7 @@ static void mtk_dsi_cmdq(struct mtk_dsi *dsi, const struct mipi_dsi_msg *msg)
>         const char *tx_buf = msg->tx_buf;
>         u8 config, cmdq_size, cmdq_off, type = msg->type;
>         u32 reg_val, cmdq_mask, i;
> +       u32 reg_cmdq_off = dsi->driver_data->reg_cmdq_off;
>
>         if (MTK_DSI_HOST_IS_READ(type))
>                 config = BTA;
> @@ -953,9 +959,11 @@ static void mtk_dsi_cmdq(struct mtk_dsi *dsi, const struct mipi_dsi_msg *msg)
>         }
>
>         for (i = 0; i < msg->tx_len; i++)
> -               writeb(tx_buf[i], dsi->regs + DSI_CMDQ0 + cmdq_off + i);
> +               mtk_dsi_mask(dsi, (reg_cmdq_off + cmdq_off + i) & (~0x3U),
> +                            (0xffUL << (((i + cmdq_off) & 3U) * 8U)),
> +                            tx_buf[i] << (((i + cmdq_off) & 3U) * 8U));

I found the writeb call _much_ clearer ... Either switch back to that,
or create a new mtk_disk_mask_byte function maybe?

>
> -       mtk_dsi_mask(dsi, DSI_CMDQ0, cmdq_mask, reg_val);
> +       mtk_dsi_mask(dsi, reg_cmdq_off, cmdq_mask, reg_val);

You're removing DSI_CMDQ0 usage in this patch, so remove the #define
in this patch too (instead of doing that in 3/3).

>         mtk_dsi_mask(dsi, DSI_CMDQ_SIZE, CMDQ_SIZE, cmdq_size);
>  }
>
> @@ -1074,10 +1082,27 @@ static const struct component_ops mtk_dsi_component_ops = {
>         .unbind = mtk_dsi_unbind,
>  };
>
> +static const struct mtk_dsi_driver_data mt8173_dsi_driver_data = {
> +       .reg_cmdq_off = 0x200,
> +};
> +
> +static const struct mtk_dsi_driver_data mt2701_dsi_driver_data = {
> +       .reg_cmdq_off = 0x180,
> +};
> +
> +static const struct of_device_id mtk_dsi_of_match[] = {
> +       { .compatible = "mediatek,mt2701-dsi",
> +         .data = &mt2701_dsi_driver_data },
> +       { .compatible = "mediatek,mt8173-dsi",
> +         .data = &mt8173_dsi_driver_data },
> +       { },
> +};
> +
>  static int mtk_dsi_probe(struct platform_device *pdev)
>  {
>         struct mtk_dsi *dsi;
>         struct device *dev = &pdev->dev;
> +       const struct of_device_id *of_id;
>         struct resource *regs;
>         int irq_num;
>         int comp_id;
> @@ -1101,6 +1126,10 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>         if (ret)
>                 goto err_unregister_host;
>
> +       of_id = of_match_device(mtk_dsi_of_match, &pdev->dev);
> +       dsi->driver_data = (struct mtk_dsi_driver_data *)
> +                           of_id->data;

This fits in 80 chars. Also, of_id->data is a void*, so no cast needed.

> +
>         dsi->engine_clk = devm_clk_get(dev, "engine");
>         if (IS_ERR(dsi->engine_clk)) {
>                 ret = PTR_ERR(dsi->engine_clk);
> @@ -1194,12 +1223,6 @@ static int mtk_dsi_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> -static const struct of_device_id mtk_dsi_of_match[] = {
> -       { .compatible = "mediatek,mt2701-dsi" },
> -       { .compatible = "mediatek,mt8173-dsi" },
> -       { },
> -};

Any reason you moved this up?

> -
>  struct platform_driver mtk_dsi_driver = {
>         .probe = mtk_dsi_probe,
>         .remove = mtk_dsi_remove,
> --
> 2.20.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
