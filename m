From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 16 Jul 2018 15:33:30 +0200
Subject: [PATCH v2 1/6] dt-bindings: gpu: mali-utgard: add
 mediatek,mt7623-mali compatible
In-Reply-To: <1530089565.29697.35.camel@mtkswgap22>
References: <cover.1524816502.git.sean.wang@mediatek.com>
 <7ab060c2e9ef2b220fc62913b8936b706dfaf202.1524816502.git.sean.wang@mediatek.com>
 <3bd6e509-f99a-1f2d-1b66-65c414bacdbd@gmail.com>
 <1530089565.29697.35.camel@mtkswgap22>
Message-ID: <434aae44-d289-6683-9395-cb5711cd4b71@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 27/06/18 10:52, Sean Wang wrote:
> On Mon, 2018-06-25 at 17:14 +0200, Matthias Brugger wrote:
>>
>> On 27/04/18 10:14, sean.wang at mediatek.com wrote:
>>> From: Sean Wang <sean.wang@mediatek.com>
>>>
>>> The MediaTek MT7623 SoC contains a Mali-450, so add a compatible for it
>>> and define its own vendor-specific properties.
>>>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>>> ---
>>
>> Hi Rob,
>>
>> Any comments regarding this patch?
>>
>> Regards,
>> Matthias
>>
> 
> Hi, Matthias
> 
> I've already got a Reviewed-by tag from Rob.
> 
> Is it possible that this patch go through your tree ?
> 

Basically yes, I just want to get the mmsys problem fixed first.
Sorry I know it is on my plate. I'll try to send a new version this week.

Regards,
Matthias

> 	Sean
> 
>>>  Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
>>> index 99d1c0a..656068f 100644
>>> --- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
>>> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
>>> @@ -19,6 +19,7 @@ Required properties:
>>>        + rockchip,rk3228-mali
>>>        + rockchip,rk3328-mali
>>>        + stericsson,db8500-mali
>>> +      + mediatek,mt7623-mali
>>>  
>>>    - reg: Physical base address and length of the GPU registers
>>>  
>>> @@ -89,6 +90,14 @@ to specify one more vendor-specific compatible, among:
>>>        * interrupt-names and interrupts:
>>>          + combined: combined interrupt of all of the above lines
>>>  
>>> +  - mediatek,mt7623-mali
>>> +     Required properties:
>>> +      * resets: phandle to the reset line for the GPU
>>> +      * mediatek,larb: phandle pointed to the local arbiter used to control the
>>> +	access to external memory on the SoC.
>>> +	see Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
>>> +	for details
>>> +
>>>  Example:
>>>  
>>>  mali: gpu at 1c40000 {
>>>
> 
> 
