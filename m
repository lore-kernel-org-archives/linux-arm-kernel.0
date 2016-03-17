From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 17 Mar 2016 23:38:21 +0100
Subject: [PATCH v2 1/4] nmi_backtrace: add more trigger_*_cpu_backtrace()
 methods
In-Reply-To: <56EB3050.3060607@mellanox.com>
References: <1458147733-29338-1-git-send-email-cmetcalf@mellanox.com>
 <1458147733-29338-2-git-send-email-cmetcalf@mellanox.com>
 <20160317193600.GY6344@twins.programming.kicks-ass.net>
 <56EB3050.3060607@mellanox.com>
Message-ID: <20160317223821.GZ6344@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2016 at 06:31:44PM -0400, Chris Metcalf wrote:
> On 3/17/2016 3:36 PM, Peter Zijlstra wrote:
> >On Wed, Mar 16, 2016 at 01:02:10PM -0400, Chris Metcalf wrote:
> >>Currently you can only request a backtrace of either all cpus, or
> >>all cpus but yourself.  It can also be helpful to request a remote
> >>backtrace of a single cpu, and since we want that, the logical
> >>extension is to support a cpumask as the underlying primitive.
> >>
> >>This change modifies the existing lib/nmi_backtrace.c code to take
> >>a cpumask as its basic primitive, and modifies the linux/nmi.h code
> >>to use either the old "all/all_but_self" arch methods, or the new
> >>"cpumask" method, depending on which is available.
> >>
> >>The existing clients of nmi_backtrace (arm and x86) are converted
> >>to using the new cpumask approach in this change.
> >So the past days I've been staring at RCU stall warns, and they can use
> >a little of this. Their remote stack unwinds are less than useful.
> 
> Were you suggesting this as an improvement for a possible v3, or just a
> kind of implicit ack of the patch series?  Thanks!

A suggestion more like. I've not actually looked at the 4th patch.

I'll try and fold the patches into the runs I do tomorrow, I'm sure to
trigger lots of fail. Maybe I'll even do that RCU patch.
