From: lina.iyer@linaro.org (Lina Iyer)
Date: Tue, 1 Mar 2016 12:24:21 -0700
Subject: [RFC v2 06/12] PM / cpu_domains: Record CPUs that are part of
 the domain
In-Reply-To: <20160226192033.GX28849@codeaurora.org>
References: <1455310238-8963-1-git-send-email-lina.iyer@linaro.org>
 <1455310238-8963-7-git-send-email-lina.iyer@linaro.org>
 <20160226192033.GX28849@codeaurora.org>
Message-ID: <20160301192421.GM1440@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26 2016 at 12:20 -0700, Stephen Boyd wrote:
>On 02/12, Lina Iyer wrote:
>> diff --git a/include/linux/cpu_domains.h b/include/linux/cpu_domains.h
>> index bab4846..0c539f0 100644
>> --- a/include/linux/cpu_domains.h
>> +++ b/include/linux/cpu_domains.h
>> @@ -11,8 +11,10 @@
>>  #ifndef __CPU_DOMAINS_H__
>>  #define __CPU_DOMAINS_H__
>>
>> +#include <linux/cpumask.h>
>
>Just forward declare struct cpumask instead?
>
Sure.

Thanks,
Lina

>> +
>>  struct cpu_pd_ops {
>> -	int (*power_off)(u32 state_idx, u32 param);
>> +	int (*power_off)(u32 state_idx, u32 param, const struct cpumask *mask);
>>  	int (*power_on)(void);
>>  };
>
>-- 
>Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>a Linux Foundation Collaborative Project
