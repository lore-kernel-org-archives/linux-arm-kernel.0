Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785D7C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:07:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4786420989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X8HBBLQ9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W0eNB8pc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4786420989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZdN6EOq2Kw58F0anB4M7Ippy7uLECFAA0e7WJyOekRg=; b=X8HBBLQ9RDjTHT
	H7S+3tSKmobisXkKwrBfpZz/DWr8rcbrsRkEcMqCmGNkByfIkk0Ii1Qlzetajl5PACE9yDbR+C+AE
	UU8yG7tRW/Xk+4dp9grGT/T+d3LMjQSoI7gZqww1bGLulMOghjsEMg5dDvvNO+pbb75qzB9QOgSRv
	vadsi6V1TPEj37XJGPS/4XQE8FyiGvuq0taCOPm3M4uyk/rFQLpLoZfyr54GWmAB8fVp1BHXDDmT4
	newAhh8sBPQXoxZiZnzdFYdzqbiMs7jnsKYhTw4/xIUcPp5agPmerHPvJ9XkQwprXb4Nsc0QUo2XO
	iseSKNFYxMguDlKVFYiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1govCY-000672-Gt; Wed, 30 Jan 2019 19:07:10 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1govCU-00065v-FV
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 19:07:08 +0000
Received: by mail-pf1-x442.google.com with SMTP id i12so249715pfo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 11:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=9duydc19GYN8AxYc5ag4AZR+rk+raFykoe6IFlo6h3k=;
 b=W0eNB8pcKJgPJTItR89wwfj6aqagd11pPHm9zBuwQ0sFOODe45mDZkSO21jyuhA3jF
 RuucgKnorNCqMRuWrFeoRD2uiWyVT8HTPPix8Q5dXiwWGJDbyjdP9bl1/IGx95hfQZWg
 oFHmTxQtxzgrOMp4/7Aocib9HjLLvehH7DREc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9duydc19GYN8AxYc5ag4AZR+rk+raFykoe6IFlo6h3k=;
 b=AN6+bblarJAl0G81p/YCMN2oaqUOzUL0uuJl8OuHSd1XG0kQjn+vkSyB8Ems9Es9JY
 aLn6cdekCZOH8HoZj+F0Cl2rn1xlLZNbArvQxnkSfXz+h7isLpWct31JQiKyH0B2bHx+
 X/CDRnFpvcK+hY/2oQ76xJqyKJwSXZBozr81lxJrv0DQV3Mny+PiWLhMoodh9F1ybnba
 JpaCe0mq79fSgMOegr05eo/1XAcZ5sZIQ3SU3F7CRUT8+CV7neShvB3rpLXJEnDE/RKN
 dHPw/czplFXQg+EzRcPokXi4JcaFsXWZ9DUtuoCyXnsYMnjULGfTffcovlF7Izho4kKg
 6SYQ==
X-Gm-Message-State: AJcUukc7wY8cdr5qyEsTD+pgUrm5Yy4ukDPs8eI9Otnf/GGTeXkCeT9r
 siG0oUiriUl0Gl+kOPok6Ro6Yg==
X-Google-Smtp-Source: ALg8bN6MJCpntz8Z6TXacjN/a0N92GEZgcdiwaA7z44fMrJfbD2UyjtSUsSpkG5Gz/nFRG8upiOaww==
X-Received: by 2002:a63:587:: with SMTP id 129mr28321887pgf.273.1548875225077; 
 Wed, 30 Jan 2019 11:07:05 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
 by smtp.gmail.com with ESMTPSA id p77sm4603429pfi.85.2019.01.30.11.07.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 30 Jan 2019 11:07:04 -0800 (PST)
Date: Wed, 30 Jan 2019 11:07:03 -0800
From: Matthias Kaehlcke <mka@chromium.org>
To: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v2 1/5] PM / OPP: Introduce a power estimation helper
Message-ID: <20190130190703.GM81583@google.com>
References: <20190130170506.20450-1-quentin.perret@arm.com>
 <20190130170506.20450-2-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190130170506.20450-2-quentin.perret@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_110706_522020_2A321A6A 
X-CRM114-Status: GOOD (  32.54  )
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
Cc: nm@ti.com, linux-pm@vger.kernel.org, sboyd@kernel.org,
 viresh.kumar@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 sudeep.holla@arm.com, dietmar.eggemann@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Quentin,

On Wed, Jan 30, 2019 at 05:05:02PM +0000, Quentin Perret wrote:
> The Energy Model (EM) framework provides an API to let drivers register
> the active power of CPUs. The drivers are expected to provide a callback
> method which estimates the power consumed by a CPU at each available
> performance levels. How exactly this should be implemented, however,
> depends on the platform.
> 
> On some systems, PM_OPP knows the voltage and frequency at which CPUs
> can run. When coupled with the CPU 'capacitance' (as provided by the
> 'dynamic-power-coefficient' devicetree binding), it is possible to
> estimate the dynamic power consumption of a CPU as P = C * V^2 * f, with
> C its capacitance and V and f respectively the voltage and frequency of
> the OPP. The Intelligent Power Allocator (IPA) thermal governor already
> implements that estimation method, in the thermal framework.
> 
> However, this power estimation method can be applied to any platform
> where all the parameters are known (C, V and f), and not only those
> suffering thermal issues. As such, the code implementing this feature
> can be re-used to also populate the EM framework now used by EAS.
> 
> As a first step, introduce in PM_OPP a helper function which CPUFreq
> drivers can use to register into the EM framework. This duplicates the
> power estimation done in IPA until it can be migrated to using the EM
> framework. This will be done later, once the EM framework has support
> for at least all platforms currently supported by IPA.
> 
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> 
> ---
> 
> Matthias: Given this patch changed a bit I dropped your Reviewed-by and
> Tested-by, but let me know if you think they still hold.
> ---
>  drivers/opp/of.c       | 88 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  6 +++
>  2 files changed, 94 insertions(+)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 06f0f632ec47..4c8bf172e9ed 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -20,6 +20,7 @@
>  #include <linux/pm_domain.h>
>  #include <linux/slab.h>
>  #include <linux/export.h>
> +#include <linux/energy_model.h>

