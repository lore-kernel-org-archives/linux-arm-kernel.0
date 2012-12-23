From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Sun, 23 Dec 2012 16:05:26 +0530
Subject: [PATCH] ARM: tegra: cpufreq: move clk_get/put out of function
 tegra_cpu_init/exit
In-Reply-To: <50D4D44F.2080203@wwwdotorg.org>
References: <1356084595-17800-1-git-send-email-linuxzsc@gmail.com>
 <50D4D44F.2080203@wwwdotorg.org>
Message-ID: <50D6DE6E.4060106@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 22 December 2012 02:57 AM, Stephen Warren wrote:
> On 12/21/2012 03:09 AM, Richard Zhao wrote:
>> tegra_cpu_init/exit will be called every time one cpu core is online or
>> offline. And all cpu cores share same clocks, redundant clk_get/put
>> wast time,  so I move them out.
> I think this is reasonable.
>
> Prashant, Peter, any comments?
>
> Is any other work in tegra_cpu_init() redundant? Is tegra_cpu_init()
> supposed to be called due to hotplug, or is that a bug in the cpufreq core?

Looks good. Also, instead of array we can use single variable for 
target_cpu_speed.
