From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Aug 2013 16:54:37 -0600
Subject: [PATCH v6 3/4] drivers: of: add initialization code for dma
 reserved memory
In-Reply-To: <3804224.ROD4LeYdVO@flatron>
References: <1376924669-28873-1-git-send-email-m.szyprowski@samsung.com>
 <9906612.JEHkvlBKY1@flatron> <52129BC2.6020804@wwwdotorg.org>
 <3804224.ROD4LeYdVO@flatron>
Message-ID: <5212A22D.7050402@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19/2013 04:40 PM, Tomasz Figa wrote:
> On Monday 19 of August 2013 16:27:14 Stephen Warren wrote:
>> On 08/19/2013 04:24 PM, Tomasz Figa wrote:
>>> On Monday 19 of August 2013 16:17:30 Stephen Warren wrote:
>>>> On 08/19/2013 04:02 PM, Tomasz Figa wrote:
>>>>> Hi Stephen,
>>>>>
>>>>> On Monday 19 of August 2013 15:49:20 Stephen Warren wrote:
>>>>>> On 08/19/2013 09:04 AM, Marek Szyprowski wrote:
>>>>>>> This patch adds device tree support for contiguous and reserved
>>>>>>> memory regions defined in device tree.
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/memory.txt
>>>>>>> b/Documentation/devicetree/bindings/memory.txt
...
>>>> Also, what if a device needs multiple separate memory regions?
>>>> Perhaps a GPU is forced to allocate displayable surfaces from
>>>> addresses 0..32M and textures/off-screen-render-targets from
>>>> 256M..384M or something whacky like that. In that case, we could
>>>> either:
>>>>
>>>> a) Adjust memory.txt to allow multiple entries in memory-regions, and
>>>> add an associated memory-region-names property.
>>>>
>>>> or:
>>>>
>>>> b) Adjust memory.txt not to mention any specific property names, but
>>>> simply mention that other DT nodes can refer to define memory regions
>>>> by phandle, and leave it up to individual bindings to define which
>>>> property they use to reference the memory regions, perhaps with
>>>> memory.txt providing a recommendation of memory-region for the
>>>> simple case, but perhaps also allowing a custom case, e.g.:
>>>>
>>>> display-memory-region = <&phandl1e1>;
>>>> texture-memory-region = <&phahndle2>;
>>>
>>> Well, such setup simply cannot be handled by Linux today, as one
...
>>> I agree that the device tree should be able to describe such
>>> configurations,
...
> Well, if it's just about modifying the binding to support such cases, but 
> without actually adding support for them in Linux, then I guess it's fine. 

Yes. I don't care so much if the SW won't work (yet?), but I want to
make sure the binding isn't going to need semantic changes.
