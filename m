From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 8 Sep 2017 11:28:06 +0100
Subject: Conflict when accessing PMU counters from userspace
In-Reply-To: <CALk3wS0P-R9=HU1wYCWWYZ2w=7RjFoD4M=Vwzg-1ALRuRNMHUA@mail.gmail.com>
References: <CALk3wS0P-R9=HU1wYCWWYZ2w=7RjFoD4M=Vwzg-1ALRuRNMHUA@mail.gmail.com>
Message-ID: <20170908102806.GD13657@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 07, 2017 at 12:36:48PM -0700, Jason Teplitz wrote:
> Hello,

Hi,

> I'm reading the PMU counters from a userspace process, but the cycle
> counter keeps getting reset. I don't believe any other running
> processes are doing this. Is there something in the kernel that resets
> the cycle counter periodically and if so is there an easy way to
> disable it?

Reading the PMU counters directly from userspace is not supported, and
we configure the CPU to trap such accesses.

Ignoring explicit reset of the counters, there are a number of reasons
why you will not see consistent values from userspace.

Which kernel are you using (e.g. version? arm/arm64?), and how have you
enabled userspace access?

Thanks,
Mark.
