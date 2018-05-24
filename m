From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 24 May 2018 09:20:37 +0100
Subject: [PATCH v4 3/3] arm64: Introduce command line parameter to disable
 CNP
In-Reply-To: <20180523171721.ppazcyf576koimhl@armageddon.cambridge.arm.com>
References: <1526638022-4137-1-git-send-email-vladimir.murzin@arm.com>
 <1526638022-4137-4-git-send-email-vladimir.murzin@arm.com>
 <20180523171721.ppazcyf576koimhl@armageddon.cambridge.arm.com>
Message-ID: <b4771d84-2403-3bd4-9566-4d9b1403d112@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/05/18 18:17, Catalin Marinas wrote:
> On Fri, May 18, 2018 at 11:07:02AM +0100, Vladimir Murzin wrote:
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 11fc28e..8f59d47 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -2636,6 +2636,10 @@
>>  
>>  	noclflush	[BUGS=X86] Don't use the CLFLUSH instruction
>>  
>> +	nocnp		[ARM64]
>> +			Disable CNP (Common not Private translations)
>> +			even if it is supported by processor.
>> +
>>  	nodelayacct	[KNL] Disable per-task delay accounting
>>  
>>  	nodsp		[SH] Disable hardware DSP at boot time.
> 
> Do we actually have a use-case for this command line option? I'm not
> considering hardware errata as these are handled separately in the
> kernel.
> 

Well, I cannot count all cases, yet we might see CnP support advertised
by CPU via ID register (where CPU meant to be part of bL) but not really
doing optimisations in hardware.

Probably, some userspace (benchmarks) might not benefit of CnP; otoh maybe
better way for such case would be user-space asking kernel to {dis,en}able
CnP...

I have no strong opinion on patch, so I'm fine to drop it and come back
when/if we get results from real hardware.

Cheers
Vladimir
