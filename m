From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 02 Sep 2011 13:56:03 +0100
Subject: [PATCH v3] ARM: sched_clock: allow sched_clock to be selected
	at runtime
In-Reply-To: <20110902124945.GX3548@atomide.com>
References: <1314712599-12234-1-git-send-email-marc.zyngier@arm.com>
	<20110902124945.GX3548@atomide.com>
Message-ID: <4E60D263.60702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 02/09/11 13:49, Tony Lindgren wrote:
> * Marc Zyngier <marc.zyngier@arm.com> [110830 16:29]:
>> sched_clock() is yet another blocker on the road to the single
>> image. This patch implements an idea by Russell King:
>>
>> http://www.spinics.net/lists/linux-omap/msg49561.html
>>
>> Instead of asking the platform to implement both sched_clock()
>> itself and the rollover callback, simply register a read()
>> function, and let the ARM code care about sched_clock() itself,
>> the conversion to ns and the rollover. sched_clock() uses
>> this read() function as an indirection to the platform code.
>>
>> This allow some simplifications and possibly some footprint gain
>> when multiple platforms are compiled in. Among the drawbacks,
>> the removal of the *_fixed_sched_clock optimization which could
>> negatively impact some platforms (sa1100, tegra, versatile
>> and omap).
>>
>> Tested on 11MPCore, OMAP4 and Tegra.
> 
> Great, seems to boot just fine with printk_time :)
> 
> I gave it a quick boot test on omap16xx, 2420, 3430,
> 3630 and 4430:
> 
> Tested-by: Tony Lindgren <tony@atomide.com>

Thanks for testing!.

	M.
-- 
Jazz is not dead. It just smells funny...
