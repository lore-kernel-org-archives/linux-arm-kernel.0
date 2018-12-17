Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8903C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:54:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D559206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UO7kE3zk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="bZqp5nv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D559206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xPecIYccpT25nIss/F2F0OhEO77OboNuRj7HVXkZV64=; b=UO7kE3zkT2jm6D
	BUh+NjGOndHSZVMDj3mVMVGrwuOD/w1UlixOnR4aTZUcDL49/8mT+BrxWr0y/0Pz1UKyj2vIDa41R
	KIFpfIdblSnayWm3le6HIBFY0NDRlAw9C37+s1yzmORWfo79aKiT6Uar3zRwj3zrf3BU4UhtVXxW8
	kfh6EwTccgsoGmuenUxn7aZe4hTNDzrcC42/LVVDW4ya53QmFjW/ghQvuTOg4lJCHsBZvLkwvGXJN
	tsP1o0xQOPQgntGWkpYbyoQgVLm3N1GJOckjQdTtaM5+40OwRYySXApjAApcusxFstbe3d0RcCiUY
	vOJ6/ixVG2ed6Yg5IWeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYuHb-0003VC-BC; Mon, 17 Dec 2018 14:54:11 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYuHX-0003UJ-0R
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 14:54:09 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 3E4F425B781;
 Tue, 18 Dec 2018 01:53:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1545058433; bh=MMtSLILbamHCzSvh0JcFNWqbPnWcIrsgTH7ITHRdDzY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bZqp5nv6kF61JkMLqQqdycsqwILJJcEI1sHRH+3a0pfqQl5/a7WjxmcE3/NUa6ZK8
 b112nAS1wLyyP10PwtUyr7iHh0NIuCJE6r2j/oYeypNGvP5WNUa1mN6fcuXbsiAB/K
 HWF+6fekEQRQsqPHn71E6l824NLf4+Es3LH9fwAA=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 6062E94048A; Mon, 17 Dec 2018 15:53:51 +0100 (CET)
Date: Mon, 17 Dec 2018 15:53:51 +0100
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] ARM: shmobile: Add missing dts files to MAINTAINERS
Message-ID: <20181217145350.a6fp2quy2gylbflf@verge.net.au>
References: <20181212105435.28310-1-horms+renesas@verge.net.au>
 <CAMuHMdVoJSxOJ4X1_nF8qG-g9EgCYLKUhuqHyJ65J3rjhiqq7w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdVoJSxOJ4X1_nF8qG-g9EgCYLKUhuqHyJ65J3rjhiqq7w@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_065407_696947_F6D6590E 
X-CRM114-Status: GOOD (  12.90  )
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
 Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Biju Das <biju.das@bp.renesas.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 17, 2018 at 03:23:27PM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Wed, Dec 12, 2018 at 11:55 AM Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Add some more patterns to the ARM/SHMOBILE ARM ARCHITECTURE
> > section of MAINTAINERS to complete the list of maintained dts files.
> >
> > As of writing dts files covered are:
> > * arch/arm/boot/dts/gr-peach-audiocamerashield.dtsi
> > * arch/arm/boot/dts/iwg20d-q7-common.dtsi
> > * arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2075,6 +2075,8 @@ Q:        http://patchwork.kernel.org/project/linux-renesas-soc/list/
> >  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git next
> >  S:     Supported
> >  F:     arch/arm/boot/dts/emev2*
> > +F:     arch/arm/boot/dts/gr-peach*
> > +F:     arch/arm/boot/dts/iwg20d-q7*
> 
> I had hoped to make this more future-proof by shortening the string, but
> apparently there are non-Renesas iwg2* boards.

Thanks, applied for v4.22.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
