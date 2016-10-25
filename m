From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Tue, 25 Oct 2016 23:19:50 +0200
Subject: [PATCH 0/5] ARM: dts: imx: update Boundary Devices boards support
Message-ID: <20161025211955.5345-1-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This series includes several patches to update the support for our platforms.

Here are the main goals of this series:
1- Adding support for our latest SOM (SOM2)
2- Fix panel naming consistency across the boards
  -> This way our U-Boot bootscript[1] can easily set the panel compatible.
3- Fix USB PHY reset for some boards
  -> U-Boot used to always set the reset pin whether usb was used or not.
     Anyway, the kernel should not be dependent on the bootloader.

Let me know if you have any question.

Regards,
Gary

[1] https://github.com/boundarydevices/u-boot-imx6/blob/boundary-v2016.03/board/boundary/nitrogen6x/6x_bootscript-mainline.txt

Gary Bisson (5):
  ARM: dts: imx: add Boundary Devices Nitrogen6_SOM2 support
  ARM: dts: imx6qdl-sabrelite: rename panel nodes
  ARM: dts: imx6qdl-sabrelite: add missing USB PHY reset control
  ARM: dts: imx6qdl-nitrogen6x: rename panel nodes
  ARM: dts: imx6qdl-nitrogen6x: add missing USB PHY reset control

 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/imx6q-nitrogen6_som2.dts    |  53 ++
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi | 770 ++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi     |  24 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi      |  24 +-
 5 files changed, 868 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6q-nitrogen6_som2.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi

-- 
2.9.3
