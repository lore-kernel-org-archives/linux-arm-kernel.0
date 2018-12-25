Return-Path: <SRS0=E6tZ=PC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8317AC64E75
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 03:57:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5185720882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 03:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o7HcGgjI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HLPkITwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5185720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4gzD5KvBBZ5NaEJSFF9vhsmORqbV+4nR5NEGnBH2o6Q=; b=o7HcGgjIeyNN76
	8vsR2PWBT4fIE82qJ17jg3E5ryrAzT8RpP8gLNIAL5Gq1kTZFIq90EaMgxBu2GcyBoUZRXiJ2ikzM
	4khe6MnpdzQyxwY9ljxQuJLyyQIfYqlc6djRBfyX4CN9uUpnaZmVryatohBAfZkOtszFsj2YsJZ8C
	6ukSTJAmKAUToM/iKGUSF/dpWxRL/Usg4OuQUPEY/5yVos5dWFoY+C9Olx3d3ZrgLpncpJWQRkiz9
	v+yK0/lp2WVJAvmvYyDtLSyXQg8oTOr2WbjKMudcI0h4ZYByJAgRM0Ke5AOz4FpUiPjIG9wTmXUit
	yWU3SP9rHjFTVgzWIO7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbdqU-0008Va-8x; Tue, 25 Dec 2018 03:57:30 +0000
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbdqO-0008UF-EJ
 for linux-arm-kernel@lists.infradead.org; Tue, 25 Dec 2018 03:57:28 +0000
Received: by mail-qt1-x841.google.com with SMTP id p17so14334194qtl.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 24 Dec 2018 19:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=s5geiLs7kDycDhYNSL4q6vv2w/JxPB7NmvJkyHK8CYI=;
 b=HLPkITwjGl65iN8oUZFeOk3xzKurwM1QYWPHXLL+nDaL/SJ5hYTsGF3zJvv+ie6iOp
 hFylEVic3usbaWQ1r+5l53cioUWAXF6ql/rWeXdjX7PQ59MZ/vuEf8Yvnqab6gDdjOyO
 MJIa7MGBdrhfrPo4mAOxTijLmzElfVtK++NiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s5geiLs7kDycDhYNSL4q6vv2w/JxPB7NmvJkyHK8CYI=;
 b=KZrodiLPgjWbnF8qNMn7B5tgaEOqTqV5HMhVMegbP8JM4xZQl1QwRU7EgLGhvjhsf+
 iL+loECvOzEN+63xud/E863OqlWzMhJJvJ8Qvk2ZfEsXL474+1mBeylOuJgVf5tUrRcU
 aRZ6QslChCGjp/wjo0TQ67mM+uMzWoTl1VpSXG2SJ9d1XeZoa7kc9jV2/Cjy29+LJk6A
 icvc5191FJj2wrrE7O3ty47kvTTRrEE0pnoCUS7NLC5itFG4QyeQpnwvzxD87YgVTUnH
 gVYys4F05p5QXFNqIKzz9GSBO93HP5HC9PVoPt404iGZMg7L415uXnoV3/5VUEcdtZnm
 r9Ng==
X-Gm-Message-State: AJcUukdQd4SqrgCPzwOuA7u9NdGpenyBRWGB2DJOmBjX75qMA93NoVr4
 FI7km9TiRCzW5ofzeZSHZvektenVXhHV9zvM4eVtJQ==
X-Google-Smtp-Source: ALg8bN6xgg47waxonnNSsErsFKqVr/MYeuvZGLAnjipVbD1FgXDfc5ueGpw0WOyMZbfxMhx//31nZiKbw9UC4+Mbwos=
X-Received: by 2002:a0c:d0d7:: with SMTP id b23mr14050872qvh.67.1545710231259; 
 Mon, 24 Dec 2018 19:57:11 -0800 (PST)
