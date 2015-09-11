From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 11 Sep 2015 15:39:16 +0530
Subject: cpufreq: mediatek: allow modular build
In-Reply-To: <20150911095820.GM21084@n2100.arm.linux.org.uk>
References: <1768766.yu1lxjsjLL@wuerfel> <2329563.MhTbBXHVz1@wuerfel>
 <20150911082536.GL9650@linux> <3071823.f1VzTWVMmV@wuerfel>
 <20150911083806.GM9650@linux>
 <20150911093454.GK21084@n2100.arm.linux.org.uk>
 <20150911094003.GN9650@linux>
 <20150911095820.GM21084@n2100.arm.linux.org.uk>
Message-ID: <20150911100916.GO9650@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11-09-15, 10:58, Russell King - ARM Linux wrote:
> Not module "unplug" (I've never heard it called that before).  A module
> with a module_init() but no module_exit() can only be added to a running
> kernel, and never removed.  That's intentional behaviour.

Ah, I see. I wasn't sure that a module with no module_exit() can't be
removed.

> However, if you're talking about hot-unplug, presumably you're talking
> about _CPU_ hot-unplug, and that's something the code should definitely
> handle irrespective of whether it's built-in or a module.
> 
> The two issues are entirely separate.

Bah, all this time I meant module insertion/removal, sorry :(

-- 
viresh
