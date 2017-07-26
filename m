From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Jul 2017 14:33:42 +0100
Subject: [PATCH v3 2/2] ARM: dts: keystone-k2g-evm: Add gpio nodes
In-Reply-To: <ecb45045-057a-98c1-9c22-bc6c0df6f5bd@ti.com>
References: <1501051524-5990-1-git-send-email-j-keerthy@ti.com>
 <1501051524-5990-2-git-send-email-j-keerthy@ti.com>
 <1fb21a17-c38e-539f-7cd3-b72bd819a531@ti.com>
 <ecb45045-057a-98c1-9c22-bc6c0df6f5bd@ti.com>
Message-ID: <20170726133342.GO31807@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 06:59:58PM +0530, Keerthy wrote:
> >> +
> >> +		gpio0: gpio at 2603000 {
> >> +			compatible = "ti,keystone-k2g-gpio", "ti,keystone-gpio";
> >> +			reg = <0x02603000 0x100>;
> >> +			gpio-controller;
> >> +			#gpio-cells = <2>;
> >> +
> >> +			interrupts = <GIC_SPI 432 IRQ_TYPE_EDGE_RISING>,
> >> +					<GIC_SPI 433 IRQ_TYPE_EDGE_RISING>,
> >> +					<GIC_SPI 434 IRQ_TYPE_EDGE_RISING>,
> >> +					<GIC_SPI 435 IRQ_TYPE_EDGE_RISING>,
> >> +					<GIC_SPI 436 IRQ_TYPE_EDGE_RISING>,
> >> +					<GIC_SPI 437 IRQ_TYPE_EDGE_RISING>,
> >> +					<GIC_SPI 438 IRQ_TYPE_EDGE_RISING>,
> >> +					<GIC_SPI 439 IRQ_TYPE_EDGE_RISING>,
> >> +					<GIC_SPI 440 IRQ_TYPE_EDGE_RISING>;
> >> +			interrupt-controller;
> >> +			#interrupt-cells = <2>;
> >> +			ti,ngpio = <144>;
> >> +			ti,davinci-gpio-unbanked = <0>;
> >> +			clocks = <&k2g_clks 0x001b 0x0>;
> >> +			clock-names = "gpio";
> >> +		};
> >> +
> >> +		gpio1: gpio at 260a000 {
> >> +			compatible = "ti,keystone-k2g-gpio", "ti,keystone-gpio";
> >> +			reg = <0x0260a000 0x100>;
> >> +			gpio-controller;
> >> +			#gpio-cells = <2>;
> >> +			interrupts = <GIC_SPI 442 IRQ_TYPE_EDGE_RISING>,
> >> +					<GIC_SPI 443 IRQ_TYPE_EDGE_RISING>,
> >> +					<GIC_SPI 444 IRQ_TYPE_EDGE_RISING>,
> >> +					<GIC_SPI 445 IRQ_TYPE_EDGE_RISING>,
> >> +					<GIC_SPI 446 IRQ_TYPE_EDGE_RISING>;
> >> +			interrupt-controller;
> >> +			#interrupt-cells = <2>;
> >> +			ti,ngpio = <68>;
> >> +			ti,davinci-gpio-unbanked = <0>;
> >> +			clocks = <&k2g_clks 0x001c 0x0>;
> >> +			clock-names = "gpio";
> >> +		};

With the addition of GPIO support, does that mean there is a chance to
control the noisy fan via the kernel's thermal management?  Do we have
temperature sensor support for Keystone 2 ?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
