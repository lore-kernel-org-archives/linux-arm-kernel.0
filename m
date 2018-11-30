Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4435EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:56:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A04920834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VXQudn1o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXUP6lLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A04920834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rVBj7WrduwuCPDn341s2xJf6UMNAiSLvWzrNuxPbifU=; b=VXQudn1osgCeAZ
	N2eF6losTnDWP/2kyW8cd+bVf96d+j8RXBHnyYNALYDRpSE0loIfy9I1Wa/iSGxcg5wB/Y1LllQw9
	hht0yFSqVH95G8XWsZ8ASUBGlL521/SZ2KEeyTjoeF+gSI12NPQMqI5UbVf4SfJhyOFZ3GyVcDnhV
	Pyza4YTQVrGnn0F4HoTkF5byMDzRnh+3JotTGdRYp1GMVr9SMfB6i5Z2iZPasyiPmT9+6NaDo4M9C
	1IFcfj1PIfnIMRtD11iCvmwpveBJHqithMLsnnr9kHvoC2bXfx/dYRK8GzYwcReLrfcLPZ8iwM6q3
	b0DjYpGRvqKZ4Wcr0HCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSnxL-0006hs-Fb; Fri, 30 Nov 2018 18:56:03 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSnxI-0006gv-01
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 18:56:01 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 51ABA20834;
 Fri, 30 Nov 2018 18:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543604149;
 bh=Yn3Kj8SjepGfVKMZ9qAYh+MpJuICHMTg+kf4tPrygn0=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=tXUP6lLzV2XfLkWPdc1GUCk8AHHsFkyadFUNgvBla2I/YUDWPkuJxLT2jxXgdIbhb
 IHyP4xRLjFVqw5AoihNXw1sBAUH7PRMjnVHT5tCNPpqdOw+H6eXKD098bS5IeSGK3D
 KI+pB+R0onnWJQLoe4Mp5xGAJqPiGko/CoZLaxMo=
MIME-Version: 1.0
To: Phil Edworthy <phil.edworthy@renesas.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181130110446.GE30658@n2100.armlinux.org.uk>
References: <20181120141445.21378-1-phil.edworthy@renesas.com>
 <154356894146.88331.4169293505438588293@swboyd.mtv.corp.google.com>
 <TY1PR01MB1769161656941346A08F9F8AF5D30@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <20181130110446.GE30658@n2100.armlinux.org.uk>
Message-ID: <154360414857.88331.16753630865153792604@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v8] clk: Add (devm_)clk_get_optional() functions
Date: Fri, 30 Nov 2018 10:55:48 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_105600_071654_3E99AB02 
X-CRM114-Status: GOOD (  20.69  )
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
Cc: Michael Turquette <mturquette@baylibre.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Russell King - ARM Linux (2018-11-30 03:04:46)
> On Fri, Nov 30, 2018 at 10:25:37AM +0000, Phil Edworthy wrote:
> > On 30 November 2018 09:09 Stephen Boyd wrote:
> > > Quoting Phil Edworthy (2018-11-20 06:14:45)
> > > > This adds clk_get_optional() and devm_clk_get_optional() functions to
> > > > get optional clocks.
> > > > They behave the same as (devm_)clk_get except where there is no clock
> > > > producer. In this case, instead of returning -ENOENT, the function
> > > > returns NULL. This makes error checking simpler and allows
> > > > clk_prepare_enable, etc to be called on the returned reference without
> > > > additional checks.
> > > 
> > > Ok. I guess that works by virtue of how -ENOENT is returned by various
> > > functions that are called deeper in the clk_get() path? I'm cautiously
> > > optimistic. So cautious, we should probably add a comment to these optional
> > > functions that indicate they rely on the functions they call to return -ENOENT
> > > under the various conditions that make a clk optional.
> > Yes, it does indeed rely on how clk_get() is implemented.
> > Specifically, that if __of_clk_get_by_name() returns -EINVAL, the error is
> > superseded by clk_get_sys() returning -ENOENT.
> > As you say, a comment may help here.
> 
> Each time the question of the optional clk_get() stuff comes up, we go
> around the same discussions time and time again.  So far, each time
> has ended up flopping.
> 
> Yes, clk_get() can only ever return -ENOENT if it falls back to the
> non-DT methods, because it assumes that the clk tables are complete
> (it can do nothing else.)
> 
> I don't think it needs a comment because it's obvious from the code
> and also from the implementation point of view.

Ok. I would still suggest a comment on of_clk_get_by_name() that
indicates what types of return values happen in there. Otherwise it's
obvious from the code after reading 3 or 4 functions deep
(__of_clk_get_by_name -> __of_clk_get -> of_parse_phandle_with_args and
__of_clk_get_from_provider) that this is what happens.

> 
> > > > +static inline struct clk *clk_get_optional(struct device *dev, const
> > > > +char *id)
> > > 
> > > Any kernel doc for this function?
> > I took my cue from the surrounding functions, let me know if I have to add it.
> 
> I don't see you need to - this is an internal function by way of the
> "static inline" you have before it.  It's not an API function.

It's static inline in a header file. That is an API function as far as I
can tell.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
