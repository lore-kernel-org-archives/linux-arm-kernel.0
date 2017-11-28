From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Nov 2017 15:00:46 +0000
Subject: [PATCH v2 00/16] SolidRun Hummingboard DT updates
Message-ID: <20171128150045.GV31757@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

This series updates the SolidRun Hummingboard platforms to:
(a) make the DT more reflective of the schematics
(b) re-organise how we deal with the differences between various board
    versions in preparation for the new 1.5 SOM.

The idea with (b) is that we add the support for the board + usom
combination by including the appropriate dtsi files.

For example, in mainline at the moment, we support two variants of the
Hummingboards - both with Broadcom Wi-Fi and without eMMC.  Going
forward, when a 1.5 SOM is fitted (which modern Hummingboards will all
have) the boards will have TI Wi-Fi and potentially eMMC on the usom.

This series adds the dtsi files for the new SOM and dts files for the
platform variants (v1.5 SOM without eMMC, v1.5 SOM with eMMC.)  It's
unfortunate that the w/o eMMC variant can't detect the lack of eMMC,
running the eMMC version without eMMC on the boards results in an
almost constant stream of kernel messages.

Feedback from the previous posting has been addressed, and additional
changes adding the v1.5 SOM board level files added through discussion
with Jon.

 arch/arm/boot/dts/Makefile                         |   8 +
 arch/arm/boot/dts/imx6dl-cubox-i-emmc-som-v15.dts  |  52 +++++++
 arch/arm/boot/dts/imx6dl-cubox-i-som-v15.dts       |  51 +++++++
 arch/arm/boot/dts/imx6dl-cubox-i.dts               |   2 +
 .../boot/dts/imx6dl-hummingboard-emmc-som-v15.dts  |  53 +++++++
 arch/arm/boot/dts/imx6dl-hummingboard-som-v15.dts  |  52 +++++++
 arch/arm/boot/dts/imx6dl-hummingboard.dts          |   2 +
 arch/arm/boot/dts/imx6q-cubox-i-emmc-som-v15.dts   |  60 ++++++++
 arch/arm/boot/dts/imx6q-cubox-i-som-v15.dts        |  59 +++++++
 arch/arm/boot/dts/imx6q-cubox-i.dts                |   2 +
 arch/arm/boot/dts/imx6q-h100.dts                   |   4 +-
 .../boot/dts/imx6q-hummingboard-emmc-som-v15.dts   |  61 ++++++++
 arch/arm/boot/dts/imx6q-hummingboard-som-v15.dts   |  60 ++++++++
 arch/arm/boot/dts/imx6q-hummingboard.dts           |   2 +
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi             |  72 ++++-----
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi        | 103 ++++++++-----
 arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi     |  99 ------------
 arch/arm/boot/dts/imx6qdl-microsom.dtsi            | 161 -------------------
 arch/arm/boot/dts/imx6qdl-sr-som-brcm.dtsi         | 144 +++++++++++++++++
 arch/arm/boot/dts/imx6qdl-sr-som-emmc.dtsi         |  70 +++++++++
 arch/arm/boot/dts/imx6qdl-sr-som-ti.dtsi           | 170 +++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-sr-som.dtsi              | 121 +++++++++++++++
 22 files changed, 1072 insertions(+), 336 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
