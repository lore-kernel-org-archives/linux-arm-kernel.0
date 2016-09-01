From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  1 Sep 2016 17:41:22 +0200
Subject: [PATCH 0/2] arm64: marvell: MSI support updates
Message-ID: <1472744484-19132-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This small set of patches brings some MSI updates on Armada 3700 and
Armada 7K/8K:

 - On Armada 3700, it removes a useless msi-parent property. This
   patch should only be merged once "pci: pci-aardvark: move to MSI
   handling using generic MSI support" has been applied and merged by
   the PCI maintainer, otherwise MSI support will be broken.

 - On Armada 7K/8K, it enables MSI support by using the GIC
   v2m. Adding an msi-parent property is enough to achieve this. This
   can be applied right away.

Thanks,

Thomas

Thomas Petazzoni (2):
  arm64: dts: marvell: remove msi-parent from PCIe on Armada 3700
  arm64: dts: marvell: enable MSI for PCIe on Armada 7K/8K

 arch/arm64/boot/dts/marvell/armada-37xx.dtsi         | 1 -
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 3 +++
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.7.4
