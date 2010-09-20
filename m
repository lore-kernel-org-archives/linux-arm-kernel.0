From: gerg@snapgear.com (Greg Ungerer)
Date: Mon, 20 Sep 2010 16:44:57 +1000
Subject: [PATCH] at91: drop at91x40 support
In-Reply-To: <20100920063243.GA32018@game.jcrosoft.org>
References: <1284790974-11143-1-git-send-email-plagnioj@jcrosoft.com>
	<4C94875B.3060200@snapgear.com>
	<20100918142857.GA12003@game.jcrosoft.org>
	<4C96F63A.2090704@snapgear.com>
	<20100920063243.GA32018@game.jcrosoft.org>
Message-ID: <4C9702E9.8020500@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/09/10 16:32, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 15:50 Mon 20 Sep     , Greg Ungerer wrote:
>> On 19/09/10 00:28, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>> On 19:33 Sat 18 Sep     , Greg Ungerer wrote:
>>>> On 18/09/10 16:22, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>>>> as it's broken for releases and no one care about it
>>>>>
>>>>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD<plagnioj@jcrosoft.com>
>>>>> Cc: Andrew Victor<linux@maxim.org.za>
>>>>> Cc: Nicolas Ferre<nicolas.ferre@atmel.com>
>>>>> Cc: Greg Ungerer<gerg@snapgear.com>
>>>>
>>>> NAK, I care. I sent a fix to this very list about a week ago
>>>> to fix the current compile problem.
>>> sorry but not see it
>>
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-September/025404.html
>>
>>
>>> and I see it failled to build for at least 4 releases and
>>
>> And this is not really due to the board support code (which
>> you propose to remove) at all. It is almost always due to
>> breakage of something else. The patch I reference above is
>> a good example. Breakage in the non-MMU support code is
>> another example (and I have another patch I need to send to
>> fix a problem there too).
> which means no one test it or used it

I have a patch for it. I tested it. I just didn't get
around to sending the patch. My bad. I have had it sitting
around for a while. It happens.


>>> no debug-macro.S for years
>>> since what 4 or 5 years we just have the timer and irq
>>
>> I don't follow. What is wrong with
>> arch/arm/mach-at91/include/mach/debug-macro.S?
> the at91x40 can not use it as it's not have DBGU support

Yes, thats right. But it causes no problems.


>> The AT91x40 parts are pretty simple, what else do you expect?
>>
>>> do you have plan to update it?
>>
>> I don't see anything to update. It does exactly what I want it to do.
>> The board support code you point at causes me no troubles, and not
>> very often do I need to fix/change/update it.
> you have no flash,

Uh?  That doesn't need to go into the board support file.
(And my use case doesn't use flash anyway).


> no uart, no pio support, no watchdog supportm so tc support,

I don't need or want most of those. If someone else needs them
they can add them.


> the CPU type is no even selected in the Kconfig

What, you can't select "AT91x40" in menuconfig?


> so yes the current implementation is not really usefull for anything

I use it. I do my main work on non-MMU code on ARM using this base.
It is very useful to me.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
