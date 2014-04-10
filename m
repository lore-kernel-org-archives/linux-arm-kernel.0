From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 10 Apr 2014 13:35:55 +0900
Subject: [PATCH 01/10] ARM: EXYNOS: Cleanup  "mach-exynos/common.h" file
In-Reply-To: <53441CF5.80003@samsung.com>
References: <1396425058-4012-1-git-send-email-pankaj.dubey@samsung.com>
 <1396425058-4012-2-git-send-email-pankaj.dubey@samsung.com>
 <53441CF5.80003@samsung.com>
Message-ID: <53461FAB.6060303@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On 04/09/2014 12:59 AM, Tomasz Figa wrote:
> Hi Pankaj,
>
> On 02.04.2014 09:50, Pankaj Dubey wrote:
>> Remove unused declarations from "mach-exynos/common.h"
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>   arch/arm/mach-exynos/common.h |    3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
>> index 9ef3f83..277a83e 100644
>> --- a/arch/arm/mach-exynos/common.h
>> +++ b/arch/arm/mach-exynos/common.h
>> @@ -15,9 +15,6 @@
>>   #include <linux/reboot.h>
>>   #include <linux/of.h>
>>
>> -void mct_init(void __iomem *base, int irq_g0, int irq_l0, int irq_l1);
>> -
>> -struct map_desc;
>>   void exynos_init_io(void);
>>   void exynos_restart(enum reboot_mode mode, const char *cmd);
>>   void exynos_cpuidle_init(void);
>>
>
> You could also drop a bit more. From the context above I can see that at least 
> exynos_restart() and exynos_init_io() are never used outside of files they are 
> defined in, so they too could be dropped from this header. Looking at rest of 
> the header, there seems to be a lot of similar definitions. If cleaning up the 
> header anyway, could you take care of them as well?
>

Thanks for review.
Sure, I will take care of other functions which are not required in this header
file in next version.

> Best regards,
> Tomasz
>


-- 
Best Regards,
Pankaj Dubey
