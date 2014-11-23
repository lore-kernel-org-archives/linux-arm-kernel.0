From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 22 Nov 2014 21:45:54 -0300
Subject: [PATCH 0/7] Armada 375/38x perf support, and a bonus irqchip
 driver simplification
In-Reply-To: <20141109225004.GB3698@titan.lakedaemon.net>
References: <1413985427-20918-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20141109052348.GT3698@titan.lakedaemon.net>
 <20141109104150.03044ee0@free-electrons.com>
 <545F5B82.5090004@free-electrons.com>
 <20141109225004.GB3698@titan.lakedaemon.net>
Message-ID: <54712E42.1030400@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/2014 07:50 PM, Jason Cooper wrote:
> On Sun, Nov 09, 2014 at 09:18:10AM -0300, Ezequiel Garcia wrote:
>> On 11/09/2014 06:41 AM, Thomas Petazzoni wrote:
>>> Jason, Ezequiel,
>>>
>>> On Sun, 9 Nov 2014 00:23:48 -0500, Jason Cooper wrote:
>>>> On Wed, Oct 22, 2014 at 10:43:40AM -0300, Ezequiel Garcia wrote:
>>>>> This patchset enables support for perf hardware events, by enabling the PMU
>>>>> interrupts in the irqchip driver.
>>>>>
>>>>> While doing this, we noticed the driver could use some cleaning to simplify
>>>>> the overly complex implementation of the .map(), .unmask() and .mask()
>>>>> functions.
>>>>>
>>>>> The first three patches are the result of this cleaning effort, while the
>>>>> rest of the series is the Perf support for Armada 375 and Armada 38x SoCs.
>>>>>
>>>>> The series is based on v3.18-rc1.
>>>>>
>>>>> Ezequiel Garcia (7):
>>>>>   irqchip: armada-370-xp: Simplify interrupt map, mask and unmask
>>>>>   irqchip: armada-370-xp: Initialize per cpu registers when CONFIG_SMP=N
>>>>>   irqchip: armada-370-xp: Introduce a is_percpu_irq() helper for
>>>>>     readability
>>>>>   irqchip: armada-370-xp: Enable Performance Counter interrupts
>>>>
>>>> Patches 1 to 4 tentatively applied to irqchip/mvebu.  Things have been
>>>> quiet, so let's get it in next for some more test coverage.
>>>
>>
>> Jason, please consider *only* patch 1 for inclusion, as long as we
>> have Gregory's Ack on it. I don't want to break the irqchip driver
>> because of a clean-up! On the other side, if such weird handling
>> is needed, we need find why and document it.
> 
> No sweat.  I've now rolled irqchip/mvebu back to:
> 
>   aaae00a7fa86 irqchip: armada-370-xp: Simplify interrupt map, mask and unmask
> 
> and an updated for-next is being build-tested and pushed hopefully
> before Stephen gets his cup of coffee.  :)
> 
> 

Jason,

Please drop that one as well. Gregory and I have been discussing some more
and we concluded that the change is wrong.

I'm working on a new series, but it'll take some time.

Thanks and sorry for the huge delay,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
