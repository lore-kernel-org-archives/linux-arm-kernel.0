From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Oct 2018 22:18:18 +0100
Subject: [GIT PULL 0/4] ARM: SoC changes for 4.20
Message-ID: <CAK8P3a0RbZiHCF+krpmPpmH=4yy5G57NoTDpOKE=xz1wbgy78A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here are the arm-soc changes for the current merge window, with a
little delay due to the conference travel last week.

This is feels a little bigger than the last few I did before Olof took
over for the summer. We have 965 non-merge changesets in the
branch, and we pulled from a total of 101 downstream branches this
time. In the top contributors, we have a few new names this time,
most of these worked specifically on one SoC platform:

    128 Marcel Ziswiler
     35 Biju Das
     34 H. Nikolaus Schaller
     27 Grygorii Strashko
     25 Rob Herring
     25 Manivannan Sadhasivam
     23 Geert Uytterhoeven
     23 Fabio Estevam
     22 Aapo Vienamo
     21 Fabrizio Castro
     21 Anson Huang
     15 Bjorn Andersson
     14 Sergei Shtylyov
     13 Krzysztof Kozlowski
     12 Niklas Cassel
     12 Nicolas Ferre
     12 Alex Elder
     11 Martin Blumenstingl
     11 Marek Szyprowski
     10 Suzuki K Poulose
     10 Jerome Brunet

While the majority of the patches went into 32-bit ARM, this is
the first time I noticed more new boards getting added on 64-bit,
which seems like a significant departure from the past. Around
76% of the patches arch for dts files and bindings, 12% are for
drivers, and the rest is architecture specific code (the numbers
are not exact because of overlapping changes). In more detail,
this looks like

$ git diff --dirstat=0.1 v4.19-rc6..
   0.5% Documentation/devicetree/bindings/arm/freescale/
   0.5% Documentation/devicetree/bindings/arm/tegra/
   0.5% Documentation/devicetree/bindings/arm/
   0.2% Documentation/devicetree/bindings/firmware/xilinx/
   0.1% Documentation/devicetree/bindings/firmware/
   0.1% Documentation/devicetree/bindings/net/dsa/
   0.1% Documentation/devicetree/bindings/reset/
   0.2% Documentation/devicetree/bindings/
   0.2% Documentation/xilinx/
  36.2% arch/arm/boot/dts/
   0.1% arch/arm/mach-exynos/
   0.1% arch/arm/mach-imx/
   0.5% arch/arm/mach-omap1/
   0.2% arch/arm/mach-omap2/
   0.4% arch/arm/mach-s3c24xx/
   0.7% arch/arm/mach-shmobile/
   0.8% arch/arm/mach-u300/
   1.2% arch/arm/
   0.9% arch/arm64/boot/dts/actions/
   1.7% arch/arm64/boot/dts/allwinner/
   1.5% arch/arm64/boot/dts/amlogic/
   0.3% arch/arm64/boot/dts/arm/
   0.6% arch/arm64/boot/dts/hisilicon/
   1.7% arch/arm64/boot/dts/marvell/
   1.0% arch/arm64/boot/dts/mediatek/
   0.5% arch/arm64/boot/dts/nvidia/
   3.9% arch/arm64/boot/dts/qcom/
  11.2% arch/arm64/boot/dts/renesas/
  10.3% arch/arm64/boot/dts/rockchip/
   1.4% arch/arm64/boot/dts/socionext/
   0.3% arch/arm64/boot/dts/synaptics/
   0.5% arch/arm64/boot/dts/ti/
   0.2% arch/arm64/boot/dts/
   0.5% drivers/bus/
   3.8% drivers/clk/zynqmp/
   1.1% drivers/edac/
   0.1% drivers/firmware/arm_scmi/
   0.8% drivers/firmware/imx/
   0.1% drivers/firmware/meson/
   2.0% drivers/firmware/xilinx/
   0.3% drivers/firmware/
   0.3% drivers/reset/
   0.1% drivers/soc/actions/
   0.4% drivers/soc/amlogic/
   0.3% drivers/soc/fsl/qbman/
   0.4% drivers/soc/imx/
   0.8% drivers/soc/mediatek/
   0.9% drivers/soc/qcom/
   1.0% drivers/soc/renesas/
   1.9% drivers/soc/tegra/
   0.2% drivers/tee/
   0.1% drivers/
   0.2% include/dt-bindings/clock/
   0.2% include/dt-bindings/power/
   0.1% include/linux/firmware/imx/svc/
   1.6% include/linux/firmware/imx/
   0.2% include/linux/firmware/
   0.1% include/linux/soc/amlogic/
   0.4% include/linux/
   0.1% include/soc/fsl/
   0.1% include/

         Arnd
