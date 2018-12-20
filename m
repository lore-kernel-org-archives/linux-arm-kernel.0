Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA1DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:56:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C1FD218FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WjHPj8s+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JNQuNJqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C1FD218FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Mpn7HsGdfwc17GNwiIQYbGZ+cmN1a0w5668kSFq1IC4=; b=WjHPj8s+UBXePj
	ygUTMW35Yb767jWf/HsLWtGkc2MYxOSYP+7Ml9B0FYoacq578NXBP7oKrIqkXbLqAHWpR7vkj4jhe
	I1lXYSU8fLAbezAxeZzbXSfdPIS/fB3v1PqUmW4an1J4mvkZIKEiajCqy3xnD9Qo0tJaoIInMpiPB
	CWnS1KcmbcMJ4UN07RP4wYPwiCsgcHEitHRkPZ7Yk+XuwFexiUj0uTDhO4PeuOcTkoT1xjWGAlFpH
	Ah8PwRfgeDPgES77iPTJ2HzZLWm1Scygmgb47bZWbnQECRedJw9PfW5e8moUtGgFxkOMLduRFMYDz
	99/upXxNItpdL8CB5S5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga5N0-0001bS-Vo; Thu, 20 Dec 2018 20:56:38 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga5Mw-0001aE-Mb
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 20:56:36 +0000
Received: by mail-it1-x143.google.com with SMTP id g85so4028902ita.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 12:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=efF2qmFwsJ1axs0m1B4BUuW+RUh8a4wq2pjaccVYe9c=;
 b=JNQuNJqZv35yGcoTQlpjyNDO1LK/icLfT60oa8Oe1zdECcpIoOi/jLh7f+N+AXGbr4
 b6Yp3533F2UND8fzsMoBSLPV3qQcXdZ8jBlLxTJ7daT78hXkveFq6xwdbd2Mugz8vO5e
 tfkhEYtNZnFFapSAFdmYjwAin4vKTOu2ST8Rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=efF2qmFwsJ1axs0m1B4BUuW+RUh8a4wq2pjaccVYe9c=;
 b=h5VxEEVMWT/OaNfJmkoojgm0IBeDSzrTIG7dSN4U/cUhaf1YhuX3EgK6BGKgPOLDYG
 nxJPGeT6qqjP/+gTTbJVPRDnSPfvlMzz05gv9kR1oxZIHAys147rsBhGd8E47Rv1nUf9
 FILPhqOGjioiqeZI52P/0M2iRkQdxArtA8TBb+hNPHFUHuOQNMF0WauTbECS+yCEqgbk
 B12nn5bCsUPLe1ZiUDwIoUbJuaF51nUVdb16COlU/5RvT/SHhr/MxDnNRKQhetnMU3jf
 rjusnBz94jU1yJPczE1ZGlZdxQ8YDXZu2K2Cn8aOO7r299Lh3TJ8kdNT5ji8dDyhaQlG
 /v1Q==
X-Gm-Message-State: AA+aEWao6WTvTqkP0j2g1yFLq5H2KW3rWPu1d5bZA6mIBFR9yp64AU5r
 QgnBVQqzTPoM4rXdO1hV5vCleFbXy1YWZX1URqarAQ==
X-Google-Smtp-Source: ALg8bN6rfXd4idarU47KMo5Mow2yJjrhhdUXYqRqjjZX8AY37yXXMGazvLIMeKxtXulHnZixSS1jALfRLmJ1Sme/Y88=
X-Received: by 2002:a24:5411:: with SMTP id t17mr207706ita.32.1545339383319;
 Thu, 20 Dec 2018 12:56:23 -0800 (PST)
MIME-Version: 1.0
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
 <20181210161729.29720-8-jagan@amarulasolutions.com>
 <20181211164900.wfmkmbrbj3nmlb3h@flea>
In-Reply-To: <20181211164900.wfmkmbrbj3nmlb3h@flea>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Fri, 21 Dec 2018 02:26:11 +0530
Message-ID: <CAMty3ZB5F5jD9iJT1soXSA5HtQOf5W9rKO9nCdGFUfVo0hpO4Q@mail.gmail.com>
Subject: Re: [PATCH v5 07/17] drm/sun4i: sun6i_mipi_dsi: Refactor vertical
 video start delay
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_125634_993660_A3D70D38 
X-CRM114-Status: GOOD (  17.67  )
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
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, Chen-Yu Tsai <wens@csie.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 10:19 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> On Mon, Dec 10, 2018 at 09:47:19PM +0530, Jagan Teki wrote:
> > Video start delay can be computed by subtracting total vertical
> > timing with front porch timing and with adding 1 delay line for TCON.
> >
> > BSP code form BPI-M64-bsp is computing video start delay as
> > (from linux-sunxi/
> > drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> >
> > u32 vfp = panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
> > => (panel->lcd_vt) - panel->lcd_y - (panel->lcd_vbp)
> > => (timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y)
> >    - panel->lcd_y - (panel->lcd_vbp)
> > => timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y
> >                            - panel->lcd_y - panel->lcd_vbp
> > => timmings->ver_front_porch
> >
> > So, update the start delay computation accordingly.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>
> Even though it's a bit better now on my A33 board and I don't have the
> white stripes on the bottom of the display, there's still some
> flickering with your patches applied.
>
> Bisecting it seems to point at that patch, but reverting it doesn't
> make the issue go away, so it's not really clear which one exactly is
> at fault.

Is reverting this patch, work fine or not?

This patch is trying to make use of front porch instead of existing
back porch to compute the delay. Since we revert the VBP fix patch[1]
to assume VBP as VFP value look like your setup would also require to
revert this change. But as per BSP or drm_mode details all of my
displays even work with and w/o reverting these two.

I'm thinking your display should work in the same behavior since the
dsi controller making this route.

[1] https://patchwork.kernel.org/patch/10680309/

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
