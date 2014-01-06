From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Mon, 06 Jan 2014 22:17:32 +0100
Subject: [PATCH v5 3/4] ARM: BCM5301X: add dts files for BCM4708 SoC
In-Reply-To: <20140106020023.52f28c76@skate>
References: <1388965601-18329-1-git-send-email-hauke@hauke-m.de>	<1388965601-18329-4-git-send-email-hauke@hauke-m.de>
 <20140106020023.52f28c76@skate>
Message-ID: <52CB1D6C.9040303@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/2014 02:00 AM, Thomas Petazzoni wrote:
> Dear Hauke Mehrtens,
> 
> On Mon,  6 Jan 2014 00:46:40 +0100, Hauke Mehrtens wrote:
> 
>> +	uart at 18000300 {
>> +		compatible = "ns16550";
>> +		reg = <0x18000300 0x100>;
>> +		interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
>> +		clock-frequency = <100000000>;
>> +	};
>> +
>> +	uart at 18000400 {
>> +		compatible = "ns16550";
>> +		reg = <0x18000400 0x100>;
>> +		interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
>> +		clock-frequency = <100000000>;
>> +	};
>> +
>> +	scu at 19020000 {
>> +		compatible = "arm,cortex-a9-scu";
>> +		reg = <0x19020000 0x100>;
>> +	};
>> +
>> +	timer at 19020200 {
>> +		compatible = "arm,cortex-a9-global-timer";
>> +		reg = <0x19020200 0x100>;
>> +		interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
>> +		clocks = <&clk_periph>;
>> +	};
>> +
>> +	local-timer at 19020600 {
>> +		compatible = "arm,cortex-a9-twd-timer";
>> +		reg = <0x19020600 0x100>;
>> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
>> +		clocks = <&clk_periph>;
>> +	};
>> +
>> +	gic: interrupt-controller at 19021000 {
>> +		compatible = "arm,cortex-a9-gic";
>> +		#interrupt-cells = <3>;
>> +		#address-cells = <0>;
>> +		interrupt-controller;
>> +		reg = <0x19021000 0x1000>,
>> +		      <0x19020100 0x100>;
>> +	};
>> +
>> +	L2: cache-controller at 19022000 {
>> +		compatible = "arm,pl310-cache";
>> +		reg = <0x19022000 0x1000>;
>> +		cache-unified;
>> +		cache-level = <2>;
>> +	};
> 
> I don't know if that has been discussed before, but most of the DTS
> group the internal SoC peripherals in some top-level node that
> represents the internal bus (or busses) of the SoC, like:
> 
> 	<some bus name> {
> 		uart at ... {
> 			...
> 		};
> 
> 		gic at ... {
> 			...
> 		};
> 	};
> 
> This allows to have the in-SoC peripherals cleanly separated from other
> things in the DTS. It would also you to use a ranges = <...> property
> to do an address translation on this bus, and replace the absolute
> addresses for each of the peripherals by offsets relative to the base
> address of where all peripherals are mapped.
> 
> That said, having this top-level node is most likely not a requirement,
> so my comment is mainly meant to open the discussion. I'm sure Arnd
> will give his opinion on this :)
> 

I spited it up like it was done for the rockchip SoCs.
One dtsi file for a line of SoCs, one for the specific SoC and one for
the device. How does this ranges stuff work, do you have an example for me?

Hauke
