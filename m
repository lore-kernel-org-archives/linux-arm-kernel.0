From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 03 Dec 2010 16:38:58 +0100
Subject: [PATCH 1/4] mach-s5pv210: Add platform definitions for mipi-csis
In-Reply-To: <AANLkTi=bARGdX2Y4Ea-YP8qQRcjAXme8NW9Mp-0dTxgZ@mail.gmail.com>
References: <1291307862-8125-1-git-send-email-s.nawrocki@samsung.com>
	<1291307862-8125-2-git-send-email-s.nawrocki@samsung.com>
	<012301cb92a1$a7020af0$f50620d0$%kim@samsung.com>
	<AANLkTi=bARGdX2Y4Ea-YP8qQRcjAXme8NW9Mp-0dTxgZ@mail.gmail.com>
Message-ID: <4CF90F12.6020803@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 12/03/2010 06:30 AM, Kyungmin Park wrote:
> On Fri, Dec 3, 2010 at 1:22 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> Sylwester Nawrocki wrote:
>>>
>>> Added resource definitions for mipi-csis interface, naming
>>> changed for consistency with s5pv310 where there are two
>>> instances of the device.
>>>
>>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>> ---
>>>  arch/arm/mach-s5pv210/include/mach/irqs.h       |    2 +-
>>>  arch/arm/mach-s5pv210/include/mach/map.h        |    4 ++++
>>>  arch/arm/mach-s5pv210/include/mach/regs-clock.h |    5 +----
>>>  3 files changed, 6 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-s5pv210/include/mach/irqs.h b/arch/arm/mach-
>>> s5pv210/include/mach/irqs.h
>>> index 119b95f..8b5994c 100644
>>> --- a/arch/arm/mach-s5pv210/include/mach/irqs.h
>>> +++ b/arch/arm/mach-s5pv210/include/mach/irqs.h
>>> @@ -65,7 +65,7 @@
>>>  #define IRQ_HSMMC0           S5P_IRQ_VIC1(26)
>>>  #define IRQ_HSMMC1           S5P_IRQ_VIC1(27)
>>>  #define IRQ_HSMMC2           S5P_IRQ_VIC1(28)
>>> -#define IRQ_MIPICSI          S5P_IRQ_VIC1(29)
>>> +#define IRQ_MIPICSI0         S5P_IRQ_VIC1(29)
>>
>> Firstly don't use directly IRQ_MIPICSI0 which is used in platform device.
>> Because it can be confused that there would be another MIPICSI such as
>> MIPICSI1.
>> In that case, just use like following. For example,
> Hi,
> 
> First respect others work.
> my impression is that you forced the developers to work as you want.
> 
> okay who summit this code? If you think name is odd, then you check it
> before you submitted.
> When you commit the code is okay, but other should be considered as yours.
> 
>>
>> ---
>> @@ -132,5 +132,6 @@
>>  #define IRQ_LCD_FIFO           IRQ_LCD0
>>  #define IRQ_LCD_VSYNC          IRQ_LCD1
>>  #define IRQ_LCD_SYSTEM         IRQ_LCD2
>> +#define IRQ_MIPI_CSIS0         IRQ_MIPICSI
>>
>>  #endif /* ASM_ARCH_IRQS_H */
>> ---
>>
>> And I'm confused about the name of MIPI-CSI...
>> Hmm...used MIPICSI or MIPI_CSI, sometimes MIPICSIS or MIPI_CSIS.
>>
>> Maybe the meaning is Camera Serial Interface Slave...
>> So...how about to use just one such as "IRQ_MIPI_CSIS" and
>> "S5PV210_PA_MIPI_CSIS".
> 
> I think it's better use the common word, CSI. I can't find CSIS word
> at googling.

Yeah, you are making a good point Kyungmin. I just wanted to make it more human
friendly by using CSI instead of CSIS. However I guess we would be
better off using exact names from the datasheet.
The worst thing is that the datasheet often lacks an explanation of what
some of that cryptic names like MIPI CSIS, FIMC, FIMD, etc. mean.

For those who still don't know:
MIPI CSIS - MIPI Camera Serial Interface Slave
FIMC - Fully Interactive Mobile Camera
FIMD - Fully Interactive Mobile Display


Regards,
-- 
Sylwester Nawrocki
Linux Platform Group
Samsung Poland R&D Center
