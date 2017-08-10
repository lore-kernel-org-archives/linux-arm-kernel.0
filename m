From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu, 10 Aug 2017 21:17:10 +0000
Subject: [RESEND PATCH 2/4] dt-bindings: add "reduced-width" property for
 Armada XP SDRAM controller
References: <20170807014641.4003-1-chris.packham@alliedtelesis.co.nz>
 <20170807014641.4003-3-chris.packham@alliedtelesis.co.nz>
 <20170810203801.jz5hl5onqci275ef@rob-hp-laptop>
Message-ID: <4935472b6a44447fa764fa811a645b9f@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/17 08:38, Rob Herring wrote:
> On Mon, Aug 07, 2017 at 01:46:39PM +1200, Chris Packham wrote:
>> Some SoC implementations that use this controller have a reduced pin
>> count so the meaning of "full" and "half" with change.
> 
> s/with/width/ ?
> 

Yes will include in v2.

>>
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> ---
>>   .../bindings/memory-controllers/mvebu-sdram-controller.txt          | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt b/Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt
>> index 89657d1d4cd4..3041868321c8 100644
>> --- a/Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt
>> +++ b/Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt
>> @@ -13,6 +13,12 @@ Required properties:
>>    - reg: a resource specifier for the register space, which should
>>      include all SDRAM controller registers as per the datasheet.
>>   
>> +Optional properties:
>> + - marvell,reduced-width: some SoCs that use this SDRAM controller have
>> +   a reduced pin count. On such systems "full" width is 32-bits and
>> +   "half" width is 16-bits. Set this property to indicate that the SoC
>> +   used is such a system.
> 
> Maybe you should just state what the width is.


Specifying a number like 64/32/16 is done in for some other properties I 
dismissed that because what this is about how we interpret a 
pin-strapping option. I guess "max-width = <64>;" and "max-width = 
<32>"; would achieve the same.


> Or your compatible string should just be specific enough to know the
> width.

I decided against a new compatible sting that because the IP block 
really is the Armada-XP one and the existing compatible string is used 
in other places (using multiple compatible strings would solve that).

I'm not too fussed which of the 3 options are used. Is there any 
particular preference?
