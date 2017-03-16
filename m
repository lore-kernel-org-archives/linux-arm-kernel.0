From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 16 Mar 2017 16:16:26 +0100
Subject: [PATCH 0/2] arm64: marvell: support network on Armada 7K/8K
Message-ID: <1489677388-19320-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Now that the PPv2.2 support has been merged in the mvpp2 network
driver, we can finally enable networking support on the Armada 7K and
Armada 8K SoCs.

This small series:

 - Adds the Device Tree description of the PPv2.2 IP in both the
   master CP110 and slave CP110 (SoC description) and the description
   of a number of network interfaces available in the Armada 7K and
   Armada 8K development boards.

 - Enable the mvpp2 driver in the arm64 defconfig, since it's now used
   on ARM64 platforms.

Thanks!

Thomas

Thomas Petazzoni (2):
  arm64: marvell: dts: add PPv2.2 description to Armada 7K/8K
  arm64: defconfig: enable MVPP2

 arch/arm64/boot/dts/marvell/armada-7040-db.dts     | 25 +++++++++++++++
 arch/arm64/boot/dts/marvell/armada-8040-db.dts     | 16 ++++++++++
 .../boot/dts/marvell/armada-cp110-master.dtsi      | 37 ++++++++++++++++++++++
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 37 ++++++++++++++++++++++
 arch/arm64/configs/defconfig                       |  1 +
 5 files changed, 116 insertions(+)

-- 
2.7.4
