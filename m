From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 15 Mar 2017 13:48:29 +0100
Subject: [PATCH v6 07/14] dt: bindings: Add bindings for Marvell Xenon SD
 Host Controller
In-Reply-To: <3a4ce2fd25ed812482b0fc96f50dd305c8f40fe9.1487091464.git-series.gregory.clement@free-electrons.com>
References: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
 <3a4ce2fd25ed812482b0fc96f50dd305c8f40fe9.1487091464.git-series.gregory.clement@free-electrons.com>
Message-ID: <CAPDyKFrmb51cTR7B5S0JkmACH0=bw9+28RmWnjwWkuiT7N4wVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> +
> +Example:
> +- For eMMC:
> +
> +       sdhci at aa0000 {
> +               compatible = "marvell,armada-ap806-sdhci";
> +               reg = <0xaa0000 0x1000>;
> +               interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>
> +               clocks = <&emmc_clk>;
> +               clock-names = "core";
> +               bus-width = <4>;
> +               marvell,xenon-phy-slow-mode;
> +               marvell,xenon-tun-count = <11>;

There's no vmmc-supply here.

How do you control power to the eMMC card?

> +
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               apm_mmccard: mmccard at 0 {
> +                       compatible = "mmc-card";
> +                       reg = <0>;
> +               };
> +       };
> +
> +- For SD/SDIO:
> +
> +       sdhci at ab0000 {
> +               compatible = "marvell,armada-cp110-sdhci";
> +               reg = <0xab0000 0x1000>;
> +               interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>
> +               vqmmc-supply = <&sd_regulator>;

I guess you know vqmmc is for the I/O voltage.

Again, how do you power the SD/SDIO card? No vmmc?

> +               clocks = <&sdclk>;
> +               clock-names = "core";
> +               bus-width = <4>;
> +               marvell,xenon-tun-count = <9>;
> +       };
> +
> +- For eMMC with compatible "marvell,armada-3700-sdhci":
> +
> +       sdhci at aa0000 {
> +               compatible = "marvell,armada-3700-sdhci";
> +               reg = <0xaa0000 0x1000>,
> +                     <phy_addr 0x4>;
> +               interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>
> +               clocks = <&emmcclk>;
> +               clock-names = "core";
> +               bus-width = <8>;
> +               mmc-ddr-1_8v;
> +               mmc-hs400-1_8v;

Again, no vmmc?

> +
> +               marvell,pad-type = "fixed-1-8v";
> +
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               mmccard: mmccard at 0 {
> +                       compatible = "mmc-card";
> +                       reg = <0>;
> +               };
> +       };
> +
> +- For SD/SDIO with compatible "marvell,armada-3700-sdhci":
> +
> +       sdhci at ab0000 {
> +               compatible = "marvell,armada-3700-sdhci";
> +               reg = <0xab0000 0x1000>,
> +                     <phy_addr 0x4>;
> +               interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>
> +               vqmmc-supply = <&sd_regulator>;

Again, no vmmc?

> +               clocks = <&sdclk>;
> +               clock-names = "core";
> +               bus-width = <4>;
> +
> +               marvell,pad-type = "sd";
> +       };
> --
> git-series 0.9.1


Kind regards
Uffe
