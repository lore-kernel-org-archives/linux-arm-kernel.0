Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9870AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:10:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 631022084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pO15D1/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 631022084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Guc26NtW9Knthv1rCukCW+bm2BUO+ImuCOfptnYS/Kk=; b=pO15D1/Rf6Auio
	+WAwuzpvDzsjZrAuPE09nkj7xgbu4k/grV699oeT2AAWsT0sJCG8ZMn67uDTaINj/5WdAPVm9Cbof
	kc+D7OWamuzm9OKNfVyBHiXhqqyMQrMweai/nSXzMYxonW5I1y8DMu6jIovh6IfmMgaW5Vj5m/t4h
	DFzx45gSGYQZXz2IPYPjxhyVQqMxjLy4vtQ7k/t4xr+bGIOhi4kkESyy/ftcQ51yy+hHxcvXpeQQ5
	3xnfGKB1A9FNv1xUl+8UygqMcjS6iNutlVvozrIQUUdxA+nNkotXHiGcyNA1nJtYKbZ71/NYwG2JQ
	yQLCJp91Zpz1QhctF71g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goPPQ-00061Z-7k; Tue, 29 Jan 2019 09:10:20 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goPP1-0004eb-1G
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 09:10:11 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DE2280D;
 Tue, 29 Jan 2019 01:09:54 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2A6B3F7A6;
 Tue, 29 Jan 2019 01:09:51 -0800 (PST)
Date: Tue, 29 Jan 2019 09:09:50 +0000
From: Quentin Perret <quentin.perret@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/7] PM / OPP: Introduce a power estimation helper
Message-ID: <20190129090948.3yomjtpbdsar576w@queper01-lin>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-2-quentin.perret@arm.com>
 <20190129051030.gu5nhr6vmcd35bzk@vireshk-i7>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190129051030.gu5nhr6vmcd35bzk@vireshk-i7>
User-Agent: NeoMutt/20171215
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_010955_361016_5D35B8C2 
X-CRM114-Status: GOOD (  20.97  )
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

Hi Viresh,

On Tuesday 29 Jan 2019 at 10:40:30 (+0530), Viresh Kumar wrote:
> > +int of_dev_pm_opp_get_cpu_power(unsigned long *mW, unsigned long *KHz, int cpu)
> 
> I would suggest to change the return type to unsigned long and return 0 for
> errors and positive values for mW.

Well, I can't really do that -- this must match the API of PM_EM:

https://elixir.bootlin.com/linux/v5.0-rc4/source/include/linux/energy_model.h#L62

I'll make sure to make that explicit in the commit message for v2.

> 
> > +{
> > +	unsigned long mV, Hz, MHz;
> 
> MHz is used only once, I think you can get rid of it just open code the division
> by 1000000. Maybe remove Hz as well and directly use kHz.

I would expect/hope the compiler will optimize things like that for me
but yes, I can try to reduce a bit the temp variables if you prefer.

> 
> > +	struct device *cpu_dev;
> > +	struct dev_pm_opp *opp;
> > +	struct device_node *np;
> > +	u32 cap;
> > +	u64 tmp;
> 
> Name this mW with the above changes.

So that doesn't really work given what I mentioned above.

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
> > +	Hz = *KHz * 1000;
> > +	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &Hz);
> > +	if (IS_ERR(opp))
> > +		return -EINVAL;
> > +
> > +	mV = dev_pm_opp_get_voltage(opp) / 1000;
> > +	dev_pm_opp_put(opp);
> > +	if (!mV)
> > +		return -EINVAL;
> > +
> > +	MHz = Hz / 1000000;
> > +	tmp = (u64)cap * mV * mV * MHz;
> > +	do_div(tmp, 1000000000);
> > +
> > +	*mW = (unsigned long)tmp;
> > +	*KHz = Hz / 1000;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(of_dev_pm_opp_get_cpu_power);
> > diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> > index 0a2a88e5a383..fedde14f5187 100644
> > --- a/include/linux/pm_opp.h
> > +++ b/include/linux/pm_opp.h
> > @@ -322,6 +322,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpuma
> >  struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
> >  struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
> >  int of_get_required_opp_performance_state(struct device_node *np, int index);
> > +int of_dev_pm_opp_get_cpu_power(unsigned long *mW, unsigned long *KHz, int cpu);
> >  #else
> >  static inline int dev_pm_opp_of_add_table(struct device *dev)
> >  {
> > @@ -364,6 +365,10 @@ static inline int of_get_required_opp_performance_state(struct device_node *np,
> >  {
> >  	return -ENOTSUPP;
> >  }
> 
> Add a blank line here. We missed adding the same before
> of_get_required_opp_performance_state() earlier, maybe add the new routine
> before of_get_required_opp_performance_state() and add blank line before and
> after it :)

Sounds good !

> 
> > +static inline int of_dev_pm_opp_get_cpu_power(unsigned long *mW, unsigned long *KHz, int cpu)
> > +{
> > +	return -ENOTSUPP;
> > +}
> >  #endif
> >  
> >  #endif		/* __LINUX_OPP_H__ */
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
