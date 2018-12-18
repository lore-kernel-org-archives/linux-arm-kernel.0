Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91313C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:32:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6127721841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LzNMpZ0x";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="flodcFug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6127721841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Subject:To:In-Reply-To:
	Message-ID:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5+DVrXZb4K5sp3bD78eKCocMEHfNx2UZIdDNHkiXywg=; b=LzNMpZ0xrpD/HL
	bjnrcvx8iO0ipSmKKqkbnPUkE32F3vtZQLlT2wcPMZDhMm4EGYg/w5q0DiGUXCrhInCrRn5Kbo0RL
	xmbWmoULn/2G1Ib0K6PJsXO0KHE8uOHhPgdvrJU1HbpdEDAxInb+iuaaqhSkeDua2q3xpFZKVgJG6
	iSCbmceDxTd5Gd68g1MeBDoEEm0GnvPa6RxIMXsQpniEmf8QrfHg1NcjEM60tmatlWZRzboPIuKIw
	I+v3++IYVB9Nt4BIJuyzlUp8Mn9UWq7+FDvCPJp9KKs3+dDeaSMr2Vfi5ZCOSJ+MfPR10D3o7DhW/
	qAGPaDi7KP/Zh8u4vNuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZL6Y-0007uX-2D; Tue, 18 Dec 2018 19:32:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZL6U-0007tR-Ff
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 19:32:32 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B2A4721841;
 Tue, 18 Dec 2018 19:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545161539;
 bh=/nHdXQ/zF4C6rNYzrfEFgxg7f8Fg6aD4YYC1RllIsgQ=;
 h=References:In-Reply-To:To:Cc:Subject:From:Date:From;
 b=flodcFugnfW7N/z0SNd08BA5O3pDIQ80oJ+jsq+TnObvZoXY2uGqVawHTb3319F4w
 E7zACZB48CujJqAluwrnYsEWRUmszG2wSpKanJi6p/BQ1tUIxvnXhMc+9yWXB7AmJ5
 muFgJnyeGAViXn2z4JpleQE1nL89RZ20tNhtYK3s=
MIME-Version: 1.0
References: <1545101396-16335-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5BX6PWBp_FmTsMkZJEsKpf+=N6Zyn8P_+ziis-fKR37Ng@mail.gmail.com> ,
 <1545129634.5874.20.camel@pengutronix.de>
 <7E78DD25-BA90-4EBA-81B9-755CD89BD0BF@nxp.com> ,
 <1545140504.5874.25.camel@pengutronix.de>
 <25BEFDBA-5A09-42E9-A4E3-AC15EF4B1886@nxp.com>
 <1545141748.5874.27.camel@pengutronix.de>
Message-ID: <154516153880.238328.15274393304999995060@swboyd.mtv.corp.google.com>
In-Reply-To: <1545141748.5874.27.camel@pengutronix.de>
To: Anson Huang <anson.huang@nxp.com>, Lucas Stach <l.stach@pengutronix.de>
User-Agent: alot/0.8
Subject: Re: [PATCH] clk: imx: add CLK_GET_RATE_NOCACHE flag for i.MX8M
 composite clock
From: Stephen Boyd <sboyd@kernel.org>
Date: Tue, 18 Dec 2018 11:32:18 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_113230_561021_279001E2 
X-CRM114-Status: GOOD (  19.53  )
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
Cc: "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Lucas Stach (2018-12-18 06:02:28)
> Am Dienstag, den 18.12.2018, 13:53 +0000 schrieb Anson Huang:
> [...]
> > > 
> > > > Regarding about the over head, yes, the change in common composite
> > > > clock register has too many over head for other clocks, what if I
> > > > ONLY have dram core clock to pass the CLK_GET_RATE_NOCACHE flag to
> > > > register the composite clock?
> > > 
> > > IMHO marking clocks under TF-A control explicitly as nocache would be
> > > much more acceptable than doing it for every composite clock. This
> > > seems okay for a short term solution.
> > > 
> > > Still I think that whatever is causing the bus frequency scale to
> > > change should have a way to explicitly invalidate the clock cache for
> > > the affected clocks eventually.
> > 
> > It is because the DDR PLL/clocks can only be changed with strict DDR
> > freq change flow, and it is done in TF-A, Linux kernel can NOT touch
> > it in runtime, so we have to mark the child clock of DDR PLL to be
> > uncached, in V2 patch, I will just add the flag for the DDR PLL child
> > clocks to be a shorten solution, should be only very few ones, hope
> > it is acceptable, thanks.
> 
> I fully understand why you are doing the frequency change in TF-A and I
> agree with the reasoning to do so. I also think that using uncached for
> the few clocks under TF-A control is fine for now.
> 
> But if/when the bus frequency scaling is actually implemented for
> upstream I think the flow should look something like that:
> 
> 1. Bus freq scaling driver determines that a change is necessary
> 2. Scaling driver calls into TF-A to do the change
> 3. TF-A reconfigures clock rates
> 4. Scaling driver calls into clock driver to signal that a clock change
> might have happened
> 5. Clock driver invalidates and recalculates cached values for the
> affected clocks
> 

Does any clk consuming driver of the downstream clks that are branched
off of the bus clk managed by firmware care about the frequency? Or do
they just want the clk to be on. If they don't care then it's possible
to break the parent dependency and just not care to tell them what the
bus frequency is anymore.

I don't know how you would implement #4 above, besides by having the bus
freq scaling driver use clk_set_rate() to tell the bus clk that it wants
a new rate and then having that clk implementation do #2. That way the
rate propagation works without having to notify clk code somehow.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
