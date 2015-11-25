From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 25 Nov 2015 13:31:14 +0100
Subject: [PATCH v8 2/2] arm64: dts: mt8173: Add nor flash node
In-Reply-To: <1448449042.24527.0.camel@mtksdaap41>
References: <1447817403-16631-1-git-send-email-bayi.cheng@mediatek.com>
 <1447817403-16631-3-git-send-email-bayi.cheng@mediatek.com>
 <56559274.1090900@gmail.com> <1448449042.24527.0.camel@mtksdaap41>
Message-ID: <5655AA12.4070903@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/11/15 11:57, Yingjoe Chen wrote:
> On Wed, 2015-11-25 at 11:50 +0100, Matthias Brugger wrote:
>>
>> On 18/11/15 04:30, Bayi Cheng wrote:
>>> Add Mediatek nor flash node
>>>
>>> Signed-off-by: Bayi Cheng <bayi.cheng@mediatek.com>
>>> Acked-by: Brian Norris <computersforpeace@gmail.com>
>>> ---
>>>    arch/arm64/boot/dts/mediatek/mt8173.dtsi | 18 +++++++++++++++++-
>>>    1 file changed, 17 insertions(+), 1 deletion(-)
>>>
>>
>> Applied to v4.5-next/dts
>>
>> Thanks.
>> Matthias
>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>>> index 4dd5f93..7988656 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>>> @@ -387,7 +387,23 @@
>>>    			status = "disabled";
>>>    		};
>>>
>>> -		i2c3: i2c at 11010000 {
>>> +		nor_flash: spi at 1100d000 {
>>> +			compatible = "mediatek,mt8173-nor";
>>> +			reg = <0 0x1100d000 0 0xe0>;
>>> +			clocks = <&pericfg CLK_PERI_SPI>,
>>> +				 <&topckgen CLK_TOP_SPINFI_IFR_SEL>;
>>> +			clock-names = "spi", "sf";
>>> +			#address-cells = <1>;
>>> +			#size-cells = <0>;
>>> +			status = "disabled";
>>> +
>>> +			flash at 0 {
>>> +				compatible = "jedec,spi-nor";
>>> +				reg = <0>;
>>> +			};
>>> +		};
>>> +
>>> +		i2c3: i2c3 at 11010000 {
>
> Hi Matthias,
>
> Just notice this one. Please make sure this line should be
>
> i2c3: i2c at 11010000 {
>
> instead of
>
> i2c3: i2c3 at 11010000 {
>

Fixed, thanks for catching this.
