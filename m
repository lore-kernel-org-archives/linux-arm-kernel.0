From: leoy@marvell.com (Leo Yan)
Date: Mon, 15 Aug 2011 18:25:36 +0800
Subject: [PATCH V4 0/3] ARM: mmp: add audio sram support
In-Reply-To: <CAMPhdO_StSa9fsYLNjJDd0KDkUyg6ep3gN2n5Gx-WmZ8t=bTFw@mail.gmail.com>
References: <1313377794-26721-1-git-send-email-leoy@marvell.com>
	<1313377893.14434.5.camel@Lily>
	<CAMPhdO8rkct4H74zXBzaDa183u5vrPArerXgiNXwvQWzZT67Ng@mail.gmail.com>
	<20110815091245.GC32705@game.jcrosoft.org>
	<CAMPhdO_StSa9fsYLNjJDd0KDkUyg6ep3gN2n5Gx-WmZ8t=bTFw@mail.gmail.com>
Message-ID: <4E48F420.3030101@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/15/2011 05:35 PM, Eric Miao wrote:
> On Mon, Aug 15, 2011 at 5:12 PM, Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com>  wrote:
>> On 16:43 Mon 15 Aug     , Eric Miao wrote:
>>> On Mon, Aug 15, 2011 at 11:11 AM, Haojian Zhuang
>>> <haojian.zhuang@marvell.com>  wrote:
>>>> On Sun, 2011-08-14 at 20:09 -0700, Leo Yan wrote:
>>>>> On mmp platform, there have two sram banks:
>>>>> audio sram bank, and internal sram bank for video and PM.
>>>>> So add the sram module to manage these sram banks.
>>>>>
>>>>> And register the sram banks so can dynamically alloc/free
>>>>> the buffer.
>>>>>
>>>>> Leo Yan (3):
>>>>>    ARM: mmp: add sram allocator
>>>>>    ARM: mmp: register audio sram bank
>>>>>    ARM: mmp: register internal sram bank
>>>>>
>>>>>   arch/arm/Kconfig                      |    1 +
>>>>>   arch/arm/mach-mmp/Makefile            |    2 +-
>>>>>   arch/arm/mach-mmp/brownstone.c        |   11 ++
>>>>>   arch/arm/mach-mmp/include/mach/mmp2.h |   13 +++
>>>>>   arch/arm/mach-mmp/include/mach/sram.h |   35 +++++++
>>>>>   arch/arm/mach-mmp/mmp2.c              |    3 +
>>>>>   arch/arm/mach-mmp/sram.c              |  168 +++++++++++++++++++++++++++++++++
>>>>>   7 files changed, 232 insertions(+), 1 deletions(-)
>>>>>   create mode 100644 arch/arm/mach-mmp/include/mach/sram.h
>>>>>   create mode 100644 arch/arm/mach-mmp/sram.c
>>>>>
>>>> Acked-by: Haojian Zhuang<haojian.zhuang@gmail.com>
>>>
>>> Looks good to me. Thanks Haojian. Applied to -devel.
>> I've some reserve on the named pool they need to be managed at generic level
>> not here
>
> What are their names? And your suggestions to fix this?
>

For MMP platform have not only one bank, so now named the audio sram 
bank as "asram", and another sram bank as "isram" which is used by 
video/secure processor/pm.
If other modules want to use the sram, just use the name string to
get the gen pool handler, and then just call genalloc APIs.

I just wander if maintain the name in genalloc, then the name string
we should maintain in the pool's structure or chunk's structure?

>>
>> Best Regards,
>> J.
>>
