From: guohanjun@huawei.com (Hanjun Guo)
Date: Wed, 27 Jan 2016 14:20:11 +0800
Subject: [PATCH v3 08/12] arm64, numa: rework numa_add_memblk()
In-Reply-To: <20160125093429.GD24726@rric.localdomain>
References: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
 <1453541967-3744-9-git-send-email-guohanjun@huawei.com>
 <20160125093429.GD24726@rric.localdomain>
Message-ID: <56A8619B.9010602@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/1/25 17:34, Robert Richter wrote:
> On 23.01.16 17:39:23, Hanjun Guo wrote:
>> Rework numa_add_memblk() to update the parameter "u64 size"
>> to "u64 end", this will make it consistent with x86 and
>> can simplify the code later.
>> --- a/arch/arm64/kernel/of_numa.c
>> +++ b/arch/arm64/kernel/of_numa.c
>> @@ -168,7 +168,7 @@ static int __init early_init_parse_memory_node(unsigned long node)
>>  		pr_debug("NUMA-DT:  base = %llx , node = %u\n",
>>  				base, nid);
>>  
>> -		if (numa_add_memblk(nid, base, size) < 0)
>> +		if (numa_add_memblk(nid, base, base + size) < 0)
> The overall function usage looks more like as it should use size
> instead of end. Even in the x86 implementation end is calculated from
> base + size. So better change x86 code to use size instead.
>
> Though this might involve to change the interface for
> numa_add_memblk_to() for unifcation too.
>

This should be a minor one, I'm fine with both directions, I will
stay for a few days to get more review comments, if no objections,
I will update.

Thanks
Hanjun
