From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 5 Jan 2018 21:43:41 +0800
Subject: [PATCH 2/6] ARM64: dts: meson-axg: uart: fix address space range
In-Reply-To: <1515148207.5048.24.camel@baylibre.com>
References: <20180105095621.196472-1-yixun.lan@amlogic.com>
 <20180105095621.196472-3-yixun.lan@amlogic.com>
 <1515148207.5048.24.camel@baylibre.com>
Message-ID: <45074e93-c8ec-d0d1-13d9-fbd2fab07a7a@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/2018 06:30 PM, Jerome Brunet wrote:
> On Fri, 2018-01-05 at 17:56 +0800, Yixun Lan wrote:
>> The address space range is actually 0x18, fixed here.
> 
> Isn't it the same for other meson SoC ? If they are compatible, it should.
> Could you please re-submit this change addressing all the required platforms ?
> 

sure

sorry, I was in hurry to send the patch set without do a full tree check..

you right, the fix should also apply to other SoCs, I will fold them
into this patch together, thanks for raising the idea.



>>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> index 1c6002b3fe34..9636a7c5f6ed 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> @@ -143,14 +143,14 @@
>>  
>>  			uart_A: serial at 24000 {
>>  				compatible = "amlogic,meson-gx-uart";
>> -				reg = <0x0 0x24000 0x0 0x14>;
>> +				reg = <0x0 0x24000 0x0 0x18>;
>>  				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
>>  				status = "disabled";
>>  			};
>>  
>>  			uart_B: serial at 23000 {
>>  				compatible = "amlogic,meson-gx-uart";
>> -				reg = <0x0 0x23000 0x0 0x14>;
>> +				reg = <0x0 0x23000 0x0 0x18>;
>>  				interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>;
>>  				status = "disabled";
>>  			};
> 
> .
> 
