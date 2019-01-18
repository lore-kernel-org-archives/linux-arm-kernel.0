Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DE5C07EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:59:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0740C20896
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tqmh3DQS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GTAvFPi0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0740C20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mrrQhOkpSWdcvC5PvoQqap9TywQG3kion48rK2FuYGQ=; b=Tqmh3DQSZk+npa
	x/IVosubSbQm3Vd+MCZ95QkzNTXoDa1D7cf/M6yYKz2vK3NWfEzV3pLPNVLiDD5UEo7yaiRM8b3IG
	7AuQOgE3BugGAGrrk7+NPX9Dfl8LZEPOx0D0rhbkY93lx02pu0t+CzwKMxs7YZTRZqPZ+gmMKmgL0
	pzbzDE0moU2qa0zr4HywIKFuk2yCNbOe1bBUKVAFv4rRspuBkZsomPNCqNt4GRQ7RHk2Vl90DfX84
	wzVLG5d0SlIloY+stmvp6Arw1SYavCytJGW8s4fVjjCZ1246qK/PumdW/W0aDa0N2pgU2SjQ6Hiwd
	DPncs67O0iViw69MtLog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkYQ2-00038z-TW; Fri, 18 Jan 2019 17:59:02 +0000
Received: from mail-ua1-x941.google.com ([2607:f8b0:4864:20::941])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkYPs-0002wt-Fz
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 17:58:59 +0000
Received: by mail-ua1-x941.google.com with SMTP id t8so4981472uap.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 09:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bbCm6Mjj+UOtI0js0KK3dAUMBdnMCn4ezggwRW382+A=;
 b=GTAvFPi0ABVBqlEqD+0tLwUNpHh+hRPu/bBtIH2iMnc6AuTFMqNT6ObwbTHVnvWnK9
 RV5X4xZ6OgzTcAOOvRAsR/0wU3IS31Q/XKNvMBcP40bM4m71a0HYqsu86iW5y6w24F3Q
 9QEhpF6KtOCZgkSKune1Jb+APVU1/5ycTrcAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bbCm6Mjj+UOtI0js0KK3dAUMBdnMCn4ezggwRW382+A=;
 b=adC09NFrtNKFR1BUFW5hBWGorutiJhA39ZWVVKweSvSe3szn4FLB2GeVoPWA4I3J5P
 pQqGd6yhdiyyTIRSCIihDhhVKgmDs0YtrOphPLTSE6XAXpy/g1NQY+ux5dO7I2hWFHPz
 4S7CBZ1XMnXQgE0uvrkbn/4xb1bT9zhgzk9ytGl2gq5kMRn03EjhSusjLrSQrxkl2qnw
 AOgznqiWxARN6DnHGrE2EPYRM+rTFgflKw8Y27ZLDwFKJxXyA5r9WXtoXFKxh3/28zFN
 Iqwhk5xdXeVutbEnTkFcfcNSBexzgTo33w1GD3UYavFgTcuauP9c3YqpLx8xZ5aUOl1W
 jvJw==
X-Gm-Message-State: AJcUukcsoDhvUWWQPamfRuky3F74QpZcmjYxO2p9ol1qJH8GdZzIhuFA
 /DqYpvIpdsdMIUcSY0bgs0/jNFEAPnY=
X-Google-Smtp-Source: ALg8bN4GsjecaYBFWDd5u5khHkzMkLlxGflEdNoKh020D0PsrxZOyAsWNoGwJBxe+XjVsICrvr/dVw==
X-Received: by 2002:ab0:2a01:: with SMTP id o1mr7943816uar.121.1547834328454; 
 Fri, 18 Jan 2019 09:58:48 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com.
 [209.85.217.41])
 by smtp.gmail.com with ESMTPSA id x20sm10004897uan.12.2019.01.18.09.58.47
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 09:58:47 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id t17so8916058vsc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 09:58:47 -0800 (PST)
X-Received: by 2002:a67:efd1:: with SMTP id s17mr8491468vsp.119.1547834326871; 
 Fri, 18 Jan 2019 09:58:46 -0800 (PST)
MIME-Version: 1.0
References: <20190109065922.231753-1-hsinyi@chromium.org>
In-Reply-To: <20190109065922.231753-1-hsinyi@chromium.org>
From: Sean Paul <seanpaul@chromium.org>
Date: Fri, 18 Jan 2019 12:58:10 -0500
X-Gmail-Original-Message-ID: <CAOw6vb+a2SAq+=xfL9RZyA6R7zn-HYFQbDnDaK28TD8yrh+wLg@mail.gmail.com>
Message-ID: <CAOw6vb+a2SAq+=xfL9RZyA6R7zn-HYFQbDnDaK28TD8yrh+wLg@mail.gmail.com>
Subject: Re: [PATCH resend] drm/panel: panel-innolux: set display off in
 innolux_panel_unprepare
To: "Hsin-Yi, Wang" <hsinyi@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_095853_533711_DF188D47 
X-CRM114-Status: GOOD (  18.42  )
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
Cc: David Airlie <airlied@linux.ie>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 9, 2019 at 1:59 AM Hsin-Yi, Wang <hsinyi@chromium.org> wrote:
>
> Move mipi_dsi_dcs_set_display_off() from innolux_panel_disable()
> to innolux_panel_unprepare(), so they are consistent with
> innolux_panel_enable() and innolux_panel_prepare().
>
> This also fixes some mode check and irq timeout issue in MTK dsi code.
>
> Since some dsi code (e.g. mtk_dsi) have following call trace:
> 1. drm_panel_disable(), which calls innolux_panel_disable()
> 2. switch to cmd mode
> 3. drm_panel_unprepare(), which calls innolux_panel_unprepare()
>
> However, mtk_dsi needs to be in cmd mode to be able to send commands
> (e.g. mipi_dsi_dcs_set_display_off() and mipi_dsi_dcs_enter_sleep_mode()),
> so we need these functions to be called after the switch to cmd mode happens,
> i.e. in innolux_panel_unprepare.
>
>
> Signed-off-by: Hsin-Yi, Wang <hsinyi@chromium.org>

Reviewed-by: Sean Paul <seanpaul@chromium.org>

> ---
> Resend for review.
> ---
>  drivers/gpu/drm/panel/panel-innolux-p079zca.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
> index ca4ae45dd307..8e5724b63f1f 100644
> --- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
> +++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
> @@ -70,18 +70,12 @@ static inline struct innolux_panel *to_innolux_panel(struct drm_panel *panel)
>  static int innolux_panel_disable(struct drm_panel *panel)
>  {
>         struct innolux_panel *innolux = to_innolux_panel(panel);
> -       int err;
>
>         if (!innolux->enabled)
>                 return 0;
>
>         backlight_disable(innolux->backlight);
>
> -       err = mipi_dsi_dcs_set_display_off(innolux->link);
> -       if (err < 0)
> -               DRM_DEV_ERROR(panel->dev, "failed to set display off: %d\n",
> -                             err);
> -
>         innolux->enabled = false;
>
>         return 0;
> @@ -95,6 +89,11 @@ static int innolux_panel_unprepare(struct drm_panel *panel)
>         if (!innolux->prepared)
>                 return 0;
>
> +       err = mipi_dsi_dcs_set_display_off(innolux->link);
> +       if (err < 0)
> +               DRM_DEV_ERROR(panel->dev, "failed to set display off: %d\n",
> +                             err);
> +
>         err = mipi_dsi_dcs_enter_sleep_mode(innolux->link);
>         if (err < 0) {
>                 DRM_DEV_ERROR(panel->dev, "failed to enter sleep mode: %d\n",
> --
> 2.18.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
