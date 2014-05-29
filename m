From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 29 May 2014 13:36:45 +0530
Subject: [PATCH 1/5] ARM: imx: Use PTR_ERR_OR_ZERO in platform-mxc_rnga.c
In-Reply-To: <20140529080321.GF8860@dragon>
References: <1401339434-26085-1-git-send-email-sachin.kamat@linaro.org>
 <20140529080321.GF8860@dragon>
Message-ID: <CAK9yfHxTRrqSoJqo5vkdM8OG6O=-HYfsF+Jwh3hdZ6ejuOjtgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 May 2014 13:33, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Thu, May 29, 2014 at 10:27:10AM +0530, Sachin Kamat wrote:
>> PTR_ERR_OR_ZERO simplifies the code.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> ---
>>  arch/arm/mach-imx/devices/platform-mxc_rnga.c |    6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-imx/devices/platform-mxc_rnga.c b/arch/arm/mach-imx/devices/platform-mxc_rnga.c
>> index c58404badb59..33d58ca2001a 100644
>> --- a/arch/arm/mach-imx/devices/platform-mxc_rnga.c
>> +++ b/arch/arm/mach-imx/devices/platform-mxc_rnga.c
>> @@ -6,6 +6,7 @@
>>   * the terms of the GNU General Public License version 2 as published by the
>>   * Free Software Foundation.
>>   */
>> +#include <linux/err.h>
>>  #include "../hardware.h"
>>  #include "devices-common.h"
>>
>> @@ -48,9 +49,6 @@ static int __init imxXX_add_mxc_rnga(void)
>>  #endif /* if defined(CONFIG_SOC_IMX31) */
>>               ret = ERR_PTR(-ENODEV);
>>
>> -     if (IS_ERR(ret))
>> -             return PTR_ERR(ret);
>> -
>> -     return 0;
>> +     return PTR_ERR_OR_ZERO(ret);
>
> The existing code looks just fine and actually more readable to me.
> Also, all the files you are patching will eventually be killed by DT
> support.  So let's just leave it there as it is for now.

If these files are meant to go, then we can leave these changes out.
Thanks Shawn.

-- 
With warm regards,
Sachin
