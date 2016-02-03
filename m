From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 3 Feb 2016 09:11:57 -0700
Subject: [PATCH V8 23/23] perf tools: adding coresight etm PMU record
 capabilities
In-Reply-To: <20160202164129.GE32488@kernel.org>
References: <1452807977-8069-1-git-send-email-mathieu.poirier@linaro.org>
 <1452807977-8069-24-git-send-email-mathieu.poirier@linaro.org>
 <CANLsYkyBCFyu3Q-3jet-6rNfa3vGzWWQ3_m+PNf4Z+n6OxsscA@mail.gmail.com>
 <20160125211048.GE22501@kernel.org> <56AB4027.2070208@intel.com>
 <CANLsYkyFSjLmT_i7ANE2VL21Y+Nud13SvjOd1akV-e9hQcTcHA@mail.gmail.com>
 <20160129211208.GB32225@kernel.org>
 <CANLsYkxwtqHyoQ7+Z4a+qJfTV_ZWc72_mJh12FHxVEhNYKsgjw@mail.gmail.com>
 <CANLsYkysvVKoaxKJu9TYLAGJaZj9=9gMN+O6NpcDLztJNrgy+w@mail.gmail.com>
 <20160202164129.GE32488@kernel.org>
Message-ID: <CANLsYkwtT7VbLJaW+jsC+X0151znDsu6rLio4f5Fg-dyY2xJtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 February 2016 at 09:41, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> Em Tue, Feb 02, 2016 at 09:20:51AM -0700, Mathieu Poirier escreveu:
>> [...]
>>
>> >>> >
>> >>> > Looks OK, apart from adding linux/coresight-pmu.h to the manifest, but I
>> >>> > mentioned that on another patch.
>> >>> >
>> >>> > However there is no decoder, which begs the question, is there anything you
>> >>> > can actually do with the perf.data file?  Might be a bit confusing for users
>> >>> > if they can capture traces but not use perf tools on the resulting perf.data
>> >>> > file?
>> >>>
>> >>> We are working on a decoding library in parallel to this work.
>> >>
>> >> Would be nice to be able to get both in the same patch kit, no? So that
>> >> one can both record and process the traces, verifying it all works.
>> >
>> > We are still a few weeks away from being in a position where the
>> > community can start playing with the decoding library.  I can hold off
>> > on the "perf tools" patches when I queue the kernel side of the work
>> > for 4.6 but since you and Adrian have already reviewed the work it
>> > would be nice to have that part included as well.
>> >
>> > We've been playing with the perf.data files for a couple of months now
>> > and things look at the right place.  This isn't surprising since we
>> > are using the same framework as X86.
>> >
>> > I think the generation of the perf.data file should be coupled with
>> > the submission of the kernel driver but would also respect a diverging
>> > point of view.  Simply let me know what you prefer and I will adjust
>> > V9 accordingly.
>>
>> Arnaldo,
>>
>> I'm preparing V9 at this time - what's your view on the above?
>
> I'd say go with something we can test, i.e. if we generate a perf.data
> file we can't then process to figure out if what was inserted is right,
> how can we decide if it is ok?

Very well - I'll hold off on the perf tools patches for now.  We can
make a submission of all the user space components when things are in
a working order.

Mathieu

>
> Otherwise please describe how you test it, preferably by having this in
> the commit log, i.e. if you decide that using plain 'perf report -D' is
> enough, state that and show the output, etc.
>
> - Arnaldo
