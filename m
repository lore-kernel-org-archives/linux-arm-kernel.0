From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 19 Apr 2016 09:14:49 -0600
Subject: [PATCH V2 05/15] coresight: tmc: splitting driver in ETB/ETF and
 ETR components
In-Reply-To: <571622A3.4020103@arm.com>
References: <1460483692-25061-1-git-send-email-mathieu.poirier@linaro.org>
 <1460483692-25061-6-git-send-email-mathieu.poirier@linaro.org>
 <571622A3.4020103@arm.com>
Message-ID: <CANLsYkzkJpm2L3dWGAR9ZWT5rzCjg381jDca79AoYdGX-2JOeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 April 2016 at 06:20, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
> On 12/04/16 18:54, Mathieu Poirier wrote:
>>
>> The TMC block can operate in 3 modes (ETB, ETF and ETR) and accessed
>> via two interfaces (sysFS and Perf).  That makes 6 mode to cover, which
>> is way too much coupling for a single file.
>>
>> This patch splits the original TMC driver in 2 halves, one for ETB/ETF
>> and another one for ETR mode.  A common core is kept for functionality
>> common to all 3 modes.
>>
>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>
>
>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h
>> b/drivers/hwtracing/coresight/coresight-tmc.h
>> index 2d7d52747b4e..b99d4dfc1d0b 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc.h
>> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
>> @@ -18,6 +18,8 @@
>>   #ifndef _CORESIGHT_TMC_H
>>   #define _CORESIGHT_TMC_H
>>
>> +#include <linux/miscdevice.h>
>> +
>
>
> What was this for ?

For the struct tmc_drvdata::miscdev field, used to generate the sink's
entry under /dev.

Thanks,
Mathieu

>
> Irrespective of that,
>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
