From: j-keerthy@ti.com (Keerthy)
Date: Wed, 26 Jul 2017 19:13:12 +0530
Subject: [PATCH v3 2/2] ARM: dts: keystone-k2g-evm: Add gpio nodes
In-Reply-To: <20170726133342.GO31807@n2100.armlinux.org.uk>
References: <1501051524-5990-1-git-send-email-j-keerthy@ti.com>
 <1501051524-5990-2-git-send-email-j-keerthy@ti.com>
 <1fb21a17-c38e-539f-7cd3-b72bd819a531@ti.com>
 <ecb45045-057a-98c1-9c22-bc6c0df6f5bd@ti.com>
 <20170726133342.GO31807@n2100.armlinux.org.uk>
Message-ID: <7687bd4b-a098-2eaf-dab0-ad24bc23b2d6@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 26 July 2017 07:03 PM, Russell King - ARM Linux wrote:
> On Wed, Jul 26, 2017 at 06:59:58PM +0530, Keerthy wrote:
>>>> +
>>>> +		gpio0: gpio at 2603000 {
>>>> +			compatible = "ti,keystone-k2g-gpio", "ti,keystone-gpio";
>>>> +			reg = <0x02603000 0x100>;
>>>> +			gpio-controller;
>>>> +			#gpio-cells = <2>;
>>>> +
>>>> +			interrupts = <GIC_SPI 432 IRQ_TYPE_EDGE_RISING>,
>>>> +					<GIC_SPI 433 IRQ_TYPE_EDGE_RISING>,
>>>> +					<GIC_SPI 434 IRQ_TYPE_EDGE_RISING>,
>>>> +					<GIC_SPI 435 IRQ_TYPE_EDGE_RISING>,
>>>> +					<GIC_SPI 436 IRQ_TYPE_EDGE_RISING>,
>>>> +					<GIC_SPI 437 IRQ_TYPE_EDGE_RISING>,
>>>> +					<GIC_SPI 438 IRQ_TYPE_EDGE_RISING>,
>>>> +					<GIC_SPI 439 IRQ_TYPE_EDGE_RISING>,
>>>> +					<GIC_SPI 440 IRQ_TYPE_EDGE_RISING>;
>>>> +			interrupt-controller;
>>>> +			#interrupt-cells = <2>;
>>>> +			ti,ngpio = <144>;
>>>> +			ti,davinci-gpio-unbanked = <0>;
>>>> +			clocks = <&k2g_clks 0x001b 0x0>;
>>>> +			clock-names = "gpio";
>>>> +		};
>>>> +
>>>> +		gpio1: gpio at 260a000 {
>>>> +			compatible = "ti,keystone-k2g-gpio", "ti,keystone-gpio";
>>>> +			reg = <0x0260a000 0x100>;
>>>> +			gpio-controller;
>>>> +			#gpio-cells = <2>;
>>>> +			interrupts = <GIC_SPI 442 IRQ_TYPE_EDGE_RISING>,
>>>> +					<GIC_SPI 443 IRQ_TYPE_EDGE_RISING>,
>>>> +					<GIC_SPI 444 IRQ_TYPE_EDGE_RISING>,
>>>> +					<GIC_SPI 445 IRQ_TYPE_EDGE_RISING>,
>>>> +					<GIC_SPI 446 IRQ_TYPE_EDGE_RISING>;
>>>> +			interrupt-controller;
>>>> +			#interrupt-cells = <2>;
>>>> +			ti,ngpio = <68>;
>>>> +			ti,davinci-gpio-unbanked = <0>;
>>>> +			clocks = <&k2g_clks 0x001c 0x0>;
>>>> +			clock-names = "gpio";
>>>> +		};
> 
> With the addition of GPIO support, does that mean there is a chance to
> control the noisy fan via the kernel's thermal management?  Do we have
> temperature sensor support for Keystone 2 ?

Russell,

GPIO support using davinci driver for K2HK/L/E was there for a long time
here: arch/arm/boot/dts/keystone.dtsi

commit 970c225636ac4ae98739094d6b6bbf2bdc3694f9
Author: Grygorii Strashko <grygorii.strashko@ti.com>
Date:   Mon Feb 10 18:41:18 2014 +0200

    ARM: dts: keystone: add gpio device entry

I have only added the k2g nodes now as it is different compared to other
keystone 2 platforms.

I believe there is no temperature sensor support for Keystone 2 yet.

Regards,
Keerthy
> 
