From: punit.agrawal@arm.com (Punit Agrawal)
Date: Thu, 15 Aug 2013 11:09:04 +0100
Subject: [PATCH] drivers: CCI: add ARM CCI PMU support
In-Reply-To: <ABE5FFA6-8709-4E8F-A726-27C1154157F0@codeaurora.org>
References: <1374571176-11584-1-git-send-email-punit.agrawal@arm.com>
 <520BF152.1020704@wwwdotorg.org>
 <56FE58B8-1619-4CDF-A5E6-89CE6F51E96C@codeaurora.org>
 <520BF2E1.8070805@wwwdotorg.org>
 <ABE5FFA6-8709-4E8F-A726-27C1154157F0@codeaurora.org>
Message-ID: <520CA8C0.4080008@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/08/13 22:16, Kumar Gala wrote:
>
> On Aug 14, 2013, at 4:13 PM, Stephen Warren wrote:
>
>> On 08/14/2013 03:09 PM, Kumar Gala wrote:
>>>
>>> On Aug 14, 2013, at 4:06 PM, Stephen Warren wrote:
>>>
>>>> On 07/23/2013 03:19 AM, Punit Agrawal wrote:
>>>>> The CCI PMU can profile bus transactions at the master and slave
>>>>> interfaces of the CCI. The PMU can be used to observe an aggregated view
>>>>> of the bus traffic between the various components connected to the CCI.
>>>>>
>>>>> Extend the existing CCI driver to support the PMU by registering a perf
>>>>> backend for it.
>>>>>
>>>>> Document the device tree binding to describe the CCI PMU.
>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/arm/cci.txt b/Documentation/devicetree/bindings/arm/cci.txt
>>>>
>>>>> +	- CCI PMU node
>>>>> +
>>>>> +		Node name must be "pmu".
>>>>
>>>> I don't think the binding should require the node to have a particular
>>>> name; node names shouldn't be interpret/used/relied-upon by drivers.
>>>
>>> While I agree with that, we should be aiming for some convention and consistency with node names.
>>
>> Sure. Should there be a Documentation/devictree/bindings/node-names that
>> lists common node names for people to use? Either way though, I still
>> think this is an aspect of authoring the *.dts file, not an aspect of
>> the DT binding? After all, what if there were more than one CCI so they
>> needed to be named pmu at 0, pmu at 1, etc.?
>
> Agreed, I was thinking a bindings/node-names would be a good idea.
>
> I'm guessing 99% of people copy either from the example in the binding of an existing .dts file.  So while I agree the binding shouldn't require a node name be a specific thing as part of the spec, we as reviewers should try to ensure consistency in examples or .dts files.
>

Based on the comments so far, I will change the bindings documentation 
submitted with this patch to remove the requirement for a particular 
node name for CCI PMU.

As it is, this is not required by the driver but was only done for 
consistency.

Cheers,
Punit

> - k
>
