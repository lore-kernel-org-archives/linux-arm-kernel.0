Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709E8C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:44:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 408AB207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AWd0pTOA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 408AB207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lPuJn88cMcx0S+4wE16XWkuEQkmnOIK5ccG/cS2jyG8=; b=AWd0pTOAczv5cq
	jKvmFfY9XPQomikBJhHGbxlPrgyexxlWInvh/72aUPwbxDZ//cb4KN8nIVsRJfo4Gmp8rpPazxY+e
	RKzcj153CmecKqOFRQvU1YryN5Eb1800hck0qXh44qZC9hxVolNwmpCrshU4IJehhD21g8BkLJ1/a
	RjuBl0xCIgCgROIS3OhJboKwmsTbhVYpJm9IDjf8bgU7OOmnRW+T7O/HXy8yNcej1f7jmu2QP4AyL
	W2LfqlP5XNy3gHbbOeLvHL7WM+w7ve1ke0DjBf6raozL1sCFnjwout/LiR/JXxkrw/LlO1ZYLIe2f
	0v1a2GrCK8wGCo/65T4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr11a-0006Qa-48; Tue, 05 Feb 2019 13:44:30 +0000
Received: from mail-ed1-f67.google.com ([209.85.208.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr11P-0006Ib-Vx
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 13:44:27 +0000
Received: by mail-ed1-f67.google.com with SMTP id d12so1835790edy.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 05:44:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UzQZRFs25qWZAsAYEW0SYoGEoO/nV18H65SPSBaC+Lg=;
 b=Fvn1Xvibya+P6uI/8ggfX25Of24LClwtkdxf54r+p+68ikHFQ1ID2DIYDcZCy7+Msc
 EPKec3WycwLUbHlGvUqc1cKT0y257WEIUzpEc2m5S58h6Cq4J+lRvMp1UrrGOt9Gcsfh
 a7yhMrm/Mweq/YISPzloA4vmGrflpVVy3xYyY4liw6MRkb0I8aNiUvGeV1W12zPSaZGr
 JE8OSEwHCz7lK97v8Zyl9tQU7Np6/iZxPZt3fVp6Fj1eb0jic2hTIti/kLXWU2LKXHea
 zGgcXfaRpQl38cIGZJhWzNDwSOp5Bg62peTddxGHEKKxRETBQKeoJ5VijDrVcNq1KMjV
 gVYA==
X-Gm-Message-State: AHQUAuZ5M1wE1tDPazi8UD/aDN5xv/x57f/W3Toynp0lHwv81x0x0JC+
 I6e+vywV9tX5QrbLX3L7UBiIWiYEfDs=
X-Google-Smtp-Source: AHgI3Ia7F/S6hNToUlBDve1OvVFgKqjAUxhdsdjpxTUGl7hEsyopcBxvJ5GUhGH4sc/ucCrZap/r5g==
X-Received: by 2002:a17:906:4584:: with SMTP id
 t4mr3611715ejq.135.1549374257494; 
 Tue, 05 Feb 2019 05:44:17 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com.
 [209.85.221.41])
 by smtp.gmail.com with ESMTPSA id m13sm5182900edd.2.2019.02.05.05.44.16
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 05:44:17 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id q18so3641803wrx.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 05:44:16 -0800 (PST)
X-Received: by 2002:adf:891a:: with SMTP id s26mr3732163wrs.44.1549374256271; 
 Tue, 05 Feb 2019 05:44:16 -0800 (PST)
MIME-Version: 1.0
References: <20190202155209.31617-1-plaes@plaes.org>
 <20190205094529.t7je4ozzu2b4ornc@flea>
In-Reply-To: <20190205094529.t7je4ozzu2b4ornc@flea>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 5 Feb 2019 21:44:02 +0800
X-Gmail-Original-Message-ID: <CAGb2v673ntXn7MTRhU1uecO9q8_i79e+Ovio=tucd6qFf5L84Q@mail.gmail.com>
Message-ID: <CAGb2v673ntXn7MTRhU1uecO9q8_i79e+Ovio=tucd6qFf5L84Q@mail.gmail.com>
Subject: Re: [RFC PATCH] clk: sunxi-ng: sun4i: Use CLK_SET_RATE_PARENT for
 mmc2 clock
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_054420_540566_5D387EE9 
X-CRM114-Status: GOOD (  17.96  )
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
Cc: Jernej Skrabec <jernej.skrabec@siol.net>, Priit Laes <plaes@plaes.org>,
 Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-clk <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 5, 2019 at 5:45 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Sat, Feb 02, 2019 at 05:52:09PM +0200, Priit Laes wrote:
> > Recent patch of improving MP clock rate calculations by taking
> > into account whether adjusting parent rate is allowed, have
> > unfortunately broken eMMC support on A20 Olinuxino-Lime2-eMMC
> > boards which fail with following error:
> >
> > [snip]
> > EXT4-fs (mmcblk1p4): INFO: recovery required on readonly filesystem
> > EXT4-fs (mmcblk1p4): write access will be enabled during recovery
> > sunxi-mmc 1c11000.mmc: data error, sending stop command
> > sunxi-mmc 1c11000.mmc: send stop command failed
> > [/snip]
> >
> > Previously, mmc2 clock was requesting 520MHz and settling at 512MHz
> > clock rate with following parents:

You mean 52 and 51.2 MHz.

> > [snip]
> > pll-ddr-base        2  2        0   768000000 0     0  50000
> >    pll-ddr-other    1  1        0   768000000 0     0  50000
> >       mmc2          0  0        0    51200000 0     0  50000
> > [/snip]
> >
> > Now, after the improvements, requested and settled rate are both
> > 520MHz, but as mmc2 clock cannot adjust parent rate, the situation
> > ends up like this:
> > [snip]
> > pll-periph-base     3  3        0  1200000000 0     0  50000
> >    pll-periph       6  6        0   600000000 0     0  50000
> >       mmc2          3  3        0    50000000 0     0  50000
> > [/snip]
> >
> > With this patch (allowing mmc2 to set parent rate), we end up with
> > working tree with both mmc0 (sd-card) and mmc2 (eMMC) working:
> > [snip]
> > pll-periph-base     3  3        0   312000000 0     0  50000
> >    mbus             1  1        0    78000000 0     0  50000
> >    pll-periph-sata  1  1        0    26000000 0     0  50000
> >       sata          1  1        0    26000000 0     0  50000
> >    pll-periph       5  5        0   156000000 0     0  50000
> >       mmc2          0  0        0    52000000 0     0  50000
> >       mmc0          0  0        0    39000000 0     0  50000
> > [/snip]
> >
> > Fixes: 3f790433c3cb ("clk: sunxi-ng: Adjust MP clock parent rate when allowed")
> > Signed-off-by: Priit Laes <plaes@plaes.org>
>
> Applied, thanks!
> Maxime

I'm concerned for other users of the PLL-PERIPH clock. AFAIK
all of them, except the HRTIMER, expect the clock rate to stay
the same and not change underneath them. And SATA expects it to
be at 600 MHz, as the datasheet says. And while it may not directly
apply to the LIME2, eMMC on newer SoCs / boards run at the slightly
reduced rate of 50 MHz just fine.

In the commit in question, clocks without CLK_SET_RATE_PARENT
should be using the old code (now in the if conditional block),
i.e. the behavior should not have changed.

I don't think this actually "fixes" whatever bug was introduced,
but only papers over the issue, and possible introduces further
issues for other users.

Regards
ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
