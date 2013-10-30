From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 30 Oct 2013 14:43:51 -0700
Subject: [PATCH 1/2] ARM: s3c64xx: cpuidle: convert to platform driver
In-Reply-To: <526AEF6B.2000404@linaro.org>
References: <1382685074-16502-1-git-send-email-daniel.lezcano@linaro.org>
 <6431720.IUjkN7MGOG@thinkpad> <526AC2DF.2020904@linaro.org>
 <1953577.TBW5ixuUM5@thinkpad> <526AEF6B.2000404@linaro.org>
Message-ID: <52717D97.8090905@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2013 03:23 PM, Daniel Lezcano wrote:

[ ... ]

>>> Won't it be worth to add a new WFI_SLEEP state to the cpuidle driver ?
>>
>> I don't think so. How a suspend-to-RAM specific thing like WFI_SLEEP
>> could
>> be relevant to a cpuidle driver? (Unless there are some plans to
>> consolidate STR with cpuidle that I haven't heard about...)
>
> I finally found a documentation for the s3c6410x and the description of
> the different modes. Indeed, the sleep mode is not adequate for a
> cpuidle state. What about the 'stop' and 'deep stop' state ?

Hi Thomas,

just a reminder about the question above, so I can go ahead: fix what 
you pointed out or remove the driver directly.

You mentionned in the previous email the STOP is not usful because it 
can be controlled by manually outside of the cpuidle driver. But I see 
in the documentation, the stop states power gates the cpu and deep-stop 
stops the regulator.

If these states have to been added later, still it worth to remove the 
driver ?

Thanks!
   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
