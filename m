From: tony@atomide.com (Tony Lindgren)
Date: Thu, 20 Sep 2018 14:52:49 -0700
Subject: [PATCH] ARM: dts: ti: Fix SPI and I2C bus warnings
In-Reply-To: <20180913181245.25484-1-robh@kernel.org>
References: <20180913181245.25484-1-robh@kernel.org>
Message-ID: <20180920215249.GY5662@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robh@kernel.org> [180913 11:17]:
> dtc has new checks for I2C and SPI buses. Fix the warnings in node names
> and unit-addresses.
> 
> arch/arm/boot/dts/am437x-idk-evm.dtb: Warning (spi_bus_bridge): /ocp at 44000000/qspi at 47900000: node name for SPI buses should be 'spi'
> arch/arm/boot/dts/am437x-sk-evm.dtb: Warning (spi_bus_bridge): /ocp at 44000000/qspi at 47900000: node name for SPI buses should be 'spi'
> arch/arm/boot/dts/am43x-epos-evm.dtb: Warning (spi_bus_bridge): /ocp at 44000000/qspi at 47900000: node name for SPI buses should be 'spi'
> arch/arm/boot/dts/omap3-n9.dtb: Warning (i2c_bus_reg): /ocp at 68000000/i2c at 48060000/ak8975 at 0f: I2C bus unit address format error, expected "f"
> arch/arm/boot/dts/am335x-osd3358-sm-red.dtb: Warning (i2c_bus_reg): /ocp/i2c at 44e0b000/pressure at 78: I2C bus unit address format error, expected "76"
> arch/arm/boot/dts/am335x-boneblack.dtb: Warning (i2c_bus_reg): /ocp/i2c at 44e0b000/tda19988: I2C bus unit address format error, expected "70"
> arch/arm/boot/dts/am335x-boneblack-wireless.dtb: Warning (i2c_bus_reg): /ocp/i2c at 44e0b000/tda19988: I2C bus unit address format error, expected "70"
> arch/arm/boot/dts/am335x-sancloud-bbe.dtb: Warning (i2c_bus_reg): /ocp/i2c at 44e0b000/tda19988: I2C bus unit address format error, expected "70"
> arch/arm/boot/dts/am571x-idk.dtb: Warning (spi_bus_bridge): /ocp/qspi at 4b300000: node name for SPI buses should be 'spi'
> arch/arm/boot/dts/am572x-idk.dtb: Warning (spi_bus_bridge): /ocp/qspi at 4b300000: node name for SPI buses should be 'spi'
> arch/arm/boot/dts/am574x-idk.dtb: Warning (spi_bus_bridge): /ocp/qspi at 4b300000: node name for SPI buses should be 'spi'
> arch/arm/boot/dts/am57xx-cl-som-am57x.dtb: Warning (spi_bus_bridge): /ocp/qspi at 4b300000: node name for SPI buses should be 'spi'
> arch/arm/boot/dts/am57xx-sbc-am57x.dtb: Warning (spi_bus_bridge): /ocp/qspi at 4b300000: node name for SPI buses should be 'spi'
> arch/arm/boot/dts/dra72-evm.dtb: Warning (spi_bus_bridge): /ocp/qspi at 4b300000: node name for SPI buses should be 'spi'
> arch/arm/boot/dts/dra72-evm-revc.dtb: Warning (spi_bus_bridge): /ocp/qspi at 4b300000: node name for SPI buses should be 'spi'
> arch/arm/boot/dts/dra76-evm.dtb: Warning (spi_bus_bridge): /ocp/qspi at 4b300000: node name for SPI buses should be 'spi'
> arch/arm/boot/dts/dra7-evm.dtb: Warning (spi_bus_bridge): /ocp/qspi at 4b300000: node name for SPI buses should be 'spi'
> arch/arm/boot/dts/am335x-pdu001.dtb: Warning (spi_bus_reg): /ocp/spi at 481a0000/cfaf240320a032t: SPI bus unit address format error, expected "0"
> arch/arm/boot/dts/keystone-k2g-evm.dtb: Warning (spi_bus_bridge): /soc at 0/qspi at 2940000: node name for SPI buses should be 'spi'
> arch/arm/boot/dts/keystone-k2g-ice.dtb: Warning (spi_bus_bridge): /soc at 0/qspi at 2940000: node name for SPI buses should be 'spi'
> 
> Cc: "Beno?t Cousson" <bcousson@baylibre.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: linux-omap at vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please apply to the sub-arch tree. The dtc changes haven't landed, but 
> will for 4.20.

OK thanks applying this into omap-for-v4.20/dt.

Tony
