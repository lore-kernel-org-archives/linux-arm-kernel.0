Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18B8C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:26:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ED3F2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NRQbMlL9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aCIt3mQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED3F2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RcHDL0i1XuNg518BsTnxWsOurhd8KsGXTdVAtWvD24Y=; b=NRQbMlL9M2wUEe
	kWv1Y55j+ReTynpMyB3RTrnT9BPYY76zkbzEp/OWi2G7t0EwWxK1KHoV/RAD0V9JNNJ9x5F9GR6tS
	eDfC4DXt5CWZqmdDTfUGZDQEVjAJfVwUSiYcwkf7+oQjy2zprcKdpvD+xGQNVRISKGQEIGkUV1VUB
	4sVJdAsyNMf/mupxZ5HdmR6HLpuyLYXuPPus/Z9FdpUViiwH5z5OVVizYFEGrhffjZlGKgOr8HpY6
	Bcjq8YcOgx9XDSSUheL/sPYMdJXR4Q3LeY+khZZkSsLjsHyOdXuWqQ4FYC5E+WJG0jjPkC2yfOsGg
	E/caP0sFXXbUgkx+KGNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp6kB-0006pH-Oa; Thu, 31 Jan 2019 07:26:39 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp6k8-0006ou-NT
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 07:26:38 +0000
Received: by mail-pl1-x642.google.com with SMTP id e11so1079769plt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 23:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=UnrYeubApCq/+0X7gGe4NXl9ZaHuao0U3/2CArPUokc=;
 b=aCIt3mQd6UL5e+OqkpGMLrqT6JTN9FEoEs4eXoSzVyjDr6l8jRas7N+dCEKaK05CHj
 7Mrspf4epo0lt+rfkMIhJS7h/5F5sQtivF5jKbmVyewgH+Wj8tEc6uz2Dqr7MG3PoOL5
 svxZDzC4C6LS6unq34KyrnJZ0XZ/+SHBMyF3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=UnrYeubApCq/+0X7gGe4NXl9ZaHuao0U3/2CArPUokc=;
 b=oK1qCfu98DRjCaEK3itbq/mCPt6+a2WJeXMOtVfY5/XSg0KiGQqV8BFfEfBvfI5yNQ
 nN/eLnp01c8nTPOfkR2Ll8ognFeJX+jD4KtEoJs8gALTtvpSpHYbY4YLJc3KQV+9JvES
 4fqjY4XrrqM6s1yJnH76aAqNCLc0JuOIyTuW7CzCMbDGrVK3Y2dYPFUjbiZ5pUt4qMPn
 oDqv+4jjIGPL9v/FQFIGJChqRuPb9fjUIWQed9v2CC8sl2UFcl9Bdm8r6qgBPVpoZtou
 8iQL7CHMfK0WzRqq7Sg/phvAeiwR1tU7d4/sxhqfqv8uQTPboOoVRlED0nm+Xw6kVqwV
 OgkQ==
X-Gm-Message-State: AJcUukdTbJU0nPB5xcA9trG3HTH1ykNZ8D9lU35Qm5fFW6SxmXbybKVi
 hgYGSaXSrTwsQ5XY+4I2MdT7MQ==
X-Google-Smtp-Source: ALg8bN5Yu2fhJvbbNMdhN2xDmQJK0Q2QimJ2AuBY9WHuBzUGxKsYmBZGYc6+I9/YZ4NSSwl9aATViw==
X-Received: by 2002:a17:902:4025:: with SMTP id
 b34mr34117301pld.181.1548919595981; 
 Wed, 30 Jan 2019 23:26:35 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id p77sm7546037pfi.85.2019.01.30.23.26.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 23:26:35 -0800 (PST)
Date: Thu, 31 Jan 2019 12:56:33 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v2 1/5] PM / OPP: Introduce a power estimation helper
Message-ID: <20190131072633.bcqc75s6jmyt7fgx@vireshk-i7>
References: <20190130170506.20450-1-quentin.perret@arm.com>
 <20190130170506.20450-2-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190130170506.20450-2-quentin.perret@arm.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_232636_763019_11169D06 
X-CRM114-Status: GOOD (  17.70  )
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

On 30-01-19, 17:05, Quentin Perret wrote:
> +static int __maybe_unused _get_cpu_power(unsigned long *mW, unsigned long *kHz,
> +					 int cpu)
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

The voltage is also stored as triplet now a days and we must consider
the higher value for these calculations. Also what about the case of
multiple regulators here or performance-states ?

> +	dev_pm_opp_put(opp);
> +	if (!mV)
> +		return -EINVAL;
> +
> +	tmp = (u64)cap * mV * mV * (Hz / 1000000);
> +	do_div(tmp, 1000000000);
> +
> +	*mW = (unsigned long)tmp;

I was thinking will it be better if we just save this information in
opp->power field during init, so we can just read a value here
instead. But I am still not sure :(

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
> + * been specified, and tries to register an Energy Model with it if it has.
> + */
> +void dev_pm_opp_of_register_em(struct cpumask *cpus, int nr_opp)
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

What if no voltage is supplied in DT ?

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
> -- 
> 2.20.1

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
