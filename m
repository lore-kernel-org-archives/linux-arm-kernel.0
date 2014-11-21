From: morten.rasmussen@arm.com (Morten Rasmussen)
Date: Fri, 21 Nov 2014 12:35:26 +0000
Subject: [PATCH v9 03/10] sched: remove frequency scaling from cpu_capacity
In-Reply-To: <1415033687-23294-4-git-send-email-vincent.guittot@linaro.org>
References: <1415033687-23294-1-git-send-email-vincent.guittot@linaro.org>
 <1415033687-23294-4-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20141121123526.GD23177@e105550-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 03, 2014 at 04:54:40PM +0000, Vincent Guittot wrote:
> Now that arch_scale_cpu_capacity has been introduced to scale the original
> capacity, the arch_scale_freq_capacity is no longer used (it was
> previously used by ARM arch). Remove arch_scale_freq_capacity from the
> computation of cpu_capacity. The frequency invariance will be handled in the
> load tracking and not in the CPU capacity. 

Just a note:

Yes, we are scaling the load tracking of each task to compensate for
frequency scaling. I think that is all fine. Later we will have to feed
the current frequency into the energy model as well to figure out if
putting more tasks on a cpu will/should cause the frequency to increase
or not. We don't need it for now and don't need to add it in the commit
message. It is just a reminder that we may actually want to use
arch_scale_freq_capacity() combined with cpu_capacity to provide this
input to the energy model later.