nit: AFAIK typically alphabetical order is used for includes, though
this file doesn't exactly adhere to it.

>  #include "opp.h"
>  
> @@ -1047,3 +1048,90 @@ struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
>  	return of_node_get(opp->np);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_get_of_node);
> +
> +/*
> + * Callback function provided to the Energy Model framework upon registration.
> + * This computes the power estimated by @CPU at the first OPP above @kHz (ceil),

that's not entirely correct, it could be the OPP at @kHz.

> + * and updates @kHz and @mW accordingly. The power is estimated as
> + * P = C * V^2 * f with C being the CPU's capacitance and V and f respectively
> + * the voltage and frequency of the OPP.
> + *
> + * Returns -ENODEV if the CPU device cannot be found, -EINVAL if the power
> + * calculation failed because of missing parameters, 0 otherwise.
> + */
> +static int __maybe_unused _get_cpu_power(unsigned long *mW, unsigned long *kHz,
> +					 int cpu)

why __maybe_unused?

> +{
> +	struct device *cpu_dev;
> +	struct dev_pm_opp *opp;
> +	struct device_node *np;
> +	unsigned long mV, Hz;
> +	u32 cap;
> +	u64 tmp;
> +	int ret;
> +
> +	cpu_dev = get_cpu_device(cpu);
> +	if (!cpu_dev)
> +		return -ENODEV;
> +
> +	np = of_node_get(cpu_dev->of_node);
> +	if (!np)
> +		return -EINVAL;
> +
> +	ret = of_property_read_u32(np, "dynamic-power-coefficient", &cap);
> +	of_node_put(np);
> +	if (ret)
> +		return -EINVAL;
> +
> +	Hz = *kHz * 1000;
> +	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &Hz);
> +	if (IS_ERR(opp))
> +		return -EINVAL;
> +
> +	mV = dev_pm_opp_get_voltage(opp) / 1000;
> +	dev_pm_opp_put(opp);
> +	if (!mV)
> +		return -EINVAL;
> +
> +	tmp = (u64)cap * mV * mV * (Hz / 1000000);
> +	do_div(tmp, 1000000000);
> +
> +	*mW = (unsigned long)tmp;
> +	*kHz = Hz / 1000;
> +
> +	return 0;
> +}
> +
> +/**
> + * dev_pm_opp_of_register_em() - Attempt to register an Energy Model
> + * @cpus	: CPUs for which an Energy Model has to be registered
> + * @nr_opp	: Number of OPPs to register in the Energy Model
> + *
> + * This checks whether the "dynamic-power-coefficient" devicetree binding has

s/binding/property/ ?

> + * been specified, and tries to register an Energy Model with it if it has.
> + */
> +void dev_pm_opp_of_register_em(struct cpumask *cpus, int nr_opp)

Is the nr_opp parameter really needed? The function looks up the CPU
device and hence could determine the OPP count itself with
dev_pm_opp_get_opp_count(). I see most cpufreq drivers call
dev_pm_opp_get_opp_count() anyway, so passing the count as parameter
can be considered a small optimization, not sure how relevant it is
though, since dev_pm_opp_of_register_em() isn't called frequently.

> +{
> +	struct em_data_callback em_cb = EM_DATA_CB(_get_cpu_power);
> +	int ret, cpu = cpumask_first(cpus);
> +	struct device *cpu_dev;
> +	struct device_node *np;
> +	u32 cap;
> +
> +	cpu_dev = get_cpu_device(cpu);
> +	if (!cpu_dev)
> +		return;
> +
> +	np = of_node_get(cpu_dev->of_node);
> +	if (!np)
> +		return;
> +
> +	/* Don't register an EM without the right DT binding */
> +	ret = of_property_read_u32(np, "dynamic-power-coefficient", &cap);
> +	of_node_put(np);
> +	if (ret || !cap)
> +		return;
> +
> +	em_register_perf_domain(cpus, nr_opp, &em_cb);
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_of_register_em);
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index b895f4e79868..58ae08b024bd 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -327,6 +327,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpuma
>  struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
>  struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
>  int of_get_required_opp_performance_state(struct device_node *np, int index);
> +void dev_pm_opp_of_register_em(struct cpumask *cpus, int nr_opp);
>  #else
>  static inline int dev_pm_opp_of_add_table(struct device *dev)
>  {
> @@ -365,6 +366,11 @@ static inline struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
>  {
>  	return NULL;
>  }
> +
> +static inline void dev_pm_opp_of_register_em(struct cpumask *cpus, int nr_opp)
> +{
> +}
> +
>  static inline int of_get_required_opp_performance_state(struct device_node *np, int index)
>  {
>  	return -ENOTSUPP;

Tested-by: Matthias Kaehlcke <mka@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
