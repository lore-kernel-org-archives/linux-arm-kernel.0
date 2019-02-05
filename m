Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF02C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:43:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F6B62145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Az/ultRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6B62145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=psJ4NdqDfKcaFWLRL2XwR1mxQIDTIE3dJvskVn4ludY=; b=Az/ultRHA2yMUm
	JIji3+h4vDKCkxJlwwOI55RCwp8jIcwhKUmnm2vN423Dk+jdzKFKi6UYkSeVM0n4sLuLq/YNqWHf2
	L25+XqY4EXu5Z8xAoQABLq2lU3YICC72NYqxqrVtXQoqOI2UWM0Uo0XcnqRv5zswa504gDUezmBcM
	T+jfj7sicEMoOQDbvfqsGfuLYABIdnUm/zJzh/Eb4CGahuSNcllf3+c6vbX+VpzkTvi7jy3+4XLJE
	jc0FIZzGy29nR/n8tnn6jasB6AoXliR2Rd58jNL1EFCq4y4mzeungalLCfwN/kToAYrk5ZSKqEQRQ
	Zo5ILt+JLS5o24jwS3XQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqwK1-0000rn-Je; Tue, 05 Feb 2019 08:43:13 +0000
Received: from mail-ed1-f66.google.com ([209.85.208.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqwJy-0000rR-HX
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 08:43:12 +0000
Received: by mail-ed1-f66.google.com with SMTP id a20so2145490edc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 00:43:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uxF7sxTcTVOmIXTNns+MzsXu9a/eBw2fG/LtQgY51Y4=;
 b=tL8TKWZkPeyRnh2YRcUr5ZXRdw1mzQtYfTNwMSAy6jQNnHEYcKZxPQN9h0A/Us8QbF
 Xb1OwuQ54jwEv77wbxxwIj79Eftul9S+WmtLYNjcDpi4v9PXytYMNncLz+3IpsoXcjeN
 +Ii4/j+O653eZrdcf56EH9qmHH1tj2mRB6SrreP45xe2RW7x7PrQFceF7uSoNV0ScZWr
 eYP7P+gMVlu/jjgqaNhq+TXOcH9oy5MjJyGgyq1Rbz76tscMk44yRy9GqJFM2c4xsT/R
 63qQPkseBH7jNWCCDLqOwH4mXXpO0acjrjuNVFU2i1V1hG3CltbZuxtgiFGqgt6ibt89
 ZYvQ==
X-Gm-Message-State: AHQUAubD2n7IsMc4O/gDnm+ao2K92Tbc1ikZg7jFUHQ+b4cw8b3aYCsP
 fw1aMWXt2vFsEiANt5F20xKKNQuwmH0=
X-Google-Smtp-Source: AHgI3IaU0o609KRZpiNqeJU9HqbOAiNmy2YyaoaDujW/17ePrJM8L5LcD/yEY88/N4SesT2nErUFQg==
X-Received: by 2002:a17:906:6447:: with SMTP id
 l7mr2655668ejn.156.1549356187799; 
 Tue, 05 Feb 2019 00:43:07 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com.
 [209.85.128.46])
 by smtp.gmail.com with ESMTPSA id s46sm5015863edd.9.2019.02.05.00.43.07
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 00:43:07 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id t200so2684936wmt.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 00:43:07 -0800 (PST)
X-Received: by 2002:a1c:23cc:: with SMTP id j195mr2600594wmj.124.1549356186727; 
 Tue, 05 Feb 2019 00:43:06 -0800 (PST)
MIME-Version: 1.0
References: <20190203155628.16767-1-wens@csie.org>
 <20190203155628.16767-3-wens@csie.org>
 <20190204093427.vg63e5xmd7u52leh@flea>
 <CAGb2v64-3Cs_RaO4erAr96JStEUzZ7ZRDjAYYjK2QsWfxusKxQ@mail.gmail.com>
 <20190204134110.dvo3qvnhiksqig2l@flea>
In-Reply-To: <20190204134110.dvo3qvnhiksqig2l@flea>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 5 Feb 2019 16:42:53 +0800
X-Gmail-Original-Message-ID: <CAGb2v64RAfa1zTq+A0Vjc6TPZ7K9z7qU6qNd8nfKm1U87xDcxw@mail.gmail.com>
Message-ID: <CAGb2v64RAfa1zTq+A0Vjc6TPZ7K9z7qU6qNd8nfKm1U87xDcxw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: sunxi: Filter out unsupported modes declared in
 the device tree
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_004310_586780_DFCDA854 
X-CRM114-Status: GOOD (  31.01  )
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

On Mon, Feb 4, 2019 at 9:41 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Mon, Feb 04, 2019 at 06:16:24PM +0800, Chen-Yu Tsai wrote:
> > On Mon, Feb 4, 2019 at 5:34 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Sun, Feb 03, 2019 at 11:56:27PM +0800, Chen-Yu Tsai wrote:
> > > > The MMC device tree bindings include properties used to signal various
> > > > signalling speed modes. Until now the sunxi driver was accepting them
> > > > without any further filtering, while the sunxi device trees were not
> > > > actually using them.
> > > >
> > > > Since some of the H5 boards can not run at higher speed modes stably,
> > > > we are resorting to declaring the higher speed modes per-board.
> > > >
> > > > Regardless, having boards declare modes and blindly following them,
> > > > even without proper support in the driver, is generally a bad thing.
> > > >
> > > > Filter out all unsupported modes from the capabilities mask after
> > > > the device tree properties have been parsed.
> > > >
> > > > Cc: <stable@vger.kernel.org>
> > > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > > >
> > > > ---
> > > >
> > > > This should be backported to stable kernels in case people try to run
> > > > new device trees (that declare newly supported modes) with old kernels.
> > > > ---
> > > >  drivers/mmc/host/sunxi-mmc.c | 16 ++++++++++++++++
> > > >  1 file changed, 16 insertions(+)
> > > >
> > > > diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> > > > index 7415af8c8ff6..a01433012db0 100644
> > > > --- a/drivers/mmc/host/sunxi-mmc.c
> > > > +++ b/drivers/mmc/host/sunxi-mmc.c
> > > > @@ -1415,6 +1415,22 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
> > > >       if (ret)
> > > >               goto error_free_dma;
> > > >
> > > > +     /*
> > > > +      * If we don't support delay chains in the SoC, we can't use any
> > > > +      * of the DDR speed modes. Mask them out in case the device
> > > > +      * tree specifies the properties for them, which gets added to
> > > > +      * the caps by mmc_of_parse() above.
> > > > +      */
> > > > +     if (!(host->cfg->clk_delays || host->use_new_timings))
> > > > +             mmc->caps &= ~(MMC_CAP_3_3V_DDR | MMC_CAP_1_8V_DDR |
> > > > +                            MMC_CAP_1_2V_DDR);
> > > > +
> > > > +     /* TODO: UHS modes untested due to lack of supporting boards */
> > > > +     mmc->caps &= ~MMC_CAP_UHS;
> > >
> > > I've tested up to SDR104 and it works on the A64 at least
> >
> > That's good to know. What board was this on? I had given up hope waiting
> > for a vendor to produce a board that could do proper voltage switching for
> > SD cards.
>
> On a Sootech SoM, that had an HS400 eMMC and an SDR104 Marvell WiFi
> chip. I don't have that board anymore, and the website seems down now
> though :/

Bummer. So no commercially available board still. :/

> > > > +     /* TODO: This driver doesn't support HS200 and HS400 modes yet */
> > > > +     mmc->caps2 &= ~(MMC_CAP2_HS200 | MMC_CAP2_HS400);
> > >
> > > And HS200 works too.
> >
> > OK. I thought there was some special magic required in the driver. Maybe
> > that was for HS400 only? Again, what board was this on?
>
> Yeah, that was for HS400 only

OK. So would unblocking UHS and HS200, but not enabling them by default,
which is essentially the original behavior, work for you?

If so, I'll respin a version tonight.

ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
