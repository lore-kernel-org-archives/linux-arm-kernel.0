Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084ABC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:47:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC47D2073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IVr08LZG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfY+VLVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC47D2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:References:To:Message-ID:From:
	In-Reply-To:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gcVnDJ054GlE9CDwm6CXNxvhSSr9sQfJyK4NDETcAcM=; b=IVr08LZGrR0ic6
	BR57F5QO24Wydv+WQ1bY2nc3qQJFFVVFxt6twaxIvqNaezwhbcA3eo4XHllGsR6xDPqaNVKtnEl8T
	nCNKNwJrSMs/ttmNobSGF449TmQEW1dXq9tA2Bx6I+oLSI0mhveDv3/ehSFrhhTvam7bG7GxiJ+Ce
	9MiSr45E+Zf5ObAquGsr471rR8DtitEvTGgCz68bkE/Su7fiZsIoats6kEJHABRBAjmR6QAWZmn2h
	n1Nd7sF1gOA8D1P3TygQBKM1EWZb6ktY9pRB597ma0XxeV4zqBV606VKfguEM2FNZt1m+5dNOZhcx
	UzNjwVIWuii7HU41xHcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grRIA-00004s-H4; Wed, 06 Feb 2019 17:47:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grRI8-0008Vz-4Z
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 17:47:21 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C08312073D;
 Wed,  6 Feb 2019 17:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549475239;
 bh=lP+mz8DZ9VE4oAEkbTgi0Qy+WA94LwEJeeaejT+fX1M=;
 h=Cc:Subject:In-Reply-To:From:To:References:Date:From;
 b=HfY+VLVh2ldCo9SPJesH3QSKn944IV4fqHdkKE5AruE53dE1x+Ju1pA3umx24/ccl
 BLRzimKt0nJj/hiGdAj1gsrgtaDmy4l5OICMvIE1RZE9GfHazpJEElj4AbixGuqpPE
 1shBWJnXhQg4hrMo//tSFZo5A5omXZl/u92zqpmA=
MIME-Version: 1.0
User-Agent: alot/0.8
Subject: Re: [PATCH 1/3] dt-bindings: clock: ti,
 sci-clk: Add support for parsing clock info from DT
In-Reply-To: <ab8707fb-e632-5be9-9fdb-4b1fb3cb26ba@ti.com>
From: Stephen Boyd <sboyd@kernel.org>
Message-ID: <154947523891.74891.8214442349263473281@swboyd.mtv.corp.google.com>
To: Rob Herring <robh@kernel.org>, Tero Kristo <t-kristo@ti.com>
References: <1546954223-9738-1-git-send-email-t-kristo@ti.com>
 <1546954223-9738-2-git-send-email-t-kristo@ti.com>
 <20190121210449.GB7851@bogus> <7ce7bd25-b5c4-f99d-fda6-0f21376f2204@ti.com>
 <ab8707fb-e632-5be9-9fdb-4b1fb3cb26ba@ti.com>
Date: Wed, 06 Feb 2019 09:47:18 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_094720_192400_9A7CBEB0 
X-CRM114-Status: GOOD (  17.97  )
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
Cc: devicetree@vger.kernel.org, mturquette@baylibre.com,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 ssantosh@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Tero Kristo (2019-02-05 00:25:40)
> On 22/01/2019 09:33, Tero Kristo wrote:
> > On 21/01/2019 23:04, Rob Herring wrote:
> >> At first, I thought this was an either/or thing. Use firmware or use DT,
> >> but it is really only get the clocks used in the DT from firmware.
> >>
> >> Why wouldn't you just always do that? I can think of 3 cases:
> >> reparenting, debug and overlays. This breaks reparenting and overlays,
> >> right? Debug could be handled with some userspace trigger to get all the
> >> clocks.
> > 
> > Re-parenting this does not break, as the scan still checks every 
> > possible parent of a clock scanned. Overlays are broken for sure, as we 
> > don't know which overlays we would be applying, and what clocks would be 
> > in them. Debug is kind of broken as we only scan a small portion of the 
> > clocks.
> > 
> >>
> >> Why scan any of the clocks up front? Why not just create the clocks on
> >> demand? If an unknown clock id is requested, then create the clock and
> >> query the firmware at that point. That would avoid the DT scan too.
> >> Maybe there's some issues in the clk framework preventing that, but
> >> that's not really a DT problem.
> > 
> > The very initial version I did a couple of years back, did scan the 
> > clocks based on need, and registered them dynamically. Stephen shot down 
> > this based on the assessment that there might be locking issues with the 
> > common clock framework with this approach leading into potential 
> > deadlock situations.

It's an interesting idea to limit the scope of clks that are registered
to only the leaf and whatever up to the root of the tree is involved in
the working set of the kernel.

> 
> So Rob, what is the final call on this binding? Ack/NAK? If NAK, shall I 
> implement a kernel cmdline param to select the parsing method or what is 
> preferred? Doing it build time with a simple Kconfig seems too limiting.
> 

Is the problem a performance problem where probing the firmware for all
the clks is costly and time intensive? So instead of doing that we're
describing some of the details in DT? Why can't we describe the clk tree
in C code with some data structure that indicates parent child linkages?
This is how every other SoC is doing this so far.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
