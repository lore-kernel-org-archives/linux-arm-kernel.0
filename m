Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1B9C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:00:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94CB620672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ckSl3/CU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="hVfpngYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CB620672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H9uScELpj3wGR41fM8sHZHgme3ON8h/UQiQa/I7cYSY=; b=ckSl3/CUTtkPpt
	8ev9Gsbbuky68xIeAhvIE43nyX5u/Axr2mmsP/X1PgfU2Cs3QQ2C48UUbZsOsa0u789oeYI9VREoH
	ciuJZ3dAwtEJEFtlzmjb6RycFDI8fy0SuXd8svnaWPBZbhSSQfZjzUcJPURpZcQfPwJ/6ylTajB9A
	Kx/IOC7VyiHAdiEfT7XoESAYzMjaMWrXr4+c72ARpi4dYdpyH6jkrL/dCVElfGhbQAHvAU+sqHj8x
	nSdb1jLHNdzVgE92cCUgc5ZW//NgQNe8RmbU2/EwqvL5Di3vTfc+msfBqZNVgwkjeFPFlXLyi+k+Z
	Tys3ce3YYlIkC5YL72+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWlOh-0005kW-NM; Tue, 11 Dec 2018 17:00:39 +0000
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWlOZ-0005O3-Tr
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 17:00:36 +0000
Received: by mail-io1-xd41.google.com with SMTP id r9so12422022ioa.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 09:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oRCOPzMLIrDwVjWJ2tEJutI5NVsDV0X/Aiu/VaWtEw0=;
 b=hVfpngYF4ZURKVO1lak5Y+rAxRsd5bNbTZhiA8UgVdFMiUSp0oim5XNVLDvbf9HZVF
 9zT+XYy0QsL7JuTLtYENzfM8rGh3CvcvNp36AMMhEd+mM6Izh69V5llW+JXGFW8aIojM
 wGY/iS/3svL7kQDhbr5mTsw2hiH6fYfHyxIac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oRCOPzMLIrDwVjWJ2tEJutI5NVsDV0X/Aiu/VaWtEw0=;
 b=Z09k47LTnsMOBZHUnM3eHYd5h4t4E9oOFOJc83K+mey6gtDvE/IN64+q86N5ZqWDfc
 CFJ9xinpaJIJrwPUadenkJds9drxk4igDQWpPgDF/rIGefco8Ektyzra7B03u1eHqYEZ
 aszVGWPFrJDCseV6/eTGv6xZSdVxFIyRJSJIZxD4ev4QoBPV94h9uTJEtb7BLryUtVa9
 4iQcx6NvAqmxm3O3qTKWpl0KM4AR94/h0dKn1KLgXFBaA+Z4rftPltS+hZgUttE0r9hH
 n6duyk2GQjZMDLXVUNlJ1ZsjGMWmDABFVBlJ8wz4kJrQT6ZURkW4MIY1cDOA+9gjzexU
 P+6A==
X-Gm-Message-State: AA+aEWblKdND0Oxhu7FXBLIPPRJFxInuBEXXJg2XiFHL/v9KbljTEkbm
 e3d/zWJQlsAUvbBzt8iE1xnwXm757CBrdkB7EguovQ==
X-Google-Smtp-Source: AFSGD/X81VVihlLYP6XLcjhLKO7UOwos3IttGs5h+I85lBgxxLy+W1l64a29hAep4YMp64aI5Jxa1EEtAnhTarBFhMc=
X-Received: by 2002:a5e:c609:: with SMTP id f9mr1247997iok.114.1544547620650; 
 Tue, 11 Dec 2018 09:00:20 -0800 (PST)
MIME-Version: 1.0
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
 <20181210161729.29720-8-jagan@amarulasolutions.com>
 <20181211164900.wfmkmbrbj3nmlb3h@flea>
In-Reply-To: <20181211164900.wfmkmbrbj3nmlb3h@flea>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Tue, 11 Dec 2018 22:30:08 +0530
Message-ID: <CAMty3ZBzOyAGwgOZwArbvnqtcvwMkJrqwGQ-q7+XFX-BVs34RQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/17] drm/sun4i: sun6i_mipi_dsi: Refactor vertical
 video start delay
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_090031_961185_45931B72 
X-CRM114-Status: GOOD (  17.27  )
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
>
> So, just like I asked in your v4, twice,
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/615339.html

I don't know how can I comment here. Not quite clearly understand your
setup, because I have verified 3 different panels from different
vendors one with 2-lane, another with 4-lane and one with video format
and another one is burstmode format. I even verified with the clock
rate and register details.

Please suggest me, what can look further on this.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
