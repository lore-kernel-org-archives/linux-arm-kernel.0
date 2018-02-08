From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 8 Feb 2018 12:10:47 +0000
Subject: [PATCH v2 08/20] arm64: capabilities: Group handling of features
 and errata
In-Reply-To: <20180207103829.GY5862@e103592.cambridge.arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
 <20180131182807.32134-9-suzuki.poulose@arm.com>
 <20180207103829.GY5862@e103592.cambridge.arm.com>
Message-ID: <86f23003-72bc-5bfc-af40-a92cc68def45@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/18 10:38, Dave Martin wrote:
> On Wed, Jan 31, 2018 at 06:27:55PM +0000, Suzuki K Poulose wrote:
>> So far we have had separate routes for triggering errata and feature
>> capability detection. Also, we never allowed "features" based on local
>> CPU and "errata" based on System wide safe registers. This patch
>> groups the handling of errata and features and also allows them
>> to have all the possible scopes. So we now run through both
>> arm64_features and arm64_errata, in two phases for detection.
>>
>>   1) with SCOPE_LOCAL_CPU filter on each boot time enabled CPUs,
>>      via update_cpu_local_capabilities().
>>
>>   2) with SCOPE_SYSTEM filter only once after all boot time enabled
>>      CPUs are active, triggered from setup_cpu_features().
>>
>> A late CPU goes through both the tables for verification against
>> established capabilities, as before.
>>
>> We could ideally merge the two tables into one. But leave it as
>> it is for easy access to the list of particular type.
>>
>> Cc: Dave Martin <dave.martin@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> I don't know if there's a way of splitting or refactoring this patch to
> make it easier to understand the changes, but I think I get what's going
> on here now.
> 
> So,
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> 

Thanks,

> (But if you can see a good way to split it, I'll be happy to take
> another look.)

I did try this out, patches follows.
