From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 3 Nov 2014 16:51:29 +0100
Subject: [PATCH v8 10/10] sched: make scale_rt invariant with frequency
In-Reply-To: <1414745252-4895-11-git-send-email-vincent.guittot@linaro.org>
References: <1414745252-4895-1-git-send-email-vincent.guittot@linaro.org>
 <1414745252-4895-11-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20141103155129.GK12706@worktop.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 09:47:32AM +0100, Vincent Guittot wrote:
> The call to arch_scale_frequency_capacity in the rt scheduling path might be
> a concern for RT folks because I'm not sure whether we can rely on
> arch_scale_freq_capacity to be short and efficient ?

Well, you put it in quite a hot path on the CFS side too, so it had
better be blazing fast anyhow.


That said, can you move all the running + invariance bits at the
beginning of the patch set, these appear to be the least controversial
bits and 'desired' by quite a few people, so we'll try and get those
agreed upon and merged first.
