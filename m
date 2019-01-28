Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D8BC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:36:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFFC4217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q+Y9pYHZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="AY7yun73"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFFC4217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AIaA07LhZ18Bx0G3ve++qms6B4oK7KmnC6jjfTIO3ns=; b=Q+Y9pYHZ5iGYwn
	Ryc9wEi6cUoSYHIaJ81L5CGiImo3AyoUSYrQ3qJp13WbqlqcZftNwZuQYBkucD01y6GyVEVsf+c1a
	Dgdp1hBXrNKhhpVKQzYBeKqzuIyXh4N4IRaAnNhZB0b+VvQPbvQDLDtvaqWe64tZzXQIMAOJ4t8s0
	Yv5kuO4Tsp34YYb4HcRsNXEOR8Fw7fXJGsWVvSWLGKqOCLQ/chz4SJ65V7QZvx+MBy0ZN34viGWLT
	6al+a2OtEzYCZ9FrP2Iu0e9QRJBhF2g1ObJ9F+KmPDWXKUnhZ7rDPGQ51pWMJJpXchuX11PEc97J2
	+Ucp6BM1IXvQeOdj5+dQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go3L8-0008GY-J7; Mon, 28 Jan 2019 09:36:26 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go3L4-0008Bj-Qm
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 09:36:24 +0000
Received: by mail-it1-x142.google.com with SMTP id i145so19578951ita.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 01:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ozesp4rWwiinrHtP2lbjF0VXem3poIT2No6pvmp0vP4=;
 b=AY7yun73QD+EMNMwN0Y9/iGld70czBDXBhZwOgwRagFJXGF4+NVDKL7UmP/oFwxqMa
 bx3rn5BaL6yp5Cf4amrzXIkfjukg6OKP6aXwgTM0QqGO5rzZ41224LwdVvL3SHWhpBL2
 aR2HTIR8GnB108wOYdYBcqWMpVgeDWctVrae4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ozesp4rWwiinrHtP2lbjF0VXem3poIT2No6pvmp0vP4=;
 b=bdcB+fyzyiBkJhPsord2yqNJgXRLl4kuNSTaohepptB/YGrCn77aVzttFzMPT+Kpim
 qzbCczWQVdcbc6OvT3BIEY741AFZCwfh7Qnp9j6du2SEYgEFwBK1B6BnmUlyY342oHpe
 Ksl++bMnS9G2bSa1SF7zvNTslz86DRLwWknbWr9A4QABaiv+2UxZwYdwPR80uBWY0bvY
 jK3TxYgf08bXOADJVD3qER1H1og+EFf1XJ4x3ZL66xEbYKHLp8vMGzVbFDia461L0Tdu
 yMqjcSHa3z63EZ6qsY7Mx10hpWDtHArPSgrSfABsv+8aZRblkxDTgC+bLKaXDzNxW6Tp
 Xgvw==
X-Gm-Message-State: AJcUukeP8LRBiTtcOgidfCQMf1akgr/qd+NoVBlUfsllbVyT2hDhN/Ol
 iPKRQXiRWYxN5cVO3CY2MJ+oJ9WTXTL85UK8vV2BKw==
X-Google-Smtp-Source: ALg8bN6pbH8aim/d9XQIpdNF6Ci4nzcWf2S1jjcKEHd6gLiFxhxCMBZ3bZKyOFJKx+7PoFzRn8eTtVwDlkiO4D5JUu4=
X-Received: by 2002:a02:781e:: with SMTP id p30mr13465792jac.85.1548668181627; 
 Mon, 28 Jan 2019 01:36:21 -0800 (PST)
MIME-Version: 1.0
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
 <20190124195900.22620-12-jagan@amarulasolutions.com>
 <20190125212433.ni2jg3wvpyjazlxf@flea>
In-Reply-To: <20190125212433.ni2jg3wvpyjazlxf@flea>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 28 Jan 2019 15:06:10 +0530
Message-ID: <CAMty3ZAsH2iZ+JEqTE3D58aXfGuhMSg9YoO56ZhhOeE4c4yQHQ@mail.gmail.com>
Subject: Re: [PATCH v6 11/22] clk: sunxi-ng: a64: Add minimum rate for PLL_MIPI
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_013623_025623_BBAB941F 
X-CRM114-Status: GOOD (  16.09  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 Michael Turquette <mturquette@baylibre.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Jan 26, 2019 at 2:54 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Fri, Jan 25, 2019 at 01:28:49AM +0530, Jagan Teki wrote:
> > Minimum PLL used for MIPI is 500MHz, as per manual, but
> > lowering the min rate by 300MHz can result proper working
> > nkms divider with the help of desired dclock rate from
> > panel driver.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > Acked-by: Stephen Boyd <sboyd@kernel.org>
>
> Going 200MHz below the minimum doesn't seem really reasonable. What
> is the issue that you are trying to fix here?
>
> It looks like it's picking bad dividers, but if that's the case, this
> isn't the proper fix.

As I stated in earlier patches, the whole idea is pick the desired
dclk divider based dclk rate. So the dotclock, sun4i_dclk_round_rate
is unable to get the proper dclk divider at the end, so it eventually
picking up wrong divider value and fired vblank timeout.

So, we come-up with optimal and working min_rate 300MHz in pll-mipi to
get the desired clock something like below.
[    2.415773] [drm] No driver support for vblank timestamp query.
[    2.424116] sun4i_dclk_round_rate: min_div = 4 max_div = 127, rate = 55000000
[    2.424172] ideal = 220000000, rounded = 0
[    2.424176] ideal = 275000000, rounded = 0
[    2.424194] ccu_nkm_round_rate: rate = 330000000
[    2.424197] ideal = 330000000, rounded = 330000000
[    2.424201] sun4i_dclk_round_rate: div = 6 rate = 55000000
[    2.424205] sun4i_dclk_round_rate: min_div = 4 max_div = 127, rate = 55000000
[    2.424209] ideal = 220000000, rounded = 0
[    2.424213] ideal = 275000000, rounded = 0
[    2.424230] ccu_nkm_round_rate: rate = 330000000
[    2.424233] ideal = 330000000, rounded = 330000000
[    2.424236] sun4i_dclk_round_rate: div = 6 rate = 55000000
[    2.424253] ccu_nkm_round_rate: rate = 330000000
[    2.424270] ccu_nkm_round_rate: rate = 330000000
[    2.424278] sun4i_dclk_recalc_rate: val = 1, rate = 330000000
[    2.424281] sun4i_dclk_recalc_rate: val = 1, rate = 330000000
[    2.424306] ccu_nkm_set_rate: rate = 330000000, parent_rate = 297000000
[    2.424309] ccu_nkm_set_rate: _nkm.n = 5
[    2.424311] ccu_nkm_set_rate: _nkm.k = 2
[    2.424313] ccu_nkm_set_rate: _nkm.m = 9
[    2.424661] sun4i_dclk_set_rate div 6
[    2.424668] sun4i_dclk_recalc_rate: val = 6, rate = 55000000

But look like this wouldn't valid for all other dclock rates, say BPI
panel has 30MHz clock that would failed with this logic.

On the other side Allwinner BSP calculating dclk divider based on the
SoC's. for A33 [1] it is fixed dclk divider of 4 and for A64 is is
calculated based on the bpp/lanes.

Since the above min_rate is not desired for possible panels clock, I
think we can rely on BSP to make a move here. I'm planning to do these
changes in next version.

Let me know if you have any comments here?

[1] https://patchwork.kernel.org/patch/10777519/

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
