From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 27 Mar 2013 13:18:53 -0400 (EDT)
Subject: [RFC PATCH v3 3/6] sched: pack small tasks
In-Reply-To: <20130327163642.GA1136@localhost.cambridge.arm.com>
References: <1363955155-18382-1-git-send-email-vincent.guittot@linaro.org>
 <1363955155-18382-4-git-send-email-vincent.guittot@linaro.org>
 <1364301998.5053.17.camel@laptop> <5151BEF2.9090100@linux.intel.com>
 <1364373980.5053.57.camel@laptop>
 <CAKfTPtAox+h0YmpP6W==hJ5FaNzDfF8bQmadmU86MrfnJt67QQ@mail.gmail.com>
 <1364374820.5053.63.camel@laptop> <20130327111855.GI801@MacBook-Pro.local>
 <1364393634.5053.71.camel@laptop>
 <20130327163642.GA1136@localhost.cambridge.arm.com>
Message-ID: <alpine.LFD.2.03.1303271314240.1372@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Mar 2013, Catalin Marinas wrote:

> So if the above works, the scheduler guys can mandate that little CPUs
> are always first and for ARM it would be a matter of getting the right
> CPU topology in the DT (independent of what hw vendors think of CPU
> topology) and booting Linux on CPU 4 etc.

Just a note about that: if the scheduler mandates little CPUs first, 
that should _not_ have any implications on the DT content.  DT is not 
about encoding Linux specific implementation details.  It is simple 
enough to tweak the CPU logical map at run time when enumeratiing CPUs.


Nicolas
