Return-Path: <SRS0=ikCU=PO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9CBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 16:29:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA4392085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 16:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qgnA1n5B";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qbyRdDrk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4392085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6IaHTgKV/tGr9512x/JhOjRrPnKb8ifsDZiCSwDpxJY=; b=qgnA1n5B2wzT3m
	495Wg+wzI8TRYpr7DuFxkcyhs2bE36rm7ng2Or8ion182wErbb+ulAszAWNx7loEHoBWmEr9fGuy1
	DjGTXQPV9x1M61IAoM0NIJ8R4yi4twshS784JGVzkSxQjkPqPGA5c8caPR1ydRn408MSthhDfhWhg
	3xvvckkV83vGYmJK1Cd16EycFLO4RemUqmGCsSjflZgdHi/8pKp8lMGIB2dxM2N6CjNF2YenDInEr
	IPVcNmJ/wcuCPqhqXkVwmdfOE4qxbcm6v99QhGfYjKTEFFDfkqc3hrHQwsBmwC178pxw4Y9/oZP0p
	Ytvq01fpR9EVMZXX/kQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggBId-0004LX-4h; Sun, 06 Jan 2019 16:29:19 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggBIa-0004LD-MN
 for linux-arm-kernel@lists.infradead.org; Sun, 06 Jan 2019 16:29:18 +0000
Received: by mail-it1-x144.google.com with SMTP id i145so7654827ita.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 06 Jan 2019 08:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TKV0p0WiCpw6qO3c5kAhJMQNLPjT6ksNPdJwxNKMSuU=;
 b=qbyRdDrkrL8+wVP5kRFOrUd9GpbW6hfXwP3sikDl34Khjh8tn/NthFLOgIJkf+c4XS
 IdSQRufwXswLwN1MhuYnS8NuNrk7XI+8YnCuDzj+2oqTqLgIN2OiDyIyybqEjAydga/O
 8Z7V6o7tCpGvczj6oTFoH486mngVLnuAFE+Cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TKV0p0WiCpw6qO3c5kAhJMQNLPjT6ksNPdJwxNKMSuU=;
 b=KcQTvk4H+uccE86RJk6v+Sa2+Om367a1q9S50m4nSopuTW3QFON+oX3gr0gP3C7ga8
 01Y40aCBpcMnCYPbZ5UcjX+FghnyeUS7vUnqDlcghMwkKnkFr2F1T9PPZ65e5kl/4JdR
 4rDnuyCGNHCvuS5SBPxsbthu8LGFuDGE4GqTYSgUp95fOkDhldQ/1rPecKVf14m0IPbE
 t1KNC0xd6atGqbL1jslyXldvtzaE6Dt1DsKLMWpo3byDADW024qCGw3Fc/d+q0MI6mlV
 f7knhCCMCmuyMoXTbJsiCs37sve6gpWVvEP6bPA7MZ9TblP6nR9Pzy2kbWe5t8shrLwW
 IFVg==
X-Gm-Message-State: AA+aEWaPHvRRRBTH9vMW+jpn4pDMGlS6FqIkXWjzjmF0c9qN+MY3m4UQ
 RzWd/Xc3w9EUxPn3/8RawoIfhXw08TeADq8JD76oeA==
X-Google-Smtp-Source: AFSGD/WO5KHvO8i5w4GQv2nQLGDMRwvYHfOS1klhTp/EzwMcl0Fka+F7cdD3WrsGhP7qljdVyDj0e2L0MRGYfdjDjtw=
X-Received: by 2002:a02:104a:: with SMTP id 71mr36368412jay.103.1546792155191; 
 Sun, 06 Jan 2019 08:29:15 -0800 (PST)
MIME-Version: 1.0
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
 <20181210161729.29720-8-jagan@amarulasolutions.com>
 <20181211164900.wfmkmbrbj3nmlb3h@flea>
 <CAMty3ZB5F5jD9iJT1soXSA5HtQOf5W9rKO9nCdGFUfVo0hpO4Q@mail.gmail.com>
In-Reply-To: <CAMty3ZB5F5jD9iJT1soXSA5HtQOf5W9rKO9nCdGFUfVo0hpO4Q@mail.gmail.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Sun, 6 Jan 2019 21:59:04 +0530
Message-ID: <CAMty3ZC_FqQUjTik_3+bUbk7pfy=KtxXac9AKBJH4g2cSnPF0g@mail.gmail.com>
Subject: Re: [PATCH v5 07/17] drm/sun4i: sun6i_mipi_dsi: Refactor vertical
 video start delay
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190106_082916_728861_978FB676 
X-CRM114-Status: GOOD (  19.37  )
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

On Fri, Dec 21, 2018 at 2:26 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Tue, Dec 11, 2018 at 10:19 PM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> >
> > On Mon, Dec 10, 2018 at 09:47:19PM +0530, Jagan Teki wrote:
> > > Video start delay can be computed by subtracting total vertical
> > > timing with front porch timing and with adding 1 delay line for TCON.
> > >
> > > BSP code form BPI-M64-bsp is computing video start delay as
> > > (from linux-sunxi/
> > > drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > >
> > > u32 vfp = panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
> > > => (panel->lcd_vt) - panel->lcd_y - (panel->lcd_vbp)
> > > => (timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y)
> > >    - panel->lcd_y - (panel->lcd_vbp)
> > > => timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y
> > >                            - panel->lcd_y - panel->lcd_vbp
> > > => timmings->ver_front_porch
> > >
> > > So, update the start delay computation accordingly.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >
> > Even though it's a bit better now on my A33 board and I don't have the
> > white stripes on the bottom of the display, there's still some
> > flickering with your patches applied.
> >
> > Bisecting it seems to point at that patch, but reverting it doesn't
> > make the issue go away, so it's not really clear which one exactly is
> > at fault.
>
> Is reverting this patch, work fine or not?
>
> This patch is trying to make use of front porch instead of existing
> back porch to compute the delay. Since we revert the VBP fix patch[1]
> to assume VBP as VFP value look like your setup would also require to
> revert this change. But as per BSP or drm_mode details all of my
> displays even work with and w/o reverting these two.
>
> I'm thinking your display should work in the same behavior since the
> dsi controller making this route.

Any further comments on this?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
