From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 4 Dec 2015 17:22:39 +0100
Subject: [PATCH v8 2/2] arm64: dts: mt8173: Add nor flash node
In-Reply-To: <1448505773.9118.19.camel@mhfsdcap03>
References: <1447817403-16631-1-git-send-email-bayi.cheng@mediatek.com>
 <1447817403-16631-3-git-send-email-bayi.cheng@mediatek.com>
 <CAGS+omBVfc=BPLoobOJSDPnbv97PnGsRxUTF1gbXEz4DeufbmQ@mail.gmail.com>
 <1448505773.9118.19.camel@mhfsdcap03>
Message-ID: <5661BDCF.9020105@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26/11/15 03:42, bayi cheng wrote:
> On Thu, 2015-11-26 at 09:20 +0800, Daniel Kurtz wrote:
>> Hi Bayi, Matthias,
>>
>> Sorry for the late review, one comment below...
>>
>> On Wed, Nov 18, 2015 at 11:30 AM, Bayi Cheng <bayi.cheng@mediatek.com> wrote:
>>> Add Mediatek nor flash node
>>>
>>> Signed-off-by: Bayi Cheng <bayi.cheng@mediatek.com>
>>> Acked-by: Brian Norris <computersforpeace@gmail.com>
>>> ---
>>>   arch/arm64/boot/dts/mediatek/mt8173.dtsi | 18 +++++++++++++++++-
>>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>>> index 4dd5f93..7988656 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>>> @@ -387,7 +387,23 @@
>>>                          status = "disabled";
>>>                  };
>>>
>>> -               i2c3: i2c at 11010000 {
>>> +               nor_flash: spi at 1100d000 {
>>> +                       compatible = "mediatek,mt8173-nor";
>>> +                       reg = <0 0x1100d000 0 0xe0>;
>>> +                       clocks = <&pericfg CLK_PERI_SPI>,
>>> +                                <&topckgen CLK_TOP_SPINFI_IFR_SEL>;
>>> +                       clock-names = "spi", "sf";
>>> +                       #address-cells = <1>;
>>> +                       #size-cells = <0>;
>>> +                       status = "disabled";
>>> +
>>> +                       flash at 0 {
>>> +                               compatible = "jedec,spi-nor";
>>> +                               reg = <0>;
>>> +                       };
>>
>> I think this flash at 0 node represents the flash device present on the
>> board and should therefore be moved to the board-specific .dts.
>>
>> -Dan
>>

Good catch, thanks.

> Hi Daniel, Thanks for your comments, and I will fixed it in the next
> patch.

Ok, I dropped your patch in the meanwhile.

Regards,
Matthias

>>> +               };
>>> +
>>> +               i2c3: i2c3 at 11010000 {
>>>                          compatible = "mediatek,mt8173-i2c";
>>>                          reg = <0 0x11010000 0 0x70>,
>>>                                <0 0x11000280 0 0x80>;
>>> --
>>> 1.8.1.1.dirty
>>>
>
>
