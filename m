From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Wed, 8 Feb 2012 05:39:59 +0400
Subject: [PATCH RFC 0/4] Scheduler idle notifiers and users
Message-ID: <20120208013959.GA24535@panacea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

For some drivers we need to know when scheduler is idling. The most
straightforward way is to gracefully hook into the idle loop.

On x86 there are "CPU idle" notifiers in the inner idle loop, but
scheduler idle notifiers are different. These notifiers do not run on
every invocation/exit from cpuidle, instead they used to notify about
scheduler state changes, not HW states.

In other words, CPU idle notifiers work inside while(!need_resched())
loop (nested into idle loop), while scheduler idle notifier work
outside of the loop.

The first two patches consolidate scheduler idle entry/exit
points, and converts architectures to this new API.

The third patch is a new cpufreq governor, the commit message
briefly describes it.

The fourth patch is another user of the notifiers, a trivial one.

Thanks,

p.s. For the reference, the old discussion about CPU/PM idle
     notifiers: http://lkml.org/lkml/2011/6/27/391 

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
