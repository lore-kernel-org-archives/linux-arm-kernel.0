From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Mon, 22 Aug 2016 18:37:58 +0800
Subject: [RFC PATCH v2 1/2] mm/hugetlb: Introduce ARCH_HAS_GIGANTIC_PAGE
In-Reply-To: <20160822080101.GE13596@dhcp22.suse.cz>
References: <1471834603-27053-1-git-send-email-xieyisheng1@huawei.com>
 <1471834603-27053-2-git-send-email-xieyisheng1@huawei.com>
 <20160822080101.GE13596@dhcp22.suse.cz>
Message-ID: <32ed1cea-df4b-a170-2d6f-0a4e05ee8405@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/8/22 16:01, Michal Hocko wrote:
> On Mon 22-08-16 10:56:42, Xie Yisheng wrote:
>>  
>> +config ARCH_HAS_GIGANTIC_PAGE
>> +	depends on HUGETLB_PAGE
>> +	bool
>> +
> 
> but is this really necessary? The code where we use
> ARCH_HAS_GIGANTIC_PAGE already depends on HUGETLB_PAGE.
> 
Hi Michal,
Thank you for your reply.
That right, it's no need to depends on HUGETLB_PAGE here.

I will send v3 soon.

Thanks
Xie Yisheng
> Other than that looks good to me and a nice simplification.
> 
>>  source "fs/configfs/Kconfig"
>>  source "fs/efivarfs/Kconfig"
>>  
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 87e11d8..8488dcc 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1022,7 +1022,7 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
>>  		((node = hstate_next_node_to_free(hs, mask)) || 1);	\
>>  		nr_nodes--)
>>  
>> -#if (defined(CONFIG_X86_64) || defined(CONFIG_S390)) && \
>> +#if defined(CONFIG_ARCH_HAS_GIGANTIC_PAGE) && \
>>  	((defined(CONFIG_MEMORY_ISOLATION) && defined(CONFIG_COMPACTION)) || \
>>  	defined(CONFIG_CMA))
>>  static void destroy_compound_gigantic_page(struct page *page,
>> -- 
>> 1.7.12.4
> 
