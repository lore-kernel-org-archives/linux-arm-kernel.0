From: dv@vollmann.ch (Detlef Vollmann)
Date: Fri, 14 Aug 2015 17:45:02 +0200
Subject: commit a71b092 "ARM: Convert handle_IRQ to use
 __handle_domain_irq" breaks DNS-323
In-Reply-To: <55CE0B6C.509@free-electrons.com>
References: <55CDF5C3.7080204@vollmann.ch>
 <55CDF78F.6070001@free-electrons.com> <55CE0AD8.3030800@vollmann.ch>
 <55CE0B6C.509@free-electrons.com>
Message-ID: <55CE0CFE.4040206@vollmann.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14/15 17:38, Gregory CLEMENT wrote:
> Hi Detlef,
>
> On 14/08/2015 17:35, Detlef Vollmann wrote:
>> Hi Gregory,
>>
>> On 08/14/15 16:13, Gregory CLEMENT wrote:
>>> On 14/08/2015 16:05, Detlef Vollmann wrote:
>>>> Hello,
>>>>
>>>> this commit:
>>>>    > commit a71b092a9c68685a270ebdde7b5986ba8787e575
>>>>    > Author: Marc Zyngier <marc.zyngier@arm.com>
>>>>    > Date:   Tue Aug 26 11:03:18 2014 +0100
>>>>    >
>>>>    >     ARM: Convert handle_IRQ to use __handle_domain_irq
>>>> [...]
>>>> causes the kernel not to boot anymore on my DNS-323.
>>>> Soc: MV88F5182 Rev 2
>>>> CPU: ARM926 (Rev 0) running @ 500Mhz
>>>> CPU: Feroceon [41069260] revision 0 (ARMv5TEJ), cr=a005317f
>>>> Orion ID: MV88F5182-A2. TCLK=166666667.
>>>> DNS-323: Identified HW revision B1
>>>>
>>>> Boot stops after "Uncompressing Linux... done, booting the kernel."
>>>> Reverting the commit works fine for me.
>>>> Tested 4.1.2 and 4.2.0-rc6 with orion5x_defconfig.
>>>
>>> Could you try the following patch ?
>>>
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/356501.html
>> Thanks for the pointer.
>> Yes, this patch fixes it :-)
>>
>> I've also tested Arnd's patch at
>>
>> http://git.kernel.org/cgit/linux/kernel/git/arnd/playground.git/commit/?h=multiplatform-4.2-next&id=44b55cab3bd74739e4c39205d41e1b2ed8953155
>>
>> But at least in isolation this doesn't fix the problem.
>
> Thanks for doing these two tests,
Well, thanks for the pointer!

> so I will take Benjamin and also add your
> Tested-by if you agree.
Fine by me.

Thanks,
   Detlef
