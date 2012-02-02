From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 02 Feb 2012 09:47:23 +0100
Subject: cpu_relax in busy loops question
In-Reply-To: <CACRpkdZfdx9tDgp8HfVSdEFXdvpsPDiWdpg2iyFYesgpBjsqyw@mail.gmail.com>
References: <4F292345.8070800@linaro.org>
 <CACRpkdZfdx9tDgp8HfVSdEFXdvpsPDiWdpg2iyFYesgpBjsqyw@mail.gmail.com>
Message-ID: <4F2A4D9B.7070302@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/01/2012 09:17 PM, Linus Walleij wrote:
> On Wed, Feb 1, 2012 at 12:34 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org>  wrote:
>>
>> Hi Linus,
>>
>> While looking at the drivers/mfd/db8500-prcmu.c file I noticed:
>>
>>
>>   595         /* Grab the HW semaphore. */
>>   596         while ((readl(PRCM_SEM)&  PRCM_SEM_PRCM_SEM) != 0)
>>   597                 cpu_relax();
>>
>>
>> I was wondering why is cpu_relax needed here as readl does a memory barrier
>> ? I thought the cpu_relax function was related to the x86 to consume less
>> power with an optimization of the "rep nop" loops or/and do a memory
>> barrier.
>>
>> Should a busy-loop be always with cpu_relax ?
>
> Last time we discussed it ar LAKML I think we came to the conclusion
> that while cpu_relax() has very little semantic meaning on ARM, it
> is still nice to have from a readability and maintenance point of view,
> since it is pretty clear what we're trying to do.

Ok, thanks Linus.

   -- Daniel




-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
