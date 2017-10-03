From: robh@kernel.org (Rob Herring)
Date: Tue, 3 Oct 2017 13:36:30 -0500
Subject: ARM: new DT warnings
In-Reply-To: <20170814223843.oyezospd5knk62cl@rob-hp-laptop>
References: <20170814223843.oyezospd5knk62cl@rob-hp-laptop>
Message-ID: <CAL_JsqLrF8=4FOfR1PRRk_akQ0btTyaTKP=WHpWm1bPzk1AhSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 5:38 PM, Rob Herring <robh@kernel.org> wrote:
> I'm working on some new dtc checks that check common binding phandle
> lookups and cell sizes.

Unless someone yells, I plan to push out a dtc update to -next that's
going to enable these warnings (errors really) and they are on by
default. Some have been fixed I think, but most still remain.

Rob

>
> These are the new warnings produced. I haven't checked them all, but I
> believe these are all actual errors from the ones I checked. This is a
> trimmed list removing duplicates that get repeated for each board.
>
> arch/arm/boot/dts/am335x-baltos-ir2110.dtb: Warning (provider_cells_property): Missing #phy-cells in provider /ocp/usb at 47400000/usb-phy at 47401300 for /ocp/usb at 47400000/usb at 47401000
> arch/arm/boot/dts/am335x-baltos-ir2110.dtb: Warning (provider_cells_property): Missing #phy-cells in provider /ocp/usb at 47400000/usb-phy at 47401b00 for /ocp/usb at 47400000/usb at 47401800
> arch/arm/boot/dts/am437x-cm-t43.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /ocp at 44000000/mcasp at 48038000
> arch/arm/boot/dts/am437x-cm-t43.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /ocp at 44000000/mcasp at 4803C000
> arch/arm/boot/dts/am437x-cm-t43.dtb: Warning (provider_cells_property): Missing #mbox-cells in provider /ocp at 44000000/mailbox at 480C8000/wkup_m3 for /ocp at 44000000/l4_wkup at 44c00000/scm at 210000/wkup_m3_ipc at 1324
> arch/arm/boot/dts/arm-realview-eb-11mp-bbrevd-ctrevb.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /fpga/charlcd at 10008000
> arch/arm/boot/dts/at91-sama5d2_xplained.dtb: Warning (provider_cells_property): Missing phandles in /ahb/apb/flexcom at fc018000/i2c at 600:dmas
> arch/arm/boot/dts/at91-sama5d3_xplained.dtb: Warning (provider_cells_property): Missing phandles in /ahb/apb/i2c at f801c000:dmas
> arch/arm/boot/dts/at91-tse850-3.dtb: Warning (provider_cells_property): Missing phandles in /ahb/apb/serial at ffffee00:dmas
> arch/arm/boot/dts/bcm2835-rpi-a.dtb: Warning (provider_cells_property): Missing #phy-cells in provider /phy for /soc/usb at 7e980000
> arch/arm/boot/dts/dm8148-evm.dtb: Warning (provider_cells_property): Missing #phy-cells in provider /ocp/l4ls at 48000000/control at 140000/usb-phy at 1b00 for /ocp/usb at 47400000/usb at 47401800
> arch/arm/boot/dts/exynos5410-odroidxu.dtb: Warning (interrupts_property): Missing #interrupt-cells in interrupt-parent /soc/system-controller at 10040000
> arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dtb: Warning (gpio_cells_property): cd-gpios property size (8) too small for cell size 2 in /soc/aips at 53f00000/esdhc at 53fb4000
> arch/arm/boot/dts/imx50-evk.dtb: Warning (provider_cells_property): Missing #dma-cells in provider /soc/aips at 60000000/sdma at 63fb0000 for /soc/aips at 50000000/spba at 50000000/ssi at 50014000
> arch/arm/boot/dts/imx50-evk.dtb: Warning (provider_cells_property): Missing #dma-cells in provider /soc/aips at 60000000/sdma at 63fb0000 for /soc/aips at 60000000/ssi at 63fcc000
> arch/arm/boot/dts/imx53-tx53-x03x.dtb: Warning (interrupts_property): interrupts size is (4), expected multiple of 8 in /soc/aips at 60000000/ethernet at 63fec000/ethernet-phy at 0
> arch/arm/boot/dts/imx6ul-pico-hobbit.dtb: Warning (interrupts_property): interrupts size is (12), expected multiple of 8 in /soc/aips-bus at 02000000/ethernet at 020b4000/mdio/ethernet-phy at 1
> arch/arm/boot/dts/lpc3250-ea3250.dtb: Warning (gpio_cells_property): power-gpio property size (12) too small for cell size 3 in /ahb/apb/i2c at 400A0000/uda1380 at 18
> arch/arm/boot/dts/omap3-cm-t3517.dtb: Warning (provider_cells_property): Missing #phy-cells in provider /hsusb1_phy for /ocp at 68000000/usbhshost at 48064000/ehci at 48064800
> arch/arm/boot/dts/omap4-droid4-xt894.dtb: Warning (interrupts_property): interrupts size is (4), expected multiple of 12 in /ocp/elm at 48078000
> arch/arm/boot/dts/picoxcell-pc7302-pc3x2.dtb: Warning (interrupts_property): Missing interrupt-parent for /paxi/dmac at 40000
> arch/arm/boot/dts/picoxcell-pc7302-pc3x2.dtb: Warning (interrupts_property): Missing interrupt-parent for /paxi/dmac at 50000
> arch/arm/boot/dts/picoxcell-pc7302-pc3x2.dtb: Warning (interrupts_property): Missing interrupt-parent for /paxi/gem at 30000
> arch/arm/boot/dts/picoxcell-pc7302-pc3x2.dtb: Warning (interrupts_property): Missing interrupt-parent for /rwid-axi/axi2pico at c0000000
> arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dtb: Warning (provider_cells_property): Missing #phy-cells in provider /soc/dsi-phy at 4700200 for /soc/mdss_dsi at 4700000
> arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dtb: Warning (provider_cells_property): Missing #phy-cells in provider /soc/hdmi-phy at 4a00400 for /soc/hdmi-tx at 4a00000
> arch/arm/boot/dts/s5pv210-aquila.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci at ec300000
> arch/arm/boot/dts/sama5d31ek.dtb: Warning (provider_cells_property): Missing phandles in /ahb/apb/serial at f0020000:dmas
> arch/arm/boot/dts/sama5d31ek.dtb: Warning (provider_cells_property): Missing phandles in /ahb/apb/spi at f0004000:dmas
> arch/arm/boot/dts/spear320-hmi.dtb: Warning (gpio_cells_property): Missing phandles in /ahb/apb/i2c at d0180000/stmpe811 at 41:irq-over-gpio
> arch/arm/boot/dts/spear600-evb.dtb: Warning (interrupts_property): Missing interrupt-parent for /ahb/apb/rtc at fc900000
> arch/arm/boot/dts/ste-nomadik-nhk15.dtb: Warning (interrupts_property): Missing interrupt-parent for /amba/clcd at 10120000
> arch/arm/boot/dts/stih407-b2120.dtb: Warning (gpio_cells_property): hdmi,hpd-gpio property size (8) too small for cell size 2 in /soc/sti-display-subsystem/sti-hdmi at 8d04000
> arch/arm/boot/dts/tango4-vantage-1172.dtb: Warning (interrupts_property): Missing #interrupt-cells in interrupt-parent /soc/interrupt-controller at 6e000
> arch/arm/boot/dts/tango4-vantage-1172.dtb: Warning (interrupts_property): Missing #interrupt-cells in interrupt-parent /soc/interrupt-controller at 6e000
> arch/arm/boot/dts/tango4-vantage-1172.dtb: Warning (interrupts_property): Missing #interrupt-cells in interrupt-parent /soc/interrupt-controller at 6e000
> arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dtb: Warning (interrupts_property): Missing interrupt-parent for /pmu
> arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dtb: Warning (provider_cells_property): Missing #phy-cells in provider /phy for /soc/usb at 7e980000
> arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: Warning (provider_cells_property): Missing #cooling-cells in provider /cpus/cpu at 0 for /thermal-zones/cpu_thermal/cooling-maps/map at 0
> arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: Warning (provider_cells_property): Missing #cooling-cells in provider /cpus/cpu at 100 for /thermal-zones/cpu_thermal/cooling-maps/map at 1
> arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dtb: Warning (provider_cells_property): Missing #power-domain-cells in provider /bpmp for /gpu at 17000000
>
> The updated dtc is here[1]. Adding "DTC=path/to/dtc" will use external
> dtc in the kernel build.
>
> Once the changes are in dtc upstream, I plan to sync kernel's copy. For
> these, I don't plan to turn off by default (i.e. w/o W=1).
>
> Thanks,
> Rob
>
> [1] https://github.com/robherring/dtc.git checks
