Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC76C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 05:55:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B8E7222A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 05:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tmNEypHZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JXMwGF6s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8E7222A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NrTdZruqFqrrXjhoWA+0PpJ16ZkLF7ITKAjHnx7Vn/E=; b=tmNEypHZDc2n8f
	WR27oLNq8chme5WMuvaj4JCbQZQleRis2nbJXGTbqZFU5aYoopL8gg+zCmqamfAp/52htDY2btJeD
	X3Otsfm9xVgTDPBY7Zk1+eGEylRKUNDX6idut4YWKHSD6FpQ/q64waNJiiOkzZGs4imERQeKCaDs0
	sO9XpIdZnNP+JC35UUKuFoA5RrLN6qDjfySvSVqSESovQAeOBrqj5KB7ib+p5k+NxoNlrr0Gvg0mF
	1jLS870WHrrFHNgdIwQiKboqyiiWgSZbwjLRB5iyqgek/InNGeERq4P5kkcPgpWdNBQ/xdGg73K7I
	SWEscfTgKG8e0RFz0/Yg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu9zB-0000vR-Tt; Thu, 14 Feb 2019 05:55:01 +0000
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu9z7-0000u5-62
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 05:54:58 +0000
Received: by mail-qk1-x741.google.com with SMTP id w204so2945180qka.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 21:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8ZZPTehRx0gCVAGAwGZLdRCyaQhXE0OghMtcZbWUN1k=;
 b=JXMwGF6sgy9y+WcZoNA2AWmObRpexqFbDrMQ/02+r6JQUTug17v90SxKPvh43Sr7wa
 0hHMJEDUNY2SA1ROLXAkc9lPs+Ei3Oqs5uXsXotW9nFwFYglLShE17cEyYFVz77CYfYv
 c71lTWzB4N8yWi0R+J9rta160kzE4DyOq1Zpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8ZZPTehRx0gCVAGAwGZLdRCyaQhXE0OghMtcZbWUN1k=;
 b=eVNuHpLROgRu7ygwG2s9Bnr3wpPIZC/9qIz5WL+r/hKkiXxB22PJ3ylBnhjcQztrrU
 MH4h1DnBaL86UsfyIzyuDIZS/NyO1s0awUchNFbxl+33j10tm0xEkR2YWC9d7DmBRbhn
 031p19B2YssVSfd8Gl8gF35bsAVhqV5ySyK1F1KCv+AdJ+HE7Anw7VafFcbZZDMOA9uO
 vO7ThHKPO6tTWLm+vtesad1MSHUQmIbEVKIE5G3nEXrAoa1hjH6Uv3rMW51T697doSPQ
 UZG4a2bsVcGZcUaFSXaBHBUlHGEzuOTY8zA2O4UNDABvV4rlYvHgZb6OdSx5BqWpcBny
 DClQ==
X-Gm-Message-State: AHQUAuaJNOUdxldVU4j2zMmLNI6VyIQcaibZ6XSy4NHXi6H/EjGusfz1
 O7aS5jXlQm/vT+uK/g1fLlFT+DGxnyo1U2rHP0GW5Q==
X-Google-Smtp-Source: AHgI3IamlS+2WnAogCdsL8ldHcyBN+PQiVASgbQh23/ApFCz870ErGq5WVsz2xgBC5rjuMBV8/5v3d6CFP3v4QEbJq4=
X-Received: by 2002:a37:7885:: with SMTP id t127mr1465362qkc.323.1550123695704; 
 Wed, 13 Feb 2019 21:54:55 -0800 (PST)
MIME-Version: 1.0
References: <20190214044243.129920-1-jitao.shi@mediatek.com>
 <20190214044243.129920-3-jitao.shi@mediatek.com>
In-Reply-To: <20190214044243.129920-3-jitao.shi@mediatek.com>
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Thu, 14 Feb 2019 13:54:44 +0800
Message-ID: <CANMq1KBR-CpjAtj6qTEjK8PA2DUW3w_-OP_EyE7uoaojGLoGLg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/mediatek: add mt8183 dsi driver support
To: Jitao Shi <jitao.shi@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_215457_250985_B378DB48 
X-CRM114-Status: GOOD (  19.31  )
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

On Thu, Feb 14, 2019 at 12:43 PM Jitao Shi <jitao.shi@mediatek.com> wrote:
>
> MT8183 dsi has two changes with mt8173.
> 1. Add the register double buffer control, but we no need it, So make
>    it default off.

Can you describe a little bit more what this is about? That's shadow
registers, right?

> 2. Add picture size control.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 80db02a25cb0..20cb53f05d42 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -78,6 +78,7 @@
>  #define DSI_VBP_NL             0x24
>  #define DSI_VFP_NL             0x28
>  #define DSI_VACT_NL            0x2C
> +#define DSI_SIZE_CON           0x38
>  #define DSI_HSA_WC             0x50
>  #define DSI_HBP_WC             0x54
>  #define DSI_HFP_WC             0x58
> @@ -131,7 +132,10 @@
>  #define VM_CMD_EN                      BIT(0)
>  #define TS_VFP_EN                      BIT(5)
>
> -#define DSI_CMDQ0              0x180

As I said earlier, move this to 2/3.

> +#define DSI_SHADOW_DEBUG       0x190U
> +#define FORCE_COMMIT           BIT(0)
> +#define BYPASS_SHADOW          BIT(1)
> +
>  #define CONFIG                         (0xff << 0)
>  #define SHORT_PACKET                   0
>  #define LONG_PACKET                    2
> @@ -158,6 +162,7 @@ struct phy;
>
>  struct mtk_dsi_driver_data {
>         const u32 reg_cmdq_off;
> +       bool has_size_ctl;
>  };
>
>  struct mtk_dsi {
> @@ -426,6 +431,9 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
>         writel(vm->vfront_porch, dsi->regs + DSI_VFP_NL);
>         writel(vm->vactive, dsi->regs + DSI_VACT_NL);
>
> +       if (dsi->driver_data->has_size_ctl)
> +               writel(vm->vactive << 16 | vm->hactive, dsi->regs + DSI_SIZE_CON);
> +
>         horizontal_sync_active_byte = (vm->hsync_len * dsi_tmp_buf_bpp - 10);
>
>         if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
> @@ -595,6 +603,9 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>         }
>
>         mtk_dsi_enable(dsi);
> +
> +       /* DSI no need this double buffer, disable it when writing register */

"DSI does not need double buffering, disable it when writing register"

> +       writel(FORCE_COMMIT | BYPASS_SHADOW, dsi->regs + DSI_SHADOW_DEBUG);

So you do this on all MT* variants, is that ok?

>         mtk_dsi_reset_engine(dsi);
>         mtk_dsi_phy_timconfig(dsi);
>
> @@ -1090,11 +1101,18 @@ static const struct mtk_dsi_driver_data mt2701_dsi_driver_data = {
>         .reg_cmdq_off = 0x180,
>  };
>
> +static const struct mtk_dsi_driver_data mt8183_dsi_driver_data = {
> +       .reg_cmdq_off = 0x200,
> +       .has_size_ctl = true,
> +};
> +
>  static const struct of_device_id mtk_dsi_of_match[] = {
>         { .compatible = "mediatek,mt2701-dsi",
>           .data = &mt2701_dsi_driver_data },
>         { .compatible = "mediatek,mt8173-dsi",
>           .data = &mt8173_dsi_driver_data },
> +       { .compatible = "mediatek,mt8183-dsi",
> +         .data = &mt8183_dsi_driver_data },
>         { },
>  };
>
> --
> 2.20.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
