From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 08 Aug 2013 16:48:53 -0600
Subject: [PATCH 1/2] ARM: Exynos: replace custom MFC reserved memory
 handling with generic code
In-Reply-To: <6170882.dm214gAmhr@flatron>
References: <1375705610-12724-1-git-send-email-m.szyprowski@samsung.com>
 <1421964.5VNJUTGkrX@flatron> <520411E7.4070708@wwwdotorg.org>
 <6170882.dm214gAmhr@flatron>
Message-ID: <52042055.6020403@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2013 04:10 PM, Tomasz Figa wrote:
> On Thursday 08 of August 2013 15:47:19 Stephen Warren wrote:
>> On 08/08/2013 03:19 PM, Tomasz Figa wrote:
>>> On Thursday 08 of August 2013 15:00:52 Stephen Warren wrote:
>>>> On 08/05/2013 06:26 AM, Marek Szyprowski wrote:
>>>>> MFC driver use custom bindings for managing reserved memory. Those
>>>>> bindings are not really specific to MFC device and no even well
>>>>> discussed. They can be easily replaced with generic, platform
>>>>> independent code for handling reserved and contiguous memory.
>>>>>
>>>>> Two additional child devices for each memory port (AXI master) are
>>>>> introduced to let one assign some properties to each of them. Later
>>>>> one
>>>>> can also use them to assign properties related to SYSMMU
>>>>> controllers,
>>>>> which can be used to manage the limited dma window provided by those
>>>>> memory ports.
...
>>>>> +Two child nodes must be defined for MFC device. Their names must be
>>>>> +following: "memport-r" and "memport-l" ("right" and "left").
>>>>> Required
>>>>
>>>> Node names shouldn't have semantic meaning.
>>>
>>> What about bus-master-0 and bus-master-1?
>>
>> Just "bus-master" for each might make sense. Use reg properties to
>> differentiate the two?
> 
> What this reg property would mean in this case?
> 
> My understanding of reg property was that it should be used for real 
> addresses or IDs and for all other cases node names should be suffixed 
> with "-ID".

Presumably it would hold the ID of the HW block as defined in the
documentation. Or, it could be somewhat arbitrary.
