From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Dec 2013 19:41:30 +0000
Subject: [PATCH 0/2] Add support for SolidRun's IMX6 board
Message-ID: <20131217194130.GA4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So, this patch series adds support for SolidRun's new platform which
is similar in size to a well known board named after a type of fruit.
These two patches add the basic support for the platform, without HDMI.

Having discussed the timing of this with Rabeeh, I have his blessing to
post this now.

The platform is made up from two boards:
- A microsom board, which is re-used in the Cubox-I.  This board comes
  in a couple of different configurations:
  - AR8035 gigabit ethernet phy fitted
  - AR8030 fast ethernet phy fitted
  In order to support these two configurations, I have split the Ethernet
  support from the rest of the microsom.  When the AR8030 versions are
  available and known, I'll add the imx6qdl-microsom-ar8030.dtsi file.
- The base board.

Not many changes are required to the code - the only requirement is the
need to add AR8035 ethernet phy configuration support to the IMX6Q code.

 arch/arm/boot/dts/Makefile                     |    1 +
 arch/arm/boot/dts/imx6dl-hummingboard.dts      |   90 ++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi |   58 +++++++++++++++
 arch/arm/boot/dts/imx6qdl-microsom.dtsi        |   80 +++++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig           |    4 +
 arch/arm/mach-imx/mach-imx6q.c                 |   35 +++++++++
 6 files changed, 268 insertions(+), 0 deletions(-)
