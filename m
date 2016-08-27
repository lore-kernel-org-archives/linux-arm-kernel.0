From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Sat, 27 Aug 2016 18:44:39 +0800
Subject: [PATCH v7 14/14] Documentation: remove the constraint on the
 distances of node pairs
In-Reply-To: <20160826153550.GI30302@arm.com>
References: <1472024693-12912-1-git-send-email-thunder.leizhen@huawei.com>
 <1472024693-12912-15-git-send-email-thunder.leizhen@huawei.com>
 <20160826153550.GI30302@arm.com>
Message-ID: <57C16F17.5070609@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/8/26 23:35, Will Deacon wrote:
> On Wed, Aug 24, 2016 at 03:44:53PM +0800, Zhen Lei wrote:
>> Update documentation. This limit is unneccessary.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
>>  Documentation/devicetree/bindings/numa.txt | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
>> index 21b3505..c0ea4a7 100644
>> --- a/Documentation/devicetree/bindings/numa.txt
>> +++ b/Documentation/devicetree/bindings/numa.txt
>> @@ -48,7 +48,6 @@ distance (memory latency) between all numa nodes.
>>
>>    Note:
>>  	1. Each entry represents distance from first node to second node.
>> -	The distances are equal in either direction.
> 
> Hmm, so what happens now if firmware provides a description where both
> distances (in either direction) are supplied, but are different?
I have not known any hardware that the distances of two direction are different yet, but:
1. software have no need to limit the distances of two direction must be equal.
2. suppose below software scenario:
   1) cpu0 and cpu1 belong to the same hardware node.
   2) cpu0 is a master control CPU, many tasks and interrupts deliver to cpu0 first. So cpu0 often busy than cpu1.
   3) we split cpu0 and cpu1 into two logical nodes, cpu0 belongs to node0, cpu1 belong to node1. Now, we make
      the distance from cpu0 to cpu1 larger than the distance from cpu1 to cpu0.

> 
> Will
> 
> .
> 
