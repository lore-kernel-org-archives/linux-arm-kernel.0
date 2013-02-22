From: jacob.jun.pan@linux.intel.com (Jacob Pan)
Date: Fri, 22 Feb 2013 09:55:30 -0800
Subject: [PATCH 2/2][RFC] time : set broadcast irq affinity
In-Reply-To: <1361484083-5906-2-git-send-email-daniel.lezcano@linaro.org>
References: <5123C299.3080005@linaro.org>
 <1361484083-5906-1-git-send-email-daniel.lezcano@linaro.org>
 <1361484083-5906-2-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20130222095530.377fd218@chromoly>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Feb 2013 23:01:23 +0100
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> +/*
> + * Set broadcast interrupt affinity
> + */
> +static void tick_broadcast_set_affinity(struct clock_event_device
> *bc, int cpu) +{
> +	struct cpumask cpumask;
> +
> +	if (!(bc->features & CLOCK_EVT_FEAT_DYNIRQ))
> +		return;
> +
> +	cpumask_clear(&cpumask);
> +	cpumask_set_cpu(cpu, &cpumask);
> +	irq_set_affinity(bc->irq, &cpumask);
would it be more efficient to keep track of the current bc->irq affinity
via cpumask then set it only if it is different?

-- 
Thanks,

Jacob
