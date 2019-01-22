Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5356BC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:53:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D3D020866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tSyVLtbD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="AHvKGUc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3D020866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wTMSXKPYCIbHXvUNagnQO/Ww7yr5q9vPdv9N/zJ688w=; b=tSyVLtbDQi3LsQ
	hd5NJ342fckt3zYduBqjO7tj5piYo4A0PeUeDjAtsSIHpiHtn9gQSDapVpCRu2IM5+AqdSJyLPQmE
	RkCFu0yCLdrZy3z8/7XOOw9FuDS9r2H2XP82X2p+W7+edX0nQr2bPJbJZ5G/rMRAVDoIO01cr7YaJ
	/6MHw3c1Kcsj3f7suiP1E0VYRKGVtiLddIK0kb2KYn3Fhf0UtqARzPZsrxgIV9+Zq+6VOJrajlujT
	k82rNntiAexiP5lCbtr/PjRSFBQs5bgU9fl5dfKW6MVBSGa8LH3FTuZ4oFbAVQjDvfaZp8A/wUCbl
	IN/1NsKzqtLFT7t2vs/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm3yl-00007d-O1; Tue, 22 Jan 2019 21:53:07 +0000
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm3yh-00006m-ST
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 21:53:05 +0000
Received: by mail-yb1-xb44.google.com with SMTP id y63so28916ybc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 13:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poorly.run; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=AGImLWKSXyqcZe7nveg/7vkgivfZ2ayznn3rwDCE8FY=;
 b=AHvKGUc1yOVBQIXBFh5sY1o9v6Vm3IX0sfgcGrTG34kaFzlxf1Jm8AVan2dh507cGI
 ygYgYsNvIhwq7FlmpQGjt7HdKurdL57SPlrCPaGP81/nFKDVEqWEvcR2G9pUVj41TaEI
 f+EYZsEK5+fylSuCVIyAD5L4I8fbl0DWoyLf99bBl1JbckxrmMUBMBelq0KeNXxUQ2Qe
 zfcnnCOGt6DmByNpeJFXR3bEmCMWomuGSAZ7WmfpVGkcfMnHyZ36k0Ebpy2RDVV37zwN
 oRNf3Fcwl9Ecw1FMoc7Cgpxn5Hztk7gRaf6LyV3wGPZ+djf6oCq1CWw0JtuJV+lD7dNz
 8iCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=AGImLWKSXyqcZe7nveg/7vkgivfZ2ayznn3rwDCE8FY=;
 b=JGMM3HiJI4Vd8EaIhUSIhMq4R+DaNHWcmTyr+QXCAITj+YWyw4lyhJiZ5LytxmpuM2
 Gh1GlqHeV1jBITyKQVcCvo86SjK94rQJHMNp9JF7Mdo7CFlDEbdMmrHb3wJ6IT+oKAtp
 hy2SVxp74glFnjh0O5QdQ+kevhtA6hhHb+Vt3bRy/K4E8/FABk3SJ8F2vmlltMafIN8i
 h5SG6UaWT0fv0z0LOw9AUFTJl7LizRtAqxRAJU8sPZVlwWBjXR1DH5VU2fgrTO1NcP2E
 UbnzIq3jutd3LHX7YaiVAcBOTGBgls6CDRJkgdgdfdG9cy3mYnU2+EeW1D2OqUAOYIZz
 vQtw==
X-Gm-Message-State: AJcUukckgoUYpgp4pZnoRAI6D9XVzgAtHsWaq/EVhcvkuP3FDA0LBUGW
 6vDfCrpN+MONW92/PYvQLLsUVA==
X-Google-Smtp-Source: ALg8bN5UNJJkma6ODmjgOp5ajWZ643xJYjRhSPm0CyAqEy+6i7UzkoQS05f2gvmSgQitqKvDujro4A==
X-Received: by 2002:a25:3455:: with SMTP id b82mr22727920yba.402.1548193980378; 
 Tue, 22 Jan 2019 13:53:00 -0800 (PST)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
 by smtp.gmail.com with ESMTPSA id w2sm6327173ywe.62.2019.01.22.13.52.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 22 Jan 2019 13:52:59 -0800 (PST)
