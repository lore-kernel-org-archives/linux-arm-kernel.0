From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 7 Feb 2018 15:10:47 +0000
Subject: [PATCH v2 1/2] arm64: Relax constraints on ID feature bits
In-Reply-To: <20180207150906.GQ5862@e103592.cambridge.arm.com>
References: <20180207142106.10716-1-suzuki.poulose@arm.com>
 <20180207150906.GQ5862@e103592.cambridge.arm.com>
Message-ID: <1b48ec33-db45-d6b2-b519-b5652196cb45@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/18 15:09, Dave Martin wrote:
> On Wed, Feb 07, 2018 at 02:21:05PM +0000, Suzuki K Poulose wrote:

...

> [...]
> 
>> -	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_ASID_SHIFT, 4, 0),
>> +	/*
>> +	 * We handle differing ASID widths by explicit checks to make sure the system is
>> +	 * safe via verify_cpu_asid_bits()
> 
> I guess that's sufficient.
> 
> Although I had suggested adding a comment to verify_cpu_asid_bits()
> cross-referencing back to here, it now seems superfluous.  It's fairly
> obvious what that function is supported to do.
> 
> 
> [...]
> 
>> -	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_VHE_SHIFT, 4, 0),
> 
> [...]
> 
>> +	/*
>> +	 * When CONFIG_ARM64_VHE is enabled, we ensure that there is no conflict in run
>> +	 * levels via verify_cpu_run_el()
>> +	 */
>> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_VHE_SHIFT, 4, 0),
> 
> Similarly ack.
> 
> 
> [...]
> 
>> -	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_IESB_SHIFT, 4, 0),
> 
> [...]
> 
>> +	/*
>> +	 * Lacking implicit ESB on exception boundaries on a subset of CPUs is no worse than
>> +	 * lacking it on all of them.
>> +	 */
>> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_IESB_SHIFT, 4, 0),
> 
> And again.  Thanks.
> 
> [...]
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> 


Thanks Dave !
