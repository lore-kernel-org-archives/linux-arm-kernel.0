From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Tue, 11 Feb 2014 14:18:56 +0100
Subject: [PATCH 1/4] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20140211103428.GC8693@mudshark.cambridge.arm.com>
References: <1392037324-5069-1-git-send-email-broonie@kernel.org>
 <20140210162230.GK25305@arm.com> <20140210164647.GB13533@sirena.org.uk>
 <CAKfTPtDih6n5ckhXUgNKrbw5EFt45uuQFFPKB2aN0NGGG96Pmg@mail.gmail.com>
 <20140211103428.GC8693@mudshark.cambridge.arm.com>
Message-ID: <CAKfTPtDjF2bZsoj+tgBH-ZXYXNbXQ2mBie0FVgUy2vb_jY12FQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 February 2014 11:34, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Feb 11, 2014 at 08:15:19AM +0000, Vincent Guittot wrote:
>> On 10 February 2014 17:46, Mark Brown <broonie@kernel.org> wrote:
>> > On Mon, Feb 10, 2014 at 04:22:31PM +0000, Catalin Marinas wrote:
>> >> On Mon, Feb 10, 2014 at 01:02:01PM +0000, Mark Brown wrote:
>> >
>> >> > +           if (cpu != cpuid)
>> >> > +                   cpumask_set_cpu(cpu, &cpuid_topo->thread_sibling);
>> >> > +   }
>> >> > +   smp_wmb();
>> >
>> >> I now noticed there are a couple of smp_wmb() calls in this patch. What
>> >> are they for?
>> >
>> > To be honest I mostly cargo culted them from the ARM implementation; I
>> > did look a bit but didn't fully dig into it - it seemed they were
>> > required to ensure that the updates for the new CPU are visible over all
>> > CPUs.  Vincent?
>>
>> Yes that's it. we must ensure that updates are made visible to other CPUs
>
> In relation to what? The smp_* barriers ensure ordering of observability
> between a number of independent accesses, so you must be ensuring
> ordering against something else. Also, you need to guarantee ordering on the
> read-side too -- how is this achieved? I can't see any smp_rmb calls from a
> quick grep, so I assume you're making use of address dependencies?

The boot sequence ensures the rmb

Vincent

>
> /confused
>
> Will
