Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC04C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:28:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9492C218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IHtWEB7R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="azlP41og"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9492C218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:Message-ID:In-Reply-To:From:
	References:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rneY89TF5kEmLhziAj5yAxcbMJGPIPpjL+331mV3uhY=; b=IHtWEB7RF5d8MJ
	jDOym//7c9ItpkDkI16Gn5UTG8fRrWPoImqQXMe6/U47AzFW4ZhKcG8B6eYrhij5YitoM6NDpCfJa
	nCy/kkpPgSLvTp3PodvuY2YeB7VkWzxCML/eYcEJOOE+onL71bsFeGYGrXCzl/tEST3QkNvcelcuN
	I+LfKbL4bQYYkHeG2UHyFEoYTHtCMQDkX4FX7mAr5DeI6JtHSpLbW0+Kvt0ZK/izQ1VSeQzjQdoxh
	mY8QMWrUGl7C8LavSyWGUZQe60lfIJNZgScJZxoNPIrXIakFAHZ+LhCPyh9aFV9SDv2nWgGukus49
	opIy/IHWNOl6j2Dmq6fg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn91e-0005Sw-EP; Fri, 25 Jan 2019 21:28:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn91b-0005SS-9D
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 21:28:32 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EF665217D4;
 Fri, 25 Jan 2019 21:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548451710;
 bh=ZbAOvZ7TcGXFrQiocOFb2gplYV9RMuWPk15cBWYoOB0=;
 h=Subject:References:Cc:From:In-Reply-To:To:Date:From;
 b=azlP41og08i5ER5VHcOjNTBAxv+CL1O+TAWyGAECtyyQYakre7GL0bAeMTfgQojyl
 5vspxPqRcMzhtNIugDuIpOzrxXVxq5MYYxTTM98S8jPrfN3zt/xZZ10iP7oCG+BTve
 mOTLGKyfKbxYJpBa8aXz5GKhtmpYKSms+8+gj/l8=
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/4] clk: core: link consumer with clock driver
References: <20181204192440.12125-1-miquel.raynal@bootlin.com>
 <20181204192440.12125-3-miquel.raynal@bootlin.com>
 <154454837597.17204.11648795524314926025@swboyd.mtv.corp.google.com>
 <20190104165406.3b52399a@xps13>
User-Agent: alot/0.8
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190104165406.3b52399a@xps13>
Message-ID: <154845170894.136743.2408260720819956377@swboyd.mtv.corp.google.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 25 Jan 2019 13:28:28 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_132831_359392_A69830DC 
X-CRM114-Status: GOOD (  22.87  )
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

Quoting Miquel Raynal (2019-01-04 07:54:06)
> Hi Stephen,
> 
> Stephen Boyd <sboyd@kernel.org> wrote on Tue, 11 Dec 2018 09:12:55
> -0800:
> 
> > Sorry, I'm not reviewing the whole patch right now, just this one little
> > bit because I'm also working in the same area.
> > 
> > Quoting Miquel Raynal (2018-12-04 11:24:38)
> > > diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> > > index 60c51871b04b..721d6b55b2fa 100644
> > > --- a/include/linux/clk-provider.h
> > > +++ b/include/linux/clk-provider.h
> > > @@ -781,6 +781,8 @@ void devm_clk_hw_unregister(struct device *dev, struct clk_hw *hw);
> > >  const char *__clk_get_name(const struct clk *clk);
> > >  const char *clk_hw_get_name(const struct clk_hw *hw);
> > >  struct clk_hw *__clk_get_hw(struct clk *clk);
> > > +void clk_link_consumer(struct device *consumer, struct clk *clk);
> > > +void clk_unlink_consumer(struct clk *clk);  
> > 
> > We shouldn't need to add these functions as far as I can tell. That's
> > because __clk_get() has become an internal API between clkdev.c and
> > clk.c that does nothing now on implementations that aren't the CCF. We
> > can even change this API to take a clk_hw pointer instead of a clk
> > pointer.
> > 
> > I'd rather see us plumb a struct device and clk_hw structure down into
> > __clk_get() and fold it all into __clk_create_clk, possibly even
> > renaming __clk_create_clk to clk_hw_create_clk(). That way we can get
> > the calling device and clk_hw pointer in one call in the clk framework,
> > along with the device name and connection name, and then generate the
> > struct clk right there. This can simplify some code and make it easier
> > to extend this to associate calling devices with the clk consumer
> > somehow.
> > 
> > Here's the diff. With this, you should be able to add and remove device
> > links in clk_hw_create_clk() when dev != NULL.
> 
> Thanks for the help; I updated my work on top of yours, it looks ok but
> I need to run some more tests.
> 
> However I had to tweak a parameter in one of your recent changes, you
> used '-1' as index in __of_clock_get() while it is not a valid value
> (returning an error). As in the __of_clk_get_by_name() function you
> removed index was just set to 0 at the top of the function, I think the
> below fix is valid.

Thanks. Makes sense so I folded it in.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
