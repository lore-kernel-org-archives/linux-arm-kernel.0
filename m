From: charu@ti.com (Varadarajan, Charulatha)
Date: Thu, 25 Nov 2010 10:07:45 +0530
Subject: [PATCH v7 07/11] OMAP3: hwmod data: Add GPIO
In-Reply-To: <4CED96EC.1040608@ti.com>
References: <1290524213-395-1-git-send-email-charu@ti.com>
	<1290524213-395-8-git-send-email-charu@ti.com>
	<4CED96EC.1040608@ti.com>
Message-ID: <AANLkTik4dtCv9uVbL4dJgw+mpK-WWGZykUHSsKv4zvEZ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benoit,

On Thu, Nov 25, 2010 at 04:21, Cousson, Benoit <b-cousson@ti.com> wrote:
> On 11/23/2010 3:56 PM, Varadarajan, Charulatha wrote:
>>
>> Add GPIO hwmod data for OMAP3
>>
>> Signed-off-by: Charulatha V<charu@ti.com>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>
> Acked-by: Benoit Cousson <b-cousson@ti.com>

Thanks.

>
>> ---
>> ?arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | ?360
>> ++++++++++++++++++++++++++++
>> ?1 files changed, 360 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> index a8bed84..9ca2206 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> @@ -20,6 +20,7 @@
>> ?#include<plat/serial.h>
>> ?#include<plat/l4_3xxx.h>
>> ?#include<plat/i2c.h>
>> +#include<plat/gpio.h>
>> ?#include<plat/omap34xx.h>
>>
>> ?#include "omap_hwmod_common_data.h"
>> @@ -45,6 +46,12 @@ static struct omap_hwmod omap3xxx_wd_timer2_hwmod;
>> ?static struct omap_hwmod omap3xxx_i2c1_hwmod;
>> ?static struct omap_hwmod omap3xxx_i2c2_hwmod;

<<snip>>

>> +};
>> +
>> +/* gpio1 */
>> +static struct omap_hwmod_irq_info omap3xxx_gpio1_irqs[] = {
>> + ? ? ? { .name = "gpio_mpu_irq", .irq = 29 }, /* INT_34XX_GPIO_BANK1 */
>
> In this case the name is not necessarily needed since there is only one irq
> line.
> You can save some memory by just adding the .irq field.

Yes, I too thought about it. But to be consistent with other devices,
I included it here
as I did not receive any comments before on this. Anyways, will remove
them while
re-sending patches as per Kevin's suggestions to rebase them on pm-core branch.

>
> Benoit
>
