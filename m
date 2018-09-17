From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 17 Sep 2018 10:22:04 +0200
Subject: [PATCH] ARM: dts: rk3036: Fix erroneous SPI bus warnings
In-Reply-To: <20180913181245.25484-12-robh@kernel.org>
References: <20180913181245.25484-12-robh@kernel.org>
Message-ID: <1778216.aYnKCIvxKR@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 13. September 2018, 20:12:36 CEST schrieb Rob Herring:
> dtc has new checks for SPI buses. The rk3036 dts file has a node named
> spi' which causes false positive warnings. As the node is a pinctrl child
> node, change the node name to be 'spi-pins' to fix the warnings.
> 
> arch/arm/boot/dts/rk3036-evb.dtb: Warning (spi_bus_bridge): /pinctrl/spi: incorrect #address-cells for SPI bus
> arch/arm/boot/dts/rk3036-kylin.dtb: Warning (spi_bus_bridge): /pinctrl/spi: incorrect #address-cells for SPI bus
> arch/arm/boot/dts/rk3036-evb.dtb: Warning (spi_bus_bridge): /pinctrl/spi: incorrect #size-cells for SPI bus
> arch/arm/boot/dts/rk3036-kylin.dtb: Warning (spi_bus_bridge): /pinctrl/spi: incorrect #size-cells for SPI bus
> 
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-rockchip at lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please apply to the sub-arch tree. The dtc changes haven't landed, but 
> will for 4.20.

applied for 4.20

Thanks
Heiko
