From: djw@t-chip.com.cn (Levin Du)
Date: Mon, 14 May 2018 09:22:35 +0800
Subject: [PATCH v1 3/5] arm64: dts: rockchip: Add gpio-syscon10 to rk3328
In-Reply-To: <CAL_JsqLK6S0iA=K1o=gpuJAxD6HxCSzHaJ6ZchuCz=GZ-Zb=Dg@mail.gmail.com>
References: <1525943800-14095-1-git-send-email-djw@t-chip.com.cn>
 <1525943800-14095-4-git-send-email-djw@t-chip.com.cn>
 <CAL_JsqLK6S0iA=K1o=gpuJAxD6HxCSzHaJ6ZchuCz=GZ-Zb=Dg@mail.gmail.com>
Message-ID: <5218da3c-40d3-a44f-2b82-13cd4c522a1f@t-chip.com.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2018-05-11 8:22 PM, Rob Herring wrote:
> On Thu, May 10, 2018 at 4:16 AM,  <djw@t-chip.com.cn> wrote:
>> From: Levin Du <djw@t-chip.com.cn>
>>
>> Adding a new gpio controller named "gpio-syscon10" to rk3328, providing
>> access to the pins defined in the syscon GRF_SOC_CON10.
>>
>> Boards using these special pins to control regulators or LEDs, can now
>> utilize existing drivers like gpio-regulator and leds-gpio.
>>
>> Signed-off-by: Levin Du <djw@t-chip.com.cn>
>>
>> ---
>>
>> Changes in v1:
>> - Split from V0 and add to rk3328.dtsi for general use.
>>
>>   arch/arm64/boot/dts/rockchip/rk3328.dtsi | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> index b8e9da1..73a822d 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> @@ -309,6 +309,12 @@
>>                          mode-loader = <BOOT_BL_DOWNLOAD>;
>>                  };
>>
>> +               gpio_syscon10: gpio-syscon10 {
> GPIO controller nodes should be named just 'gpio'.

'gpio' is a general name, and there're already gpio0~gpio3 for pinctrl 
GPIOs.

>> +                       compatible = "rockchip,gpio-syscon";
>> +                       gpio-controller;
>> +                       #gpio-cells = <2>;
>> +                       gpio,syscon-dev = <0 0x0428 0>;
> This property is not documented and takes a phandle.
See PATCH1 which allows fetching syscon from parent node .
This is also documented in 
Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
in PATCH2.

Thanks
Levin
