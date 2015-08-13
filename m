From: leilk.liu@mediatek.com (lei liu)
Date: Thu, 13 Aug 2015 11:35:16 +0800
Subject: [PATCH v5 3/3] arm64: dts: Add spi bus dts
In-Reply-To: <CAGS+omA0dabyGkCB2JYORn1CjXvgMs_3x7nqSOOJKMg4HRhCSg@mail.gmail.com>
References: <1438931991-17044-1-git-send-email-leilk.liu@mediatek.com>
 <1438931991-17044-4-git-send-email-leilk.liu@mediatek.com>
 <CAGS+omA0dabyGkCB2JYORn1CjXvgMs_3x7nqSOOJKMg4HRhCSg@mail.gmail.com>
Message-ID: <1439436916.21454.15.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +               spi: spi at 1100a000 {
> > +                       compatible = "mediatek,mt8173-spi";
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       reg = <0 0x1100a000 0 0x1000>;
> > +                       interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>;
> > +                       clocks = <&topckgen CLK_TOP_SPI_SEL>, <&topckgen CLK_TOP_SYSPLL3_D2>;
> > +                       clock-names = "spi-clk", "parent-clk";
> > +                       pinctrl-names = "default";
> > +                       pinctrl-0 = <&spi_pins_a>;
> > +                       mediatek,pad-select = <0>;
> 
> The pinctl and pad-select fields are board specific.
> Please move to mt8173-evb.dtsi, along with status = "okay";
> 

OK, I will fix it.
