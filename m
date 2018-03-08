From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 8 Mar 2018 12:24:40 +0000
Subject: [PATCH v3 09/22] arm64: capabilities: Split the processing of
 errata work arounds
In-Reply-To: <20180209181834.GG5862@e103592.cambridge.arm.com>
References: <20180209175513.17100-1-suzuki.poulose@arm.com>
 <20180209175513.17100-19-suzuki.poulose@arm.com>
 <20180209181834.GG5862@e103592.cambridge.arm.com>
Message-ID: <b5b90236-7734-2c05-65fd-57fcbe732b6c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/18 18:18, Dave Martin wrote:
> On Fri, Feb 09, 2018 at 05:54:48PM +0000, Suzuki K Poulose wrote:
>> Right now we run through the errata workarounds check on all boot
>> active CPUs, with SCOPE_ALL. This doesn't help with detecting the
>> errata's with a SYSTEM_SCOPE. While nobody uses it, let us clean
>> this up in preparation for merging capability handling.
> 
> errata; and SCOPE_SYSTEM (if I'm being pedantic)
> 
> To make it clearer this this is adding support for new behaviour rather
> than changing old behaviour, perhaps change "This doesn't help ...
> While nobody uses it ..." to something like:
> 
> "This wouldn't help for detecting erratum workarounds with SCOPE_SYSTEM.
> There are none yet, but we plan to introduce some: let us clean this up
> so that such workarounds can be detected and enabled correctly."

Fixed

>>
>> So, we run the checks with SCOPE_LOCAL_CPU on all CPUs and SCOPE_SYSTEM
>> checks are run only once after all the boot time CPUs are active.
>>
>> Cc: Dave Martin <dave.martin@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Otherwise,
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Thanks
Suzuki
