From: robh@kernel.org (Rob Herring)
Date: Thu, 18 Feb 2016 08:36:01 -0600
Subject: [PATCH v2 5/8] arm64: dts: add Allwinner A64 SoC .dtsi
In-Reply-To: <1455709440-8668-6-git-send-email-andre.przywara@arm.com>
References: <1455709440-8668-1-git-send-email-andre.przywara@arm.com>
 <1455709440-8668-6-git-send-email-andre.przywara@arm.com>
Message-ID: <20160218143601.GE9654@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 11:43:57AM +0000, Andre Przywara wrote:
> The Allwinner A64 SoC is a low-cost chip with 4 ARM Cortex-A53 cores
> and the typical tablet / TV box peripherals.
> The SoC is based on the (32-bit) Allwinner H3 chip, sharing most of
> the peripherals and the memory map.
> Although the cores are proper 64-bit ones, the whole SoC is actually
> limited to 4GB (including all the supported DRAM), so we use 32-bit
> address and size cells. This has the nice feature of us being able to
> reuse the DT for 32-bit kernels as well.
> This .dtsi lists the hardware that we support so far.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.txt   |   1 +
>  Documentation/devicetree/bindings/clock/sunxi.txt |   1 +
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi     | 642 ++++++++++++++++++++++
>  3 files changed, 644 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi

[...]

> +	memory {
> +		device_type = "memory";
> +		reg = <0x40000000 0>;
> +	};
> +
> +	gic: interrupt-controller at 01c81000 {

Remove the numerous leading 0s on the unit addresses.

With that:

Acked-by: Rob Herring <robh@kernel.org>
