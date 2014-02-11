From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Tue, 11 Feb 2014 09:15:19 +0100
Subject: [PATCH 1/4] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20140210164647.GB13533@sirena.org.uk>
References: <1392037324-5069-1-git-send-email-broonie@kernel.org>
 <20140210162230.GK25305@arm.com> <20140210164647.GB13533@sirena.org.uk>
Message-ID: <CAKfTPtDih6n5ckhXUgNKrbw5EFt45uuQFFPKB2aN0NGGG96Pmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 February 2014 17:46, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Feb 10, 2014 at 04:22:31PM +0000, Catalin Marinas wrote:
>> On Mon, Feb 10, 2014 at 01:02:01PM +0000, Mark Brown wrote:
>
>> > +           if (cpu != cpuid)
>> > +                   cpumask_set_cpu(cpu, &cpuid_topo->thread_sibling);
>> > +   }
>> > +   smp_wmb();
>
>> I now noticed there are a couple of smp_wmb() calls in this patch. What
>> are they for?
>
> To be honest I mostly cargo culted them from the ARM implementation; I
> did look a bit but didn't fully dig into it - it seemed they were
> required to ensure that the updates for the new CPU are visible over all
> CPUs.  Vincent?

Yes that's it. we must ensure that updates are made visible to other CPUs
