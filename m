From: dv@vollmann.ch (Detlef Vollmann)
Date: Fri, 14 Aug 2015 17:43:28 +0200
Subject: commit a71b092 "ARM: Convert handle_IRQ to use
 __handle_domain_irq" breaks DNS-323
In-Reply-To: <55CE0636.3050205@arm.com>
References: <55CDF5C3.7080204@vollmann.ch>
 <55CDF78F.6070001@free-electrons.com> <55CE0636.3050205@arm.com>
Message-ID: <55CE0CA0.5010806@vollmann.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14/15 17:16, Marc Zyngier wrote:
> On 14/08/15 15:13, Gregory CLEMENT wrote:
>> Hi Detlef,
>>
>> On 14/08/2015 16:05, Detlef Vollmann wrote:
>>> Hello,
>>>
>>> this commit:
>>>   > commit a71b092a9c68685a270ebdde7b5986ba8787e575
>>>   > Author: Marc Zyngier <marc.zyngier@arm.com>
>>>   > Date:   Tue Aug 26 11:03:18 2014 +0100
>>>   >
>>>   >     ARM: Convert handle_IRQ to use __handle_domain_irq
>>> [...]
>>> causes the kernel not to boot anymore on my DNS-323.
>>> Soc: MV88F5182 Rev 2
>>> CPU: ARM926 (Rev 0) running @ 500Mhz
>>> CPU: Feroceon [41069260] revision 0 (ARMv5TEJ), cr=a005317f
>>> Orion ID: MV88F5182-A2. TCLK=166666667.
>>> DNS-323: Identified HW revision B1
>>>
>>> Boot stops after "Uncompressing Linux... done, booting the kernel."
>>> Reverting the commit works fine for me.
>>> Tested 4.1.2 and 4.2.0-rc6 with orion5x_defconfig.
>>
>> Could you try the following patch ?
>>
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/356501.html
>
> As a side note, having to revert that patch to get your system up and
> running is a reliable indication that something is wrong with your
> interrupt mapping, and that you are using 0 as a valid interrupt number
> (which has been declared invalid a long time ago by the chief penguin).
Well, in this case it wasn't me ;-)
I wanted to avoid looking at the sources myself as the DNS-323 is still
a widely used hardware.

> Hopefully Gregory has put you in the right direction.
Yes.  Now I'll use that patch until some fix is accepted in mainline.

   Detlef
