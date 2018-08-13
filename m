From: jianxin.pan@amlogic.com (Jianxin Pan)
Date: Mon, 13 Aug 2018 19:57:53 +0800
Subject: [PATCH v2 2/2] arm64: dts: meson-g12a: add initial g12a s905d2
 SoC DT support
In-Reply-To: <97a8213c1dd3a22b4f98c959d4a2c2bfbd432e9d.camel@baylibre.com>
References: <1534160901-22889-1-git-send-email-jianxin.pan@amlogic.com>
 <1534160901-22889-3-git-send-email-jianxin.pan@amlogic.com>
 <97a8213c1dd3a22b4f98c959d4a2c2bfbd432e9d.camel@baylibre.com>
Message-ID: <5f35952e-38de-4c4f-0a3f-42ff0ffab46f@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/13/2018 7:52 PM, Jerome Brunet wrote:
> On Mon, 2018-08-13 at 19:48 +0800, Jianxin Pan wrote:
>> Try to add basic DT support for the Amlogic's Meson-G12A S905D2 SoC,
>> which describe components as follows: Reserve Memory, CPU, GIC, IRQ,
>> Timer, UART. It's capable of booting up into the serial console.
>>
>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/Makefile            |   1 +
>>  arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts |  22 +++
>>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi     | 172 ++++++++++++++++++++++++
>>  3 files changed, 195 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
>>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>>
>> +
>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupts = <GIC_PPI 13
>> +			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 14
>> +			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 11
>> +			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 10
>> +			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>;
>> +	};
> 
> t* should be after s*
OK, I will fix it. Thanks for your review
> 
>> +
>> +	soc {
>> +		compatible = "simple-bus";
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
> 
> .
> 
