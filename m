Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B3CC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:36:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52DCC20818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CSDle/Ml";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="UcWzavtC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DCC20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Uy9jjAX6LXCGCsFAwsULnF9xXVSaRwbgPZzAqbxDdXs=; b=CSDle/Ml0pwGLm
	7V9J5LPZ/vRs3UYb/qdWDIGGFmhayinUsFUZJdvVrcbDbnVqMIQMXsZUdNa/tFns46eH3cyClJE2L
	iZH4nlROGlyxM2nAFm1smjzo90fXQGRUMSoUGFFm1z8pyFLwEwf1NPVx1GWbul8MoyicbKewAFq6R
	vv9muYx+T6tFJHl426LxjtlfKD8Hf9MO0Ea/26HGqStdW4Ug9pAcHmTN+1+n8mX/qpotX8y7XGbDQ
	qEvqz0GjwM19ZWVFFQUnrG8083iZTWcS0tRdmKuTdvCKjamJvmi3YiZKUzs/razN0wZvioAteGzIW
	+czKBbgGflvhvSZSeJdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtCgk-0001bt-Lq; Mon, 11 Feb 2019 14:36:02 +0000
Received: from plaes.org ([188.166.43.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtCgg-0001aW-Ul
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 14:36:00 +0000
Received: from plaes.org (localhost [127.0.0.1])
 by plaes.org (Postfix) with ESMTPSA id C02C9412CA;
 Mon, 11 Feb 2019 14:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
 t=1549895753; bh=8Gi4omit073u81WaoF9zvkqRCS3LXU7oUSEGO5wyFVg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UcWzavtCei5KDgJWdYUmJqg3iM+kJGgqI6RL1LfSuXi7HxH8x92/YtcE/TFpRV/vd
 OXTkEpfGw0zTjOOhXn26nTz88366xRfx/duaJqI5JvIA6oDOpPckgIU4P3dDRu3uN4
 l9z2yNsJdbOCz1Hrle7EwdowWHV6rNEPpa+KU1XNhHWubpo5LKKYZhK7ZPpF4LFvEp
 dXlObLMkJjG1EudRgdcaFUugj+GukUBJQ8cYeGpYhXF5b8vf7dhXZtywiCn+KupPB5
 ku36ilStHzdIwhC5RzuoXiDBk0fiXEaiuIYZA3G36e8i53XSBp8x9scneTReEAt+ta
 IP0ydVUHZEYrA==
Date: Mon, 11 Feb 2019 14:35:52 +0000
From: Priit Laes <plaes@plaes.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [RFC PATCH] clk: sunxi-ng: sun4i: Use CLK_SET_RATE_PARENT for
 mmc2 clock
Message-ID: <20190211143552.2uqx6yy53dyv5lbl@plaes.org>
References: <20190202155209.31617-1-plaes@plaes.org>
 <20190205094529.t7je4ozzu2b4ornc@flea>
 <CAGb2v673ntXn7MTRhU1uecO9q8_i79e+Ovio=tucd6qFf5L84Q@mail.gmail.com>
 <20190206092000.f46nsn4fw2n4crub@flea>
 <20190206100309.dhkm2l73qzkwgjzg@plaes.org>
 <20190206155227.wbkzvsdgykir4wn5@flea>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190206155227.wbkzvsdgykir4wn5@flea>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_063559_133504_F355C676 
X-CRM114-Status: GOOD (  20.31  )
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
Cc: Jernej Skrabec <jernej.skrabec@siol.net>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 linux-clk <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 06, 2019 at 04:52:27PM +0100, Maxime Ripard wrote:
> Hi,
> 
> On Wed, Feb 06, 2019 at 10:03:09AM +0000, Priit Laes wrote:
> > > > I'm concerned for other users of the PLL-PERIPH clock. AFAIK
> > > > all of them, except the HRTIMER, expect the clock rate to stay
> > > > the same and not change underneath them. And SATA expects it to
> > > > be at 600 MHz, as the datasheet says. And while it may not directly
> > > > apply to the LIME2, eMMC on newer SoCs / boards run at the slightly
> > > > reduced rate of 50 MHz just fine.
> > > > 
> > > > In the commit in question, clocks without CLK_SET_RATE_PARENT
> > > > should be using the old code (now in the if conditional block),
> > > > i.e. the behavior should not have changed.
> > > > 
> > > > I don't think this actually "fixes" whatever bug was introduced,
> > > > but only papers over the issue, and possible introduces further
> > > > issues for other users.
> > > 
> > > You're right, I've overlooked that it was pll-periph being
> > > affected. I've dropped it for now.
> > 
> > Any ideas what could be done. I currently have no time to debug it,
> > but it affects existing systems.
> 
> I can't find what would change with that commit either if the flag
> isn't set, so looking at the register state before and after that
> commit would help I guess?

Register dump without the patch:

$ busybox devmem 0x01c20090
0x0250030E

pll-ddr-base     2 2 0   768000000          0     0  50000
   pll-ddr-other 1 1 0   768000000          0     0  50000
      mmc2       3 3 0    51200000          0     0  50000

Register dump with patch applied, booted from mmc0 and after mounting emmc:

$ busybox devmem 0x01c20090
0x8140020B

pll-periph-base  3 3 0  1200000000          0     0  50000
   pll-periph    6 6 0   600000000          0     0  50000
      mmc2       3 3 0    50000000          0     0  50000



> 
> Maxime
> 
> -- 
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
