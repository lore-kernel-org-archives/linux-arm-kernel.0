From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Tue, 22 Apr 2014 10:27:26 +0200
Subject: [PATCH v2 0/2] ARM: berlin: add SDHCI support
Message-ID: <1398155248-1659-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds the Berlin BG2Q SDHCI nodes to support the 3 controllers
available. The Berlin BG2Q SDHCI controllers are compatible with the pxav3
driver. This patches also enable the SD Card reader and the eMMC of the
BG2Q DMP.

This series applies on top of Alexandre's patches for the Berlin's pll:
https://patchwork.kernel.org/patch/3890341/
https://patchwork.kernel.org/patch/3876271/

Changes since v1:
	The v2 introduced a custom Berlin SDHCI driver. It turns out the
	available pxav3 driver was compatible with the BG2Q SDHCI controllers.
	- removed the unneeded custom driver
	- switched to the pxav3 driver
	- removed the board specific properties from the SoC device tree

Antoine T?nart (2):
  ARM: dts: berlin: add the SDHCI nodes for the BG2Q
  ARM: dts: berlin: enable SD card reader and eMMC for the BG2Q DMP

 arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 11 ++++++++++
 arch/arm/boot/dts/berlin2q.dtsi            | 32 ++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

-- 
1.8.3.2
