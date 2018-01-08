From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Mon, 8 Jan 2018 11:22:53 -0600
Subject: [PATCH] arm64: Implement branch predictor hardening for Falkor
In-Reply-To: <20180108092849.alfqtsmaf2dqakkr@kamzik.brq.redhat.com>
References: <1515184139-23743-1-git-send-email-shankerd@codeaurora.org>
 <20180108092849.alfqtsmaf2dqakkr@kamzik.brq.redhat.com>
Message-ID: <53924fb5-e5d6-69d7-0042-3a7eb8febc32@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On 01/08/2018 03:28 AM, Andrew Jones wrote:
> Hi Shanker,
> 
> On Fri, Jan 05, 2018 at 02:28:59PM -0600, Shanker Donthineni wrote:
> ...
>> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
>> index cb0fb37..daf53a5 100644
>> --- a/arch/arm64/kernel/cpu_errata.c
>> +++ b/arch/arm64/kernel/cpu_errata.c
>> @@ -54,6 +54,8 @@ static int cpu_enable_trap_ctr_access(void *__unused)
>>  
>>  #ifdef CONFIG_KVM
>>  extern char __psci_hyp_bp_inval_start[], __psci_hyp_bp_inval_end[];
>> +extern char __qcom_hyp_sanitize_link_stack_start[];
>> +extern char __qcom_hyp_sanitize_link_stack_end[];
>>  
>>  static void __copy_hyp_vect_bpi(int slot, const char *hyp_vecs_start,
>>  				const char *hyp_vecs_end)
>> @@ -96,8 +98,10 @@ static void __install_bp_hardening_cb(bp_hardening_cb_t fn,
>>  	spin_unlock(&bp_lock);
>>  }
>>  #else
>> -#define __psci_hyp_bp_inval_start	NULL
>> -#define __psci_hyp_bp_inval_end		NULL
>> +#define __psci_hyp_bp_inval_start	   	NULL
>> +#define __psci_hyp_bp_inval_end			NULL
>> +#define __qcom_hyp_sanitize_link_stack_start	NULL
>> +#define __qcom_hyp_sanitize_link_stack_start	NULL
>                                           ^^ copy+paste error here

Thanks for catching typo, I'll fix in v2 patch. 

> 
> Thanks,
> drew
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
