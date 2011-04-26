From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue, 26 Apr 2011 16:32:13 +1200
Subject: [PATCH 14/14] at91: move clock subsystem init to soc generic init
In-Reply-To: <20110426041336.GC12904@game.jcrosoft.org>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303780300-2205-2-git-send-email-plagnioj@jcrosoft.com>
	<4DB63841.1060903@bluewatersys.com>
	<20110426041336.GC12904@game.jcrosoft.org>
Message-ID: <4DB64ACD.7000507@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/26/2011 04:13 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 15:13 Tue 26 Apr     , Ryan Mallon wrote:
>> On 04/26/2011 01:11 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>>> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
>>
>> <snip>
>>
>>>  /* --------------------------------------------------------------------
>>> diff --git a/arch/arm/mach-at91/soc.c b/arch/arm/mach-at91/soc.c
>>> index c82d219..2d4e415 100644
>>> --- a/arch/arm/mach-at91/soc.c
>>> +++ b/arch/arm/mach-at91/soc.c
>>> @@ -115,7 +115,10 @@ void __init at91_initialize(unsigned long main_clock)
>>>  
>>>  	pr_info("AT91: detected soc: %s\n", current_soc.name);
>>>  
>>> -	current_soc.init(main_clock);
>>> +	current_soc.init();
>>
>> I think this patch should go near the beginning of the series so that
>> current_soc.init never needs to take an argument.
> no until you factorize the at91_init_clock you do need it

That's my point. If you move this patch earlier so that at91_init_clock
is factorised early then current_soc.init won't ever need the argument.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
