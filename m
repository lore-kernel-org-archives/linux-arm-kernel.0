From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 25 Jul 2017 10:29:31 +0100
Subject: [PATCH v5 08/19] coresight tmc: Add helpers for accessing 64bit
 registers
In-Reply-To: <CANLsYkz8DS8TN7Luw4uh2Ripod8dX5BK4bFOZc-BEw4212_WOA@mail.gmail.com>
References: <1500545849-23724-1-git-send-email-suzuki.poulose@arm.com>
 <1500545849-23724-9-git-send-email-suzuki.poulose@arm.com>
 <CANLsYkz8DS8TN7Luw4uh2Ripod8dX5BK4bFOZc-BEw4212_WOA@mail.gmail.com>
Message-ID: <505bb6e9-8f38-bcda-23dd-7ed95ffa143b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/07/17 18:11, Mathieu Poirier wrote:
> On 20 July 2017 at 04:17, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>> Coresight TMC splits 64bit registers into a pair of 32bit registers
>> (e.g DBA, RRP, RWP). Provide helpers to read/write to these registers.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
>> index 51c0185..c78de00 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc.h
>> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
>> @@ -18,6 +18,7 @@
>>  #ifndef _CORESIGHT_TMC_H
>>  #define _CORESIGHT_TMC_H
>>
>> +#include <linux/io.h>
>
> Is this needed?  I recompiled on my side without it and nothing breaks.
>

I think it is a left over from rebase, where I initially open coded the
read/write_relaxed here and then later moved to the coresight-priv.h. So,
yes, please could you fix it up when you commit ?

Cheers
Suzuki
