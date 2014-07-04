From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 04 Jul 2014 10:07:59 +0200
Subject: [PATCH 11/17] pwm: samsung: remove s5pc100 related pwm codes
In-Reply-To: <02ca01cf975a$1848aaa0$48d9ffe0$@samsung.com>
References: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
 <1404163947-3105-12-git-send-email-kgene.kim@samsung.com>
 <53B55021.9020307@samsung.com> <02ca01cf975a$1848aaa0$48d9ffe0$@samsung.com>
Message-ID: <53B660DF.8060100@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.07.2014 09:32, Kukjin Kim wrote:
> Tomasz Figa wrote:
>>
>> Hi Kukjin,
>>
> Hi,
> 
>> On 30.06.2014 23:32, Kukjin Kim wrote:
>>> This patch removes supporting s5pc100 related pwm codes.
>>>
>>> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
>>> Cc: Thierry Reding <thierry.reding@gmail.com>
>>> ---
>>>  Documentation/devicetree/bindings/pwm/pwm-samsung.txt |    2 --
>>>  drivers/clocksource/samsung_pwm_timer.c               |   12 ------------
>>>  drivers/pwm/pwm-samsung.c                             |    8 --------
>>>  3 files changed, 22 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
>> b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
>>> index 43925d3..82c7f6b 100644
>>> --- a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
>>> +++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
>>> @@ -11,8 +11,6 @@ Required properties:
>>>  - compatible : should be one of following:
>>>      samsung,s3c2410-pwm - for 16-bit timers present on S3C24xx SoCs
>>>      samsung,s3c6400-pwm - for 32-bit timers present on S3C64xx SoCs
>>> -    samsung,s5pc100-pwm - for 32-bit timers present on S5PC100, S5PV210,
>>> -			  Exynos4210 rev0 SoCs
>>
>> As you can see here, this variant is used for more than S5PC100. It is
>> needed for S5PV210 and Exynos4210 rev0 SoCs as well. So this patch
>> should be dropped.
> 
> Oh, I just now checked its datasheets and s5pv210 and early exynos4210 are
> using BIT(5) for tclk_mask. You're right. But I couldn't its usage in mainline
> when I created the patch. Anyway it can be used for s5pv210 so how about
> following?

Hmm, sorry for the confusion, but actually this seems to be a mistake in
the binding documentation. On Exynos4210 rev0, "samsung,s5p6440-pwm" is
supposed to be used and "samsung,s5pc100" supports both S5PC100 and S5PV210.

However I'm not sure why you want to change existing DT bindings. The
rule is to name the compatible string after first existing SoC for which
it can be used, so removing support for this SoC doesn't imply removing
this compatible string because it can be used for future SoCs as well,
if they turn out to be compatible.

My suggestion is to keep this as it was.

Best regards,
Tomasz
