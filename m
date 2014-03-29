From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 28 Mar 2014 22:27:14 -0400 (EDT)
Subject: [RFC 0/4] sched: consolidation of cpu_power
In-Reply-To: <1396012949-6227-1-git-send-email-vincent.guittot@linaro.org>
References: <1396012949-6227-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <alpine.LFD.2.11.1403282217070.1571@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Mar 2014, Vincent Guittot wrote:

> Part of this patchset was previously part of the larger tasks packing patchset
> [1]. I have splitted the latter in 3 different patchsets (at least) to make the
> thing easier.
> -configuration of sched_domain topology [2]
> -update and consolidation of cpu_power (this patchset)
> -tasks packing algorithm
> 
> SMT system is no more the only system that can have a CPUs with capacity that
> is different from the default value. We need to extend the use of
> cpu_power_orig to all kind of platform so the scheduler will have both the
> maximum capacity (cpu_power_orig/power_orig) and the current capacity
> (cpu_power/power) of CPUs and groups of the sched_domains.
[...]

Wouldn't it make sense to have a patch in this series that performs some 
s/power/capacity/ throughout the scheduler code before the other patches 
are applied?  That would help getting consistent terminology and avoid 
confusion before real power related metrics are eventually brought into 
the scheduler.


Nicolas
