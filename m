From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Fri, 18 Apr 2014 13:54:48 +0200
Subject: [PATCH v4 4/5] sched: add a new SD_SHARE_POWERDOMAIN for
 sched_domain
In-Reply-To: <20140418105801.GV11182@twins.programming.kicks-ass.net>
References: <1397209481-28542-1-git-send-email-vincent.guittot@linaro.org>
 <1397209481-28542-5-git-send-email-vincent.guittot@linaro.org>
 <20140418105801.GV11182@twins.programming.kicks-ass.net>
Message-ID: <CAKfTPtATHUk8kswxQ+MaGhFa-m4TB4pcAxL5mBJHOOZXmm8bwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 April 2014 12:58, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Apr 11, 2014 at 11:44:40AM +0200, Vincent Guittot wrote:
>> A new flag SD_SHARE_POWERDOMAIN is created to reflect whether groups of CPUs
>> in a sched_domain level can or not reach different power state. As an example,
>> the flag should be cleared at CPU level if groups of cores can be power gated
>> independently. This information can be used in the load balance decision or to
>> add load balancing level between group of CPUs that can power gate
>> independantly.
>> This flag is part of the topology flags that can be set by arch.
>>
>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>> ---
>
> Building a cris-defconfig this gets me an endless stream of misery:
>
> In file included from /usr/src/linux-2.6/init/do_mounts.c:12:0:
> /usr/src/linux-2.6/include/linux/sched.h:1048:46: warning: 'struct sched_domain_topology_level' declared inside parameter list [enabled by default]
> /usr/src/linux-2.6/include/linux/sched.h:1048:46: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
> In file included from /usr/src/linux-2.6/include/linux/utsname.h:5:0,
>                  from /usr/src/linux-2.6/include/linux/init_task.h:6,
>                  from /usr/src/linux-2.6/init/init_task.c:1:
>
> Might be something about UP builds, didn't check x86-UP.

yes, you're right
An empty set_sched_topology function has been define for UP whereas it
can't because of the sched_domain_topology_level parameter which is
available only in SMP

I'm going to send a fix.

sorry for the dumb error
