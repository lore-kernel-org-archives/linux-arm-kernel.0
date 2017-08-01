From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 1 Aug 2017 14:46:28 +0200
Subject: [PATCH v5 2/2] arm64: dts: Add Mediatek SoC MT2712 and evaluation
 board dts and Makefile
In-Reply-To: <1501577481.32089.3.camel@mtksdaap41>
References: <1501241835-47849-1-git-send-email-yt.shen@mediatek.com>
 <1501241835-47849-3-git-send-email-yt.shen@mediatek.com>
 <1501577481.32089.3.camel@mtksdaap41>
Message-ID: <85f5d713-a599-e4cc-f1b4-2e0dedf2797f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/01/2017 10:51 AM, Yingjoe Chen wrote:
> On Fri, 2017-07-28 at 19:37 +0800, YT Shen wrote:
>> diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
>> new file mode 100644
>> index 0000000..1e135af
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> 
> <...>
> 
>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupt-parent = <&gic>;
>> +		interrupts = <GIC_PPI 13
>> +			      (GIC_CPU_MASK_RAW(0x13) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 14
>> +			      (GIC_CPU_MASK_RAW(0x13) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 11
>> +			      (GIC_CPU_MASK_RAW(0x13) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 10
>> +			      (GIC_CPU_MASK_RAW(0x13) | IRQ_TYPE_LEVEL_LOW)>;
>> +	};
>> +
>> +	soc {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		compatible = "simple-bus";
>> +		ranges;
> 
> Matthias,
> 
> I notice this have soc node.
> Do we need to get rid of it?
> 

Good catch. Yes please get rid of it. We should avoid artificial bus nodes. As 
soc is no real bus, we should get rid of it.

Thanks,
Matthias
