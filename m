From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 5 Jan 2018 21:11:12 +0800
Subject: [PATCH 1/6] ARM64: dts: meson-axg: uart: drop legacy compatible
 name from EE UART
In-Reply-To: <1515148228.5048.25.camel@baylibre.com>
References: <20180105095621.196472-1-yixun.lan@amlogic.com>
 <20180105095621.196472-2-yixun.lan@amlogic.com>
 <1515148228.5048.25.camel@baylibre.com>
Message-ID: <9463e936-922b-b9ed-69c2-06cee127b2c1@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/2018 06:30 PM, Jerome Brunet wrote:
> On Fri, 2018-01-05 at 17:56 +0800, Yixun Lan wrote:
>> For the UART controller in EE domain, they require 'pclk' to work.
> 
> they ? "the driver" maybe ?
> 
>> Current logic of the code will force to go for legacy clock probe
>> if it found current compatible string match to 'amlogic,meson-ao-uart'.
> 
> did you mean "amlogic,meson-uart" instead ?
> 
good catch! it's "amlogic,meson-uart"


> Apart from that
> 
> Acked-by: Jerome Brunet <jbrunet@baylibre.com>
> 
>>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> index e2b8a9c8bf0b..1c6002b3fe34 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> @@ -142,14 +142,14 @@
>>  			};
>>  
>>  			uart_A: serial at 24000 {
>> -				compatible = "amlogic,meson-gx-uart", "amlogic,meson-uart";
>> +				compatible = "amlogic,meson-gx-uart";
>>  				reg = <0x0 0x24000 0x0 0x14>;
>>  				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
>>  				status = "disabled";
>>  			};
>>  
>>  			uart_B: serial at 23000 {
>> -				compatible = "amlogic,meson-gx-uart", "amlogic,meson-uart";
>> +				compatible = "amlogic,meson-gx-uart";
>>  				reg = <0x0 0x23000 0x0 0x14>;
>>  				interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>;
>>  				status = "disabled";
> 
> .
> 
