Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C96C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:51:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1114C218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ETwbN7EY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1114C218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U0pgMCNnJ8iRfk0mHDKLf0jfwv85eNDEI/dsktJOoEc=; b=ETwbN7EY107Djg
	iEjotRbPX2CxKjQr0yamKGirRSltNQ2iAGiyPeM0qaflwSRMGD9gy5y4hbjUjpULjZhDTU/SN5uQ1
	hVQkyqlsJ4E5czulCy3CIpp+g7DZqakONnZZai6kwu3xEeOoOvSwvwO+ZG1Rf9LnxKKT3LzGBElCP
	3bjLdhkg3QwHXZFRBMlxXo8Xc5Q0ctc/OlK0+QzEjzY41uxvy7tMyFkkAsq2utTqOHQ4/v4AKXGEH
	i1d6RZlZZUfMpefIUZQ+3gNSWXKlV5fCX/yFzoy+KRlnx3+YeOZaKnR/LQn8RpYAycxg7AXhmxuby
	dsAU5lIVau2cUEGHWdAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp903-0002x5-BN; Thu, 31 Jan 2019 09:51:11 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp8zz-0002tI-SF
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 09:51:09 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74474A78;
 Thu, 31 Jan 2019 01:51:07 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A80393F71E;
 Thu, 31 Jan 2019 01:51:05 -0800 (PST)
Date: Thu, 31 Jan 2019 09:51:04 +0000
From: Quentin Perret <quentin.perret@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/5] PM / OPP: Introduce a power estimation helper
Message-ID: <20190131095101.g64h32wxqa5rhbqh@queper01-lin>
References: <20190130170506.20450-1-quentin.perret@arm.com>
 <20190130170506.20450-2-quentin.perret@arm.com>
 <20190131072633.bcqc75s6jmyt7fgx@vireshk-i7>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190131072633.bcqc75s6jmyt7fgx@vireshk-i7>
User-Agent: NeoMutt/20171215
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_015107_917507_998D7425 
X-CRM114-Status: GOOD (  23.82  )
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
Cc: nm@ti.com, linux-pm@vger.kernel.org, sboyd@kernel.org, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, mka@chromium.org, sudeep.holla@arm.com,
 dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thursday 31 Jan 2019 at 12:56:33 (+0530), Viresh Kumar wrote:
> On 30-01-19, 17:05, Quentin Perret wrote:
> > +static int __maybe_unused _get_cpu_power(unsigned long *mW, unsigned long *kHz,
> > +					 int cpu)
> > +{
> > +	struct device *cpu_dev;
> > +	struct dev_pm_opp *opp;
> > +	struct device_node *np;
> > +	unsigned long mV, Hz;
> > +	u32 cap;
> > +	u64 tmp;
> > +	int ret;
> > +
> > +	cpu_dev = get_cpu_device(cpu);
> > +	if (!cpu_dev)
> > +		return -ENODEV;
> > +
> > +	np = of_node_get(cpu_dev->of_node);
> > +	if (!np)
> > +		return -EINVAL;
> > +
> > +	ret = of_property_read_u32(np, "dynamic-power-coefficient", &cap);
> > +	of_node_put(np);
> > +	if (ret)
> > +		return -EINVAL;
> > +
> > +	Hz = *kHz * 1000;
> > +	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &Hz);
> > +	if (IS_ERR(opp))
> > +		return -EINVAL;
> > +
> > +	mV = dev_pm_opp_get_voltage(opp) / 1000;
> 
> The voltage is also stored as triplet now a days and we must consider
> the higher value for these calculations. Also what about the case of
> multiple regulators here or performance-states ?

Well at least this is not worst than what we already do for IPA :-)

https://elixir.bootlin.com/linux/latest/source/drivers/thermal/cpu_cooling.c#L245

In the case of multiple regulators, then maybe that should be dealt with
at the dev_pm_op_get_voltage() ? Not sure.

> 
> > +	dev_pm_opp_put(opp);
> > +	if (!mV)
> > +		return -EINVAL;
> > +
> > +	tmp = (u64)cap * mV * mV * (Hz / 1000000);
> > +	do_div(tmp, 1000000000);
> > +
> > +	*mW = (unsigned long)tmp;
> 
> I was thinking will it be better if we just save this information in
> opp->power field during init, so we can just read a value here
> instead. But I am still not sure :(

Yeah, I had the exact same question. But, then I thought, we're only
gonna use that once, so it's not clear we need to cache the value. And I
don't think we want other subsystems to ask PM_OPP for power values
directly. Those subsystems should ask the EM framework instead (which
exists for that very reason). So we're probably not gonna expose a
dev_pm_opp_get_power() accessor or so, I think.

That's why I went that way.

> 
> > +	*kHz = Hz / 1000;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * dev_pm_opp_of_register_em() - Attempt to register an Energy Model
> > + * @cpus	: CPUs for which an Energy Model has to be registered
> > + * @nr_opp	: Number of OPPs to register in the Energy Model
> > + *
> > + * This checks whether the "dynamic-power-coefficient" devicetree binding has
> > + * been specified, and tries to register an Energy Model with it if it has.
> > + */
> > +void dev_pm_opp_of_register_em(struct cpumask *cpus, int nr_opp)
> > +{
> > +	struct em_data_callback em_cb = EM_DATA_CB(_get_cpu_power);
> > +	int ret, cpu = cpumask_first(cpus);
> > +	struct device *cpu_dev;
> > +	struct device_node *np;
> > +	u32 cap;
> > +
> > +	cpu_dev = get_cpu_device(cpu);
> > +	if (!cpu_dev)
> > +		return;
> > +
> > +	np = of_node_get(cpu_dev->of_node);
> > +	if (!np)
> > +		return;
> > +
> > +	/* Don't register an EM without the right DT binding */
> > +	ret = of_property_read_u32(np, "dynamic-power-coefficient", &cap);
> > +	of_node_put(np);
> > +	if (ret || !cap)
> > +		return;
> 
> What if no voltage is supplied in DT ?

Then don't provide 'dynamic-power-coefficient' ? There is nothing you
can do with that without voltages I think.

With this implementation you'll get an error message at some point,
which is probably sane.

> 
> > +
> > +	em_register_perf_domain(cpus, nr_opp, &em_cb);
> > +}
> > +EXPORT_SYMBOL_GPL(dev_pm_opp_of_register_em);
> > diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> > index b895f4e79868..58ae08b024bd 100644
> > --- a/include/linux/pm_opp.h
> > +++ b/include/linux/pm_opp.h
> > @@ -327,6 +327,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpuma
> >  struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
> >  struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
> >  int of_get_required_opp_performance_state(struct device_node *np, int index);
> > +void dev_pm_opp_of_register_em(struct cpumask *cpus, int nr_opp);
> >  #else
> >  static inline int dev_pm_opp_of_add_table(struct device *dev)
> >  {
> > @@ -365,6 +366,11 @@ static inline struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
> >  {
> >  	return NULL;
> >  }
> > +
> > +static inline void dev_pm_opp_of_register_em(struct cpumask *cpus, int nr_opp)
> > +{
> > +}
> > +
> >  static inline int of_get_required_opp_performance_state(struct device_node *np, int index)
> >  {
> >  	return -ENOTSUPP;
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
