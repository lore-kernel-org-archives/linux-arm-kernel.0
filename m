From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 27 Mar 2013 17:37:42 +0000
Subject: [RFC PATCH v3 3/6] sched: pack small tasks
In-Reply-To: <alpine.LFD.2.03.1303271314240.1372@syhkavp.arg>
References: <1363955155-18382-4-git-send-email-vincent.guittot@linaro.org>
 <1364301998.5053.17.camel@laptop>
 <5151BEF2.9090100@linux.intel.com>
 <1364373980.5053.57.camel@laptop>
 <CAKfTPtAox+h0YmpP6W==hJ5FaNzDfF8bQmadmU86MrfnJt67QQ@mail.gmail.com>
 <1364374820.5053.63.camel@laptop>
 <20130327111855.GI801@MacBook-Pro.local>
 <1364393634.5053.71.camel@laptop>
 <20130327163642.GA1136@localhost.cambridge.arm.com>
 <alpine.LFD.2.03.1303271314240.1372@syhkavp.arg>
Message-ID: <20130327173742.GA17642@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 05:18:53PM +0000, Nicolas Pitre wrote:
> On Wed, 27 Mar 2013, Catalin Marinas wrote:
> 
> > So if the above works, the scheduler guys can mandate that little CPUs
> > are always first and for ARM it would be a matter of getting the right
> > CPU topology in the DT (independent of what hw vendors think of CPU
> > topology) and booting Linux on CPU 4 etc.
> 
> Just a note about that: if the scheduler mandates little CPUs first, 
> that should _not_ have any implications on the DT content.  DT is not 
> about encoding Linux specific implementation details.  It is simple 
> enough to tweak the CPU logical map at run time when enumeratiing CPUs.

You are right, though a simpler way (hack) to tweak the cpu_logical_map
is to change the DT ;).

But the problem is that the kernel doesn't know which CPU is big and
which is little, unless you specify this in some way via the DT. It can
be the cpu nodes order or some other means.

-- 
Catalin
