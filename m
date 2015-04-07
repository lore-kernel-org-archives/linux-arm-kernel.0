From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 07 Apr 2015 12:05:19 +0200
Subject: [PATCH 03/14] clkdev: get rid of redundant clk_add_alias()
 prototype in linux/clk.h
References: <20150403171149.GC13898@n2100.arm.linux.org.uk>
 <E1Ye593-0001B1-W4@rmk-PC.arm.linux.org.uk> <87lhi8rrmd.fsf@free.fr>
 <5522D8B5.7050205@codeaurora.org>
Message-ID: <871tjws17k.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd <sboyd@codeaurora.org> writes:

> On 04/04/15 05:43, Robert Jarzmik wrote:
>> Russell King <rmk+kernel@arm.linux.org.uk> writes:
>>
>>> clk_add_alias() is provided by clkdev, and is not part of the clk API.
>>> Howver, it is prototyped in two locations: linux/clkdev.h and
>>> linux/clk.h.  This is a mess.  Get rid of the redundant and unnecessary
>>> version in linux/clk.h.
>>>
>>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
>>
>> Actually, this serie fixes a regression I've seen in linux-next, and which was
>> triggering the Oops in [1] on lubbock. With your serie, the kernel boots fine.
>>
>>
>
> Is this with the lubbock_defconfig? Is it a regression in 4.0-rc series
> or is it due to some pending -next patches interacting with the per-user
> clock patches? It looks like the latter because __clk_get_hw() should be
> inlined on lubbock_defconfig where CONFIG_COMMON_CLK=n.

It's upon linux-next and the "not yet pulled" pxa tree merged :
 - http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/331119.html
I think it will appear once arm-soc has been prepared for linux-next and pulled.

This specific merge window will shift pxa architecture to common clock
framework, that's why I saw the regression.

Cheers.

-- 
Robert
