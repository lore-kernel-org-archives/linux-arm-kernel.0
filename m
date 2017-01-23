From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 23 Jan 2017 10:20:02 +0100
Subject: arm64: dts: mt8173: add node for thermal calibration
In-Reply-To: <CAGS+omA=aip76=8CcGY7gPUrHj9eLLem=8MBziz99fVDq86zPQ@mail.gmail.com>
References: <1484286771-35913-1-git-send-email-dawei.chien@mediatek.com>
 <CAGS+omA=aip76=8CcGY7gPUrHj9eLLem=8MBziz99fVDq86zPQ@mail.gmail.com>
Message-ID: <f33ae1e4-ff12-7468-67e4-5e5b28dd67bb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/13/2017 09:51 AM, Daniel Kurtz wrote:
> On Fri, Jan 13, 2017 at 1:52 PM, Dawei Chien <dawei.chien@mediatek.com> wrote:
>>
>> From: "dawei.chien at mediatek.com" <dawei.chien@mediatek.com>
>>
>> Add this for supporting thermal calibration by e-fuse data.
>>
>> Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
>
> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
>

applied, thanks

>> ---
>>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> index 12e7027..adfac1e 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> @@ -401,6 +401,11 @@
>>                 efuse: efuse at 10206000 {
>>                         compatible = "mediatek,mt8173-efuse";
>>                         reg = <0 0x10206000 0 0x1000>;
>> +                       #address-cells = <1>;
>> +                       #size-cells = <1>;
>> +                       thermal_calibration: calib at 528 {
>> +                               reg = <0x528 0xc>;
>> +                       };
>>                 };
>>
>>                 apmixedsys: clock-controller at 10209000 {
>> @@ -574,6 +579,8 @@
>>                         resets = <&pericfg MT8173_PERI_THERM_SW_RST>;
>>                         mediatek,auxadc = <&auxadc>;
>>                         mediatek,apmixedsys = <&apmixedsys>;
>> +                       nvmem-cells = <&thermal_calibration>;
>> +                       nvmem-cell-names = "calibration-data";
>>                 };
>>
>>                 nor_flash: spi at 1100d000 {
>> --
>> 1.9.1
>>
