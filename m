From: james.morse@arm.com (James Morse)
Date: Tue, 17 Oct 2017 17:34:38 +0100
Subject: [PATCH v3 10/13] firmware: arm_sdei: Add support for CPU and
 system power states
In-Reply-To: <20171016135204.ncz6fzw5gh3gv57c@armageddon.cambridge.arm.com>
References: <20170922182614.27885-1-james.morse@arm.com>
 <20170922182614.27885-11-james.morse@arm.com>
 <20171016135204.ncz6fzw5gh3gv57c@armageddon.cambridge.arm.com>
Message-ID: <59E6311E.7030406@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 16/10/17 14:52, Catalin Marinas wrote:
> On Fri, Sep 22, 2017 at 07:26:11PM +0100, James Morse wrote:
>> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
>> index f24bfb2b9a2d..466b949474df 100644
>> --- a/include/linux/cpuhotplug.h
>> +++ b/include/linux/cpuhotplug.h
>> @@ -88,6 +88,7 @@ enum cpuhp_state {
>>  	CPUHP_AP_PERF_XTENSA_STARTING,
>>  	CPUHP_AP_PERF_METAG_STARTING,
>>  	CPUHP_AP_MIPS_OP_LOONGSON3_STARTING,
>> +	CPUHP_AP_SDEI_STARTING,
> 
> Nitpick: how generic is this as to apply to other architectures?
> Probably not, so shall we prefix this with ARM_?

This may get used on 32bit ARM. I blindly copied PSCI, which doesn't have a
prefix. But it makes sense to have one.


> Not actually a strong preferences but similar question for the
> definitions in the sdei.h files (and maybe the filenames themselves).


Thanks,

James
