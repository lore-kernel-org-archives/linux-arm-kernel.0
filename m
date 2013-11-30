From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 30 Nov 2013 14:41:31 +0000
Subject: [PATCH] ARM: sunxi: stop timer from ticking before enabling
 interrupts
In-Reply-To: <20131130141558.GD3002@lukather>
References: <1385815995-15145-1-git-send-email-marc.zyngier@arm.com>
 <20131130141558.GD3002@lukather>
Message-ID: <5c486d6c2b5b3515db44200d36fd1078@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-11-30 14:15, Maxime Ripard wrote:

Hi Maxime,

> On Sat, Nov 30, 2013 at 12:53:15PM +0000, Marc Zyngier wrote:
>> The sun4i timer can still be ticking when we enable the interrupt.
>> If another timer is actually used (A7 architected timer, for 
>> example),
>> odds are that the interrupt will eventually fire with the 
>> event_handler
>> pointer being NULL.
>>
>> The obvious fix it to stop the timer before registering the 
>> interrupt.
>>
>> Observed and tested on sun7i (cubietruck).
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>
> You can add my Acked-by, but you should rather send this to Daniel
> Lezcano, which is the clocksource/clockevent maintainer.

Thanks. I'll push that to Daniel directly.

Cheers,

         M.
-- 
Fast, cheap, reliable. Pick two.
