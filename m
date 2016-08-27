From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Sat, 27 Aug 2016 18:29:28 +0800
Subject: [PATCH v7 10/14] arm64/numa: define numa_distance as array to
 simplify code
In-Reply-To: <20160826152915.GH30302@arm.com>
References: <1472024693-12912-1-git-send-email-thunder.leizhen@huawei.com>
 <1472024693-12912-11-git-send-email-thunder.leizhen@huawei.com>
 <20160826152915.GH30302@arm.com>
Message-ID: <57C16B88.7080500@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/8/26 23:29, Will Deacon wrote:
> On Wed, Aug 24, 2016 at 03:44:49PM +0800, Zhen Lei wrote:
>> 1. MAX_NUMNODES is base on CONFIG_NODES_SHIFT, the default value of the
>>    latter is very small now.
>> 2. Suppose the default value of MAX_NUMNODES is enlarged to 64, so the
>>    size of numa_distance is 4K, it's still acceptable if run the Image
>>    on other processors.
>> 3. It will make function __node_distance quicker than before.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  arch/arm64/include/asm/numa.h |  1 -
>>  arch/arm64/mm/numa.c          | 74 +++----------------------------------------
>>  2 files changed, 5 insertions(+), 70 deletions(-)
> 
> I fail to see the advantages of this patch. Do you have some compelling
> performance figures or something?

We can only put numa_distance_cnt on one node, so for the cpus of other nodes to access it should
spend more time. I have not tested how many can be improved yet.

I will try to get some data next week.

> 
> Will
> 
> .
> 
