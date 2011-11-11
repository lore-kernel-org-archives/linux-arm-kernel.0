From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 11 Nov 2011 15:56:05 +0100
Subject: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
In-Reply-To: <20111111114735.GC5114@totoro>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
 <1319467559-5518-5-git-send-email-ming.lei@canonical.com>
 <alpine.DEB.2.00.1111080750130.10451@utopia.booyaka.com>
 <CACVXFVMSJUT2Ac+bWetrLpbyOs6PqY+npNHsbvHipEVZ0gWdgQ@mail.gmail.com>
 <alpine.DEB.2.00.1111100152430.4195@utopia.booyaka.com>
 <20111111114147.GE12410@mudshark.cambridge.arm.com>
 <20111111114735.GC5114@totoro>
Message-ID: <4EBD3785.4050102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/2011 12:47 PM, Jamie Iles wrote:
> On Fri, Nov 11, 2011 at 11:41:47AM +0000, Will Deacon wrote:
>> [Adding Benoit to CC].
>>
>> On Thu, Nov 10, 2011 at 09:02:14AM +0000, Paul Walmsley wrote:
>>> On Wed, 9 Nov 2011, Ming Lei wrote:
>>>> Also, current arm perf code don't handle three IRQs(one pl310 irq and
>>>> two CTI irq) inside one device correctly.
>>>
>>> To fix this, that ARM perf code should either be using
>>> platform_get_irq_byname(), or the hwmod hardware data will need to be
>>> rearranged to meet the arbitrary ordering requirement.  I'd suggest
>>> pinging Will on this issue to see what he wants to do.
>>
>> The issue stems from the fact that we have to route the PMU interrupts to
>> the correct CPU manually (I think only MSM routes them as PPIs, which is
>> clearly the correct thing to do). To do this, we expect the IRQ resources to
>> be laid out in CPU order. In hindsight, maybe naming the resources might
>> have been a good idea, but them we'd still have to generate the names using
>> CPU numbers when iterating through the platform device.
>
> There isn't yet a way to do naming of resources with DT, and although I
> think there was a proposal for doing named register resources I don't
> think this has been accepted and there wasn't anything for IRQ
> resources...

It will come soon... along with the updated patch for reg-names support.

Regards,
Benoit
