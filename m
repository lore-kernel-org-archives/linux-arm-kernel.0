From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Mon, 29 Jul 2013 12:39:16 +0200
Subject: [RFC][PATCH 1/2] ARM64: add cpu topology definition
In-Reply-To: <20130729095400.GB32383@mudshark.cambridge.arm.com>
References: <1374921728-9007-1-git-send-email-hanjun.guo@linaro.org>
 <CAKfTPtBpo41LJ3V8TB8YwudwqpURuA2u_Lvu4KYVK=qSs+gFuQ@mail.gmail.com>
 <20130729095400.GB32383@mudshark.cambridge.arm.com>
Message-ID: <CAKfTPtANkeZkDHP_b2OV=tRxQ+q-J_SVMzrMYifgEhiJy=GijA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 July 2013 11:54, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Jul 29, 2013 at 10:46:06AM +0100, Vincent Guittot wrote:
>> On 27 July 2013 12:42, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> > Power aware scheduling needs the cpu topology information to improve the
>> > cpu scheduler decision making.
>>
>> It's not only power aware scheduling. The scheduler already uses
>> topology and cache sharing when  CONFIG_SCHED_MC and/or
>> CONFIG_SCHED_SMT are enable. So you should also add these configs for
>> arm64 so the scheduler can use it
>
> ... except that the architecture doesn't define what the AFF fields in MPIDR
> really represent. Using them to make key scheduling decisions relating to

Do you mean that it's not define for arm64 ARM? AFAIK, there are good
explanation in the arm32 ARM and it's currently used with SCHED_MC and
SCHED_SMT

> cache proximity seems pretty risky to me, especially given the track record
> we've seen already on AArch32 silicon. It's a convenient register if it
> contains the data we want it to contain, but we need to force ourselves to
> come to terms with reality here and simply use it as an identifier for a
> CPU.
>
> Can't we just use the device-tree to represent this topological data for
> arm64? Lorenzo has been working on bindings in this area.

I agree that we should probably use DT if we can't rely in MPIDR for arm64

Vincent
>
> Will
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
