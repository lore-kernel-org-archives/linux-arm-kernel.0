Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D0DC282D5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:12:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6E612184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mfsJ2N4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E612184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3O0HCKvrvtvG+JnCzsJ9S7wr36uMfitWI/H2q4jc0rE=; b=mfsJ2N4k9m5UjX
	xTYr644TeF+wSIVAKhhdhL2a91+di3wLspcHH3MElZFo2oBmaiIiusRT/9T4PTMINxKB7xYvC42ID
	Tfn09Zxlyzkf+nV7XQQEmOZUiJLV9RUk2MV3HV/CkdLhfOyw3koGpXDUaGC462+ZiXCPnJUnhyaI6
	cnbdPO62o2Eg/GeMLy1NXxSxQJUslJNCn4+mse2oc3EBr0ScQ1CoUYDORFToDqTThXpceC7jvOzfA
	/PBKiLL7qW3O1sIqZukAxEe5Gt1y+HRNFEw4biyZWjNepoW8J9tXpKJluZC+5DgyTyLHJhGnyt2qB
	G0as2HZ/LS46XJW/Sg9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1golvE-0000oP-Ik; Wed, 30 Jan 2019 09:12:40 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1golvB-0000nB-I6
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 09:12:38 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 018B9A78;
 Wed, 30 Jan 2019 01:12:35 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76AF73F557;
 Wed, 30 Jan 2019 01:12:32 -0800 (PST)
Date: Wed, 30 Jan 2019 09:12:27 +0000
From: Quentin Perret <quentin.perret@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/7] cpufreq: dt: Register an Energy Model
Message-ID: <20190130091055.zjj2jrjvi2n3ht66@queper01-lin>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-3-quentin.perret@arm.com>
 <20190128193656.GI81583@google.com>
 <20190129052144.plicqu4vozh3l3ss@vireshk-i7>
 <20190129091546.tfh3lo4w4sosfuba@queper01-lin>
 <20190130051806.fdsos27jaekkwgbs@vireshk-i7>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190130051806.fdsos27jaekkwgbs@vireshk-i7>
User-Agent: NeoMutt/20171215
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_011237_599981_02320AD4 
X-CRM114-Status: GOOD (  21.22  )
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

Hi Viresh,

On Wednesday 30 Jan 2019 at 10:48:06 (+0530), Viresh Kumar wrote:
> On 29-01-19, 09:15, Quentin Perret wrote:
> > On Tuesday 29 Jan 2019 at 10:51:44 (+0530), Viresh Kumar wrote:
> > > On 28-01-19, 11:36, Matthias Kaehlcke wrote:
> > > > I think this patch will result in error messages at registration on
> > > > platforms that use the cpufreq-dt driver and don't specify
> > > > 'dynamic-power-coefficient' for the CPUs in the DT. Not sure if that's
> > > > a problem as long as the cpufreq initialization succeeds regardless,
> > > > it could be seen as a not-so-gentle nudge to add the values.
> > > 
> > > That wouldn't be acceptable.
> > 
> > Fair enough. What I can propose in this case is to have in PM_OPP a
> > helper called 'dev_pm_opp_of_register_em()' or something like this. This
> > function will check all prerequisites are present (we have the right
> > values in DT, and so on) and then call (or not) em_register_perf_domain().
> > Then we can make the CPUFreq drivers use that instead of calling
> > em_register_perf_domain() directly.
> 
> That should be fine.
> 
> > That would also make it easy to implement Matthias' suggestion to not
> > call em_register_perf_domain() if an EM is already present.
> 
> So you will track registration state within the OPP core for that ?

What I had in mind is something as simple as:

	void of_dev_pm_opp_register_em(struct cpumask *cpus)
	{
		/* Bail out if an EM is there */
		if (em_cpu_get(cpumask_first(cpus)))
			return;

		/* Check prerequisites: dpc coeff in DT, ... */
		...

		em_register_perf_domain(...);
	}

IIUC, Matthias' point was that if the EM is already registered, there is
no good reason to call em_register_perf_domain() again. Now, that should
in fact be harmless because em_register_perf_domain() already does that
check. It's just cleaner and easier to understand from a conceptual
standpoint to not call that function several times for no reason I
assume.

> Sorry but that doesn't sound right. What's wrong with having an
> unregister helper in energy-model to keep proper code flow everywhere
> ?

For the EM we basically allocate the tables in memory once and for all
at boot time and never touch them again. That makes it easy for users
(the scheduler as of now, IPA soon) to access them without messing
around with RCU or so. So there isn't really a concept or unregistering
a pd right now.

Thanks,
Quentin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
