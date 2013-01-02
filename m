From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 02 Jan 2013 12:36:42 -0700
Subject: [PATCH] ARM: tegra: cpufreq: move clk_get/put out of function
 tegra_cpu_init/exit
In-Reply-To: <1356084595-17800-1-git-send-email-linuxzsc@gmail.com>
References: <1356084595-17800-1-git-send-email-linuxzsc@gmail.com>
Message-ID: <50E48C4A.6080207@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/21/2012 03:09 AM, Richard Zhao wrote:
> tegra_cpu_init/exit will be called every time one cpu core is online or
> offline. And all cpu cores share same clocks, redundant clk_get/put
> wast time,  so I move them out.

I've applied this to Tegra's for-3.9/soc branch.
