From: steve.muckle@linaro.org (Steve Muckle)
Date: Tue, 9 Feb 2016 09:30:05 -0800
Subject: [PATCH v3 0/6] CPUs capacity information for heterogeneous systems
In-Reply-To: <20160209103748.GP11415@e106622-lin>
References: <1454500799-18451-1-git-send-email-juri.lelli@arm.com>
 <56B92BF4.4030405@linaro.org> <20160209103748.GP11415@e106622-lin>
Message-ID: <56BA221D.1030907@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/2016 02:37 AM, Juri Lelli wrote:
>> I'm still concerned that there's no way to obtain optimal boot time on a
>> > heterogeneous system. Either the dynamic benchmarking is enabled, adding
>> > 1 sec, or the benchmarking is skipped, and task distribution on the
>> > heterogeneous CPUs is determined by the platform's CPU numbering and
>> > chance, potentially impacting performance nondeterministically until
>> > userspace sets the correct capacity values via sysfs.
>> > 
>> > I believe you tested the impact on boot time of using equal capacity
>> > values and saw little difference. I'm wondering though, what was the CPU
>> > numbering on that target?
>> > 
>
> My targets (Juno and TC2) had big cluster on 1,2 and little on the
> remaining cpus. Why do you think this might matter?

There's a natural bias in the scheduler AFAIK towards lower-numbered
CPUs since they are typically scanned in numerically ascending order. So
when all capacities are initially defaulted to be the same I think
you'll be more likely to use the lower numbered CPUs.

I'd be curious what the performance penalty is on a b.L system where the
lowest numbered CPUs are small. I don't have such a target but maybe
it's possible to compare booting just with bigs vs just with littles, at
least until userspace intializes and a script can bring up the others,
which is the same point at which capacities could be properly set. That
would give something of an upper bound.

> Anyway, IMHO boot time performance is not what we are targeting here, so
> I wouldn't be too worried about this particular point.

It may not be the most important thing but it is a factor worth
considering - as mentioned earlier there are applications where boot
time is critical such as automotive. It seems unfortunate that actual
performance may be left on the table due to (IMO anyway) a tenuous
concern over DT semantics. But it looks like that may just be my
position :/ .

thanks,
Steve
