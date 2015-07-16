From: a0131933@ti.com (Lokesh Vutla)
Date: Thu, 16 Jul 2015 17:58:47 +0530
Subject: [PATCH 3/3] ARM: AMx3xx: hwmod: RTC: Add lock and unlock functions
In-Reply-To: <alpine.DEB.2.02.1507160013370.32764@utopia.booyaka.com>
References: <1433928386-24891-1-git-send-email-lokeshvutla@ti.com>
 <1433928386-24891-4-git-send-email-lokeshvutla@ti.com>
 <alpine.DEB.2.02.1507160013370.32764@utopia.booyaka.com>
Message-ID: <55A7A37F.4080803@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,
On Thursday 16 July 2015 05:44 AM, Paul Walmsley wrote:
> Hi
>
> On Wed, 10 Jun 2015, Lokesh Vutla wrote:
>
>> RTC IP have kicker feature which prevents spurious writes to its registers.
>> In order to write into any of the RTC registers, KICK values has to be
>> written to KICK registers.
>>
>> omap_hwmod_rtc_unlock/lock functions writes into these KICK registers
>> inorder to lock and unlock RTC registers.
>> This patch hooks omap_hwmod_rtc_unlock/lock functions into RTC hwmod,
>> so that SYSCONFIG register is updated properly.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>>   arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
>> index cabc569..2d92958 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
>> @@ -904,6 +904,8 @@ static struct omap_hwmod_class_sysconfig am33xx_rtc_sysc = {
>>   static struct omap_hwmod_class am33xx_rtc_hwmod_class = {
>>   	.name		= "rtc",
>>   	.sysc		= &am33xx_rtc_sysc,
>> +	.unlock		= &omap_hwmod_rtc_unlock,
>> +	.lock		= &omap_hwmod_rtc_lock,
>>   };
>>
>>   struct omap_hwmod am33xx_rtc_hwmod = {
>
> The DRA7xx integration from the previous patch should either be combined
> with this patch, or moved into a separate patch like this one (your
> preference).
Ill make a separate patch for DRA7xx integration and repost it.

Thanks and regards,
Lokesh
>
>
> - Paul
>
