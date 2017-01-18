From: raviteja.garimella@broadcom.com (Raviteja Garimella)
Date: Wed, 18 Jan 2017 17:50:01 +0530
Subject: [PATCH v2 0/3] Support for USB DRD Phy driver for NS2 
Message-ID: <1484742004-6792-1-git-send-email-raviteja.garimella@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes from v1:
===============
1. Initialize file operatiosn .owner field with THIS_MODULE
2. Remove unnecessary gpio example in DT bindings documentation.
   This is previously acked by Rob Herring <robh@kernel.org>.

Introduction:

This patch adds support for USB Dual Role Device Phy for Broadcom
Northstar2 SoC. Apart from the new phy driver, this patchset contains
changes to Kconfig, Makefile, and Device tree files.

This patchset is tested on Broadcom NS2 BCM958712K reference board.

Repo: https://github.com/Broadcom/arm64-linux.git
Branch: ns2_drdphy_v2

Raviteja Garimella (3):
  Add DT bindings documentation for NS2 USB DRD phy
  Broadcom USB DRD Phy driver for Northstar2
  DT nodes for Broadcom Northstar2 USB DRD Phy

 .../devicetree/bindings/phy/brcm,ns2-drd-phy.txt   |  30 ++
 arch/arm64/boot/dts/broadcom/ns2.dtsi              |  14 +
 drivers/phy/Kconfig                                |  13 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-bcm-ns2-usbdrd.c                   | 588 +++++++++++++++++++++
 5 files changed, 646 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,ns2-drd-phy.txt
 create mode 100644 drivers/phy/phy-bcm-ns2-usbdrd.c

-- 
2.1.0
