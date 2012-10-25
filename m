From: robherring2@gmail.com (Rob Herring)
Date: Thu, 25 Oct 2012 09:25:06 -0500
Subject: [PATCH] ARM: decompressor: clear SCTLR.A bit for v7 cores
In-Reply-To: <20121025141645.GA16962@sig21.net>
References: <alpine.LFD.2.02.1210100939160.16518@xanadu.home>
 <1349959402-24164-1-git-send-email-robherring2@gmail.com>
 <20121025093411.GA32662@sig21.net> <50893389.2090002@gmail.com>
 <20121025141645.GA16962@sig21.net>
Message-ID: <50894BC2.5050706@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2012 09:16 AM, Johannes Stezenbach wrote:
> On Thu, Oct 25, 2012 at 07:41:45AM -0500, Rob Herring wrote:
>> On 10/25/2012 04:34 AM, Johannes Stezenbach wrote:
>>> On Thu, Oct 11, 2012 at 07:43:22AM -0500, Rob Herring wrote:
>>>
>>>> While v6 can support unaligned accesses, it is optional and current
>>>> compilers won't emit unaligned accesses. So we don't clear the A bit for
>>>> v6.
>>>
>>> not true according to the gcc changes page
>>
>> What are you going to believe: documentation or what the compiler
>> emitted? At least for ubuntu/linaro 4.6.3 which has the unaligned access
>> support backported and 4.7.2, unaligned accesses are emitted for v7
>> only. I guess default here means it is the default unless you change the
>> default in your build of gcc.
> 
> Since ARMv6 can handle unaligned access in the same way as ARMv7
> it seems a clear bug in gcc which might hopefully get fixed.
> Thus in this case I think it is reasonable to follow the
> gcc documentation, otherwise the code would break for ARMv6
> when gcc gets fixed.

But the compiler can't assume the state of the U bit. I think it is
still legal on v6 to not support unaligned accesses, but on v7 it is
required. All the standard v6 ARM cores support it, but I'm not sure
about custom cores or if there are SOCs with buses that don't support
unaligned accesses properly.

Rob
