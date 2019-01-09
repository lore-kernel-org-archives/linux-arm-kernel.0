Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A1EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:58:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35B0720859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="piqjbOGt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="qtnHsmtn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B0720859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wW8prebASFyD4LhL0+SYVw7+2flTRaDr8es/9zT02/E=; b=piqjbOGtHTkOc0
	pMnzh2fecov2aL/ErWVlj/VMbZR1ryHlEjBctccAYeN8fh9psfWoP8plrPg7KL/K1tiJ5FQMgEc0X
	xEKNvArS84tgdPJouORE/TCOU0ljzGDisIqG/1WATNt7rJ3SHRCn+LRzzkX+S2N1BeeWoIXNWejwO
	yGbpuBnE+m6eCGYzJsOWYDVhtJifof/1l/zYOMhlMQD+AVEGzL9/S1wSPYZ551mD/0hrJW1+mSef6
	fF5BuaVGeWLR+itjQTohm8Y3yf5z2qsNGvoNxNC63POr4pUAuOt/d9YsmDLDj1K9icmUS76Dytu5S
	HIsa6vcURF96GHJeQeTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghHBa-0006c4-Ot; Wed, 09 Jan 2019 16:58:34 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghHBV-0006ay-Bl
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 16:58:32 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id C379C25B780;
 Thu, 10 Jan 2019 03:58:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1547053106; bh=dznEJDjOOjNrhlXP3RBUxBg40PRs5r4ApPNfVC0oEhQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qtnHsmtnqtahyTCQCsZR8Juo+oCkkPTBhwEMdIKiLt/JU/YohU2mZKwm1T51lKD8j
 TS1XP5BbDk393ZsXW6nsoAOWwPFTlzla/ByoUM1mV4B8YulxyjXN7nvjXe9+LApYYz
 pK4u8Ypd1oVWsl3fifV69eqlzC89JpkpVmhdNWwM=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 9B886940420; Wed,  9 Jan 2019 17:58:23 +0100 (CET)
Date: Wed, 9 Jan 2019 17:58:23 +0100
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] arm64: dts: renesas: r8a77990: ebisu: Fix backlight
 regulator numbering
Message-ID: <20190109165822.tmj7qbho46f7clvg@verge.net.au>
References: <20190109140045.17449-1-marek.vasut@gmail.com>
 <CAMuHMdX3bP_WCYNRRMmVRPwV52e72NOZMtW8cf29Fo+E9_CvcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdX3bP_WCYNRRMmVRPwV52e72NOZMtW8cf29Fo+E9_CvcQ@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_085829_620576_84787375 
X-CRM114-Status: GOOD (  15.59  )
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
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Marek Vasut <marek.vasut@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 09, 2019 at 04:26:25PM +0100, Geert Uytterhoeven wrote:
> On Wed, Jan 9, 2019 at 3:01 PM <marek.vasut@gmail.com> wrote:
> > From: Marek Vasut <marek.vasut+renesas@gmail.com>
> >
> > There are two regulator1 nodes in the Ebisu DTS right now, one 3.3V for
> > the eMMC and one 12V for the backlight. This causes one to be overwritten
> > by the other, ultimatelly resulting in inoperable eMMC, which depends on
> > the former. Fix this by renumbering the backlight regulator to regulator2.
> >
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > Cc: Simon Horman <horms+renesas@verge.net.au>
> > Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Cc: linux-renesas-soc@vger.kernel.org
> > Reported-by: Simon Horman <horms+renesas@verge.net.au>
> > Fixes: 9d16c4a10e07 ("arm64: dts: renesas: r8a77990: ebisu: Add backlight")
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > --- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> > +++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> > @@ -191,7 +191,7 @@
> >                 clock-frequency = <24576000>;
> >         };
> >
> > -       reg_12p0v: regulator1 {
> > +       reg_12p0v: regulator2 {
> >                 compatible = "regulator-fixed";
> >                 regulator-name = "D12.0V";
> >                 regulator-min-microvolt = <12000000>;
> 
> Perhaps the node name should get a more descriptive suffix
> (e.g. "regulator-12p0v"), like is already done for some of the other
> regulators?

I think I would prefer that addressed in a follow-up patch.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
