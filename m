From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Tue, 21 Oct 2014 01:53:30 +0000
Subject: [PATCHv5 1/6] ARM: dts: Add SoC level device tree support for
 LS1021A
In-Reply-To: <20141019013701.GC7869@tiger>
References: <1413192963-11153-1-git-send-email-jingchang.lu@freescale.com>
 <1413192963-11153-2-git-send-email-jingchang.lu@freescale.com>
 <20141019013701.GC7869@tiger>
Message-ID: <da1e5200fc1f44e2b32d3c81beee168d@BL2PR03MB467.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>-----Original Message-----
>From: Shawn Guo [mailto:shawn.guo at linaro.org]
>Sent: Sunday, October 19, 2014 9:37 AM
>To: Lu Jingchang-B35083
>Cc: arnd at arndb.de; mark.rutland at arm.com; linux-arm-
>kernel at lists.infradead.org; devicetree at vger.kernel.org; Lu Jingchang-
>B35083; Badola Nikhil-B46172; Zhao Chenhui-B35336; Gupta Suresh-B42813;
>Leekha Shaveta-B20052; Gupta Ruchika-R66431; Sharma Bhupesh-B45370; Fu
>Chao-B44548; Xiubo Li-B47053
>Subject: Re: [PATCHv5 1/6] ARM: dts: Add SoC level device tree support for
>LS1021A
>
>On Mon, Oct 13, 2014 at 05:35:58PM +0800, Jingchang Lu wrote:
>> +/ {
>> +	compatible = "fsl,ls1021a";
>> +	interrupt-parent = <&gic>;
>> +
>> +	aliases {
>> +		serial0 = &lpuart0;
>> +		serial1 = &lpuart1;
>> +		serial2 = &lpuart2;
>> +		serial3 = &lpuart3;
>> +		serial4 = &lpuart4;
>> +		serial5 = &lpuart5;
>> +		sysclk = &sysclk;
>
>What is this sysclk aliase used for?
The sysclk alias is used by dtb fixup stage in u-boot to set the proper clk frequency
for its configurable. The sysclk is compatible to "fixed-clock" but there may be more
than one "fixed-clock" source and only the sysclk is desired, so an alias is add to
located it exclusively. Thanks.

>
>> +		};
>
>Bad indent.
>
>> +
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		cpu at f00 {
>> +			compatible = "arm,cortex-a7";
>> +			device_type = "cpu";
>> +			reg = <0xf00>;
>> +		};
>> +
>> +		cpu at f01 {
>> +			compatible = "arm,cortex-a7";
>> +			device_type = "cpu";
>> +			reg = <0xf01>;
>> +		};
>> +	};
>> +
>> +	timer {
>> +		compatible = "arm,armv7-timer";
>> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
>IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) |
>IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) |
>IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) |
>IRQ_TYPE_LEVEL_LOW)>;
>
>I like this indent style ...
>
>> +	};
>> +
>> +	pmu {
>> +		compatible = "arm,cortex-a7-pmu";
>> +		interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
>> +				<GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
>
>... not this style.  Please fix such indents through the file.

I will, thanks.

Best Regards,
Jingchang

>
>> +	};
>
>Shawn
