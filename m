From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Thu, 13 Apr 2017 06:32:34 -0700
Subject: [PATCH 0/8] i.MX7 PCIe related device tree changes
Message-ID: <20170413133242.5068-1-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn, everyone:

This series includes changes made to device-tree in order to support
PCIe on i.MX7 platform. They include:

     - Bringing 'anatop-enable-bit' property of ANATOP regulators back
       and extending it to all of the HW it is applicable to

     - Adding GPCv2 node for i.MX7 (which was missing, despite the
       irqchip driver for it being in the tree for quite some time)

     - Adding a PCIe node for i.MX7

     - Adding GPIO expander used by PCIe and enabling PCIe node from
       above on i.MX7 based Sabre board

As usual, feedback is welcome.

Thanks,
Andrey Smrinov

Andrey Smirnov (8):
  Revert "ARM: dts: imx: Remove unexistant property"
  ARM: dts: imx6: Specify 'anatop-enable-bit' where appropriate
  ARM: dts: imx7s: Adjust anatop-enable-bit for 'reg_1p0d'
  ARM: dts: imx7s: Add node for GPC
  ARM: dts: imx7s: Mark 'gpr' compatible with i.MX6 variant
  ARM: dts: imx7d-sdb: Add GPIO expander node
  ARM: dts: imx7d: Add node for PCIe controller
  ARM: dts: imx7d-sdb: Enable PCIe peripheral

 arch/arm/boot/dts/imx6qdl.dtsi  |  3 +++
 arch/arm/boot/dts/imx6sl.dtsi   |  3 +++
 arch/arm/boot/dts/imx6sx.dtsi   |  3 +++
 arch/arm/boot/dts/imx6ul.dtsi   |  1 +
 arch/arm/boot/dts/imx7d-sdb.dts | 39 +++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx7d.dtsi    | 38 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx7s.dtsi    | 31 +++++++++++++++++++++++++++++--
 7 files changed, 116 insertions(+), 2 deletions(-)

-- 
2.9.3
