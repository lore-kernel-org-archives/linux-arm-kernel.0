From: lina.iyer@linaro.org (Lina Iyer)
Date: Wed, 25 Nov 2015 07:13:38 -0700
Subject: [PATCH RFC 17/27] drivers: cpu-pd: Record CPUs that are part of
 the domain
In-Reply-To: <20151124210043.GD25963@codeaurora.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
 <1447799871-56374-18-git-send-email-lina.iyer@linaro.org>
 <20151124210043.GD25963@codeaurora.org>
Message-ID: <20151125141338.GH30342@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24 2015 at 14:00 -0700, Stephen Boyd wrote:
>On 11/17, Lina Iyer wrote:
>> diff --git a/drivers/base/power/cpu-pd.c b/drivers/base/power/cpu-pd.c
>> index 9758b8d..617ce54 100644
>> --- a/drivers/base/power/cpu-pd.c
>> +++ b/drivers/base/power/cpu-pd.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/device.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/pm_qos.h>
>
>What's this added for?
>
pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
Getting the PM QoS for the CPUs.

-- Lina

>>  #include <linux/rculist.h>
>>  #include <linux/slab.h>
>
>-- 
>Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>a Linux Foundation Collaborative Project
