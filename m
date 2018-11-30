Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AC0C64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:25:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35EEB20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EJHJF1y1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0XVAg7js"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EEB20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1I9Dtwwink23M92DBqogmRty/cZHT6X72CxXtiNA3bU=; b=EJHJF1y1PgaZWI
	yGCJD+HQpLiz/nkHtbt1nC+hsDtAix/qPPi5Rjma1gyIW7vq+a3+29e+7kPgl0Bsq1RRsUIgu231X
	kQhe2LZxieh04Y4y9Mcsb85Oo+slHl0EUv1ZxtR62Pui+G2NC59ekzmFBAFZMm8Gx+00x1iHo2YZd
	OO9Hthr02RgOAA7QYbhPMGRpSyq8jdJjrVF3iiNNgIRtvqpv3tu2pP4l4g3UpjkU+ie5Tzb2ODx+l
	MEOjW4U0nwB0JsOAkk9/nbbk/AteDkVjQ256resaelZG0AsDbmdl1LjgG5cmMh04aLLpNVHr7h3Cu
	kgHEQZu/M5IvYQy6EtLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSf2w-00049l-IZ; Fri, 30 Nov 2018 09:25:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSf2s-0002jw-UJ
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 09:25:12 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4B7E920863;
 Fri, 30 Nov 2018 09:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543569898;
 bh=Fo35libfAVNgS5fOv7nF4RFOKa3eu31VoDU7+zsoRUk=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=0XVAg7jsl3K4IewcJSRnsG8dzHyupS1dhNmdjF/C1V7bS4gIj/hlyscTR6GFv//h0
 bbwWsRNFR+sNIbH5uAxBKyiY42cWBzwRHMdA6io/D6yMKnISBoy7DI0v1eOrdsT/uU
 6sUQ1Kwzwd3ywa8tMPCKgeM1rkzhhBbNGWpJ9/MI=
MIME-Version: 1.0
To: Michael Turquette <mturquette@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Russell King <linux@armlinux.org.uk>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181122212212.16039-1-miquel.raynal@bootlin.com>
References: <20181122212212.16039-1-miquel.raynal@bootlin.com>
Message-ID: <154356989722.88331.10134203618475749179@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 0/2] Link consumer with clock driver
Date: Fri, 30 Nov 2018 01:24:57 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_012511_026034_388DBDE7 
X-CRM114-Status: GOOD (  18.31  )
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
Cc: Antoine Tenart <antoine.tenart@bootlin.com>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Miquel Raynal (2018-11-22 13:22:10)
> Hello,
> 
> While working on suspend to RAM feature, I ran into troubles multiple
> times when clocks where not suspending/resuming at the desired time. I
> had a look at the core and I think the same logic as in the
> regulator's core may be applied here to (very easily) fix this issue:
> using device links.

Thanks! I've wanted to add device links to the clk framework for a while
now but haven't gotten around to it. Can you expand on the scenario that
you've run into where you need this?

> 
> The only additional change I had to do was to always (when available)
> populate the device entry of the core clock structure so that it could
> be used later. This is the purpose of patch 1. Patch 2 actually adds
> support for device links.

That's fine. We should do it into clk_core all the time for other
reasons too.

> 
> As I am not used to hack into the clock subsystem I might have missed
> something big preventing such change but so far I could not see
> anything wrong with it. As this touches core code, I am of course
> entirely open to suggestions.
> 

Two questions:

 1) Do device links work if we make a loop between devices? I'm thinking
 of the case where we have two clock controllers that provide clks to
 each other and could potentially register some clks and then clk_get()
 the ones they depend on. I suspect loops don't work and so we need to
 be aware of this and somehow prevent it.

 2) Do we need to link clk consumers to anything besides the device
 providing the clk they get from clk_get()? Put another way, do we need
 to make links through the clk tree and any potential parent clks of
 whatever the device is using at the time. Would clk tree changing
 topology because some new parent is chosen need to affect
 suspend/resume ordering? Or would that all need to be handled by clk
 framework figuring out the ordering of the tree at suspend/resume time
 and suspending clock controller drivers in the right order?



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
