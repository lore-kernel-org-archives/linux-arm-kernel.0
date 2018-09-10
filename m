From: mingo@kernel.org (Ingo Molnar)
Date: Mon, 10 Sep 2018 10:21:11 +0200
Subject: [PATCH 1/4] sched/topology: SD_ASYM_CPUCAPACITY flag detection
In-Reply-To: <1532093554-30504-2-git-send-email-morten.rasmussen@arm.com>
References: <1532093554-30504-1-git-send-email-morten.rasmussen@arm.com>
 <1532093554-30504-2-git-send-email-morten.rasmussen@arm.com>
Message-ID: <20180910082111.GA48257@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Morten Rasmussen <morten.rasmussen@arm.com> wrote:

> The SD_ASYM_CPUCAPACITY sched_domain flag is supposed to mark the
> sched_domain in the hierarchy where all cpu capacities are visible for
> any cpu's point of view on asymmetric cpu capacity systems. The

>  /*
> + * Find the sched_domain_topology_level where all cpu capacities are visible
> + * for all cpus.
> + */

> +	/*
> +	 * Examine topology from all cpu's point of views to detect the lowest
> +	 * sched_domain_topology_level where a highest capacity cpu is visible
> +	 * to everyone.
> +	 */

>  #define SD_WAKE_AFFINE               0x0020  /* Wake task to waking CPU */
> -#define SD_ASYM_CPUCAPACITY  0x0040  /* Groups have different max cpu capacities */
> +#define SD_ASYM_CPUCAPACITY  0x0040  /* Domain members have different cpu capacities */

For future reference: *please* capitalize 'CPU' and 'CPUs' in future patches like the rest of 
the scheduler does.

You can see it spelled right above the new definition: 'waking CPU' ;-)

(I fixed this up in this patch.)

Thanks!

	Ingo
