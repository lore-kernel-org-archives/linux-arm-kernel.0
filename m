From: quentin.perret@arm.com (Quentin Perret)
Date: Thu, 22 Feb 2018 09:04:04 +0000
Subject: [PATCH v5 19/20] cpufreq: add support for CPU DVFS based on SCMI
 message protocol
In-Reply-To: <1518461124-17371-20-git-send-email-sudeep.holla@arm.com>
References: <1518461124-17371-1-git-send-email-sudeep.holla@arm.com>
 <1518461124-17371-20-git-send-email-sudeep.holla@arm.com>
Message-ID: <20180222085936.GA2290@e108498-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

On Monday 12 Feb 2018 at 18:45:23 (+0000), Sudeep Holla wrote:
[...]
> +/*
> + * perf_ops->freq_set is not a synchronous, the actual OPP change will
> + * happen asynchronously and can get notified if the events are
> + * subscribed for by the SCMI firmware
> + */
> +static int
> +scmi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
> +{
> +	struct scmi_data *priv = policy->driver_data;
> +	struct scmi_perf_ops *perf_ops = handle->perf_ops;
> +	u64 freq = policy->freq_table[index].frequency * 1000;
> +
> +	return perf_ops->freq_set(handle, priv->domain_id, freq, false);
> +}

Is arch_set_freq_scale() needed in this function ?

Thanks,
Quentin
