From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Wed, 30 Sep 2015 14:50:41 +0300
Subject: [RFC PATCH 15/20] coresight: etm-perf: implementing 'setup_aux()'
 API
In-Reply-To: <1442593594-10665-16-git-send-email-mathieu.poirier@linaro.org>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
 <1442593594-10665-16-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <87bnckjfce.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> +static void *etm_setup_aux(int cpu, void **pages,
> +			      int nr_pages, bool overwrite)
> +{
> +	struct coresight_device *csdev;
> +
> +	if (cpu == -1)
> +		cpu = smp_processor_id();
> +
> +	csdev = per_cpu(csdev_sink, cpu);
> +	if (!csdev)
> +		return NULL;
> +
> +	return sink_ops(csdev)->setup_aux(csdev, cpu, pages,
> +					  nr_pages, overwrite);

Is it guaranteed that this sink would always have .setup_aux()?

Regards,
--
Alex
