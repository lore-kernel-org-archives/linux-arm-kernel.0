From: olof@lixom.net (Olof Johansson)
Date: Mon, 11 Jun 2018 17:01:38 -0700
Subject: [GIT PULL 0/4] ARM: SoC updates
Message-ID: <20180612000142.28883-1-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here are the pull requests for arm-soc for this merge window, broken up
into 4 different pull requests. In addition to this, I will follow up
with a small branch that normalizes some of the defconfigs at the end
of the merge window, since they have become quite shuffled with time.

There are a handful of conflicts in the first two branches, described
in the emails. Unfortunately this release some driver maintainers
picked up the devicetree fragments when they were sent with the same
patch series as the driver updates, we normally avoid that and merge DT
only through arm-soc, but this time it slipped through. I'm considering
adding monitoring scripts for it in linux-next to catch it early since
it's often a source for conflicts on active platforms.


About the contributions this release:

826 patches from 170 authors, 29778 lines added and 11701 deleted.

Dirstat this release is similar to most other releases, with the vast
majority of changes in the devicetree files. For non-DT contributions
cleanups of OMAP platforms and new development on Qualcomm and Nvidia
memory controllers cover most of it, but also some ARM SCMI, Allwinner,
Hisilicon and misc other platform improvements are there.

  51.1% arch/arm/boot/dts/
   3.8% arch/arm/mach-omap2/
   3.0% arch/arm/
   7.0% arch/arm64/boot/dts/mediatek/
   3.2% arch/arm64/boot/dts/qcom/
   8.5% arch/arm64/boot/dts/renesas/
   6.6% arch/arm64/boot/dts/
   3.2% drivers/memory/
   3.6% drivers/soc/qcom/
   5.2% drivers/

Excluding DT:
  17.2% arch/arm/mach-omap2/
  13.9% arch/arm/
   7.0% drivers/bus/
   5.8% drivers/firmware/arm_scmi/
  10.3% drivers/memory/tegra/
  16.5% drivers/soc/qcom/
   9.0% drivers/soc/
   6.4% drivers/
   8.1% include/linux/


New SoCs introduced in this release:

  - Amlogic:
   + Meson 8M2 SoC, a.k.a. S812. A quad Cortex-A9 SoC used in some set
     top boxes and other products.

  - Mediatek:
   + MT7623A, which is a flavor of the MT7623 family with other on-chip
     ethernet options.

 - Qualcomm:
   + SDM845, a.k.a Snapdragon 845, an 4+4-core Kryo 385/845
     (Cortex-A75/A55 derivative) SoC that's one of the current high-end
     mobile SoCs.

     It's great to see mainline support for it. So far, you
     can't do much with it, since a lot of peripherals are not yet in the
     DTs but driver support for USB, GPU and other pieces are starting to
     trickle in. This might end up being a well-supported SoC upstream if
     the momentum keeps up.

 - Renesas:
   + R8A77990, a.k.a R-Car E3, a new automotive entertainment-targeted
     SoC. Currently only one Cortex-A53 CPU is enabled, we are eagerly
     awaiting more. So far, basic drivers such as serial, gpios, PMU and
     ethernet are enabled.
   + R8A77470, a.k.a. RZ/G1C, a new dual Cortex-A7 SoC with PowerVR
     GPU. Same here, basic set of drivers such as serial, gpios and ethernet
     enabled, and SMP support is also forthcoming.

 - STMicroelectronics:
   + STM32F469, very similar tih STM32F429 but with display support

Enhancements to SoCs/platforms (DTS contents, some driver portions might
not be in yet):

 - Allwinner sun8i (h3/a33/a83t) SMP, DVFS tweaks, misc
 - Amlogic Meson: I2C, UFS, TDM, GPIO external interrupts, MMC resets
 - Hisilicon hi3660: Thermal cooling, CPU frequency scaling, mailbox interfaces
 - Marvell Berlin2CD: SMP support, thermal sensors
 - Mediatek MT7623: Highspeed DMA, audio support
 - Qualcomm IPQ8074 PCIe support, MSM8996 UFS support
 - Renesas: Watchdog and PMU support across many platforms
 - Rockchip RK3399: USB3 OTG support
 - Samsung Exynos: Audio-over-HDMI on Odroid X/X2/U3
 - STMicro STM32: Lots of peripherals added to STM32MP175C
 - Uniphier: Ethernet support


New boards:

Allwinner A20: Olimex A20-SOM-EVB-eMMC variant
Allwinner H2+: Libre Computer ALL-H3-CC (h2+ version)
Allwinner A33: Nintendo NES/SuperNES Classic Edition
Aspeed: S2600WF, Inventec Lanyang BMC, Portwell Neptune
Berlin2CD: Valve Steam Link
Broadcom BCM5301X: Luxul XAP-1610 and XWR-3150 V1
Broadcom: Raspberry Pi 3 B+
Mediatek MT7623N and MT7623A  reference boards
Meson 8M2: Tronsmart MXIII Plus
NXP i.MX: Engicam i.CoreM6, DHCOM iMX6 SOM, BTicino i.MX6DL Mamoj
Qualcomm MSM8974: Sony Xperia Z1 Compact support
Qualcomm SDM845 MTP development board
Renesas: Ebisu R8A77990 board
Renesas RZ/G1C: iwg23s: iWave G235-SDB
TI am335x: Pocketbeagle support
