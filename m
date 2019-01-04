Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA24C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:12:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB9E217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pRh4sx20";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="RKoqGrgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB9E217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sKgVgWqhyVTvIGc1PglZvHIqFT21Ld8qX53HyKyNtyI=; b=pRh4sx20JopXcU
	ld8ylzmt2PYG11dMct/W4ur7vs8934qJZAsuKMBueqICWx4wLC+luJS63nzgqA3yEKcKVf6rzyno9
	hUEqGeMseemU4m2lMA3Ns8MSeui5/wxY7mspanKsrLwGfKpVJa2NBUoVsoeAQI0tIxSilKTpbOzPE
	64t9q9iFdqlSlX58u2dSnN/JdQqktqS2UQniLaw0zbrAxmzZG0fXRVNV/cUl7JB5fc/jTg+UW7JGV
	NW30BzPQllm6r1pe3Si2jWD45lsoz23cwKLmGfGGXBpe5kSgCqiHguW6aLwpwthGxXEGJ3A+CY3F6
	+1jgpneX5T8Zf0uJGVVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfLX0-000059-Ii; Fri, 04 Jan 2019 09:12:42 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfLWx-0008WK-Dw
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 09:12:40 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id F279F25AD76;
 Fri,  4 Jan 2019 20:12:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1546593158; bh=iYWpHCIzAYVWmNS4OEUCOVRQzD7XhI2W2mmLHbU2kbk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RKoqGrgPIYqTu9PJ3tyX79WsYXjqHnLhhGw1rOFVUNnFS2jPSgLaeBcnvJc+2oz/W
 NhUQ/GDsFdvWyxQsmeowWCuJPrG+qu4htLrgplFY5fX+L9KqJrWFyFurbAEUhNKwDx
 ltDnimQxLvqgXJ3BDuPPxlhQDyI0Y88kqNLFxuAs=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 12BFA940376; Fri,  4 Jan 2019 10:12:35 +0100 (CET)
Date: Fri, 4 Jan 2019 10:12:35 +0100
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] arm64: defconfig: Enable R-Car thermal driver
Message-ID: <20190104091216.dgbnkxuuamgicysg@verge.net.au>
References: <20190102095154.25839-1-horms+renesas@verge.net.au>
 <CAMuHMdU=aR8mSwd876LV=DG_vh6Bx45zxRTfMXuX3BQpy0M=ow@mail.gmail.com>
 <20190104085720.36ccxhtcbyyzgfrk@verge.net.au>
 <CAMuHMdWf=_-WZT9XUqPCZocNs1As3RJnXMYRYc05Y4td6SciFg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdWf=_-WZT9XUqPCZocNs1As3RJnXMYRYc05Y4td6SciFg@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_011239_611272_3DF7F66B 
X-CRM114-Status: GOOD (  16.25  )
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

On Fri, Jan 04, 2019 at 10:01:13AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Fri, Jan 4, 2019 at 9:57 AM Simon Horman <horms@verge.net.au> wrote:
> > On Wed, Jan 02, 2019 at 11:45:37AM +0100, Geert Uytterhoeven wrote:
> > > On Wed, Jan 2, 2019 at 10:53 AM Simon Horman <horms+renesas@verge.net.au> wrote:
> > > > Enable the R-Car thermal driver as a built-in.
> > > >
> > > > This driver is used in conjunction with the R-Car V3M (r8a77970),
> > > > E3 (r8a77990) and D3 (r8a77995) SoCs.
> > >
> > > > [v2] Enable as a built-in rather than a module as this seems
> > > >      safer from the point of view of protecting equipment from
> > > >      overheating.
> > >
> > > Shouldn't the above paragraph be moved below the ---?
> >
> > I have recently come to believe that its a matter of taste. And I think in
> > this case it captures important information that is worthy of inclusion in
> > the changelog.
> 
> The rationale behind doing it this way could still be appended to the
> first line of the body of the patch decription.

Sorry, I'm having a little trouble parsing that. Do you mean that it could
be appended to the body of the changelog at apply-time?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
