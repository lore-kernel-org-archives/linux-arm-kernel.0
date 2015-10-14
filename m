From: djkurtz@chromium.org (Daniel Kurtz)
Date: Wed, 14 Oct 2015 09:07:49 +0800
Subject: [PATCH v4 3/3] arm64: dts: mt8173: Add nor flash node
In-Reply-To: <561D1642.3070105@cogentembedded.com>
References: <1444729160-26433-1-git-send-email-bayi.cheng@mediatek.com>
 <1444729160-26433-4-git-send-email-bayi.cheng@mediatek.com>
 <561D1642.3070105@cogentembedded.com>
Message-ID: <CAGS+omDm=74d6cw7kXwkZ_Jy-faBz7z4-vJQX9ZFVNskQqSS-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei,

On Tue, Oct 13, 2015 at 10:33 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
> On 10/13/2015 12:39 PM, Bayi Cheng wrote:
>
>> Add Mediatek nor flash node
>>
>> Signed-off-by: Bayi Cheng <bayi.cheng@mediatek.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8173.dtsi | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> index d18ee42..385c2e4 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> @@ -365,6 +365,21 @@
>>                         status = "disabled";
>>                 };
>>
>> +               nor_flash: spi at 1100d000 {
>
>
>    I don't think this is a good label name for a SPI controller.

You think "spi" is not a good name for SPI controller?
Or you mean the label "nor_flash"?

Would you prefer:

  spi_nor_flash: spi at 1100d000


>
>> +                       compatible = "mediatek,mt8173-nor";
>> +                       reg = <0 0x1100d000 0 0xe0>;
>> +                       clocks = <&pericfg CLK_PERI_SPI>,
>> +                                <&topckgen CLK_TOP_SPINFI_IFR_SEL>;
>> +                       clock-names = "spi", "sf";
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +
>> +                       flash at 0 {
>> +                               compatible = "jedec,spi-nor";
>> +                               reg = <0>;
>> +                       };
>> +               };
>> +
>>                 i2c3: i2c3 at 11010000 {
>
>
>    Grr, the name should be "i2c at 11010000".

Don't worry.  This is already fixed in Matthias' tree:
  https://github.com/mbgg/linux-mediatek/commit/1ee35c05d9c67771d649f687e6f76e61e76eb779

-Dan

>
> [...]
>
> MBR, Sergei
>
