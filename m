From: mw@semihalf.com (Marcin Wojtas)
Date: Fri, 14 Nov 2014 16:57:27 +0100
Subject: [PATCH v3 0/5] Minor fixes for Marvell Armada 38x SoC.
Message-ID: <1415980652-7429-1-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

It seems that my server at work is not properly configured to be accepted by
LAKML. Now everything should be ok.

Changes from v2:
* Add 'Acked-by: Andrew Lunn <andrew@lunn.ch>' information to the commit logs

Changes from v1:
* Improve commit log with better justification for changing ethernet
  aliases format in Armada 38x Device Tree

This patchset adds minor fixes for Armada 38x SoC around SDHCI interface. It
also enables usage of I2C char-device and adjusts ethernet aliases for
bootloader's needs. Any feedback is welcome.


Marcin Wojtas (5):
  ARM: mvebu: re-enable SDHCI driver for Armada 38x SoC in v7 defconfig
  ARM: mvebu: enable no-1-8-v flag for Armada 385 DB SDHCI interface
  ARM: mvebu: remove clock-frequency from Armada 38x SDHCI Device Tree
    node
  ARM: mvebu: adjust ethernet aliases according to U-Boot requirements
    for A38x
  ARM: mvebu: enable i2c device in mvebu_v7_defconfig

 arch/arm/boot/dts/armada-385-db.dts | 2 +-
 arch/arm/boot/dts/armada-38x.dtsi   | 6 +++---
 arch/arm/configs/mvebu_v7_defconfig | 2 ++
 3 files changed, 6 insertions(+), 4 deletions(-)

-- 
1.8.3.1
