From: steve.muckle@linaro.org (Steve Muckle)
Date: Tue, 19 Jan 2016 11:48:15 -0800
Subject: [RFC PATCH v2 0/4] CPUs capacity information for heterogeneous
 systems
In-Reply-To: <20160119142933.GF8573@e106622-lin>
References: <1452262172-31861-1-git-send-email-juri.lelli@arm.com>
 <56994D87.6000709@linaro.org> <20160118151316.GD7159@e106622-lin>
 <CAKfTPtBFR4cowT-j4qVxfUvh6NDNmi6R=J7z9kywi6bONU3Pow@mail.gmail.com>
 <20160118163014.GA10332@e106622-lin>
 <CAKfTPtDJBAXUz=_-QQSkrqwAvmUJd1bUJ-VfSaNER-0NzWpunA@mail.gmail.com>
 <20160119105941.GA28845@e104818-lin.cambridge.arm.com>
 <20160119112323.GB8573@e106622-lin> <20160119142933.GF8573@e106622-lin>
Message-ID: <569E92FF.4000006@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/19/2016 06:29 AM, Juri Lelli wrote:
>>> Two questions:
>>> > > 
>>> > > 1. How is the boot time affected by the benchmark?
>>> > > 2. How is the boot time affected by considering all the CPUs the same?
>>> > > 
>>> > > My preference is for DT and sysfs (especially useful for
>>> > > development/tuning) but I'm not opposed to a boot-time benchmark if
>>> > > people insist on it. If the answer to point 2 is "insignificant", we
>>> > > could as well defer the capacity setting to user space (sysfs).
>>> > > 
>> > 
>> > Given that we are not targeting boot time with this, but rather better
>> > performance afterwards, I don't expect significant differences; but,
>> > I'll get numbers :).
>> > 
> I've got some boot time numbers on TC2 and Juno based on timestamps.
> They are of course not accurate and maybe not so representative of
> products, but I guess still ballpark right.
> 
> I'm generally seeing ~1sec increase in boot time for 1 and practically
> no difference for 2 (even after having added patches that provide
> runtime performance improvements).

One second is considerable IMO. Aside from the general desire to have
shorter boot times on any platform there are environments like
automotive where boot time is critical.

How are the CPUs numbered on TC2 and Juno? When all CPUs are considered
the same, is work running on the big CPUs because of the way they are
numbered?

thanks,
Steve