Date: Tue, 22 Jan 2019 16:52:59 -0500
From: Sean Paul <sean@poorly.run>
To: Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH resend] drm/panel: panel-innolux: set display off in
 innolux_panel_unprepare
Message-ID: <20190122215259.GN114153@art_vandelay>
References: <20190109065922.231753-1-hsinyi@chromium.org>
 <CAOw6vb+a2SAq+=xfL9RZyA6R7zn-HYFQbDnDaK28TD8yrh+wLg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOw6vb+a2SAq+=xfL9RZyA6R7zn-HYFQbDnDaK28TD8yrh+wLg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_135304_072453_4721082C 
X-CRM114-Status: GOOD (  21.47  )
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
 Thierry Reding <thierry.reding@gmail.com>, "Hsin-Yi,
 Wang" <hsinyi@chromium.org>,
 Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 12:58:10PM -0500, Sean Paul wrote:
> On Wed, Jan 9, 2019 at 1:59 AM Hsin-Yi, Wang <hsinyi@chromium.org> wrote:
> >
> > Move mipi_dsi_dcs_set_display_off() from innolux_panel_disable()
> > to innolux_panel_unprepare(), so they are consistent with
> > innolux_panel_enable() and innolux_panel_prepare().
> >
> > This also fixes some mode check and irq timeout issue in MTK dsi code.
> >
> > Since some dsi code (e.g. mtk_dsi) have following call trace:
> > 1. drm_panel_disable(), which calls innolux_panel_disable()
> > 2. switch to cmd mode
> > 3. drm_panel_unprepare(), which calls innolux_panel_unprepare()
> >
> > However, mtk_dsi needs to be in cmd mode to be able to send commands
> > (e.g. mipi_dsi_dcs_set_display_off() and mipi_dsi_dcs_enter_sleep_mode()),
> > so we need these functions to be called after the switch to cmd mode happens,
> > i.e. in innolux_panel_unprepare.
> >
> >
> > Signed-off-by: Hsin-Yi, Wang <hsinyi@chromium.org>
> 
> Reviewed-by: Sean Paul <seanpaul@chromium.org>

Applied to drm-misc-next, thanks for your patch.

Sean

> 
> > ---
> > Resend for review.
> > ---
> >  drivers/gpu/drm/panel/panel-innolux-p079zca.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
> > index ca4ae45dd307..8e5724b63f1f 100644
> > --- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
> > +++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
> > @@ -70,18 +70,12 @@ static inline struct innolux_panel *to_innolux_panel(struct drm_panel *panel)
> >  static int innolux_panel_disable(struct drm_panel *panel)
> >  {
> >         struct innolux_panel *innolux = to_innolux_panel(panel);
> > -       int err;
> >
> >         if (!innolux->enabled)
> >                 return 0;
> >
> >         backlight_disable(innolux->backlight);
> >
> > -       err = mipi_dsi_dcs_set_display_off(innolux->link);
> > -       if (err < 0)
> > -               DRM_DEV_ERROR(panel->dev, "failed to set display off: %d\n",
> > -                             err);
> > -
> >         innolux->enabled = false;
> >
> >         return 0;
> > @@ -95,6 +89,11 @@ static int innolux_panel_unprepare(struct drm_panel *panel)
> >         if (!innolux->prepared)
> >                 return 0;
> >
> > +       err = mipi_dsi_dcs_set_display_off(innolux->link);
> > +       if (err < 0)
> > +               DRM_DEV_ERROR(panel->dev, "failed to set display off: %d\n",
> > +                             err);
> > +
> >         err = mipi_dsi_dcs_enter_sleep_mode(innolux->link);
> >         if (err < 0) {
> >                 DRM_DEV_ERROR(panel->dev, "failed to enter sleep mode: %d\n",
> > --
> > 2.18.1
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Sean Paul, Software Engineer, Google / Chromium OS

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
