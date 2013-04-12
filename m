From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 12 Apr 2013 09:11:33 +0200
Subject: [V2 patch 01/19] ARM: shmobile: cpuidle: remove shmobile_enter_wfi
 function
In-Reply-To: <20130412070619.GA21350@verge.net.au>
References: <1365712969-7541-1-git-send-email-daniel.lezcano@linaro.org>
 <1365712969-7541-2-git-send-email-daniel.lezcano@linaro.org>
 <20130412004425.GD24461@verge.net.au> <5167ADF1.50401@linaro.org>
 <20130412070619.GA21350@verge.net.au>
Message-ID: <5167B3A5.60408@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/2013 09:06 AM, Simon Horman wrote:
> On ?,  4? 12, 2013 at 08:47:13?? +0200, Daniel Lezcano wrote:
>> On 04/12/2013 02:44 AM, Simon Horman wrote:
>>> On Thu, Apr 11, 2013 at 10:42:31PM +0200, Daniel Lezcano wrote:
>>>> Remove the shmobile_enter_wfi function which is the same as the
>>>> common WFI enter function from the arm cpuidle driver defined
>>>> with the ARM_CPUIDLE_WFI_STATE macro.
>>> Should this patch also make shmobile_enter_wfi static in
>>> arch/arm/mach-shmobile/cpuidle.c ?
>>
>> Hum, no :)
> 
> Ok, that was my other idea :^)
> 
>> Actually, the function was removed because it was expected to be not
>> longer used. I missed the cpuidle driver in the pm-sh7372.c file and the
>> function declaration in the header file.
>>> Also, I have a slight preference for the patch to be split into two.
>>> 1. A patch to remove usage of shmobile_enter_wfi from the sh7372 SoC.
>>> 2. A patch to remove shmobile_enter_wfi. from common.h
>>>    (and make it static?).
>>
>> Ok, regarding my answer above, do you still want two patches for this ?
> 
> Yes please.

Ok, thanks for the review.

  -- Daniel

> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
