From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 05 Oct 2011 11:46:24 +0530
Subject: Please help with the OMAP static mapping mess
In-Reply-To: <alpine.LFD.2.02.1110042232380.9106@xanadu.home>
References: <alpine.LFD.2.02.1110031312480.9106@xanadu.home>
	<20111003205658.GJ6324@atomide.com>
	<alpine.LFD.2.02.1110031744100.9106@xanadu.home>
	<20111003223824.GK6324@atomide.com> <4E8AAFF9.3090600@ti.com>
	<alpine.LFD.2.02.1110041458500.9106@xanadu.home>
	<4E8BBC6B.7000500@gmail.com>
	<alpine.LFD.2.02.1110042232380.9106@xanadu.home>
Message-ID: <4E8BF638.1000507@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 05 October 2011 08:09 AM, Nicolas Pitre wrote:
> On Tue, 4 Oct 2011, Rob Herring wrote:
> 
>> On 10/04/2011 04:21 PM, Nicolas Pitre wrote:
>>> On Tue, 4 Oct 2011, Santosh Shilimkar wrote:
>>>
>>>> On Tuesday 04 October 2011 04:08 AM, Tony Lindgren wrote:
>>>>> * Nicolas Pitre <nico@fluxnic.net> [111003 14:36]:
>>>>>> On Mon, 3 Oct 2011, Tony Lindgren wrote:
>>>>>>
>>>>>>> Having the SRAM base address move around with different sizes also
>>>>>>> requires the SoC detection.. Otherwise we can end up mapping wrong
>>>>>>> size and end up trying to access secure SRAM that will hang the system.
>>>>>>>
>>>>>>> The way to fix it is to move SRAM init happen much later so we don't
>>>>>>> have to map it early. I guess now we could use ioremap for SRAM,
>>>>>>> although we may not want device attributes for the executable code?
>>>>>>> Got any suggestions here on how we should map SRAM later on?
>>>>>>
>>>>>> You can use a variant of ioremap() such as __arm_ioremap() which let you 
>>>>>> specify the memory attribute.
>>>>>
>>>>> OK, I'll take a look at that.
>>>>>
>>>> I have tried __arm_ioremap_pfn() for some DDR mapping and it didn't
>>>> work as expected. The mapping was not getting created.
>>>
>>> Did you investigate why it wasn't created?  Must have been a trivial 
>>> issue surely?  But you have to wait until memory management is fully 
>>> initialized to call the real ioremap() though, which happens later 
>>> during the boot.
>>>
I didn't investigate further on it but may be it was because of the
ordering as you pointed out. The new __arm_ioremap_exe() seems to me
a good idea and should solve the problem.

Regards
Santosh