MIME-Version: 1.0
References: <1545638931-24938-1-git-send-email-yongqiang.niu@mediatek.com>
 <1545638931-24938-4-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1545638931-24938-4-git-send-email-yongqiang.niu@mediatek.com>
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Tue, 25 Dec 2018 11:57:00 +0800
Message-ID: <CANMq1KBTN61hmWy2K+rrx3NL0eR7AXhFQBkCpcHu5nhUw_6xjw@mail.gmail.com>
Subject: Re: [PATCH 03/18] drm/mediatek: redefine mtk_ddp_sout_sel
To: Yongqiang Niu <yongqiang.niu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_195724_478515_D745BB30 
X-CRM114-Status: GOOD (  19.13  )
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
 David Airlie <airlied@linux.ie>, lkml <linux-kernel@vger.kernel.org>,
 dri-devel@lists.freedesktop.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Philipp Zabel <p.zabel@pengutronix.de>, CK Hu <ck.hu@mediatek.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 24, 2018 at 6:52 PM Yongqiang Niu
<yongqiang.niu@mediatek.com> wrote:
>
> This patch redefine mtk_ddp_sout_sel

Can you describe a bit more why you are making this change?

> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index adb37e4..592f852 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -405,21 +405,27 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
>         return value;
>  }
>
> -static void mtk_ddp_sout_sel(void __iomem *config_regs,
> -                            enum mtk_ddp_comp_id cur,
> -                            enum mtk_ddp_comp_id next)
> +static unsigned int mtk_ddp_sout_sel(void __iomem *config_regs,

You don't use config_regs anymore, drop it.

> +                                    enum mtk_ddp_comp_id cur,
> +                                    enum mtk_ddp_comp_id next,
> +                                    unsigned int *addr)
>  {
> +       unsigned int value;
> +
>         if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0) {
> -               writel_relaxed(BLS_TO_DSI_RDMA1_TO_DPI1,
> -                              config_regs + DISP_REG_CONFIG_OUT_SEL);
> +               *addr = DISP_REG_CONFIG_OUT_SEL;
> +               value = BLS_TO_DSI_RDMA1_TO_DPI1;

You can directly return BLS_TO_DSI_RDMA1_TO_DPI1.

>         } else if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DPI0) {
> -               writel_relaxed(BLS_TO_DPI_RDMA1_TO_DSI,
> -                              config_regs + DISP_REG_CONFIG_OUT_SEL);
> -               writel_relaxed(DSI_SEL_IN_RDMA,
> -                              config_regs + DISP_REG_CONFIG_DSI_SEL);
> -               writel_relaxed(DPI_SEL_IN_BLS,
> -                              config_regs + DISP_REG_CONFIG_DPI_SEL);
> +               *addr = DISP_REG_CONFIG_OUT_SEL;
> +               value = BLS_TO_DPI_RDMA1_TO_DSI;

I (kind of) understand the change above, as you still end up writing
BLS_TO_DSI_RDMA1_TO_DPI1 in DISP_REG_CONFIG_OUT_SEL.

This changes the behaviour, as now you only write
BLS_TO_DPI_RDMA1_TO_DSI to DISP_REG_CONFIG_OUT_SEL, but the previous
revision of the code would also write to DISP_REG_CONFIG_DSI_SEL and
DISP_REG_CONFIG_DPI_SEL. Why?

> +       } else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI0) {
> +               *addr = DISP_REG_CONFIG_DSI_SEL;
> +               value = DSI_SEL_IN_RDMA;
> +       } else {
> +               value = 0;
>         }
> +
> +       return value;
>  }
>
>  void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
> @@ -434,7 +440,9 @@ void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
>                 writel_relaxed(reg, config_regs + addr);
>         }
>
> -       mtk_ddp_sout_sel(config_regs, cur, next);
> +       value = mtk_ddp_sout_sel(cur, next, &addr);
> +       if (value)
> +               writel_relaxed(value, config_regs + addr);

Why this change? I don't see mtk_ddp_sout_sel being used later in the
series, so I'm not sure why we don't directly write the value into the
register.



>         value = mtk_ddp_sel_in(cur, next, &addr);
>         if (value) {
> --
> 1.8.1.1.dirty
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
