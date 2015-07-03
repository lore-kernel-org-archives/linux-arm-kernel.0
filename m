From: pawelo@king.net.pl (Paul Osmialowski)
Date: Fri, 3 Jul 2015 19:40:59 +0200 (CEST)
Subject: [PATCH v2 3/9] arm: twr-k70f120m: clock driver for Kinetis SoC
In-Reply-To: <alpine.DEB.2.11.1507030006280.3916@nanos>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
 <alpine.LNX.2.00.1507011756140.14440@localhost.localdomain>
 <alpine.LNX.2.00.1507021206410.13210@localhost.localdomain>
 <1861313.aMcV1xHCIq@wuerfel>
 <alpine.LNX.2.00.1507022338070.28322@localhost.localdomain>
 <alpine.DEB.2.11.1507030006280.3916@nanos>
Message-ID: <alpine.LNX.2.00.1507031932220.15294@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Thomas,

Thanks for your valuable input and for your patience.

I'm attaching yet another proposal for this clock driver. I've 
flattened the .dts and ensured register access protection. I've also added 
one more clock source (osc0er) and clock gate to it.

Can you comment this one too?

On Fri, 3 Jul 2015, Thomas Gleixner wrote:

> On Thu, 2 Jul 2015, Paul Osmialowski wrote:
>> On Thu, 2 Jul 2015, Arnd Bergmann wrote:
>>
>>> I wonder if you could move out the fixed rate clocks into their own
>>> nodes. Are they actually controlled by the same block? If they are
>>> just fixed, you can use the normal binding for fixed rate clocks
>>> and only describe the clocks that are related to the driver.
>>
>> In my view having these clocks grouped together looks more convincing. After
>> all, they all share the same I/O regs in order to read configuration.
>
> The fact that they share a register is not making them a group. That's
> just a HW design decision and you need to deal with that by protecting
> the register access, but not by trying to group them artificially at
> the functional level.
>
> Thanks,
>
> 	tglx
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-arm-twr-k70f120m-clock-driver-for-Kinetis-SoC.patch
Type: text/x-diff
Size: 19961 bytes
Desc: 
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150703/1ae55ef7/attachment-0001.bin>
