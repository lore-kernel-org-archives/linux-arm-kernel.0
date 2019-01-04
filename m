Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58C2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:01:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5B172184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TlPMasTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B172184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s7jWgL9+aAooVbm7LGEYSdZYfGUf613KsI7j9kxLEmg=; b=TlPMasTm6Pgzri
	oFZWiup1IsbrINAJX2eiw/SnCDwKW2xcagTQ28gYOM9jnXusClhMhYsfQb2v14GRO+J6357jOF7AH
	YmQP3u7OS6KgMoFo0s7f6vuBDEedNbn7FNFrPZdboAEzb/UPd97rODK1JRqHfEuIjPDxV6pYVpI1A
	Nx8cmwNO9yj7/p4nBiSS4IvD00fBkfcD+YWkOxZZxvdE32RzXz5IRdk9l0J3r5OeAMkmYLekF8foY
	3G9EvFn+O0r81ahBVFStVusE0SmOyDfmloY+chQx7N/sp1oQ/Po56NGy3/8Zyx1Xwfc4FklTyxvYP
	1OLX8aKfmhRqc1TfnyTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfLML-0003mR-4d; Fri, 04 Jan 2019 09:01:41 +0000
Received: from mail-vs1-f68.google.com ([209.85.217.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfLM8-0003bh-9s
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 09:01:29 +0000
Received: by mail-vs1-f68.google.com with SMTP id p74so22316928vsc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 01:01:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E/yYzpIOAnHZpxbodo3QGzij6rnk4+olfxKJ0yZmM5U=;
 b=GcjSENTfeVQJZqZDk7H+FrOccwuoW4+ULp9zhG8COq/MmJ94cjv5iwiH9FNvIXgefz
 zc6QJXw4Oy7GyFSbefgEXGTXxNPw9aQMChoSz3FTPjjLTVncnGF+GcsEtwKIWo7JIsaQ
 gSCO1N/357gEcIzb503YLaq86/NL+PMWj8NQhgzAQJT6gn6534e8HJ1OiZXkvCzQxb/4
 XTxbxio0LGQ4uDceB9QgmCRREdA3lzKBXiaWzuGvDu7qKzLWU5m2erydPt6bo/p9v8Pl
 DgCPyESitvJsg9hUN5cf7+xJ+KAERdEgVvTdgS1nAzsY6U8hOt9wZa4P/nuPO1XnDbuQ
 8QPw==
X-Gm-Message-State: AA+aEWb7J2G2lkR+8xkPQ02av57exS1q/+BRZ0oUARmIP6yozyxFmcPk
 KKEy3pGfrNX06+Q6T59MN/WsOCb7BGXeO09AuCQ=
X-Google-Smtp-Source: AFSGD/VfoxwFycOjRvAcRUQyoN1BvrZC76ZOtcRjxNgPvbu5f0Cwsu3oekR06Rvbdv9KoOz8NN3RTWJj9snhgn0TKJM=
X-Received: by 2002:a67:c202:: with SMTP id i2mr18425620vsj.11.1546592485576; 
 Fri, 04 Jan 2019 01:01:25 -0800 (PST)
MIME-Version: 1.0
References: <20190102095154.25839-1-horms+renesas@verge.net.au>
 <CAMuHMdU=aR8mSwd876LV=DG_vh6Bx45zxRTfMXuX3BQpy0M=ow@mail.gmail.com>
 <20190104085720.36ccxhtcbyyzgfrk@verge.net.au>
In-Reply-To: <20190104085720.36ccxhtcbyyzgfrk@verge.net.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 4 Jan 2019 10:01:13 +0100
Message-ID: <CAMuHMdWf=_-WZT9XUqPCZocNs1As3RJnXMYRYc05Y4td6SciFg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: defconfig: Enable R-Car thermal driver
To: Simon Horman <horms@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_010128_345449_A235FC9A 
X-CRM114-Status: GOOD (  15.29  )
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
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Simon,

On Fri, Jan 4, 2019 at 9:57 AM Simon Horman <horms@verge.net.au> wrote:
> On Wed, Jan 02, 2019 at 11:45:37AM +0100, Geert Uytterhoeven wrote:
> > On Wed, Jan 2, 2019 at 10:53 AM Simon Horman <horms+renesas@verge.net.au> wrote:
> > > Enable the R-Car thermal driver as a built-in.
> > >
> > > This driver is used in conjunction with the R-Car V3M (r8a77970),
> > > E3 (r8a77990) and D3 (r8a77995) SoCs.
> >
> > > [v2] Enable as a built-in rather than a module as this seems
> > >      safer from the point of view of protecting equipment from
> > >      overheating.
> >
> > Shouldn't the above paragraph be moved below the ---?
>
> I have recently come to believe that its a matter of taste. And I think in
> this case it captures important information that is worthy of inclusion in
> the changelog.

The rationale behind doing it this way could still be appended to the first line
of the body of the patch decription.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
