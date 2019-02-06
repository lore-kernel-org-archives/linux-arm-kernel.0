Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CEEC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:03:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F51B2080A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OWoXR0IA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="eXqHcEoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F51B2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aosKB4yGvuqGM5caj0L2Ud0r/DQGQxbWbCB4BZ2JoTE=; b=OWoXR0IAiboVOG
	B8H9qtm1zwyK/MQDUvrEhP+rXVtr21qTUFHnrg8FugtmA2Jc6MA4jDk5gmkNe1R8Qmgi486LYcbjp
	N40wIfKHc1iHhrjcXbHPVZQD4Qfj1BzOaZT6EfS2qRlmtzuLA55I37TvwaDD2hYtsnz56YbqYDB2M
	HUUgr6AQLR996U6fLHWUy1laKFRVIImfSnHDXwwbZdfReVw3HmhZtM8sy9a+ogCF6LRSuTyS4tsG9
	aziZowqpgH47mK5eVeNCBYmg2OqXtiszXFLQcfIuPE2AVNKqzNMFx7lTvFuLrIWtIiKh+8StCQk/I
	bx9tnHihJIXXXM2MHL4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grK34-00031V-RD; Wed, 06 Feb 2019 10:03:18 +0000
Received: from plaes.org ([188.166.43.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grK30-00030B-LW
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 10:03:16 +0000
Received: from plaes.org (localhost [127.0.0.1])
 by plaes.org (Postfix) with ESMTPSA id 06D7140354;
 Wed,  6 Feb 2019 10:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
 t=1549447391; bh=8/Z5G5XftRwjdoYiNOxsQ/6m69rVL16G4o3Y/S7FXm0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eXqHcEoeXo54Xi9KStGy0yeEDlj6G2dXvNqbnvgoUCtZonDcmgdYralLCt5QWL3Dy
 4hCvLSLUJ2WMz6RwCi1phA11984YzXDB6mP4yHJQzAVN8M1Vnv6yvznal4WLvsNa7u
 XJh3N4uRzT23fnI8K5ZLVrYy4FV6wYFbqJmgQze3NnUnoYvCCDdkylupHSeb8GDPSG
 qntmwlRtAdtkI/xTjk02VCarzmn8z0w2wW4HQe6hkxKMlht9ddMhMijP5geEOkLoGO
 XZ1HZvPzfHMUYFMFQzVJiKVYTLgtgWNdX0+emZHGM97d24dMQp30KyvDVBWRE7KQu+
 enOCt739q7UuQ==
Date: Wed, 6 Feb 2019 10:03:09 +0000
From: Priit Laes <plaes@plaes.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [RFC PATCH] clk: sunxi-ng: sun4i: Use CLK_SET_RATE_PARENT for
 mmc2 clock
Message-ID: <20190206100309.dhkm2l73qzkwgjzg@plaes.org>
References: <20190202155209.31617-1-plaes@plaes.org>
 <20190205094529.t7je4ozzu2b4ornc@flea>
 <CAGb2v673ntXn7MTRhU1uecO9q8_i79e+Ovio=tucd6qFf5L84Q@mail.gmail.com>
 <20190206092000.f46nsn4fw2n4crub@flea>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190206092000.f46nsn4fw2n4crub@flea>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_020315_061349_11F5D256 
X-CRM114-Status: GOOD (  23.37  )
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

On Wed, Feb 06, 2019 at 10:20:00AM +0100, Maxime Ripard wrote:
> On Tue, Feb 05, 2019 at 09:44:02PM +0800, Chen-Yu Tsai wrote:
> > On Tue, Feb 5, 2019 at 5:45 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Sat, Feb 02, 2019 at 05:52:09PM +0200, Priit Laes wrote:
> > > > Recent patch of improving MP clock rate calculations by taking
> > > > into account whether adjusting parent rate is allowed, have
> > > > unfortunately broken eMMC support on A20 Olinuxino-Lime2-eMMC
> > > > boards which fail with following error:
> > > >
> > > > [snip]
> > > > EXT4-fs (mmcblk1p4): INFO: recovery required on readonly filesystem
> > > > EXT4-fs (mmcblk1p4): write access will be enabled during recovery
> > > > sunxi-mmc 1c11000.mmc: data error, sending stop command
> > > > sunxi-mmc 1c11000.mmc: send stop command failed
> > > > [/snip]
> > > >
> > > > Previously, mmc2 clock was requesting 520MHz and settling at 512MHz
> > > > clock rate with following parents:
> > 
> > You mean 52 and 51.2 MHz.
> > 
> > > > [snip]
> > > > pll-ddr-base        2  2        0   768000000 0     0  50000
> > > >    pll-ddr-other    1  1        0   768000000 0     0  50000
> > > >       mmc2          0  0        0    51200000 0     0  50000
> > > > [/snip]
> > > >
> > > > Now, after the improvements, requested and settled rate are both
> > > > 520MHz, but as mmc2 clock cannot adjust parent rate, the situation
> > > > ends up like this:
> > > > [snip]
> > > > pll-periph-base     3  3        0  1200000000 0     0  50000
> > > >    pll-periph       6  6        0   600000000 0     0  50000
> > > >       mmc2          3  3        0    50000000 0     0  50000
> > > > [/snip]
> > > >
> > > > With this patch (allowing mmc2 to set parent rate), we end up with
> > > > working tree with both mmc0 (sd-card) and mmc2 (eMMC) working:
> > > > [snip]
> > > > pll-periph-base     3  3        0   312000000 0     0  50000
> > > >    mbus             1  1        0    78000000 0     0  50000
> > > >    pll-periph-sata  1  1        0    26000000 0     0  50000
> > > >       sata          1  1        0    26000000 0     0  50000
> > > >    pll-periph       5  5        0   156000000 0     0  50000
> > > >       mmc2          0  0        0    52000000 0     0  50000
> > > >       mmc0          0  0        0    39000000 0     0  50000
> > > > [/snip]
> > > >
> > > > Fixes: 3f790433c3cb ("clk: sunxi-ng: Adjust MP clock parent rate when allowed")
> > > > Signed-off-by: Priit Laes <plaes@plaes.org>
> > >
> > > Applied, thanks!
> > > Maxime
> > 
> > I'm concerned for other users of the PLL-PERIPH clock. AFAIK
> > all of them, except the HRTIMER, expect the clock rate to stay
> > the same and not change underneath them. And SATA expects it to
> > be at 600 MHz, as the datasheet says. And while it may not directly
> > apply to the LIME2, eMMC on newer SoCs / boards run at the slightly
> > reduced rate of 50 MHz just fine.
> > 
> > In the commit in question, clocks without CLK_SET_RATE_PARENT
> > should be using the old code (now in the if conditional block),
> > i.e. the behavior should not have changed.
> > 
> > I don't think this actually "fixes" whatever bug was introduced,
> > but only papers over the issue, and possible introduces further
> > issues for other users.
> 
> You're right, I've overlooked that it was pll-periph being
> affected. I've dropped it for now.

Any ideas what could be done. I currently have no time to debug it, but it affects existing systems.
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
