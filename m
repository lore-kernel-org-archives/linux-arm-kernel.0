Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740CCC43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:01:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46137213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iz/hyzpA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46137213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s2v5WF3L5BnQ+MNUCp81J49o4FgS3HshP1IibqfEWY0=; b=iz/hyzpAoWt2EJ
	LmsNHTrm78piZ9jQnB4FcZQWFaJP83yVgtcR3ALjVcKXFKdXE542+KfWhNBjhuAzJdTrPMzQ4m7lu
	DZG1udqeczwa5mF500rwkIGdMrVZpZpS6scRjmFvawD0RC+rU5tpph+TNUTL2KWQsqvc3ZRO8tYot
	hYaMKGP6xO8ZvVYhfUwoyTl18dJ5moYr1eVWyWjUYBe8mzNezDh11u77COGm8B0FZqXiQh5qD7nag
	cBeWFTLIfwLGFcWgIiFmjXJBvv55jNJF/NeWE16GQrcmW+DXA8pDxtTReA6en7ef6lARN7AH+0l2R
	Sy43Bs8W6W/IvzWARhWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSOkn-0001wl-6v; Thu, 29 Nov 2018 16:01:25 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSOkO-0001uw-U0
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 16:01:02 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF086A78;
 Thu, 29 Nov 2018 08:00:47 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 928C83F59C;
 Thu, 29 Nov 2018 08:00:47 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 161241AE0FA2; Thu, 29 Nov 2018 16:01:06 +0000 (GMT)
Date: Thu, 29 Nov 2018 16:01:06 +0000
From: Will Deacon <will.deacon@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] perf: arm_spe: handle devm_kasprintf() failure
Message-ID: <20181129160105.GA4546@arm.com>
References: <1543404287-3946-1-git-send-email-hofrat@osadl.org>
 <20181129121432.2ntsfhp2s43gyvfx@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181129121432.2ntsfhp2s43gyvfx@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_080100_973464_05CA1B41 
X-CRM114-Status: GOOD (  16.65  )
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Nicholas Mc Guire <hofrat@osadl.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 12:14:32PM +0000, Mark Rutland wrote:
> On Wed, Nov 28, 2018 at 12:24:47PM +0100, Nicholas Mc Guire wrote:
> > diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> > index 54ec278..f1ea00c 100644
> > --- a/drivers/perf/arm_spe_pmu.c
> > +++ b/drivers/perf/arm_spe_pmu.c
> > @@ -927,6 +927,11 @@ static int arm_spe_pmu_perf_init(struct arm_spe_pmu *spe_pmu)
> >  
> >  	idx = atomic_inc_return(&pmu_idx);
> >  	name = devm_kasprintf(dev, GFP_KERNEL, "%s_%d", PMUNAME, idx);
> > +	if (!name) {
> > +		dev_err(dev, "Allocation of name failed\n");
> > +		return -ENOMEM;
> > +	}
> 
> In the other dev_err() messages, we use the form "failed to ...", e.g.
> 
> 	"failed to get IRQ (%d)\n"
> 	"failed to get PPI partition (%d)\n
> 	"failed to allocate spe_pmu\n"
> 
> ... so for consistency could you please change the string to:
> 
> 	"failed to allocate spe_pmu name\n"
> 
> With that, feel free to add:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks, I've queued this for 4.21 with a tweaked error message.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
