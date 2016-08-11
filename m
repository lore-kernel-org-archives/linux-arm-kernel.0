From: vince@deater.net (Vince Weaver)
Date: Wed, 10 Aug 2016 23:27:58 -0400 (EDT)
Subject: [PATCH V3 1/6] perf/core: Adding PMU driver specific configuration
In-Reply-To: <CANLsYkwz1aCmsBbtZXQK3_B-T6cVBP1UYV9cqbKiNSmdrhUuFQ@mail.gmail.com>
References: <1469742143-22245-1-git-send-email-mathieu.poirier@linaro.org>
 <1469742143-22245-2-git-send-email-mathieu.poirier@linaro.org>
 <20160804165821.GT6862@twins.programming.kicks-ass.net>
 <CANLsYkzK+mNRYiGn0SLQ5kA0+xxi6OGVbNL4F3LLRBTgSkssxQ@mail.gmail.com>
 <20160805155344.GV6879@twins.programming.kicks-ass.net>
 <CANLsYkwz1aCmsBbtZXQK3_B-T6cVBP1UYV9cqbKiNSmdrhUuFQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.11.1608102321150.8355@pianoman.cluster.toy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Aug 2016, Mathieu Poirier wrote:
> 
> After a little bit of digging around I understand that manpages have
> to be written _after_ the new ioctl call has been added - at least
> that's what I deduce when looking at what Vince Weaver did for the BPF
> support:

The manpage patch doesn't get applied until a feature hits a release 
kernel (because sometimes features are backed out at the last minute).

It is good to have a manpage update ready at the time of your initial 
patch submission though for a variety of reasons

1. It helps the patch reviewers see what ABI change is being proposed
2. It is better to catch mistakes in the ABI early rather than trying
	to fix them after it's hit a released kernel and it's too late
3. By the time the kernel is released, you might have forgotten details
	about the change, or moved on to other things, and then it's up
	to me to try to figure out the purpose of the change and
	unfortunately this isn't always obvious from the git commit logs.

Vince
