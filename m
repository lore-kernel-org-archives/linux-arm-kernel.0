Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416A1C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:21:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0510C20833
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q3Du6jUj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0510C20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mZOctGx+cERRC1OdJjBvlSj/P5BuWYhgZMxvFsHs+PE=; b=q3Du6jUjZNUe5s
	U/i6Dwp0x7GhR6WkF2lH0WjJ4Yo/Z8zBVvIavBLX6PetvpsP5h2HfbUrMe6oRNwAmQYxWGBtz62E/
	K9CEJp1BAp/alVR/8RQqaW8NLpOgdjPSSVWrjURWytghI3B2ddkHf3PP/5AlrQ95PVm1cC3Y6C35S
	mII9CHNFd09t0L0pFI+1P3NCBLwTH+eS4ALm2jwwAUw2iNQjOfBNFhvyXyBKMYR8ICOiQ80ApAiR2
	eShoHXGuP/4jFA9M8jNdp7Jby8Pq2V5XzID7+9fZ7x56+VbrTZcdk2+Wi6DV12irA1LBAiXDX7daI
	KcX6h3+Ufy+c2QeBhk4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gomzV-0004WS-Bb; Wed, 30 Jan 2019 10:21:09 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gomzB-0004Gu-NW
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 10:20:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 402E5A78;
 Wed, 30 Jan 2019 02:20:49 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2B083F71E;
 Wed, 30 Jan 2019 02:20:46 -0800 (PST)
Date: Wed, 30 Jan 2019 10:20:45 +0000
From: Quentin Perret <quentin.perret@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/7] cpufreq: dt: Register an Energy Model
Message-ID: <20190130102042.uwxpsep5vmeq4h62@queper01-lin>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-3-quentin.perret@arm.com>
 <20190128193656.GI81583@google.com>
 <20190129052144.plicqu4vozh3l3ss@vireshk-i7>
 <20190129091546.tfh3lo4w4sosfuba@queper01-lin>
 <20190130051806.fdsos27jaekkwgbs@vireshk-i7>
 <20190130091055.zjj2jrjvi2n3ht66@queper01-lin>
 <20190130101715.nz2bpqnust7gv4at@vireshk-i7>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190130101715.nz2bpqnust7gv4at@vireshk-i7>
User-Agent: NeoMutt/20171215
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_022050_106605_D8A54A68 
X-CRM114-Status: GOOD (  15.22  )
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
Cc: mark.rutland@arm.com, nm@ti.com, lorenzo.pieralisi@arm.com,
 devicetree@vger.kernel.org, sboyd@kernel.org, rjw@rjwysocki.net,
 linux-pm@vger.kernel.org, liviu.dudau@arm.com, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, Matthias Kaehlcke <mka@chromium.org>, sudeep.holla@arm.com,
 dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wednesday 30 Jan 2019 at 15:47:15 (+0530), Viresh Kumar wrote:
> On 30-01-19, 09:12, Quentin Perret wrote:
> > What I had in mind is something as simple as:
> > 
> > 	void of_dev_pm_opp_register_em(struct cpumask *cpus)
> > 	{
> > 		/* Bail out if an EM is there */
> > 		if (em_cpu_get(cpumask_first(cpus)))
> > 			return;
> > 
> > 		/* Check prerequisites: dpc coeff in DT, ... */
> > 		...
> > 
> > 		em_register_perf_domain(...);
> > 	}
> > 
> > IIUC, Matthias' point was that if the EM is already registered, there is
> > no good reason to call em_register_perf_domain() again. Now, that should
> > in fact be harmless because em_register_perf_domain() already does that
> > check. It's just cleaner and easier to understand from a conceptual
> > standpoint to not call that function several times for no reason I
> > assume.
> 
> If there is no good reason to call em_register_perf_domain() several
> times, then the same applies to of_dev_pm_opp_register_em() as well,
> isn't it ?

Hrmpf, that is true ... :-)

> This is init code anyway isn't going to run a lot, so I wouldn't
> suggest adding any such (duplicate) checks in
> of_dev_pm_opp_register_em().

Fair enough, I'll post a v2 w/o the check and we'll see if others have
complaints.

Thanks,
Quentin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
