From: arjan@linux.intel.com (Arjan van de Ven)
Date: Tue, 26 Mar 2013 08:29:54 -0700
Subject: [RFC PATCH v3 3/6] sched: pack small tasks
In-Reply-To: <1364301998.5053.17.camel@laptop>
References: <1363955155-18382-1-git-send-email-vincent.guittot@linaro.org>
 <1363955155-18382-4-git-send-email-vincent.guittot@linaro.org>
 <1364301998.5053.17.camel@laptop>
Message-ID: <5151BEF2.9090100@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Isn't this basically related to picking the NO_HZ cpu; if the system
> isn't fully symmetric with its power gates you want the NO_HZ cpu to be
> the 'special' cpu. If it is symmetric we really don't care which core
> is left 'running' and we can even select a new pack cpu from the idle
> cores once the old one is fully utilized.

you don't really care much sure, but there's some advantages for sorting "all the way left",
e.g. to linux cpu 0.
Some tasks only run there, and interrupts tend to be favored to that cpu as well on x86.
