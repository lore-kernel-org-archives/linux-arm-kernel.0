From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 21 Dec 2012 14:27:43 -0700
Subject: [PATCH] ARM: tegra: cpufreq: move clk_get/put out of function
 tegra_cpu_init/exit
In-Reply-To: <1356084595-17800-1-git-send-email-linuxzsc@gmail.com>
References: <1356084595-17800-1-git-send-email-linuxzsc@gmail.com>
Message-ID: <50D4D44F.2080203@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/21/2012 03:09 AM, Richard Zhao wrote:
> tegra_cpu_init/exit will be called every time one cpu core is online or
> offline. And all cpu cores share same clocks, redundant clk_get/put
> wast time,  so I move them out.

I think this is reasonable.

Prashant, Peter, any comments?

Is any other work in tegra_cpu_init() redundant? Is tegra_cpu_init()
supposed to be called due to hotplug, or is that a bug in the cpufreq core?
