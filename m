From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Wed, 31 Aug 2016 10:46:30 +0800
Subject: [PATCH v7 14/14] Documentation: remove the constraint on the
 distances of node pairs
In-Reply-To: <20160830175517.GM24906@arm.com>
References: <1472024693-12912-1-git-send-email-thunder.leizhen@huawei.com>
 <1472024693-12912-15-git-send-email-thunder.leizhen@huawei.com>
 <20160826153550.GI30302@arm.com> <57C16F17.5070609@huawei.com>
 <20160830175517.GM24906@arm.com>
Message-ID: <57C64506.4070605@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/8/31 1:55, Will Deacon wrote:
> On Sat, Aug 27, 2016 at 06:44:39PM +0800, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2016/8/26 23:35, Will Deacon wrote:
>>> On Wed, Aug 24, 2016 at 03:44:53PM +0800, Zhen Lei wrote:
>>>> Update documentation. This limit is unneccessary.
>>>>
>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>> Acked-by: Rob Herring <robh@kernel.org>
>>>> ---
>>>>  Documentation/devicetree/bindings/numa.txt | 1 -
>>>>  1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
>>>> index 21b3505..c0ea4a7 100644
>>>> --- a/Documentation/devicetree/bindings/numa.txt
>>>> +++ b/Documentation/devicetree/bindings/numa.txt
>>>> @@ -48,7 +48,6 @@ distance (memory latency) between all numa nodes.
>>>>
>>>>    Note:
>>>>  	1. Each entry represents distance from first node to second node.
>>>> -	The distances are equal in either direction.
>>>
>>> Hmm, so what happens now if firmware provides a description where both
>>> distances (in either direction) are supplied, but are different?
>> I have not known any hardware that the distances of two direction are
>> different yet
> 
> Then let's not add support for this just yet. When we have systems that
> actually need it, we'll be in a much better position to assess the
> suitability of any patches. At the moment, the whole thing is pretty
> questionable and it adds needless complication to the code.
How about I changed to:
To simplify the configuration, the distance of the opposite direction is the same to it by default.

> 
> Will
> 
> .
> 
