From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 17 Nov 2015 14:11:35 +0100
Subject: [PATCH] clocksource/drivers/tango-xtal: Replace code by
 clocksource_mmio_init
In-Reply-To: <564B222E.5080209@sigmadesigns.com>
References: <1447412292-841-1-git-send-email-daniel.lezcano@linaro.org>
 <5645D5A0.1000502@sigmadesigns.com> <564B1C1C.7070801@linaro.org>
 <564B222E.5080209@sigmadesigns.com>
Message-ID: <564B2787.8020202@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2015 01:48 PM, Marc Gonzalez wrote:
> On 17/11/2015 13:22, Daniel Lezcano wrote:
>> On 11/13/2015 01:20 PM, Marc Gonzalez wrote:
>>> On 13/11/2015 11:58, Daniel Lezcano wrote:
>>>
>>>> The current code to initialize, register and read the clocksource is
>>>> already factored out in mmio.c via the clocksource_mmio_init function.
>>>>
>>>> Factor out the code with the clocksource_mmio_init function.
>>>
>>> The reason I didn't like clocksource_mmio_init() is because it exports
>>> 4 generic accessors.
>>>
>>> I guess this function makes more sense when all platforms are using it,
>>> in an ARCH_MULTIPLATFORM kernel. (Also the accessors are probably quite
>>> small, so the waste is probably minimal.)
>>
>> Hi Marc,
>>
>> it is not clear for me if you agree with this patch or not. Can you
>> clarify ?
>
> [ Adding rmk as the original mmio.c author ]

Good idea. Russell, the patch is https://lkml.org/lkml/2015/11/13/261

> Hello Daniel,
>
> It's hard to give a straight answer. From my limited perspective (building
> a kernel for Sigma boards only) I feel that mmio.c brings nothing. (As you
> mentioned, it would be interesting to measure whether having reg_base in
> the ctx, rather than as a global is better or worse for perf, though the
> actual difference may be lost in the noise.)
>
> On the other hand, I can see how a different perspective, such as yours,
> may see benefits in having all drivers use the same APIs; and there may
> be other savings for ARCH_MULTIPLATFORM builds with lots of platforms.

IMO, if all the drivers are using the same code, then optimizing it will 
benefit to all drivers at the same time.

> I guess if you think it is a good patch, I will defer to your experience.

Ok, I will wait for Russell comments then.

Thanks!

   -- Daniel

> I just wish Thomas would take a look at my mmio patch. I will make an
> official submission, so that it can be properly shot down :-)



-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
