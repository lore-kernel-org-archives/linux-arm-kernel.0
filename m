From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 08 Jan 2015 14:46:15 +0530
Subject: [PATCH] drivers: cpuidle: don't initialize big.LITTLE driver
 if MCPM is unavailable
In-Reply-To: <54AE459B.8010703@linaro.org>
References: <1420698544-10277-1-git-send-email-sudeep.holla@arm.com>
 <54AE459B.8010703@linaro.org>
Message-ID: <54AE4ADF.3030307@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Thursday 08 January 2015 02:23 PM, Daniel Lezcano wrote:
> On 01/08/2015 07:29 AM, Sudeep Holla wrote:
>> If big.LITTLE driver is initialized even when MCPM is unavailable,
>> we get the below warning the first time cpu tries to enter deeper
>> C-states.
>
> Can you elaborate why MCPM could be unavailable when the tc2 pm code
> registers the mcpm platform ops before the cpuidle driver ?
>
>
I can think of 3 possible scenarios. Let me know if these make sense.

1. If the firmware settings in Vexpress configuration files are set to
    boot in legacy mode, but MCPM is enabled in the kernel.
2. If some failure occurs during MCPM initialization
3. For example, if CCI is not accessible as in some Exynos boards [1],
    we don't want to wait till mpcm_cpu_suspend ?

Regards,
Sudeep

[1] 
https://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg39624.html
