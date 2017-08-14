From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 14 Aug 2017 13:23:52 +0200
Subject: [PATCH 3/4] dt-bindings: mt8173-mtu3: add generic compatible and
 rename file
In-Reply-To: <1502434819.25536.125.camel@mhfsdcap03>
References: <8f0cb0047b2aa195d818ad686cbbceabb3ad91a0.1502170518.git.chunfeng.yun@mediatek.com>
 <121eaec8845c62383701d4fdfe9649335937f025.1502170518.git.chunfeng.yun@mediatek.com>
 <20170811025410.65jvjmji4gfnmm6l@rob-hp-laptop>
 <1502434819.25536.125.camel@mhfsdcap03>
Message-ID: <3623aff5-ec37-3209-f6d7-9eaf17096afa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/11/2017 09:00 AM, Chunfeng Yun wrote:
> On Thu, 2017-08-10 at 21:54 -0500, Rob Herring wrote:
>> On Tue, Aug 08, 2017 at 01:42:51PM +0800, Chunfeng Yun wrote:
>>> The mt8173-mtu3.txt actually holds the bindings for all mediatek
>>> SoCs with usb3 DRD IP, so add a generic compatible and change the
>>> name to mtu3.txt.
>>>
>>> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>>> ---
>>>   .../bindings/usb/{mt8173-mtu3.txt => mtu3.txt}     |    6 ++++--
>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>>   rename Documentation/devicetree/bindings/usb/{mt8173-mtu3.txt => mtu3.txt} (95%)
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/mt8173-mtu3.txt b/Documentation/devicetree/bindings/usb/mtu3.txt
>>> similarity index 95%
>>> rename from Documentation/devicetree/bindings/usb/mt8173-mtu3.txt
>>> rename to Documentation/devicetree/bindings/usb/mtu3.txt
>>> index 1d7c3bc..832741d 100644
>>> --- a/Documentation/devicetree/bindings/usb/mt8173-mtu3.txt
>>> +++ b/Documentation/devicetree/bindings/usb/mtu3.txt
>>
>> mediatek,mtu3.txt
> Ok
>>
>>> @@ -1,7 +1,9 @@
>>>   The device node for Mediatek USB3.0 DRD controller
>>>   
>>>   Required properties:
>>> - - compatible : should be "mediatek,mt8173-mtu3"
>>> + - compatible : should be one of
>>> +	"mediatek,mt8173-mtu3" (deprecated, use "mediatek,mtu3" instead),
>>
>> NAK. You can add generic compatibles, but you need SoC specific ones in
>> addition.
> It's for backward compatibility
> 

I think backwards compatibility should be in the driver but not in the binding 
description. Apart from that device tree files will need to provide a SoC 
specific binding apart from the generic one, for example:

"mediatek,mt8173-mtu3", "mediatek,mtu3": for mt8173
"mediatek,mt7623-mtu3", "mediatek,mtu3": for mt6723

This is needed to cover possible bugs/features that can be found in the future 
for a specific SoC. The driver can match just against the generic binding and 
will only implement a match against the SoC specific one if a bug/feature is 
present.

Makes sense?

Regards,
Matthias
