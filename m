From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Oct 2015 11:00:06 +0200
Subject: [PATCH V2 3/3] Add dts node for smmu on hi6220 SoC
In-Reply-To: <1445330724-129401-3-git-send-email-puck.chen@hisilicon.com>
References: <1445330724-129401-1-git-send-email-puck.chen@hisilicon.com>
 <1445330724-129401-3-git-send-email-puck.chen@hisilicon.com>
Message-ID: <39316856.jTQkIxu0yn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 October 2015 16:45:24 Chen Feng wrote:
> +
> +               smmu at f4210000 {

I think the canonical name for an IOMMU device is 'iommu', not 'smmu'.

> +                       compatible = "hisilicon,hi6220-smmu";
> +                       reg = <0x0 0xf4210000 0x0 0x1000>;
> +                       interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&sys_ctrl HI6220_MMU_CLK>,
> +                                <&media_ctrl HI6220_MED_MMU>,
> +                                <&sys_ctrl HI6220_MEDIA_PLL_SRC>;
> +                       clock-names = "smmu_clk",
> +                                     "media_sc_clk",
> +                                     "smmu_peri_clk";


Better avoid underscores in strings, and drop the "_clk" postfix in
the clock names.

I did not receive patch 1/3 this time, but I see in version 1, that
you forgot to document the strings:

> +- clock-names: The name to enable clock with clock framework.

This needs to list the names of the clock inputs to the smmu.

	Arnd
