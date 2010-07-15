From: david.yangshuai@gmail.com (David Yang)
Date: Thu, 15 Jul 2010 20:52:05 +0800
Subject: Problem with dma_alloc_coherent at linux-2.6.33-arm1 ,
	withRealView platform,board PBX-A9 and armv7 instructions.
In-Reply-To: <1279196495.6664.14.camel@e102109-lin.cambridge.arm.com>
References: <20100715093521.GD26212@n2100.arm.linux.org.uk>
	<1279196495.6664.14.camel@e102109-lin.cambridge.arm.com>
Message-ID: <AANLkTimq3E7uF4poJkqcDIomEHoS4y24D7sJWt0U44Hd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,Catalin

the patch v3 2/3 can not be patched to my  arch/arm/mm/cache-l2x0.c
from linux-2.6.33-arm1

should I modify it manually?


On Thu, Jul 15, 2010 at 8:21 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Thu, 2010-07-15 at 10:35 +0100, Russell King - ARM Linux wrote:
>> On Thu, Jul 15, 2010 at 05:13:57PM +0800, David Yang wrote:
>> > ? ? ? ?But when the driver was ported to the linux-2.6.33-arm1,the problem
>> > came:
>> > ? ? ? ? ? ? ? ? I found when the cpu executed from step 1-3, the
>> > device DMA alarm the
>> > step 2 was not completed.As a result,the step 4 was not triggered.This
>> > is different form linux-2.6.28.
>>
>> Can you try patches 6219/1 6220/1 and 6221/1 from the patch system?
>> They can be viewed/downloaded via:
>>
>> http://www.arm.linux.org.uk/developer/patches/view.php?id=6219/1
>> http://www.arm.linux.org.uk/developer/patches/view.php?id=6220/1
>> http://www.arm.linux.org.uk/developer/patches/view.php?id=6221/1
>
> I posted an updated set of patches here to avoid the do...while()
> construct causing compilation errors in some drivers:
>
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/84948
>
> If you are ok with them, I'll push them to the patch system (and discard
> the previous ones).
>
> Thanks.
>
> --
> Catalin
>
>
