From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 24 Apr 2014 11:55:56 +0100
Subject: [PATCH V2 0/5] Huge pages for short descriptors on ARM
In-Reply-To: <20140424104232.GK26756@n2100.arm.linux.org.uk>
References: <1397648803-15961-1-git-send-email-steve.capper@linaro.org>
 <20140424102229.GA28014@linaro.org>
 <20140424103639.GC19564@arm.com>
 <20140424104232.GK26756@n2100.arm.linux.org.uk>
Message-ID: <CAPvkgC3P8iZp5nECiGHdeGzRwmdh=ouiAREqKwk1tYzZxHTWvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 April 2014 11:42, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Thu, Apr 24, 2014 at 11:36:39AM +0100, Will Deacon wrote:
>> I guess I'm after some commitment that this is (a) useful to somebody and
>> (b) going to be tested regularly, otherwise it will go the way of things
>> like big-endian, where we end up carrying around code which is broken more
>> often than not (although big-endian is more self-contained).
>
> It may be something worth considering adding to my nightly builder/boot
> testing, but I suspect that's impractical as it probably requires a BE
> userspace, which would then mean that the platform can't boot LE.
>
> I suspect that we will just have to rely on BE users staying around and
> reporting problems when they occur.

The huge page support is for standard LE, I think Will was saying that
this will be like BE if no-one uses it.
I would appreciate any extra testing a *lot*. :-).

It's somewhat unfair to compare huge pages on short descriptors with
BE. For a start, the userspace that works with LPAE will work on the
short-descriptor kernel too. Great care has been taken to ensure that
programmers can just port their huge page code over to ARM from other
architectures without any issues. As things like libhugetlbfs (which
fully supports ARM) get incorporated into distros on ARM, huge pages
become the norm as opposed to the exception.

Some devices have very few TLBs and I believe this series will be very
beneficial for people using those devices.

Cheers,
-- 
Steve
