From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 14 Aug 2013 12:27:20 +0100
Subject: [RFC][PATCH 1/2] ARM64: add cpu topology definition
In-Reply-To: <20130729095400.GB32383@mudshark.cambridge.arm.com>
References: <1374921728-9007-1-git-send-email-hanjun.guo@linaro.org>
 <CAKfTPtBpo41LJ3V8TB8YwudwqpURuA2u_Lvu4KYVK=qSs+gFuQ@mail.gmail.com>
 <20130729095400.GB32383@mudshark.cambridge.arm.com>
Message-ID: <20130814112720.GB43445@MacBook-Pro.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 10:54:01AM +0100, Will Deacon wrote:
> On Mon, Jul 29, 2013 at 10:46:06AM +0100, Vincent Guittot wrote:
> > On 27 July 2013 12:42, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> > > Power aware scheduling needs the cpu topology information to improve the
> > > cpu scheduler decision making.
> > 
> > It's not only power aware scheduling. The scheduler already uses
> > topology and cache sharing when  CONFIG_SCHED_MC and/or
> > CONFIG_SCHED_SMT are enable. So you should also add these configs for
> > arm64 so the scheduler can use it
> 
> ... except that the architecture doesn't define what the AFF fields in MPIDR
> really represent. Using them to make key scheduling decisions relating to
> cache proximity seems pretty risky to me, especially given the track record
> we've seen already on AArch32 silicon. It's a convenient register if it
> contains the data we want it to contain, but we need to force ourselves to
> come to terms with reality here and simply use it as an identifier for a
> CPU.
> 
> Can't we just use the device-tree to represent this topological data for
> arm64? Lorenzo has been working on bindings in this area.

Catching up on email after holiday - I agree with Will here, we should
use DT for representing the topology (or ACPI) and not rely on the MPIDR
value.

-- 
Catalin
