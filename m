Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932B3C282CF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:35:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66C4020844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ob3L1YIR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="i/+IfggS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C4020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2POzdEzSEEv41ASPrsv7mLek2uMkTuuNHQCytZGYP10=; b=ob3L1YIRZZbzLa
	Lil2tVi6ew7ZApuk1GwNYrB9tLLj3PHq+f18PYgdI6fox15gHpFuaL42LrEKRywkiapctbrTsel5j
	L+Tr4y4qtHh+mbtHwlgiVb89suDTsKcjOEsgN4tU/Mrb0QBW/lIaQGqzcea1T0YQp89dCaNFgJN1n
	ckA+yVRG1qOCMk0uclQx+wa58Eo094L3KoxZW9/iapFG5SQhl1DGkcdlleBpmOfDBRJp97iobv0KD
	zwDUouHU5Dyc1Wixmrjq3W4M2KOMZL46vNPfEgiIag+37ObRPKoHqo1Kx5bsr6bYiAMWWzmQuH7GK
	Gbo3ivsBWf+FLtKSKGCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go9sy-0005c9-Vu; Mon, 28 Jan 2019 16:35:48 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go9sv-0005ax-Ot
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 16:35:47 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id D012425B7BA;
 Tue, 29 Jan 2019 03:35:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1548693343; bh=2sXz8tKmkSGOFC/Aprio4ztb8ZCYofPqo8MAVncgY4U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=i/+IfggSB0Vuvxtj4SWL/YkTKkN015Ola1ieSyd2sbaPgbM3xCbuj38UVA+b2OIxL
 ChVCFiTaPUF16KhUYoF6KjL+C+0wKG1MkScxVzNZPQJFIIvj6rQUMoXEMPRBA6sVHE
 5khMlj99WuMOxxmC9qRy1VYlQ9MXQDEXXDajkOws=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 49EC29403E0; Mon, 28 Jan 2019 17:35:40 +0100 (CET)
Date: Mon, 28 Jan 2019 17:35:40 +0100
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] clk: renesas: r8a77990: Add Z2 clock
Message-ID: <20190128163337.t2ditrru474ybdob@verge.net.au>
References: <20190128140127.17540-1-horms+renesas@verge.net.au>
 <CAMuHMdUw6WjkykiCwK6_SYt+ktF-DkU+jczuoLuRh0-fKpVNwA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdUw6WjkykiCwK6_SYt+ktF-DkU+jczuoLuRh0-fKpVNwA@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_083545_999245_0622228E 
X-CRM114-Status: GOOD (  11.74  )
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

On Mon, Jan 28, 2019 at 04:12:03PM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Mon, Jan 28, 2019 at 3:01 PM Simon Horman <horms+renesas@verge.net.au> wrote:
> > Adds Z2 clock to CPG driver for the R-Car E3 (r8a77990) SoC.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Thanks for your patch!
> 
> > --- a/drivers/clk/renesas/r8a77990-cpg-mssr.c
> > +++ b/drivers/clk/renesas/r8a77990-cpg-mssr.c
> > @@ -79,6 +79,7 @@ static const struct cpg_core_clk r8a77990_core_clks[] __initconst = {
> >         DEF_RATE(".oco",       CLK_OCO,            8 * 1000 * 1000),
> >
> >         /* Core Clock Outputs */
> > +       DEF_FIXED("z2",        R8A77990_CLK_Z2,    CLK_PLL0D4,     1, 1),
> 
> According to R-Car Gen3 Hardware User's Manual rev. 1.50, the SYS-CPU
> Divider 2 is controlled through the Z2FC bit field in the Frequency
> Control Register C. So it is not a fixed clock, unlike on R-Car D3.

Thanks, I will look into that.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
