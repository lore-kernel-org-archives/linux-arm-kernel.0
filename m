From: jacek.anaszewski@gmail.com (Jacek Anaszewski)
Date: Mon, 13 Mar 2017 19:35:42 +0100
Subject: [PATCH v5 2/4] dt-bindings: mfd: Add LED subnode binding for
 MT6323 PMIC
In-Reply-To: <c86eacdb-d5c8-2f0a-11f1-1a3bc623b4b0@gmail.com>
References: <1488549385-19899-1-git-send-email-sean.wang@mediatek.com>
 <1488549385-19899-3-git-send-email-sean.wang@mediatek.com>
 <c86eacdb-d5c8-2f0a-11f1-1a3bc623b4b0@gmail.com>
Message-ID: <d7b7119d-678f-ca91-3a5b-7d56c9071385@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On 03/13/2017 01:00 PM, Matthias Brugger wrote:
> 
> 
> On 03/03/17 14:56, sean.wang at mediatek.com wrote:
>> From: Sean Wang <sean.wang@mediatek.com>
>>
>> This patch adds documentation for devicetree bindings
>> for LED support as the subnode of MT6323 PMIC
>>
>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> ---
>>  Documentation/devicetree/bindings/mfd/mt6397.txt | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt
>> b/Documentation/devicetree/bindings/mfd/mt6397.txt
>> index 949c85f..522a3bb 100644
>> --- a/Documentation/devicetree/bindings/mfd/mt6397.txt
>> +++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
>> @@ -6,6 +6,7 @@ MT6397/MT6323 is a multifunction device with the
>> following sub modules:
>>  - Audio codec
>>  - GPIO
>>  - Clock
>> +- LED
>>
>>  It is interfaced to host controller using SPI interface by a
>> proprietary hardware
>>  called PMIC wrapper or pwrap. MT6397/MT6323 MFD is a child device of
>> pwrap.
>> @@ -34,6 +35,10 @@ Optional subnodes:
>>  - clk
>>      Required properties:
>>          - compatible: "mediatek,mt6397-clk"
>> +- led
>> +    Required properties:
>> +        - compatible: "mediatek,mt6323-led"
>> +    see Documentation/devicetree/bindings/leds/leds-mt6323.txt
> 
> Part of this patch is already part of linux-next:
> 05daab3 ("Documentation: devicetree: Add LED subnode binding for MT6323
> PMIC")

Yes, it's been merged via mfd tree. It doesn't break anything besides
that it points to non-existent file. Hopefully we will manage to merge
the LED part before merge window, otherwise the mfd part will have to
be dropped.

-- 
Best regards,
Jacek Anaszewski
