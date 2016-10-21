From: slash.tmp@free.fr (Mason)
Date: Fri, 21 Oct 2016 22:27:23 +0200
Subject: Disabling an interrupt in the handler locks the system up
In-Reply-To: <alpine.DEB.2.20.1610212147420.4855@nanos>
References: <580A4460.2090306@free.fr>
 <a79e2d2c-8ec8-744f-50fb-8c39216aa23e@arm.com> <580A60ED.3030307@free.fr>
 <20161021201448.3f4a0a7a@arm.com> <580A70B9.8060507@free.fr>
 <alpine.DEB.2.20.1610212147420.4855@nanos>
Message-ID: <580A7A2B.5000702@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/10/2016 21:49, Thomas Gleixner wrote:
> On Fri, 21 Oct 2016, Mason wrote:
>> On 21/10/2016 21:14, Marc Zyngier wrote:
>>> If connecting a device that signals its interrupt as level low to an
>>> input line configured as level high doesn't strike you as a major
>>> issue, nothing will. At that point, you can put anything you want in
>>> your DT.
>>
>> If I understand correctly, you are saying that I should have
>> specified IRQ_TYPE_LEVEL_LOW, instead of IRQ_TYPE_LEVEL_HIGH?
>>
>> If the HW outputs 1 when idle, and 0 when busy, that
>> is level low? (Sorry if this is obvious, I'm absolutely
>> clueless in this subject matter.)
> 
> We describe the level which is raising the interrupt. So in your case the
> line goes to 0 when the interrupt is active, so the level is LOW.

I see. I'll try that on Monday.

In my mental picture of interrupts (which is obviously so
incomplete as to be wrong) interrupts are a way for hardware
to tell the CPU that they urgently need the CPU's attention.

Obviously, the hardware being idle (line high) is not an urgent
matter which interests the CPU. Likewise, I'm not sure the CPU
cares that the hardware is busy (line low). It seems to me the
interesting event from the CPU's perspective is when the
hardware completes a "task" (transition from low to high).

So I had originally configured the interrupt as IRQ_TYPE_EDGE_RISING.
(There is an edge detection block in the irqchip, but the HW designer
warned me that at low frequencies, it is possible to "miss" some edges,
and we should prefer level triggers if possible.)

Regards.
