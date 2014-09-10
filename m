From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 10 Sep 2014 16:19:05 +0200
Subject: [PATCH v5 07/12] sched: test the cpu's capacity in wake affine
In-Reply-To: <1409051215-16788-8-git-send-email-vincent.guittot@linaro.org>
References: <1409051215-16788-1-git-send-email-vincent.guittot@linaro.org>
 <1409051215-16788-8-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20140910141905.GR3190@worktop.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 01:06:50PM +0200, Vincent Guittot wrote:
> Currently the task always wakes affine on this_cpu if the latter is idle.
> Before waking up the task on this_cpu, we check that this_cpu capacity is not
> significantly reduced because of RT tasks or irq activity.
> 
> Use case where the number of irq and/or the time spent under irq is important
> will take benefit of this because the task that is woken up by irq or softirq
> will not use the same CPU than irq (and softirq) but a idle one.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Rik, you've been 'fighting' wake_affine, any objections?
