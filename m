Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8213C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:28:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 796DB2064A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jWu1ys8y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lV6HDqE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796DB2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c83uAh0Y115Cm530rOdyj7t1g8bPU5uza/bz3Y443kU=; b=jWu1ys8y8DvzZc
	kYh7inge/eCBz9HrS5yvop+Ffzcv81SPKlK9Bc42TBjQKZEBEauZq/KF0J6+QHFRu0/xJMAskV2wb
	8B1eSggOPcCrZDe/XxuEvqi69Ozgt8BekJu336Kpe2fg+2d1spaVwvlao2TZz33LwpjrQ0dX3xzoU
	hivepkBW73sRZl/YWx6NdJNdXNtXg0Cd9so8F6FTZwJ7UyBaiyoUxsjx2z9uGUSr9kNXuT6XR3PRV
	bCe5VHQonTmCEOwA48S1jRgbuoLpBiRVbvZtUYFDmEN7TMWMnyVCjjAAb3qgf+CK7hUtD19e+ZMWw
	071bhzxfHUcJwcAWxbog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTwi0-00061U-7Q; Mon, 03 Dec 2018 22:28:56 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTwhx-00060j-4p
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 22:28:54 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A6D3B2064A;
 Mon,  3 Dec 2018 22:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543876122;
 bh=XGiQXrRMQGaufxGbz5Xbdb3hIvIJ/43Qjjwpu8sxr/E=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=lV6HDqE/oulB0F0sSL4S6+I3e05leljhJODzanTrK/cnt1x17FbNTYOFKFBYhys+S
 pd+IfVZbw7T8b5Cjw3Qi5NY+J4t1CQTbyro2jx7pbrd/XxoeERXGxAelzMxmA/t0qN
 ptJyTOS8AxEN5RKsfj1MGtNm8LeDK6s/09uQzxNk=
MIME-Version: 1.0
To: Miquel Raynal <miquel.raynal@bootlin.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181203231655.4e7dc330@xps13>
References: <20181122212212.16039-3-miquel.raynal@bootlin.com>
 <201811231627.H7ojlKLL%fengguang.wu@intel.com>
 <20181123101132.6be3829c@xps13>
 <154356998033.88331.4426431020982838779@swboyd.mtv.corp.google.com>
 <20181130112052.73d943ec@xps13>
 <154386483105.88331.13970025193347328031@swboyd.mtv.corp.google.com>
 <20181203231655.4e7dc330@xps13>
Message-ID: <154387612188.88331.1486215045607446526@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: core: link consumer with clock driver
Date: Mon, 03 Dec 2018 14:28:41 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_142853_202323_8EF54365 
X-CRM114-Status: GOOD (  17.53  )
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
Cc: kbuild test robot <lkp@intel.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 Nadav Haklai <nadavh@marvell.com>, kbuild-all@01.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Miquel Raynal (2018-12-03 14:16:55)
> Stephen Boyd <sboyd@kernel.org> wrote on Mon, 03 Dec 2018 11:20:31
> -0800:
> > Quoting Miquel Raynal (2018-11-30 02:20:52)
> > > Stephen Boyd <sboyd@kernel.org> wrote on Fri, 30 Nov 2018 01:26:20
> > > -0800:
> > > > Quoting Miquel Raynal (2018-11-23 01:11:32)  
> > > 
> > > Because we need the caller's 'struct device' to make the link and
> > > this is not available in __clk_get(). I tried to ad it as parameter but
> > > I don't think it is possible to retrieve a 'struct device' from the
> > > device name. The functions where this is problematic are:
> > > * clk.c:__of_clk_get_from_provider()
> > > * clkdev.c:clk_get_sys()
> > > 
> > > By the way in my new version I called the helpers:
> > > * clk_{link,unlink}_hierarchy()
> > > * clk_{link,unlink}_consumer()
> > > 
> > > I will send a new version with these helpers, but if you have anything
> > > in mind to help me achieve the above request, I will welcome the idea.
> > >   
> > 
> > We can do the linking in __clk_get() and __clk_put() if we poke into the
> > struct clk -> struct clk_core and bury the struct device into each
> > clk_core structure.
> > 
> 
> I meant the consumer device's structure. Yes, from a struct clk, the
> first change in patch 1/2 let's us do clk->core->dev to get the clock
> device. But for linking I need both the clock device and the consumer
> device; and the latter will be missing in __clk_get().
> 

Ah ok, sounds like this is how it has to be then.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
