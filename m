Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC91DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:15:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79E4A21871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J/joTCO/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="Emj4sbRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E4A21871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+mELGS7ii1Mzgu3rHtapEL0PHQOEgY3pdKLgXhvHm6w=; b=J/joTCO/9mAB40
	wETvXLwh7qZ7int3HktQWaVB97K3eIfm1tClDxwOyCSvrii5+zVu3Id8piwqfGLG71hf+9Bcl/t5z
	KOhqhMwSGVuEvW/P48uo7HuVuDCZlnzeefAvuuMPQgGZPRimnyy12TT69SoxQwq5CSJEOGg3QPp8l
	n9GcUegVQnsHXfN5aTHLlaS/eOhjv5/YB8uxV75y9AnhQ02jcgIgdvqxFgx8j/p4l1R5poNPqzh0Z
	CmXrVZLBowFwHtHvYeZjuTVbe90Imsep6RSJro8+Fh4f8WpEe83Gqkx+tTJvBKgKv2N8Jf4iuJTfG
	WNgtKd0hFoCBF+mT7oEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfPKE-0001KP-KZ; Fri, 04 Jan 2019 13:15:46 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfPKA-0001Jp-It
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 13:15:44 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 42C4D25B747;
 Sat,  5 Jan 2019 00:15:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1546607734; bh=duS/C5f2ArnpxMnYmNAJSSPfOzi2JSwQQ96/l/mJGFc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Emj4sbRP7g6lmvM3pdXlji3ZgJq8f/QLYlqv2D3aNRPuGQrKkFHCh938VY7dRiKG1
 mjZN8A/utnjachCVVg3sA83XgN0qTA8lkLD6TCkAj2tlkgyP0t5vG0fKtKOjvwX3kV
 9tgocp9RQ8u1IFVpp/7oESCz8XRSe9MymV81W0i0=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 37D94940376; Fri,  4 Jan 2019 14:15:32 +0100 (CET)
Date: Fri, 4 Jan 2019 14:15:32 +0100
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] arm64: defconfig: Enable R-Car thermal driver
Message-ID: <20190104131531.yqw2drds5rjpe6bg@verge.net.au>
References: <20190102095154.25839-1-horms+renesas@verge.net.au>
 <CAMuHMdU=aR8mSwd876LV=DG_vh6Bx45zxRTfMXuX3BQpy0M=ow@mail.gmail.com>
 <20190104085720.36ccxhtcbyyzgfrk@verge.net.au>
 <CAMuHMdWf=_-WZT9XUqPCZocNs1As3RJnXMYRYc05Y4td6SciFg@mail.gmail.com>
 <20190104091216.dgbnkxuuamgicysg@verge.net.au>
 <CAMuHMdWhCf-DSvVw7Z-uNpCJZ_kdGzf297OSFLZzc5TZvTNS3A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdWhCf-DSvVw7Z-uNpCJZ_kdGzf297OSFLZzc5TZvTNS3A@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_051543_271924_69273AC8 
X-CRM114-Status: GOOD (  23.79  )
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

On Fri, Jan 04, 2019 at 10:17:15AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Fri, Jan 4, 2019 at 10:12 AM Simon Horman <horms@verge.net.au> wrote:
> > On Fri, Jan 04, 2019 at 10:01:13AM +0100, Geert Uytterhoeven wrote:
> > > On Fri, Jan 4, 2019 at 9:57 AM Simon Horman <horms@verge.net.au> wrote:
> > > > On Wed, Jan 02, 2019 at 11:45:37AM +0100, Geert Uytterhoeven wrote:
> > > > > On Wed, Jan 2, 2019 at 10:53 AM Simon Horman <horms+renesas@verge.net.au> wrote:
> > > > > > Enable the R-Car thermal driver as a built-in.
> > > > > >
> > > > > > This driver is used in conjunction with the R-Car V3M (r8a77970),
> > > > > > E3 (r8a77990) and D3 (r8a77995) SoCs.
> > > > >
> > > > > > [v2] Enable as a built-in rather than a module as this seems
> > > > > >      safer from the point of view of protecting equipment from
> > > > > >      overheating.
> > > > >
> > > > > Shouldn't the above paragraph be moved below the ---?
> > > >
> > > > I have recently come to believe that its a matter of taste. And I think in
> > > > this case it captures important information that is worthy of inclusion in
> > > > the changelog.
> > >
> > > The rationale behind doing it this way could still be appended to the
> > > first line of the body of the patch decription.
> >
> > Sorry, I'm having a little trouble parsing that. Do you mean that it could
> > be appended to the body of the changelog at apply-time?
> 
> I mean the rationale could have been part of the patch description, i.e.
> above the ---, e.g.:

Thanks, I understand now.

> 
>     Subject: [PATCH v2] arm64: defconfig: Enable R-Car thermal driver
> 
>     Enable the R-Car thermal driver as a built-in.
>     Built-in seems safer than modular from the point of view of protecting
>     equipment from overheating.
> 
>     This driver is used in conjunction with the R-Car V3M (r8a77970),
>     E3 (r8a77990) and D3 (r8a77995) SoCs.
> 
>     Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>     ---
>     v2:
>       - Switch from built-in to modular.
> 
>      arch/arm64/configs/defconfig | 1 +
>      1 file changed, 1 insertion(+)
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
