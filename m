Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BDBC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:59:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B5D12081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CgQNbJHv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CjwTCiI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B5D12081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D0jn69RRaJLN1Imuc3vMCeqawl6+7T07SO0BahycEWQ=; b=CgQNbJHvGqA8dB
	1WDm1vbb8CUT5jdpGgcsAmhe67vBYVb4wEQWRdpyKpMxn0WN9x8jxzftTxs5K3awO84KsYiW6TXSF
	BV6zV+TCJaj4aQBsmIwS2bLg04BZeWTvwr6KCx9BFahpi1ZES8nYOQc0gGUM6azZzCWGQXSPGth6V
	vrR1MWEs1Qo0hNh+oHbJXaQ11eY2OBl+mfjsoijnE3CvFS6omRCvSPq+lLEH8mAGO92B5NqmLcAtG
	wXO/J1vm9gkiPnfA2VLoUTPUc2ughk2IQRQuzLDulJpdywz2r+aSLBaAxBPbt3EDCC1UzwtLd4GGK
	6lnASFA15jIifAs2JCqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqb2d-0001N7-1k; Mon, 04 Feb 2019 09:59:51 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqb2Z-0001LT-AJ
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 09:59:48 +0000
Received: by mail-wr1-x443.google.com with SMTP id s12so13674948wrt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 01:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aeI2DtFyd3cY+jY1489HFbl0luQvdWGB6TJ7lBabdo0=;
 b=CjwTCiI8T4M3Hz/dfytA4ZuN726PaIpQZTJy2Xq/FvGNqvtthG1FC+Oe24vxhrffkb
 0wnNg1uPr3xSmRnTtrxaWp/kry6Qp6IIyqY3tWdsEAG8MUW9KS4geftLJqWAgMJlnuB+
 Tw4XXVnRU7rtNXfMp/YB0jiKOGeUMB5EpxY4b8f/oASH6lfeHTGA98eNJ4PjgfeweNL3
 5k24J2MjXHaz+lEzkqN6jSpZkFhUZspCP0IsvkiNHPqi849m7XGHjqvIZ8Ky5onoozdC
 OSr2HlfcTamOyLdhYf5fGt8PHwK7yUwVRL4N+alXI3IxPwhcZvY/ybEcntcBpEaT4Nce
 M72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aeI2DtFyd3cY+jY1489HFbl0luQvdWGB6TJ7lBabdo0=;
 b=ZcDxpF9s+gof5JSw91lHs7vdaXfVB67/hKdpA4UIYQODYfYQ5yaN5/guX1rtKj4DXb
 moKJYGaVQ4FwToblQhoVT92PFo6mQFZAO1mWE/IPEqH4td5wN69wXwCvYKgGDrbE6EhS
 imu1y+Ex+lOE/4iTVvHr5cksqiFbsiJTKOOx5tqbh1PHLJWCYEwwP1VZ5XQIVuetu3TJ
 YJxqx6RQ0TUDmeETGzIPvE+RVZQTCgr6A1r/eH91x69mXBXOuOh3+9M2C+d1OCRHQi/C
 mCU2/1SFcv6yy+08kagLRaD5OmpSb2fwh3heywqRf93DvGYB93BIlODHU0VUnzhcHEYC
 /21Q==
X-Gm-Message-State: AJcUukc/PTudDAMUqR1UkZPdVWyLqaD/Fl2fEQAPNXZMbEyyF0xEcYdQ
 Z0M11j+DQDC0gBGjAPLjT/64VD6OYJQ/P+jS40dwZA==
X-Google-Smtp-Source: ALg8bN7lHMO6Hlgap21U4xcnbHcWEtLdg+eW0yH5Qmwtj7w62V9elNN46ayTwvt2/0GSaE1FI0Z1QIqG1JP7CaHzTno=
X-Received: by 2002:adf:ef0d:: with SMTP id e13mr47728456wro.29.1549274385281; 
 Mon, 04 Feb 2019 01:59:45 -0800 (PST)
MIME-Version: 1.0
References: <20190204094937.22763-1-narmstrong@baylibre.com>
In-Reply-To: <20190204094937.22763-1-narmstrong@baylibre.com>
From: Maxime Jourdan <mjourdan@baylibre.com>
Date: Mon, 4 Feb 2019 10:59:34 +0100
Message-ID: <CAMO6nawKrH3d2X=TikdJy8yjiPyuJJRnpaBjyfPYuRx3d=7vVA@mail.gmail.com>
Subject: Re: [PATCH] soc: amlogic: canvas: Fix meson_canvas_get when probe
 failed
To: Neil Armstrong <narmstrong@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_015947_356544_7A7776E6 
X-CRM114-Status: GOOD (  18.94  )
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
Cc: Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Neil,
On Mon, Feb 4, 2019 at 10:49 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> When probe fails, a platforn_device is still associated to the node,
> but dev_get_drvdata() returns NULL.
>
> Handle this case by returning a consistent error.
>
> Fixes: d4983983d987 ("soc: amlogic: add meson-canvas driver")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/soc/amlogic/meson-canvas.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> This fix depends on "soc: amlogic: add missing of_node_put()" at [1]
>
> [1] https://patchwork.kernel.org/patch/10794545/
>
> diff --git a/drivers/soc/amlogic/meson-canvas.c b/drivers/soc/amlogic/meson-canvas.c
> index 87a6c6e23591..151aa84bc593 100644
> --- a/drivers/soc/amlogic/meson-canvas.c
> +++ b/drivers/soc/amlogic/meson-canvas.c
> @@ -51,6 +51,7 @@ struct meson_canvas *meson_canvas_get(struct device *dev)
>  {
>         struct device_node *canvas_node;
>         struct platform_device *canvas_pdev;
> +       struct meson_canvas *canvas;
>
>         canvas_node = of_parse_phandle(dev->of_node, "amlogic,canvas", 0);
>         if (!canvas_node)
> @@ -63,7 +64,17 @@ struct meson_canvas *meson_canvas_get(struct device *dev)
>         }
>
>         of_node_put(canvas_node);
> -       return dev_get_drvdata(&canvas_pdev->dev);
> +
> +       /*
> +        * If priv is NULL, it's probably because the canvas hasn't
> +        * properly initialized. Bait out with -EINVAL because, in the

Bait -> Bail ?

> +        * current state, this driver probe cannot return -EPROBE_DEFER
> +        */
> +       canvas = dev_get_drvdata(&canvas_pdev->dev);
> +       if (!canvas)
> +               return ERR_PTR(-EINVAL);
> +
> +       return canvas;
>  }
>  EXPORT_SYMBOL_GPL(meson_canvas_get);
>
> --
> 2.20.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Thanks for the patch, I missed the fact that a driver could have a
pdev yet with a failed probe.

Reviewed-by: Maxime Jourdan <mjourdan@baylibre.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
