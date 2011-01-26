From: matejken@gmail.com (Matej Kenda)
Date: Wed, 26 Jan 2011 22:59:38 +0100
Subject: [PATCH 1/2] Updated XCEP partition sizes
In-Reply-To: <AANLkTinLTuJY9vDH_oHeKk7j6oo4369cF35PG+fVc5A_@mail.gmail.com>
References: <AANLkTi=42n+h+0buU_83R-y4XkXqy8bkWSquwuLAY56m@mail.gmail.com>
	<AANLkTimMniHC==y6majqBGKNBa91J1DpVK8zbnDxEWvy@mail.gmail.com>
	<AANLkTinLTuJY9vDH_oHeKk7j6oo4369cF35PG+fVc5A_@mail.gmail.com>
Message-ID: <AANLkTimVuHx4_Z=89Fj_yh-Pos8-gT3mD-yr_9+OJ07u@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/25 Eric Miao <eric.y.miao@gmail.com>:
> On Tue, Jan 25, 2011 at 2:54 AM, Matej Kenda <matejken@gmail.com> wrote:
>> I've sent two simple patches for Iskratel XCEP last week.
>>
>> Can they be included in the kernel?
>
> I'm a bit tentative on this. Patch 1 is basically OK, but what if
> someone needs a even larger partition in the future?

This small embedded computer has relatively small Flash (32 MB).

1MB partition for the kernel was created initially for kernel 2.4 a
few years ago. The size of that kernel was around 800 kB.

Later on, the size increased to 900 kB with kernel 2.6.20 (still
monolithic kernel). 2.6.32 was still small enough to be squeezed in by
moving some driver out to modules.

However, with 2.6.36 this was not possible any more: I was unable to
make the kernel smaller that 1.1 MB and therefore the partition needed
to be increased.

Assuming the growth rate of the kernel from 800 kB to 1.1 in four
years, 2 MB should be enough for next 8 years or so.

> And some work
> is on-going with cleanup of those defconfigs, guess I'll hold a
> while those changes to the defconfig until that's clear enough.
>
> BTW - did you run Uwe's script to make sure the changes to defconfig
> is the smallest one?

defconfig file was created with "make ARCH=arm savedefconfig"

Regards,

Matej
