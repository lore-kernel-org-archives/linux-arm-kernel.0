From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 17 Nov 2015 13:22:52 +0100
Subject: [PATCH] clocksource/drivers/tango-xtal: Replace code by
 clocksource_mmio_init
In-Reply-To: <5645D5A0.1000502@sigmadesigns.com>
References: <1447412292-841-1-git-send-email-daniel.lezcano@linaro.org>
 <5645D5A0.1000502@sigmadesigns.com>
Message-ID: <564B1C1C.7070801@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/13/2015 01:20 PM, Marc Gonzalez wrote:
> On 13/11/2015 11:58, Daniel Lezcano wrote:
>
>> The current code to initialize, register and read the clocksource is
>> already factored out in mmio.c via the clocksource_mmio_init function.
>>
>> Factor out the code with the clocksource_mmio_init function.
>
> The reason I didn't like clocksource_mmio_init() is because it exports
> 4 generic accessors.
>
> I guess this function makes more sense when all platforms are using it,
> in an ARCH_MULTIPLATFORM kernel. (Also the accessors are probably quite
> small, so the waste is probably minimal.)

Hi Marc,

it is not clear for me if you agree with this patch or not. Can you 
clarify ?

Thanks

   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
