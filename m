Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D56C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:16:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10DE82081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LdDfP4mR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10DE82081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DTQfMJG9oH8BqxyQhC5/YKe9d4nGYUXqgg36kunPF68=; b=LdDfP4mRTwNCz8
	PihrQFE4UMk1mPer4CvUYoDwt860/Qol+EkBzLVTW/p1P5evyUphljJ8WNNY5abjSNvcw42rBTiwg
	cNw2QuK1Drf0z93HhDtEPbivJ2FtROwxcP4llDx0uSQiJSXp5cYrJsDzmWXQDDiNK0XyASA2de2Q3
	5GPlzLy5Nu7uTeACoEhjrZaLzlPH4pAz/dELiX0v55zTzW0w6hPBBsg8OUOud+/MAuiPH6iaz6/oq
	+ogQck4WWM8LxdEbeZjyMnTe2KzuIkoSwiVBgDPlKlyZzQScMlfbyIwt7utfvDFtdbXP/5rEircvZ
	pl2USmpTULLIjHUxXsAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqbIx-0003Sw-M5; Mon, 04 Feb 2019 10:16:43 +0000
Received: from mail-ed1-f68.google.com ([209.85.208.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqbIu-0003SW-Hi
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 10:16:42 +0000
Received: by mail-ed1-f68.google.com with SMTP id y56so10707521edd.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 02:16:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wpzWuORgBg636KF1R4KFV5Q+sc913BynZzqrcQjMm0g=;
 b=MKAuGBYr8mvZ2ij/rjik68gZ4YB49B1/JzZUiBw3CCeRCIUFym6Vv+pP7pAdv2B+C+
 E0Lt+aQNrRfADpm4vYmpY+bENOqJZMdDU3diJPdol2XFM8Eu286CyiuXVnr73RdvStZX
 TEsqih3nos2XcKZ3M6qrSFTcCF3OgsnjwqnFNc0+11hLJ/pA/wuFBHpHBernJ6PHOkFk
 DPhCjiXmceVrsMM7HjqdJt0PJ1X0qAp9LKdOfk+lplcGCgvjQWqysRZ73TMBV76mRv+a
 fway6aN5pq6o0XtCwMLfdPmrQHG75HncWsySTbVqB8T9oKat+LmlnV832R2CJwph8vzt
 dP5A==
X-Gm-Message-State: AJcUukegHq9jn22FZ302PCHcUoroS8R1o0zxf8WmVwdQtKb/1jvD7d7c
 uWnafUkowf/hjD+JU4dWjLMbD+Vo6iQ=
X-Google-Smtp-Source: ALg8bN6zTKCqjiSsBwciEzzcOy9aQIeb0U+8bYd57gsax2roJGPGFXYr+9l3SLRMdVKdU1sg/LauhA==
X-Received: by 2002:a50:aa9b:: with SMTP id q27mr50098560edc.93.1549275397923; 
 Mon, 04 Feb 2019 02:16:37 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com.
 [209.85.221.45])
 by smtp.gmail.com with ESMTPSA id f20sm4341140edf.19.2019.02.04.02.16.37
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 02:16:37 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id a16so8139166wrv.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 02:16:37 -0800 (PST)
X-Received: by 2002:adf:eb12:: with SMTP id s18mr7407806wrn.120.1549275396962; 
 Mon, 04 Feb 2019 02:16:36 -0800 (PST)
MIME-Version: 1.0
References: <20190203155628.16767-1-wens@csie.org>
 <20190203155628.16767-3-wens@csie.org>
 <20190204093427.vg63e5xmd7u52leh@flea>
In-Reply-To: <20190204093427.vg63e5xmd7u52leh@flea>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 4 Feb 2019 18:16:24 +0800
X-Gmail-Original-Message-ID: <CAGb2v64-3Cs_RaO4erAr96JStEUzZ7ZRDjAYYjK2QsWfxusKxQ@mail.gmail.com>
Message-ID: <CAGb2v64-3Cs_RaO4erAr96JStEUzZ7ZRDjAYYjK2QsWfxusKxQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: sunxi: Filter out unsupported modes declared in
 the device tree
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_021640_587429_C6F8925E 
X-CRM114-Status: GOOD (  26.47  )
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
Cc: devicetree <devicetree@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Chris Blake <chrisrblake93@gmail.com>,
 linux-mmc@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 4, 2019 at 5:34 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Sun, Feb 03, 2019 at 11:56:27PM +0800, Chen-Yu Tsai wrote:
> > The MMC device tree bindings include properties used to signal various
> > signalling speed modes. Until now the sunxi driver was accepting them
> > without any further filtering, while the sunxi device trees were not
> > actually using them.
> >
> > Since some of the H5 boards can not run at higher speed modes stably,
> > we are resorting to declaring the higher speed modes per-board.
> >
> > Regardless, having boards declare modes and blindly following them,
> > even without proper support in the driver, is generally a bad thing.
> >
> > Filter out all unsupported modes from the capabilities mask after
> > the device tree properties have been parsed.
> >
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >
> > ---
> >
> > This should be backported to stable kernels in case people try to run
> > new device trees (that declare newly supported modes) with old kernels.
> > ---
> >  drivers/mmc/host/sunxi-mmc.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> > index 7415af8c8ff6..a01433012db0 100644
> > --- a/drivers/mmc/host/sunxi-mmc.c
> > +++ b/drivers/mmc/host/sunxi-mmc.c
> > @@ -1415,6 +1415,22 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
> >       if (ret)
> >               goto error_free_dma;
> >
> > +     /*
> > +      * If we don't support delay chains in the SoC, we can't use any
> > +      * of the DDR speed modes. Mask them out in case the device
> > +      * tree specifies the properties for them, which gets added to
> > +      * the caps by mmc_of_parse() above.
> > +      */
> > +     if (!(host->cfg->clk_delays || host->use_new_timings))
> > +             mmc->caps &= ~(MMC_CAP_3_3V_DDR | MMC_CAP_1_8V_DDR |
> > +                            MMC_CAP_1_2V_DDR);
> > +
> > +     /* TODO: UHS modes untested due to lack of supporting boards */
> > +     mmc->caps &= ~MMC_CAP_UHS;
>
> I've tested up to SDR104 and it works on the A64 at least

That's good to know. What board was this on? I had given up hope waiting
for a vendor to produce a board that could do proper voltage switching for
SD cards.

> > +     /* TODO: This driver doesn't support HS200 and HS400 modes yet */
> > +     mmc->caps2 &= ~(MMC_CAP2_HS200 | MMC_CAP2_HS400);
>
> And HS200 works too.

OK. I thought there was some special magic required in the driver. Maybe
that was for HS400 only? Again, what board was this on?

Thanks
ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
