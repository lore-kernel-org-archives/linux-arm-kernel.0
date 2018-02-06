From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 6 Feb 2018 16:08:49 +0100
Subject: stable-rc/linux-4.15.y build: 185 builds: 0 failed, 185 passed,
 46 warnings (v4.15.1-61-g7ab5513e4cbc)
In-Reply-To: <5a78c368.5896df0a.8f293.fd41@mx.google.com>
References: <5a78c368.5896df0a.8f293.fd41@mx.google.com>
Message-ID: <CAK8P3a1n2ELL56MHqEgffzNg2B8gdpwHpMnp_vgN4ftAAiwW8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 5, 2018 at 9:49 PM, kernelci.org bot <bot@kernelci.org> wrote:
>
> stable-rc/linux-4.15.y build: 185 builds: 0 failed, 185 passed, 46 warnings (v4.15.1-61-g7ab5513e4cbc)

Hi Greg,

FYI, the device tree compiler warnings are all fixed in
linux-4.16-rc1. These are basically fixes
that we ended up not submitting last minute for the release after one
of them (the USB PHY
one, if you remember) had blown up.

Anyway, I think the risk is rather low for any of them (they are
mostly platforms that
are not widely used, and the fixes make things work that didn't), so
to get a clean
build, feel free to pick up the remaining patches from mainline now or
after -rc1:

> Warnings Detected:
>
> Warnings summary:
> 2 arch/arm/boot/dts/spear1340-evb.dtb: Warning (dmas_property): Property 'dmas', cell 4 is not a phandle reference in /ahb/apb/serial at b4100000
> 2 arch/arm/boot/dts/spear1340-evb.dtb: Warning (dmas_property): Missing property '#dma-cells' in node /interrupt-controller at ec801000 or bad phandle (referred from /ahb/apb/serial at b4100000:dmas[4])

cdd104099141 ("arm: spear13xx: Fix dmas cells")

> 2 arch/arm/boot/dts/spear1310-evb.dtb: Warning (gpios_property): Property 'cs-gpios', cell 6 is not a phandle reference in /ahb/apb/spi at e0100000
> 2 arch/arm/boot/dts/spear1310-evb.dtb: Warning (gpios_property): Missing property '#gpio-cells' in node /interrupt-controller at ec801000 or bad phandle (referred from /ahb/apb/spi at e0100000:cs-gpios[6])

f8975cb1b8a3 ("arm: spear13xx: Fix spics gpio controller's warning")

> 2 arch/arm/boot/dts/exynos5410-smdk5410.dtb: Warning (interrupts_property): Missing interrupt-controller or interrupt-map property in /soc/system-controller at 10040000
> 2 arch/arm/boot/dts/exynos5410-smdk5410.dtb: Warning (interrupts_property): Missing #interrupt-cells in interrupt-parent /soc/system-controller at 10040000
> 2 arch/arm/boot/dts/exynos5410-odroidxu.dtb: Warning (interrupts_property): Missing interrupt-controller or interrupt-map property in /soc/system-controller at 10040000
> 2 arch/arm/boot/dts/exynos5410-odroidxu.dtb: Warning (interrupts_property): Missing #interrupt-cells in interrupt-parent /soc/system-controller at 10040000

5628a8ca1414 ("ARM: dts: exynos: fix RTC interrupt for exynos5410")

> 2 WARNING: modpost: missing MODULE_LICENSE() in arch/arm/mach-pxa/tosa-bt.o

3343647813fd ("ARM: pxa/tosa-bt: add MODULE_LICENSE tag")

> 1 arch/arm64/boot/dts/qcom/msm8916-mtp.dtb: Warning (phys_property): Missing property '#phy-cells' in node /soc/mdss at 1a00000/dsi-phy at 1a98300 or bad phandle (referred from /soc/mdss at 1a00000/dsi at 1a98000:phys[0])
> 1 arch/arm64/boot/dts/qcom/apq8016-sbc.dtb: Warning (phys_property): Missing property '#phy-cells' in node /soc/mdss at 1a00000/dsi-phy at 1a98300 or bad phandle (referred from /soc/mdss at 1a00000/dsi at 1a98000:phys[0])

b0ab681285aa ("arm64: dts: msm8916: Add missing #phy-cells")

> 1 arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: Warning (cooling_device_property): Missing property '#cooling-cells' in node /cpus/cpu at 100 or bad phandle (referred from /thermal-zones/cpu_thermal/cooling-maps/map at 1:cooling-device[0])
> 1 arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: Warning (cooling_device_property): Missing property '#cooling-cells' in node /cpus/cpu at 0 or bad phandle (referred from /thermal-zones/cpu_thermal/cooling-maps/map at 0:cooling-device[0])

acbf76ee0506 ("arm64: dts: add #cooling-cells to CPU nodes")

> 1 arch/arm/boot/dts/stih410-b2260.dtb: Warning (gpios_property): hdmi,hpd-gpio property size (8) too small for cell size 2 in /soc/sti-display-subsystem/sti-hdmi at 8d04000
> 1 arch/arm/boot/dts/stih410-b2120.dtb: Warning (gpios_property): hdmi,hpd-gpio property size (8) too small for cell size 2 in /soc/sti-display-subsystem/sti-hdmi at 8d04000
> 1 arch/arm/boot/dts/stih407-b2120.dtb: Warning (gpios_property): hdmi,hpd-gpio property size (8) too small for cell size 2 in /soc/sti-display-subsystem/sti-hdmi at 8d04000

7ac1f59c09a6 ("ARM: dts: STi: Add gpio polarity for "hdmi,hpd-gpio" property")

> 1 arch/arm/boot/dts/ste-nomadik-s8815.dtb: Warning (interrupts_property): Missing interrupt-parent for /amba/clcd at 10120000
> 1 arch/arm/boot/dts/ste-nomadik-nhk15.dtb: Warning (interrupts_property): Missing interrupt-parent for /amba/clcd at 10120000

e8bfa0422469 ("ARM: dts: nomadik: add interrupt-parent for clcd")

> 1 arch/arm/boot/dts/spear600-evb.dtb: Warning (interrupts_property): Missing interrupt-parent for /ahb/apb/rtc at fc900000

6ffb5b4f248f ("arm: spear600: Add missing interrupt-parent of rtc")

> 1 arch/arm/boot/dts/s5pv210-torbreck.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci at ec300000
> 1 arch/arm/boot/dts/s5pv210-smdkv210.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci at ec300000
> 1 arch/arm/boot/dts/s5pv210-smdkc110.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci at ec300000
> 1 arch/arm/boot/dts/s5pv210-goni.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci at ec300000
> 1 arch/arm/boot/dts/s5pv210-aquila.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci at ec300000

5c1037196b9e ("ARM: dts: s5pv210: add interrupt-parent for ohci")

> 1 arch/arm/boot/dts/mt7623n-rfb-nand.dtb: Warning (resets_property): Missing property '#reset-cells' in node /syscon at 1b000000 or bad phandle (referred from /ethernet at 1b100000:resets[0])
> 1 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dtb: Warning (resets_property): Missing property '#reset-cells' in node /syscon at 1b000000 or bad phandle (referred from /ethernet at 1b100000:resets[0])

76a09ce214ad ("arm: dts: mt7623: Update ethsys binding")

> 1 arch/arm/boot/dts/mt2701-evb.dtb: Warning (resets_property): Missing property '#reset-cells' in node /syscon at 1b000000 or bad phandle (referred from /ethernet at 1b100000:resets[0])

ae72e95b5e4d ("arm: dts: mt2701: Add reset-cells")

> 1 arch/arm/boot/dts/lpc3250-phy3250.dtb: Warning (gpios_property): reset-gpio property size (12) too small for cell size 3 in /ahb/apb/i2c at 400A0000/uda1380 at 18
> 1 arch/arm/boot/dts/lpc3250-phy3250.dtb: Warning (gpios_property): power-gpio property size (12) too small for cell size 3 in /ahb/apb/i2c at 400A0000/uda1380 at 18
> 1 arch/arm/boot/dts/lpc3250-ea3250.dtb: Warning (gpios_property): reset-gpio property size (12) too small for cell size 3 in /ahb/apb/i2c at 400A0000/uda1380 at 18
> 1 arch/arm/boot/dts/lpc3250-ea3250.dtb: Warning (gpios_property): power-gpio property size (12) too small for cell size 3 in /ahb/apb/i2c at 400A0000/uda1380 at 18

ca32e0c4bf9c ("ARM: lpc3250: fix uda1380 gpio numbers")

> 1 arch/arm/boot/dts/arm-realview-eb-a9mp.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /fpga/charlcd at 10008000
> 1 arch/arm/boot/dts/arm-realview-eb-a9mp-bbrevd.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /fpga/charlcd at 10008000
> 1 arch/arm/boot/dts/arm-realview-eb-11mp.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /fpga/charlcd at 10008000
> 1 arch/arm/boot/dts/arm-realview-eb-11mp-ctrevb.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /fpga/charlcd at 10008000
> 1 arch/arm/boot/dts/arm-realview-eb-11mp-bbrevd.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /fpga/charlcd at 10008000
> 1 arch/arm/boot/dts/arm-realview-eb-11mp-bbrevd-ctrevb.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /fpga/charlcd at 10008000

586b2a4befad ("ARM: dts: Delete bogus reference to the charlcd")

         Arnd
