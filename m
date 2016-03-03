From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 3 Mar 2016 12:07:32 +0900
Subject: [PATCH] ARM: dts: add "simple-bus" to "arm,
 amba-bus" compatible nodes
In-Reply-To: <20160301114610.GB30602@leverpostej>
References: <1456804620-8750-1-git-send-email-yamada.masahiro@socionext.com>
 <20160301114610.GB30602@leverpostej>
Message-ID: <CAK7LNAQzkg5F8wUeF+p30jf9CrpNxi7UTNfqXQgybP2XbEKJag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,


2016-03-01 20:46 GMT+09:00 Mark Rutland <mark.rutland@arm.com>:
> On Tue, Mar 01, 2016 at 12:57:00PM +0900, Masahiro Yamada wrote:
>> The "arm,amba-bus" string in the of_default_bus_match_table is
>> ambiguous.  This prepares for killing it off in a long run.
>
> I don't follow the purpose of this patch.
>
> There's no way we can remove kernel-side support for "arm,amba-bus", as
> there are DTBs that rely on it.
>
> If we're going to merge "arm,amba-bus" in the kernel with "simple-bus",
> such that there is no distinction between the two, then that doesn't
> require any DTBs to be updated.
>
> The only reason I would see for changing dts files would be a subsequent
> clean-up for consistency, but at that point "arm,amba-bus" could be
> dropped entirely.
>
> So this patch makes no sense to me.
>
> Thanks,
> Mark.
>

This patch is derived from Rob Herring' comment
"BTW, we should also kill off "amba-bus" which is an ambiguous term"
in the following thread:
http://lkml.iu.edu/hypermail/linux/kernel/1601.0/01822.html


So, the plan would be like this:

[1] Make device trees not depend on "arm,amba-bus"   (this commit)
[2] New device trees should no longer use "arm,amba-bus" alone.
[3] Go though some releases until we do not care about the backward
compatibility
[4] Drop "arm,amba-bus" from of_default_bus_match_table


No?


-- 
Best Regards
Masahiro Yamada
