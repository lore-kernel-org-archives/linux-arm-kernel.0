Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829C9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:38:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F2932075A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jghOufDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2932075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=41WQlIYqXEY6N+7/zMyCgVSW/XseWZmk8CvRXz5cFK4=; b=jghOufDN2AOmkH
	xqozIDucgLWSqMKwJ4JfrMrUX01rxbfbpJ58vM98fYNgw2JCvIIbUYn/JQuChLrfDJ6lFVBRaEoe6
	tAhMa1I1riegLV1aZ9U3KMdvKcrjH5beaB8CEl+FHopzcwZJSFhJQops7IKlH1t1xXurM+29cdNKT
	shfYsAegnoiZ7pc56yvCq1G89N5ACWz/TGLoTUDR3me356LidFIVcUIwmou2M/S3pkwjUisT7JBn3
	oWQ17ZX6qbbrbXWsdyDky/DchOHvtoqnMP3H9V45bct2DuaRJvYuqrXVa7ztxhJpitwFc4/u7G4qp
	g5VV4glZeNfO4TrJ8tFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx9A9-0004rP-S3; Fri, 22 Feb 2019 11:38:41 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx9A7-0004r2-1c
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 11:38:40 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AB5215AB;
 Fri, 22 Feb 2019 03:38:35 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 578F13F5C1;
 Fri, 22 Feb 2019 03:38:34 -0800 (PST)
Date: Fri, 22 Feb 2019 11:38:25 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] arm64: kdump: fix warning message about failed to stop
 secondary CPUs
Message-ID: <20190222113824.GA42419@lakrids.cambridge.arm.com>
References: <20190222014625.107640-1-chenzhou10@huawei.com>
 <20190222100305.GA31945@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190222100305.GA31945@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_033839_094865_26247578 
X-CRM114-Status: GOOD (  18.17  )
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
Cc: Chen Zhou <chenzhou10@huawei.com>, catalin.marinas@arm.com,
 cj.chengjian@huawei.com, linux-arm-kernel@lists.infradead.org,
 takahiro.akashi@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 10:03:05AM +0000, Will Deacon wrote:
> On Fri, Feb 22, 2019 at 09:46:25AM +0800, Chen Zhou wrote:
> > The local variable mask indicates non-boot cpus. Just print the num
> > of failing to stop secondary CPUs using varaible waiting_for_crash_ipi.
> 
> Why? Also s/varaible/variable/

I think the point is that the mask is an over-estimate, since it's all
of the CPUs which were online when we sent the stop IPI, not only the
ones we failed to stop.

If we had 255 secondary CPUs, and one failed to offline, we log the IDs
of all 255 CPUs which we tried to offline.

> > Also replace two pr_warning with the shorter pr_warn.
> > 
> > Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> > ---
> >  arch/arm64/kernel/smp.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > index 824de70..a4a952e 100644
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -989,7 +989,7 @@ void smp_send_stop(void)
> >  		udelay(1);
> >  
> >  	if (num_online_cpus() > 1)
> > -		pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
> > +		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
> >  			   cpumask_pr_args(cpu_online_mask));
> >  
> >  	sdei_mask_local_cpu();
> > @@ -1030,8 +1030,8 @@ void crash_smp_send_stop(void)
> >  		udelay(1);
> >  
> >  	if (atomic_read(&waiting_for_crash_ipi) > 0)
> > -		pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
> > -			   cpumask_pr_args(&mask));
> > +		pr_warn("SMP: failed to stop secondary CPUs %d\n",
> > +				atomic_read(&waiting_for_crash_ipi));

I think this should be:

	pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
		   cpumask_pr_args(cpu_online_mask));

... matching smp_send_stop().

In either case that includes the current processor, but that's not a new
bug, and not a big deal.

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
