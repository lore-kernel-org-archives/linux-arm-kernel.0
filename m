From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 28 Jul 2015 09:36:58 +0900
Subject: [PATCH v2] ARM: dts: Add SPI CS on exynos5250-snow
In-Reply-To: <CABxcv=kHgvXgVSzLj=bABqO26r3w7T7ezAUfdh0n4S_N3ZM-Mw@mail.gmail.com>
References: <a5054dfad3d48c582b062b0536125c9bcff41f31.1438027526.git.hramrach@gmail.com>
 <CABxcv=kHgvXgVSzLj=bABqO26r3w7T7ezAUfdh0n4S_N3ZM-Mw@mail.gmail.com>
Message-ID: <55B6CEAA.7050904@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.07.2015 06:24, Javier Martinez Canillas wrote:
> Hello Michal,
> 
> The patch looks good to me, just one small comment below.
> 
> On Mon, Jul 27, 2015 at 10:11 PM, Michal Suchanek <hramrach@gmail.com> wrote:
>> Although there is only one choice of chipselect it is necessary to
>> specify it. The driver cannot claim the gpio otherwise.
>>
>> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
>>
>> --
>> v2
>>  - don't move unrelated line
>> ---
>>  arch/arm/boot/dts/exynos5250-snow.dts | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
>> index b7f4122..62be08a 100644
>> --- a/arch/arm/boot/dts/exynos5250-snow.dts
>> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
>> @@ -688,6 +688,7 @@
>>         status = "okay";
>>         samsung,spi-src-clk = <0>;
>>         num-cs = <1>;
>> +       cs-gpios = <&gpa2 5 0>;
> 
> NIT: this should be GPIO_ACTIVE_HIGH instead of 0 but maybe Kukjin or
> Krzysztof can fixup when applying it?
> 
>>  };
>>
>>  &usbdrd_dwc3 {
>> --
> 
> Acked-by: Javier Martinez Canillas <javier@osg.samsung.com>

Yes, the GPIO_ACTIVE_HIGH would be better. Can you re-spin the patch
with this change and respective Acks? Including mine ack:
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
