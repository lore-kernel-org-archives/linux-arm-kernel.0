From: preeti@linux.vnet.ibm.com (Preeti U Murthy)
Date: Fri, 05 Sep 2014 17:36:19 +0530
Subject: [PATCH v5 08/12] sched: move cfs task on a CPU with higher
 capacity
In-Reply-To: <1409051215-16788-9-git-send-email-vincent.guittot@linaro.org>
References: <1409051215-16788-1-git-send-email-vincent.guittot@linaro.org>
 <1409051215-16788-9-git-send-email-vincent.guittot@linaro.org>
Message-ID: <5409A73B.4050402@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vincent,

On 08/26/2014 04:36 PM, Vincent Guittot wrote:
> If the CPU is used for handling lot of IRQs, trig a load balance to check if
> it's worth moving its tasks on another CPU that has more capacity.
> 
> As a sidenote, this will note generate more spurious ilb because we already
> trig an ilb if there is more than 1 busy cpu. If this cpu is the only one that
> has a task, we will trig the ilb once for migrating the task.
> 
> The nohz_kick_needed function has been cleaned up a bit while adding the new
> test
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

So I see that there are added checks in your previous patches on if the
cpu capacity for CFS tasks is good enough to run tasks on the cpu. My
concern is although they appear sensible, would they trigger an increase
in the number of times we load balance to a large extent.

Ebizzy would not test this aspect right? There are no real time
tasks/interrupts that get generated.

Besides, what is the column that says patchset+irq? What is the irq
accounting patchset that you refer to in your cover letter?

Regards
Preeti U Murthy
