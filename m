Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA1EC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:20:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 433DD208A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JHP1AhaC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5faTbEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433DD208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6kB+aW/Gh3GH1OYiAu3qaZgqDJHnyhAP8Kl/3g7O6FY=; b=JHP1AhaCecG+QX
	pFr4RUxy71FpvG+s9hY0kDybrLYEur9GqHH4v9WFoFfGRb+TOgMJWVPIVc/Zq0zDou5aLbYYuNUfi
	EgzDwP5jtxdqibjDmtr/dY5FvTgb+Gh/Qv6UYj6SPysdJLUrYpU8i5ZJad0vpob5J4U54uath6ovn
	k4rnFIF86Wk2YFCBJDNwdihX9vq1VmGa5EyJae4c+1WKuzBlaIzrriOA6MYxNRKbYoCxn/FHf3Knw
	+FN2gn6Md1iiv6KLRuPpHEc6Q5sIANKDlCOkj9FmuBrxge9w/w/Blr83jZ6H2OV8y6MepsIbAFFG+
	XVHW/klPioqI+TdZ23ZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTtlt-0002vX-9A; Mon, 03 Dec 2018 19:20:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTtlq-0002u7-5a
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 19:20:43 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9B5D8208A3;
 Mon,  3 Dec 2018 19:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543864831;
 bh=H6S6MvFSSvsPpGH6+RWcgg9meLreOiqbH96RVPwsrgw=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=H5faTbEaDiuyorLuM7U+i/E6gKaz1LpKEldlqeqqL3PuBk4fHHKpgtCAZF86+zmrO
 HxZ/HEE6+cVO3F1emfUXw38UoD++Svm/+1DEEfyHXnUGM51q+1RcZ9Tb3IJ+FyN2EG
 QG91u70kQG2IA63iZOBApiBtRPK8oDsYMzpw502Y=
MIME-Version: 1.0
To: Miquel Raynal <miquel.raynal@bootlin.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181130112052.73d943ec@xps13>
References: <20181122212212.16039-3-miquel.raynal@bootlin.com>
 <201811231627.H7ojlKLL%fengguang.wu@intel.com>
 <20181123101132.6be3829c@xps13>
 <154356998033.88331.4426431020982838779@swboyd.mtv.corp.google.com>
 <20181130112052.73d943ec@xps13>
Message-ID: <154386483105.88331.13970025193347328031@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: core: link consumer with clock driver
Date: Mon, 03 Dec 2018 11:20:31 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_112042_228145_7365FC97 
X-CRM114-Status: GOOD (  14.85  )
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

Quoting Miquel Raynal (2018-11-30 02:20:52)
> Hi Stephen,
> 
> Stephen Boyd <sboyd@kernel.org> wrote on Fri, 30 Nov 2018 01:26:20
> -0800:
> 
> > Quoting Miquel Raynal (2018-11-23 01:11:32)
> > > Would you agree with me adding dummy functions in the #else section
> > > like:
> > > 
> > > static inline void __clk_device_link(struct device *consumer, struct clk *clk)
> > > {
> > >        return;
> > > }
> > > 
> > > static inline void __clk_device_unlink(struct clk *clk)
> > > {
> > >        return;
> > > }
> > > 
> > > Do you want me to also declare these functions in the #if section
> > > (with the external keyword) to balance the above declarations?  
> > 
> > Why can't we do the linking in __clk_get() and __clk_put()?
> > 
> 
> Because we need the caller's 'struct device' to make the link and
> this is not available in __clk_get(). I tried to ad it as parameter but
> I don't think it is possible to retrieve a 'struct device' from the
> device name. The functions where this is problematic are:
> * clk.c:__of_clk_get_from_provider()
> * clkdev.c:clk_get_sys()
> 
> By the way in my new version I called the helpers:
> * clk_{link,unlink}_hierarchy()
> * clk_{link,unlink}_consumer()
> 
> I will send a new version with these helpers, but if you have anything
> in mind to help me achieve the above request, I will welcome the idea.
> 

We can do the linking in __clk_get() and __clk_put() if we poke into the
struct clk -> struct clk_core and bury the struct device into each
clk_core structure.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
