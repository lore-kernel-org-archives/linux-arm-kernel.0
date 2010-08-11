From: janboe.ye@gmail.com (ye janboe)
Date: Thu, 12 Aug 2010 01:24:29 +0800
Subject: [PATCH] arm: remove backtrace.s when ARM_UNWIND enable
In-Reply-To: <1281547117.30665.39.camel@e102109-lin.cambridge.arm.com>
References: <20100811160810.GA6792@localhost.localdomain>
	<1281547117.30665.39.camel@e102109-lin.cambridge.arm.com>
Message-ID: <AANLkTi=6GGehTa93hvjpf=PD=YDjd_DpfUGEPWKG=qn_@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

backtrace.o also need to be linked when FRAME_POINTER is not set.

At this situation, __backtrace and c_backtrace are empty functions.

Janboe

2010/8/12 Catalin Marinas <catalin.marinas@arm.com>:
> On Wed, 2010-08-11 at 17:08 +0100, janboe wrote:
>> backtrace.s can only work with FRAME_POINTER, so disable when
>> ARM_UNWIND enabled
>>
>> Signed-off-by: janboe <janboe.ye@gmail.com>
> [...]
>> +ifneq ($(CONFIG_ARM_UNWIND),y)
>> + ?lib-y ? ? ? ?+= backtrace.o
>> +endif
>
> Could we use CONFIG_FRAME_POINTER (and negate the conditions in your
> patch)? The above would be:
>
> lib-$(CONFIG_FRAME_POINTER) += backtrace.o
>
> --
> Catalin
>
>
