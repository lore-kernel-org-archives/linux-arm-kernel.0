From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 21 May 2018 14:04:44 +0100
Subject: [PATCH] cpufreq: Add Kryo CPU scaling driver
In-Reply-To: <000f01d3f103$3ff78ba0$bfe6a2e0$@codeaurora.org>
References: <1526555955-29960-11-git-send-email-ilialin@codeaurora.org>
 <1526729701-8589-1-git-send-email-ilialin@codeaurora.org>
 <153cc316-dcb5-972f-5a2f-c91fe0f6348b@arm.com>
 <000f01d3f103$3ff78ba0$bfe6a2e0$@codeaurora.org>
Message-ID: <2ace10bc-e1c4-2060-94d3-eb71e966ffbe@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/05/18 13:57, ilialin at codeaurora.org wrote:
> 
[...]

>>> +#include <linux/cpu.h>
>>> +#include <linux/err.h>
>>> +#include <linux/init.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/nvmem-consumer.h>
>>> +#include <linux/of.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/pm_opp.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/soc/qcom/smem.h>
>>> +
>>> +#define MSM_ID_SMEM	137
>>> +#define SILVER_LEAD	0
>>> +#define GOLD_LEAD	2
>>> +
>>
>> So I gather form other emails, that these are physical cpu number(not even
>> unique identifier like MPIDR). Will this work on parts or platforms that need
>> to boot in GOLD LEAD cpus.
> 
> The driver is for Kryo CPU, which (and AFAIK all multicore MSMs)
> always boots on the CPU0.


That may be true and I am not that bothered about it. But assuming
physical ordering from the logical cpu number is *incorrect* and will
break if kernel decides to change the allocation algorithm. Kernel
provides no guarantee on that, so you need to depend on some physical ID
or may be DT to achieve what your want. But the current code as it
stands is wrong.

-- 
Regards,
Sudeep
