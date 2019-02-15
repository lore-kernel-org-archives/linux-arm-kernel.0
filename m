Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996CFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:37:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68ABD222D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mtx7SVF8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BJxmEkrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68ABD222D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NYq/lIzm5DokKlLIsvAblG4YtQg/BbrrwzKvunOIBKc=; b=Mtx7SVF8o5BDa1
	HWxAZOZ4FxLR4Z8GEvKXMj7Vv7TiH+Z1th1Uu5WobIzxPhmQGRjGXuec8U1H0KmdLA9rCd2YD8qKZ
	6lTMfVWFIEkkDIGx7r2URLZI4Hrm13j7jIUM5Wek/3DDJka5FO0KSY8eTAed3rpwVKBKJvnoBieVN
	DvrZcuJj8aMHKrfgRBi2i2dHbolTXWCfqdzyiY5deOb5lpTUbCmAC4WnH+luTeluuO3juMglfdZRN
	tcj3WVSAhCYksEmzlGW6JMHZdbdHyGSMsY7Mbz6Gkt7YqzfBiE1LtExDLQNqKHP3sfhFiiPgYKy1F
	lSpHDY6xaTsC1PUNlr5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gujIb-0008BL-Fq; Fri, 15 Feb 2019 19:37:25 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gujIX-0008B2-Vf
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 19:37:23 +0000
Received: by mail-it1-x141.google.com with SMTP id z7so26930812iti.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 11:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aOSC8ZzkPCXB6WyoycrO9I7WjBSurknF8CSDyuQMuwQ=;
 b=BJxmEkrKTtLBxqiiTZTRpxbFj2xyLTKbacgro11C4Az8g6PqUfCPE6CF+pLWKWSuCj
 YLA8+2qWfO0d1ctKZDB8Pn8wIDyAb3mTs2Wq+W8RJDXmXveKfKz5Ts6ARAUgay5WGSWD
 Q+foTz6lzgWxhDNHg/RooLL2k84x/LiOTLyT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aOSC8ZzkPCXB6WyoycrO9I7WjBSurknF8CSDyuQMuwQ=;
 b=OwlNiCpFye1NdheLxG9RcDetXtYkkjcHj15LzlMMoCrfinQFb6HOBgCl1m8NAED/ab
 8RYT2KW8Rcuuriqqq5nQ4LROabEG8gbS3+ei9prq3rVOnWVTOYMHy8XSKl5YWCWtKpYc
 DSD9NQEPkXDuU3Gu+9ecpeNoNKeLcYfjcvGuy082XjbsFghbEwpGKaO6usGeiwopxMTH
 6ha6JbwtQLuIne6f7u24LfDpd977di7uZnngqFBwR919OpoAvnV7GgtrW4mzFgdHs324
 PriwzGkENk8sa/cUHBoZE0QDskTa2KS9Vvcj9irxhSKNpbNnANxnJOc2F+YajENNKz2y
 PqnQ==
X-Gm-Message-State: AHQUAuYvsQPP4iO3Yr9+rrntputaM8iYudMHB/+dcepeXRJETeBgrjC9
 zIISO410Fn5zjMnsMxj+CcjfSRHO51V3g20cjKsL37ZNnPc=
X-Google-Smtp-Source: AHgI3IYTObnlggwGkTQ2WRCe9gBMEsne4EQK/lC5WAFH1qcM9/jUub3W+2pb7FqZ30CUIWXx2uIZTMtxqfsSJB4Qis4=
X-Received: by 2002:a6b:b790:: with SMTP id h138mr6264910iof.114.1550259440391; 
 Fri, 15 Feb 2019 11:37:20 -0800 (PST)
MIME-Version: 1.0
References: <20190214192544.7314-1-jagan@amarulasolutions.com>
 <20190214192544.7314-8-jagan@amarulasolutions.com>
In-Reply-To: <20190214192544.7314-8-jagan@amarulasolutions.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Sat, 16 Feb 2019 01:07:08 +0530
Message-ID: <CAMty3ZDqnVBkcT5kiKf-pKGccEuQR0xtBXBgB2-_XFXkRKi+_A@mail.gmail.com>
Subject: Re: [PATCH v8 7/8] drm/sun4i: sun6i_mipi_dsi: Refactor vertical video
 start delay
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_113722_475779_21988258 
X-CRM114-Status: GOOD (  15.86  )
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
Cc: Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 12:56 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Vertical video start delay is computed by excluding vertical porch
> value from total vertical timings, but the current driver excluding
> vertical porch along with vertical sync values from total vertical
> timings resulting wrong start delay.
>
> This patch trying to update the video start delay by subtracting
> vertical porch from vertical total, on the other hand it added 1
> extra start_delay line for TCON based on the Allwinner BSP reference.
>
> BSP code form BPI-M64-bsp is computing video start delay as
> (from linux-sunxi/
> drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
>
> u32 vfp = panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
> => (panel->lcd_vt) - panel->lcd_y - (panel->lcd_vbp)
> => (timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y)
>    - panel->lcd_y - (panel->lcd_vbp)
> => timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y
>                              - panel->lcd_y - panel->lcd_vbp
> => timmings->ver_front_porch
>
> So, update the start delay computation accordingly.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> index a08dfdcbe9e8..31cf9c58e98d 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -358,7 +358,24 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
>  static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
>                                            struct drm_display_mode *mode)
>  {
> -       return mode->vtotal - (mode->vsync_end - mode->vdisplay) + 1;
> +       u32 vfp, start_delay;
> +
> +       /* vertical front porch */
> +       vfp = mode->vsync_start - mode->vdisplay;
> +
> +       /* start_delay = vertical total - vertical front porch */
> +       start_delay = mode->vtotal - vfp;
> +
> +       /* add extra 1 delay line for TCON, as per Allwinner BSP */
> +       start_delay = 1;

This has to be += 1;

Typo change while re-basing, I will fix this in next version.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
