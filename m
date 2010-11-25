From: charu@ti.com (Varadarajan, Charulatha)
Date: Thu, 25 Nov 2010 15:03:39 +0530
Subject: [PATCH v7 05/11] OMAP2420: hwmod data: Add GPIO
In-Reply-To: <AANLkTik1p0gqe6s8t-q0koehWBhc6nceU9=T74k3iw9_@mail.gmail.com>
References: <1290524213-395-1-git-send-email-charu@ti.com>
	<1290524213-395-6-git-send-email-charu@ti.com>
	<4CED8DF7.6040606@ti.com>
	<AANLkTimRK=eKBG3pqGN8Ota5EO8EdmEibQN5C3Lwfheq@mail.gmail.com>
	<4CEE1807.9040404@ti.com>
	<AANLkTik1p0gqe6s8t-q0koehWBhc6nceU9=T74k3iw9_@mail.gmail.com>
Message-ID: <AANLkTinEbi6V3tsCMDt4zj1jZLEzREeoq1L2ub87CbBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 25, 2010 at 14:01, Varadarajan, Charulatha <charu@ti.com> wrote:
> On Thu, Nov 25, 2010 at 13:32, Cousson, Benoit <b-cousson@ti.com> wrote:
>> On 11/25/2010 5:36 AM, Varadarajan, Charulatha wrote:
>>>
>>> Benoit,
>>>
>>> On Thu, Nov 25, 2010 at 03:43, Cousson, Benoit<b-cousson@ti.com> ?wrote:
>>>>
>>>> On 11/23/2010 3:56 PM, Varadarajan, Charulatha wrote:
>>>>>
>>>>> Add GPIO hwmod data for OMAP2420
>>>>>
>>>>> Signed-off-by: Charulatha V<charu@ti.com>
>>>>> ---
>>>>> ?arch/arm/mach-omap2/omap_hwmod_2420_data.c | ?229
>>>>> ++++++++++++++++++++++++++++
>>>>> ?arch/arm/plat-omap/include/plat/gpio.h ? ? | ? ?5 +
>>>>> ?2 files changed, 234 insertions(+), 0 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
>>>>> b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
>>>>> index a1a3dd6..c951061 100644
>>>>> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
>>>>> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
>>>>> @@ -17,6 +17,7 @@
>>>>> ?#include<plat/dma.h>
>>>>> ?#include<plat/serial.h>
>>>>> ?#include<plat/i2c.h>
>>>>> +#include<plat/gpio.h>
>>>>> ?#include<plat/omap24xx.h>
>>>>
>>>> Do you still need that header file?
>>>
>>> Yes, for the gpio_dev_attr
>>
>> I'm still confused, gpio_dev_attr just contains an int and a bool:
>
> I am talking about gpio.h file which is required for using
> omap_gpio_dev_attr. If you are pointing out omap24xx.h file,
> I am not sure. It was in the original code.

Okay. I checked. omap24xx.h file is no more required here
and I am deleting this header include from this file. Same for
OMAP2430 and OMAP3xxx hwmod database files too.

-V Charulatha
