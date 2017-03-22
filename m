From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 22 Mar 2017 13:49:36 +0100
Subject: [PATCH] arm64: dts: rockchip: add dmac nodes for rk3368 SoCs
In-Reply-To: <1490184194-32051-1-git-send-email-huibin.hong@rock-chips.com>
References: <1490184194-32051-1-git-send-email-huibin.hong@rock-chips.com>
Message-ID: <6714315.k8UebLJmJU@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Mittwoch, 22. M?rz 2017, 20:03:14 CET schrieb Huibin Hong:
> Add dmac bus and dmac peri dts nodes for peripherals,
> such as I2S, SPI, UART and so on.
> 
> Signed-off-by: Huibin Hong <huibin.hong@rock-chips.com>

I applied that patch already in [0], did something change?


[0] https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?id=4b4c0db538fa6e3f31bc40ddc17c1d5facb49d36

> ---
>  arch/arm64/boot/dts/rockchip/rk3368.dtsi | 29 +++++++++++++++++++++++++++++
> 1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3368.dtsi index a635adc..2a0422f 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> @@ -189,6 +189,35 @@
>  		};
>  	};
> 
> +        amba {
> +                compatible = "simple-bus";
> +                #address-cells = <2>;
> +                #size-cells = <2>;
> +                ranges;
> +
> +                dmac_peri: dma-controller at ff250000 {
> +                        compatible = "arm,pl330", "arm,primecell";
> +                        reg = <0x0 0xff250000 0x0 0x4000>;
> +                        interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> +                                     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> +                        #dma-cells = <1>;
> +                        clocks = <&cru ACLK_DMAC_PERI>;
> +                        clock-names = "apb_pclk";
> +                        arm,pl330-broken-no-flushp;
> +                };
> +
> +                dmac_bus: dma-controller at ff600000 {
> +                        compatible = "arm,pl330", "arm,primecell";
> +                        reg = <0x0 0xff600000 0x0 0x4000>;
> +                        interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> +                                     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
> +                        #dma-cells = <1>;
> +                        clocks = <&cru ACLK_DMAC_BUS>;
> +                        clock-names = "apb_pclk";
> +                        arm,pl330-broken-no-flushp;
> +                };
> +        };
> +
>  	arm-pmu {
>  		compatible = "arm,armv8-pmuv3";
>  		interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
