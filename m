From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 22 Jun 2018 11:25:21 +0100
Subject: [PATCH v2] arm64: kpti: Use early_param for kpti= command-line
 option
In-Reply-To: <1529659525-21340-1-git-send-email-will.deacon@arm.com>
References: <1529659525-21340-1-git-send-email-will.deacon@arm.com>
Message-ID: <1ec38ecf-5cee-5223-2b6f-f63840169dad@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 22/06/18 10:25, Will Deacon wrote:
> We inspect __kpti_forced early on as part of the cpufeature enable
> callback which remaps the swapper page table using non-global entries.
> 
> Ensure that __kpti_forced has been updated to reflect the kpti=
> command-line option before we start using it.
> 

This also fixes the case where SPE driver complains about missing
kpti=off even when it's present as __setup parse kpti only after
boot CPU detects and marks ARM64_UNMAP_KERNEL_AT_EL0 capability.

Tested-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
