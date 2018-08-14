From: jacopo+renesas@jmondi.org (Jacopo Mondi)
Date: Tue, 14 Aug 2018 15:21:44 +0200
Subject: [PATCH v2 0/2] ARM: dts: imx: Add Engicam 1.5 MX6 support
Message-ID: <1534252906-29554-1-git-send-email-jacopo+renesas@jmondi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
   the 'EDIMM Starter Kit 1.5 MIPI Evaluation" board, whose support has been
introduced by commit:
commit 3fe08835773121870b1de7d0cac9a4ade796661e ("ARM: dts: imx6q: Add Engicam
i.CoreM6 1.5 Quad/Dual MIPI starter kit support")

is actually based on 1.5 version of the "i.Core 1.5 MX6" CPU module which
differs from the original "i.Core MX6" for a few details, including the one that
has sparkled this activity: the ethernet PHY interface clock provider.

Instead of fixing the PHY clock provider in the imx6q-icore-mipi.dts file, I
preferred adding a new .dtsi for the 1.5 version of the module, to gather
differences between version in a single place. Then I've referenced the new one
in the dts file.

As a result, the ethernet interface is now working on the EDIMM 1.5 MIPI
evaluation kit.

Thanks
   j

v1 -> v2:
- Add Fabio's Reviewed-by tags
- Adjust commit message in [2/2]

Jacopo Mondi (2):
  ARM: dts: imx6qdl: Add Engicam i.Core 1.5 MX6
  ARM: dts: imx6q-icore-mipi: Use 1.5 version of i.Core MX6

 arch/arm/boot/dts/imx6q-icore-mipi.dts   |  4 ++--
 arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi | 34 ++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi

--
2.7.4
