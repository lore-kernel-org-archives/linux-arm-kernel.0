From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 19 Jun 2017 09:37:29 +0200
Subject: [PATCH] arm64: dts: marvell: mcbin: enable the mdio node
Message-ID: <20170619073729.8367-1-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the mdio nodes are disabled by default now, we should explicitly
enable these nodes at the board level when they are used. Enable the
cpm_mdio node for the 8040-mcbin.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---

Hi Gregory,

The series disabling the mdio nodes at the SoC level forgot to enable
the cpm_mdio node for the 8040-mcbin. This is based on mvebu/dt64.

Thanks,
Antoine

 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
index fe56efcfcefe..4968e731de61 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
@@ -116,6 +116,8 @@
 };
 
 &cpm_mdio {
+	status = "okay";
+
 	ge_phy: ethernet-phy at 0 {
 		reg = <0>;
 	};
-- 
2.9.4
