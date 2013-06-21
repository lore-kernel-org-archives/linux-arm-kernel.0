From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 21 Jun 2013 18:40:30 +0200
Subject: [PATCH] at91: cpuidle: Fix target_residency
In-Reply-To: <201306211830.21175.arnd@arndb.de>
References: <1371818219-13060-1-git-send-email-daniel.lezcano@linaro.org>
 <51C474E9.40908@linaro.org> <51C47B3F.1090508@atmel.com>
 <201306211830.21175.arnd@arndb.de>
Message-ID: <51C481FE.4080607@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2013 06:30 PM, Arnd Bergmann wrote:
> On Friday 21 June 2013, Nicolas Ferre wrote:
>>>
>>> Yes, I think it should go for 3.10 as it is fix and also for 3.9.8
>>> (stable). May be I should have Cc stable@ ...
>>
>> Well, so it doesn't sound like a regression if it was already present in 
>> 3.9...
>>
>> Moreover, it does not seem to be taken into account for all 
>> configuration (seems not triggered for !tickless kernels).
>>
>> So I suspect Arnd and Olof would not take it for 3.10-fixes...
>>
>> Guys, you thoughts?
>>
> 
> Ah, I just sent out a pull request for fixes a minute before I saw
> your mail. I can't tell how serious this bug is. We can certainly
> mark it for stable, but unless this is a significant regression,
> I'd apply it for 3.11 instead and wait for the backports to happen.

Ok, this is not a critical bug. The regression makes the idle state1 to
enter less often, thus consuming a bit more power with a tickless
system, but nothing leading to a crash or an unstable system.


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
