From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Tue, 24 Apr 2018 09:26:44 -0700
Subject: [PATCH v3 09/10] drivers/hwmon: Add PECI hwmon client drivers
In-Reply-To: <1524585397.21176.502.camel@linux.intel.com>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
 <20180410183212.16787-10-jae.hyun.yoo@linux.intel.com>
 <1524585397.21176.502.camel@linux.intel.com>
Message-ID: <c62f1c9a-1eae-49d9-2fde-c65452d5f0e6@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

Thanks a lot for your review. Please check my inline answers.

On 4/24/2018 8:56 AM, Andy Shevchenko wrote:
> On Tue, 2018-04-10 at 11:32 -0700, Jae Hyun Yoo wrote:
> 
>>   drivers/hwmon/peci-cputemp.c  | 783
>> ++++++++++++++++++++++++++++++++++++++++++
>>   drivers/hwmon/peci-dimmtemp.c | 432 +++++++++++++++++++++++
> 
> Does it make sense one driver per patch?
> 

Yes, I'll separate it into two patches.

>> +#define CLIENT_CPU_ID_MASK    0xf0ff0  /* Mask for Family / Model
>> info */
> 
>> +struct cpu_gen_info {
>> +	u32 type;
>> +	u32 cpu_id;
>> +	u32 core_max;
>> +};
>>
> 
>> +static const struct cpu_gen_info cpu_gen_info_table[] = {
>> +	{ .type = CPU_GEN_HSX,
>> +	  .cpu_id = 0x306f0, /* Family code: 6, Model number: 63
>> (0x3f) */
>> +	  .core_max = CORE_MAX_ON_HSX },
>> +	{ .type = CPU_GEN_BRX,
>> +	  .cpu_id = 0x406f0, /* Family code: 6, Model number: 79
>> (0x4f) */
>> +	  .core_max = CORE_MAX_ON_BDX },
>> +	{ .type = CPU_GEN_SKX,
>> +	  .cpu_id = 0x50650, /* Family code: 6, Model number: 85
>> (0x55) */
>> +	  .core_max = CORE_MAX_ON_SKX },
>> +};
> 
> Are we talking about x86 CPU IDs here?
> If so, why x86 corresponding headers, including intel-family.h are not
> used?
> 

Yes, that would make more sense. I'll include the intel-family.h and 
will use these defines instead:
INTEL_FAM6_HASWELL_X
INTEL_FAM6_BROADWELL_X
INTEL_FAM6_SKYLAKE_X

Thanks,

Jae
