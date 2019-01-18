Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF53FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:04:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE3AA20652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QOQrg0MR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3AA20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L20Jbo5m7cKry4pptL871FQSio3ajZH5xxDQ7Z5xAQA=; b=QOQrg0MRfsLQFU
	I4ItE9nS4/FLum4thpxN1aFgT2Nt4o+4It8fJ0txVExPPyDRrmU7QFK9sazVirTe82oxOpjYLQf8m
	Q1i9e/50ZiQhkoaDjCdDBWahgWOkpgSr8nBrsZp3lq/pOzSdM+9opmxBwVC0G5serti1fd3i0yCCQ
	O3ns+CQCBfEJ3BYKSLJZHUCUFIyNIcZwJhgfAY9e0CL1kqpq0HmH+HPYjaGMCO1Ll9nwLC7cuNY3E
	OYTvyonFmn7WtiGrr/n2W/uWq3IkoTN5Yq2Ddb3jlQbDyisCTvrGTcpaFJn1yhqN3H7ns61avkGKf
	hOH+tkr9PELsjDld+7bw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkUl0-0004Tz-T8; Fri, 18 Jan 2019 14:04:26 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkUkw-0004Te-T6
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 14:04:24 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 4F59D207B6; Fri, 18 Jan 2019 15:04:19 +0100 (CET)
Received: from localhost (unknown [212.81.177.10])
 by mail.bootlin.com (Postfix) with ESMTPSA id 0B0E120712;
 Fri, 18 Jan 2019 15:04:18 +0100 (CET)
Date: Fri, 18 Jan 2019 15:04:18 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Priit Laes <plaes@plaes.org>
Subject: Re: [linux-sunxi] Re: HDMI/DVI spurious failure
Message-ID: <20190118140418.m5mliyvddfdfju3v@flea>
References: <20190114132934.rywqqtjarbf6fgcr@plaes.org>
 <20190115094951.e7jnjpibj5tcp5pz@flea>
 <20190116075854.o2kme5nxq5kckwem@plaes.org>
 <20190116192442.qz4xi2ky6axgiyvg@flea>
 <20190116203516.s7pisy4miaclo63u@plaes.org>
 <20190117113340.ydszal5c3nlrqr47@flea>
 <20190118101053.gkxpfymsjzw3ptxf@plaes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190118101053.gkxpfymsjzw3ptxf@plaes.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_060423_076413_63B5F6DA 
X-CRM114-Status: GOOD (  21.86  )
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
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
 Chen-Yu Tsai <wens@csie.org>, Jonathan Liu <net147@gmail.com>,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 10:10:53AM +0000, Priit Laes wrote:
> > > > > > It doesn't look related to the clock rate itself, since it doesn't
> > > > > > change between the two cases. However, in one case the DDC clock is
> > > > > > enabled and in the other it's disabled.
> > > > > > 
> > > > > > Was it taken at the same time? Maybe you can try with that patch?
> > > > > > http://code.bulix.org/z7jmkm-555344?raw
> > > > > 
> > > > > Thanks, after doing ~50+ boots I haven't seen a single failure.
> > > > > 
> > > > > Previously I had following failure cases which are now both fixed:
> > > > > 
> > > > > a) Linux without u-boot HDMI, where one in every 6-7 boots failed.
> > > > > b) u--boot with hdmi enabled switching to simplefb and then switching
> > > > > to kms, where previously all boots ended up with garbled screen.
> > > > 
> > > > So it's not really a fix, but it really looks like the clock is not
> > > > enabled when it should.
> > > > 
> > > > Can you describe your test scenario a bit more? What are you doing
> > > > exactly, just booting? When do you start using the display? When did
> > > > you capture the debugfs output that you pasted?
> > > 
> > > Display is already connected via HDMI to the board. I don't really
> > > remove it, I just boot the device and let it start Xorg.
> > > Meanwhile I just ssh into the device and capture debugfs output.
> > > See my 3 testing scenarios below.
> > > 
> > > Kernel also includes one extra patch to fall back to DDC, in case HPD
> > > fails. Mostly the same I already submitted last November [1].
> > 
> > Do you have the same issue without that patch?
> 
> Can't really test this display without this patch and I do not have other
> HDMI/DVI screens. And this issue does not happen with other HDMI displays
> that I have here.

Can't you just force the monitor to be reported as present? It's not
great and we don't want to merge it, but that would allow you to test
that setup without too many interferences.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
