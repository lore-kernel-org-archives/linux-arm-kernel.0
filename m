From: vwadekar@nvidia.com (Varun Wadekar)
Date: Tue, 27 Dec 2011 10:19:32 +0530
Subject: Is Pandaboard cpuhotplug working stably?
In-Reply-To: <20111222102454.GD3354@n2100.arm.linux.org.uk>
References: <CAGsJ_4ydbMaS0DD6+j1m9tdCTCzw3TGELcY=KotupvvMMK1YOA@mail.gmail.com>
 <20111221094624.GB3354@n2100.arm.linux.org.uk>
 <CAGsJ_4w0iVXC6qmDzmkuOb=ZN=Q0bF7EAFkxeYR_d7-vo+8bqQ@mail.gmail.com>
 <20111221100706.GC3354@n2100.arm.linux.org.uk>
 <CAMQu2gy8mwJ-aKit0b4d7=4FkxeFakfnL-phy0eMOK81Oe=PCw@mail.gmail.com>
 <20111222102454.GD3354@n2100.arm.linux.org.uk>
Message-ID: <4EF94E5C.5040608@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>> There are few patches floating around for this issue. I posted one version
>> long back [1] and then there was one more form Thomas G.
>> The most recent is from one is from Peter Z [2] which is moving the
>> fix for the cup online race to core code.
>>
>> Can you try Peter's patch with your test-case ?
>>
>> Regards,
>> Santosh
>>
>> [1] https://lkml.org/lkml/2011/6/20/79
>> [2] https://lkml.org/lkml/2011/12/15/255
> [1] is already fixed - and is not the latest "problem" with this code.
> Fixing the problem in [1] actually itself created the latest problem
> with smp_call_function() which wasn't there before this change.  Patch
> [2] refers to this problem and proposes a fix for it.
>
>

Any idea if this patch if good to go in mainline? I am facing the same
issue on Tegra with 3.1.5 and this patch fixes the issue caused by [1].
Ideally if this change is ok, then it should be merged into 3.1.6 too.
Since this change seems to fix the issue at hand, I intend to merge the
change directly in our internal repo and wait for it to be a part of 3.1.6.

Thanks.
