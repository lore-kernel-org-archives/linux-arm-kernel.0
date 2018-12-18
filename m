Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA41C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:52:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE774217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Oj8Heqqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE774217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lTzcdVjAOb5XFXMetUhP9fmFnHklteNTgnDKr5k359M=; b=Oj8HeqqbEvEFB0
	0mGK+3vNyWv/C1QULuJPr6KNTjhUx/rx8z8pvTEte3vzkmh9NhVOJVaFA00sjHgJkUo5hp2VagLGg
	nZ1lybOeH+aWPIQI6XyaBdMBgvh57sgRfwzrvGz3JHJYOdRTV60r8yYniyRq0XZeyLsh9hg+zn5sa
	Yz8zhy534H5X0L4HWKz2Hzr917YrV/xeXS9a38Wc7elQDiMMA8/QZq1IGeidUXN1TuE4M6SNc4stT
	4qHXrd/cPz0hSWIBhUNiXXghhA/FidMRUpXklI3hHKrh/kTv26/N4p1ZXsrDjosKKRnRtSHyaVe8p
	ImldcXI6jGYvTNed2wYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZEqy-0001VB-8n; Tue, 18 Dec 2018 12:52:04 +0000
Received: from mail-ed1-f68.google.com ([209.85.208.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZEqq-0001UE-Vc
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 12:52:01 +0000
Received: by mail-ed1-f68.google.com with SMTP id p6so13802382eds.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 04:51:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WTesqBWLGzXLgLUK2oW/629yEumJB85RBemmucZab9A=;
 b=DQTZBaFmc1Tf/YS660T8TB/Xpg33erlytYx98rRUt+mfHIo6D0J5gapkfcTny9c7e7
 HDOBcHgiDehtNOk9L9ZzJH0YLV2T3FEufNo7Y61x0QcylCDutuA1t+2Te/f5r7HQlc3u
 Rk2N0jnUFppAgSnXdNO6eYmZKL2gevG7jGkBT6f8FXKExRYVOmSg/xnNwDVxkhmLOTHq
 rgJv7ab1wxDrgqu3ZfDD8BaIY9q14e5HHxTcNQ2pnAsfrcNpOA5tWYK4KFUdbPfgUfgs
 alZwvyAAcdeNvKkbJMu86lqBgxstK08P2grP+u04DqWH3y4OYHjo/omn7xIvw6LwOU1k
 HMJw==
X-Gm-Message-State: AA+aEWbCH6Ik+9tQSfS1WwzUhT7fFlhfYkk00JAHdHROVamlE3bAXWRp
 eyoKV4xELe8IYKEzbClOTt+bvLJRyN8=
X-Google-Smtp-Source: AFSGD/U0N3L+rQMqioE37UKDSOaubOEPAXRn6xxfQfET94NwYqxfTCQtUaDf7Z2w9+RqJ+ky2i3Ndg==
X-Received: by 2002:a17:906:5c9:: with SMTP id
 t9-v6mr13315619ejt.111.1545137504417; 
 Tue, 18 Dec 2018 04:51:44 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com.
 [209.85.128.44])
 by smtp.gmail.com with ESMTPSA id x47sm4410453eda.91.2018.12.18.04.51.43
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 04:51:44 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id y139so2515766wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 04:51:43 -0800 (PST)
X-Received: by 2002:a1c:f605:: with SMTP id w5mr3237738wmc.116.1545137503603; 
 Tue, 18 Dec 2018 04:51:43 -0800 (PST)
MIME-Version: 1.0
References: <20181218082800.GC440@kadam>
In-Reply-To: <20181218082800.GC440@kadam>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 18 Dec 2018 20:51:32 +0800
X-Gmail-Original-Message-ID: <CAGb2v64NgqCn5Mq3W0SfO0ecFkzBvnn9nJxQtyuFSQc8q5kNQQ@mail.gmail.com>
Message-ID: <CAGb2v64NgqCn5Mq3W0SfO0ecFkzBvnn9nJxQtyuFSQc8q5kNQQ@mail.gmail.com>
Subject: Re: [PATCH] bus: sunxi-rsb: Fix a small memory leak
To: Dan Carpenter <dan.carpenter@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_045200_094046_B9A16869 
X-CRM114-Status: GOOD (  16.62  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Mark Brown <broonie@kernel.org>,
 kernel-janitors@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Tue, Dec 18, 2018 at 4:28 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The problem is in __devm_regmap_init_sunxi_rsb().  If the call to
> __devm_regmap_init() fails, then we leak the "ctx" allocation.

This seems to be the same pattern with regmap implementations that
allocate context data, the other two being:

    - drivers/base/regmap/regmap-mmio.c
    - drivers/bluetooth/btintel.c

(CC-ing Mark) Maybe it's worth fixing in regmap itself?

> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/bus/sunxi-rsb.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
> index 1b76d9585902..5ec25c8164d1 100644
> --- a/drivers/bus/sunxi-rsb.c
> +++ b/drivers/bus/sunxi-rsb.c
> @@ -417,17 +417,9 @@ static int regmap_sunxi_rsb_reg_write(void *context, unsigned int reg,
>         return sunxi_rsb_write(rdev->rsb, rdev->rtaddr, reg, &val, ctx->size);
>  }
>
> -static void regmap_sunxi_rsb_free_ctx(void *context)
> -{
> -       struct sunxi_rsb_ctx *ctx = context;
> -
> -       kfree(ctx);
> -}
> -
>  static struct regmap_bus regmap_sunxi_rsb = {
>         .reg_write = regmap_sunxi_rsb_reg_write,
>         .reg_read = regmap_sunxi_rsb_reg_read,
> -       .free_context = regmap_sunxi_rsb_free_ctx,
>         .reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
>         .val_format_endian_default = REGMAP_ENDIAN_NATIVE,
>  };
> @@ -446,7 +438,7 @@ static struct sunxi_rsb_ctx *regmap_sunxi_rsb_init_ctx(struct sunxi_rsb_device *
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +       ctx = devm_kzalloc(&rdev->dev, sizeof(*ctx), GFP_KERNEL);

This decouples the lifetime of ctx from the regmap itself. IMO it
would be better to check the return value of __devm_regmap_init()
and act accordingly instead.

ChenYu

>         if (!ctx)
>                 return ERR_PTR(-ENOMEM);
>
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
