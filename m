Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62A5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:09:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A667921903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dmVrLCvt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="llX4WFK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A667921903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:In-Reply-To:
	From:References:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TURg2T0oazqrBdicG0lKZy+LuYa1JfA1eoz+7OKLKME=; b=dmVrLCvtX3Kyi0
	rciK49UXHZW19ZTRdxSmTpONa9qo4kGddPD4GVJ+NUKwGnhCMuzHzmFBQgE/ZAsE4/T4jj4dl0v4Y
	LhVfX0HD8paKE85ufSMDuXiV0aYODtGDjQGvPAwh1ON52d3/clSsv0tlyN8jfh+HX3HZCaqVXtsmo
	Hk/wVaCqMTzl/Z+KeZ4sjmJBxWBzXVXgyfG6kpCVIIzSu03J6DNjKDX65rYqGrOPnXvNKKMhSfLLZ
	EtKoJLq0EyLvx7JO9Bp7MMsMhlI/h0qzrIJTwKLgVaXXGiRNd1EUNkkCjfIaUUsO4t4d6bpezYcLW
	diV9O9fKjcFarAxs/iEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga5ZV-0004xN-CG; Thu, 20 Dec 2018 21:09:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga5ZS-0004wZ-Mg
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 21:09:31 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EF981218FE;
 Thu, 20 Dec 2018 21:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545340160;
 bh=Ge1/tEjB2RmN0rIIzRGmX3o8YdSsD9kdZGbjH8HZELI=;
 h=To:References:Cc:From:In-Reply-To:Subject:Date:From;
 b=llX4WFK0DS9Jd8LXQWAU6kE8TbhIDKBD5I6oV6Ep+XOzx13ZtNNRlPN94Mjm/o/UZ
 tHq4SH5c6+qzbEKQbH/BgnJcvsk8qtyw67OS7T/z51iwQ8isZbPkrMpKKAk4e0lQdo
 Q37jRlqe+KF1LgquvUNCqAkQvHNBnnktK2shItCQ=
MIME-Version: 1.0
User-Agent: alot/0.8
To: Miquel Raynal <miquel.raynal@bootlin.com>
References: <20181204192440.12125-1-miquel.raynal@bootlin.com>
 <20181204192440.12125-2-miquel.raynal@bootlin.com>
 <154517780935.238328.764268020422357561@swboyd.mtv.corp.google.com>
 <20181219090331.4c8c4852@xps13>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181219090331.4c8c4852@xps13>
Message-ID: <154534015908.79149.14109221006631310404@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH v3 1/4] clk: core: clarify the check for runtime PM
Date: Thu, 20 Dec 2018 13:09:19 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_130930_759766_9078CD9A 
X-CRM114-Status: GOOD (  24.62  )
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
Cc: Gregory Clement <gregory.clement@bootlin.com>,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, Nadav Haklai <nadavh@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Miquel Raynal (2018-12-19 00:03:31)
> Hi Stephen,
> 
> Stephen Boyd <sboyd@kernel.org> wrote on Tue, 18 Dec 2018 16:03:29
> -0800:
> 
> > Quoting Miquel Raynal (2018-12-04 11:24:37)
> > > Currently, the core->dev entry is populated only if runtime PM is
> > > enabled. Doing so prevents accessing the device structure in any
> > > case.
> > > 
> > > Keep the same logic but instead of using the presence of core->dev as
> > > the only condition, also check the status of
> > > pm_runtime_enabled(). Then, we can set the core->dev pointer at any
> > > time as long as a device structure is available.
> > > 
> > > This change will help supporting device links in the clock subsystem.
> > > 
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  drivers/clk/clk.c | 11 +++++------
> > >  1 file changed, 5 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > index af011974d4ec..b799347c5fd6 100644
> > > --- a/drivers/clk/clk.c
> > > +++ b/drivers/clk/clk.c
> > > @@ -97,7 +97,7 @@ static int clk_pm_runtime_get(struct clk_core *core)
> > >  {
> > >         int ret = 0;
> > >  
> > > -       if (!core->dev)
> > > +       if (!core->dev || !pm_runtime_enabled(core->dev))  
> > 
> > This looks potentially dangerous. What if runtime PM is disabled for the
> > clk when this function is called? Shouldn't we just stash a bool away in
> > the clk_core structure when it's registered? And then we can replace the
> > check for !core->dev with a check for 'core->rpm_enabled' instead. That
> > would be a more exact transformation.
> 
> Sure, I'll do that if you think there is a danger.

I've made the change and pushed it out to the clk tree. I'm working on
some patches to change how we do parent lookups and reworking clk_get()
in the process. Take a look so we don't duplicate efforts. The code
isn't complete, but I hope to finish soon. Your device links patches can
build upon this.

 git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-parent-rewrite


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
