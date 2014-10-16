From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 16 Oct 2014 11:59:46 +0200
Subject: [PATCH 4/5] ARM: berlin: Add AHCI and SATA PHY nodes to BG2
In-Reply-To: <1413042073-14253-5-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1413042073-14253-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1413042073-14253-5-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20141016095946.GB1061@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Sat, Oct 11, 2014 at 05:41:12PM +0200, Sebastian Hesselbarth wrote:
>  
> +		ahci: sata at e90000 {
> +			compatible = "marvell,berlin2-ahci", "generic-ahci";
> +			reg = <0xe90000 0x1000>;
> +			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&chip CLKID_SATA>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";

The ahci generic driver actually returns -ENODEV if no port is
activated. There is no need to disable it from there.

> +
> +			sata0: sata-port at 0 {
> +				reg = <0>;
> +				phys = <&sata_phy 0>;
> +				status = "disabled";
> +			};
> +
> +			sata1: sata-port at 1 {
> +				reg = <1>;
> +				phys = <&sata_phy 1>;
> +				status = "disabled";
> +			};
> +		};

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
