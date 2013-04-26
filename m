From: arjan@linux.intel.com (Arjan van de Ven)
Date: Fri, 26 Apr 2013 08:00:43 -0700
Subject: [RFC PATCH v4 00/14] sched: packing small tasks
In-Reply-To: <1366910611-20048-1-git-send-email-vincent.guittot@linaro.org>
References: <1366910611-20048-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <517A969B.5040606@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/25/2013 10:23 AM, Vincent Guittot wrote:
> Hi,
>
> This patchset takes advantage of the new per-task load tracking that is
> available in the kernel for packing the tasks in as few as possible
> CPU/Cluster/Core. It has got 2 packing modes:
> -The 1st mode packs the small tasks when the system is not too busy. The main
> goal is to reduce the power consumption in the low system load use cases by
> minimizing the number of power domain that are enabled but it also keeps the
> default behavior which is performance oriented.
> -The 2nd mode packs all tasks in as few as possible power domains in order to
> improve the power consumption of the system but at the cost of possible
> performance decrease because of the increase of the rate of ressources sharing
> compared to the default mode.


so I got to ask the hard question; what percentage of system level (not just cpu level)
power consumption gain can you measure (pick your favorite workload)...

on x86 (even on the low power stuff) I expect this to be very far into the noise
(since we have per core power gates, and power transitions are pretty fast)

you have some numbers in the back of your mail, but it's hard for me to get a conclusion out of
that (they either measure only cpu power, or are just vague in general)
