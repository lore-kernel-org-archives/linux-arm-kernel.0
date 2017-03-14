From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 14 Mar 2017 19:05:02 +0000
Subject: [PATCH 1/2] Documentation: perf: xgene: Add support for SoC PMU
 of next generation of X-Gene
In-Reply-To: <1489514812-19671-2-git-send-email-hotran@apm.com>
References: <1489514812-19671-1-git-send-email-hotran@apm.com>
 <1489514812-19671-2-git-send-email-hotran@apm.com>
Message-ID: <20170314190501.GA26335@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 11:06:51AM -0700, Hoan Tran wrote:
> This patch adds support for SoC-wide (AKA uncore) Performance Monitoring
> Unit in the next generation of X-Gene SoC.

It adds a description, certainly.

> 
> Signed-off-by: Hoan Tran <hotran@apm.com>
> ---
>  Documentation/perf/xgene-pmu.txt | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/perf/xgene-pmu.txt b/Documentation/perf/xgene-pmu.txt
> index d7cff44..51f8179 100644
> --- a/Documentation/perf/xgene-pmu.txt
> +++ b/Documentation/perf/xgene-pmu.txt
> @@ -23,12 +23,17 @@ equivalent of "l3c0/config=0x0b/".
>  Most of the SoC PMU has a specific list of agent ID used for monitoring
>  performance of a specific datapath. For example, agents of a L3 cache can be
>  a specific CPU or an I/O bridge. Each PMU has a set of 2 registers capable of
> -masking the agents from which the request come from. If the bit with
> -the bit number corresponding to the agent is set, the event is counted only if
> -it is caused by a request from that agent. Each agent ID bit is inversely mapped
> -to a corresponding bit in "config1" field. By default, the event will be
> -counted for all agent requests (config1 = 0x0). For all the supported agents of
> -each PMU, please refer to APM X-Gene User Manual.
> +masking the agents from which the request come from. If an agent is enabled,
> +the event is counted only if it is caused by a request from that agent.
> + - With SoC PMU version 1 and 2, each agent ID has an enable bit which is
> +inversely mapped to a corresponding bit in "config1" field. The value by
> +default of config1 is 0.
> + - With Soc PMU version 3, agent ID enable mask is encoded and mapped into
> +"config1" field without inversion. The value by default of "config1" is
> +defined corresponding to each SoC PMU type.

Why is this the opposite way around from version 1 and 2, given it's
described in the same field?

It seems that this only adds complication...

Mark.

> +By default, the event will be counted for all agent requests. For all the
> +supported agents of each PMU and agent configuration, please refer to
> +APM X-Gene User Manual.
>  
>  Each perf driver also provides a "cpumask" sysfs attribute, which contains a
>  single CPU ID of the processor which will be used to handle all the PMU events.
> -- 
> 1.9.1
> 
