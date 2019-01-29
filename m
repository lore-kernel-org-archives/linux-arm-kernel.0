Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E506C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:10:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2971E2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nBI01kQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2971E2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5LtoGAUYr2KZkPjcbgig96awFnp8axVYNpz8gxoZXFs=; b=nBI01kQVthu+a/
	G1WlhLY1b4MW2cqM5tu5q0cPpyrvpjDVRUYnroEyZA2VFkslDE6qQylbCovmuH38+V2HFKjNa38e8
	xXTOR9X+huNibItkr+a55aT5m1gUP9/NIk7DPhkhji7QahZ3guJqANzcoVv9roWZZ9MXGKnwsHwVQ
	cHFSggMPagq8jJg351EqzBxmvS5esrb78WvYJL9POMfFBE3ILpAL3nD+3aB9ofFV8ar4EK1MzS8jY
	D2qa8pOaK1PF02FW09AjZqSQTlTGhxOybYzNCTG0dMI5B7fpvPYLtzads+xBBzUYXLhApOCCdZ8bm
	NBKRmQWt4CHQNsLbY7Pg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goPPv-0006Mw-5b; Tue, 29 Jan 2019 09:10:51 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goPPs-0006MV-0Q
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 09:10:49 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9986980D;
 Tue, 29 Jan 2019 01:10:47 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B9EF3F7A6;
 Tue, 29 Jan 2019 01:10:44 -0800 (PST)
Date: Tue, 29 Jan 2019 09:10:43 +0000
From: Quentin Perret <quentin.perret@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/7] cpufreq: dt: Register an Energy Model
Message-ID: <20190129091041.et46clxo3lci34xf@queper01-lin>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-3-quentin.perret@arm.com>
 <20190129053041.ymyhfusj6eimpxfu@vireshk-i7>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190129053041.ymyhfusj6eimpxfu@vireshk-i7>
User-Agent: NeoMutt/20171215
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_011048_049506_4D6E1425 
X-CRM114-Status: GOOD (  18.55  )
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
 mka@chromium.org, linux-pm@vger.kernel.org, liviu.dudau@arm.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, sudeep.holla@arm.com,
 dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tuesday 29 Jan 2019 at 11:00:41 (+0530), Viresh Kumar wrote:
> On 28-01-19, 16:55, Quentin Perret wrote:
> > Now that PM_OPP provides a helper function to estimate the power
> > consumed by CPUs, make sure to try and register an Energy Model (EM)
> > from cpufreq-dt, hence ensuring interested subsystems (the task
> > scheduler, for example) can make use of that information when available.
> > 
> > Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> > ---
> >  drivers/cpufreq/cpufreq-dt.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> > index e58bfcb1169e..7556e07e7a9f 100644
> > --- a/drivers/cpufreq/cpufreq-dt.c
> > +++ b/drivers/cpufreq/cpufreq-dt.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/cpu_cooling.h>
> >  #include <linux/cpufreq.h>
> >  #include <linux/cpumask.h>
> > +#include <linux/energy_model.h>
> >  #include <linux/err.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > @@ -152,6 +153,7 @@ static int resources_available(void)
> >  
> >  static int cpufreq_init(struct cpufreq_policy *policy)
> >  {
> > +	struct em_data_callback em_cb = EM_DATA_CB(of_dev_pm_opp_get_cpu_power);
> 
> Hmm, so all the earlier comments regarding prototype of this routine are invalid
> because of this.

Right.

> 
> >  	struct cpufreq_frequency_table *freq_table;
> >  	struct opp_table *opp_table = NULL;
> >  	struct private_data *priv;
> > @@ -160,7 +162,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> >  	unsigned int transition_latency;
> >  	bool fallback = false;
> >  	const char *name;
> > -	int ret;
> > +	int ret, nr_opp;
> >  
> >  	cpu_dev = get_cpu_device(policy->cpu);
> >  	if (!cpu_dev) {
> > @@ -237,6 +239,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> >  		ret = -EPROBE_DEFER;
> >  		goto out_free_opp;
> >  	}
> > +	nr_opp = ret;
> 
> Instead use nr_opp instead of ret while calling dev_pm_opp_get_opp_count().

Will do.

> 
> >  
> >  	if (fallback) {
> >  		cpumask_setall(policy->cpus);
> > @@ -280,6 +283,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> >  	policy->cpuinfo.transition_latency = transition_latency;
> >  	policy->dvfs_possible_from_any_cpu = true;
> >  
> > +	em_register_perf_domain(policy->cpus, nr_opp, &em_cb);
> > +
> >  	return 0;
> >  
> >  out_free_cpufreq_table:
> > -- 
> > 2.20.1
> 
> -- 
> viresh

Thanks,
Quentin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
