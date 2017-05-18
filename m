From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 18 May 2017 17:13:52 +0100
Subject: [PATCH v2] ARM: MCPM: ensure not to enter __hyp_soft_restart from
 loopback and cpu_power_down
In-Reply-To: <alpine.LFD.2.20.1705181159590.4464@knanqh.ubzr>
References: <1495099592-10439-1-git-send-email-sudeep.holla@arm.com>
 <1495103028-29753-1-git-send-email-sudeep.holla@arm.com>
 <alpine.LFD.2.20.1705181159590.4464@knanqh.ubzr>
Message-ID: <346ddd67-f340-6f6e-9c97-173ae5eb9f9c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18/05/17 17:01, Nicolas Pitre wrote:
> On Thu, 18 May 2017, Sudeep Holla wrote:
> 
>> Commit 9da5ac236de6 ("ARM: soft-reboot into same mode that we entered
>> the kernel") added support to enter the new kernel in the same processor
>> mode as the previous one when we soft-reboot from one kernel into
>> another by pass a flag to cpu_reset() so it knows what to do exactly.
>>
>> However it missed to make similar changes in MCPM code. Due to the
>> missing flag, the CPUs enter HYP mode which is not supported with MCPM.
>> MCPM works only in secure mode as it manages CCI.
>>
>> This patch aligns the cpu_reset call in MCPM with other changes in the
>> above mentioned commit by making phys_reset_t to follow the prototype
>> of cpu_reset().
>>
>> Fixes: 9da5ac236de6 ("ARM: soft-reboot into same mode that we entered the kernel")
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>
> 
> Please send it to RMK's patch system.
> 

Thanks, sent to patch system(8675/1)

-- 
Regards,
Sudeep
