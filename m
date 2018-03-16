From: antoine.tenart@bootlin.com (Antoine Tenart)
Date: Fri, 16 Mar 2018 11:33:50 +0100
Subject: [PATCH net-next 09/10] arm64: dts: marvell: 8040-db: set the 10G
 interfaces management to in-band
In-Reply-To: <20180316103351.16616-1-antoine.tenart@bootlin.com>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
Message-ID: <20180316103351.16616-10-antoine.tenart@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch sets the 10G interfaces (cp0_eth0, cp1_eth0) management to
in-band. This is needed for the PPv2 driver to handle such ports, with
its conversion to phylink.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-8040-db.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
index dba55baff20f..f6224d323c7a 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
@@ -216,6 +216,7 @@
 &cp0_eth0 {
 	status = "okay";
 	phy-mode = "10gbase-kr";
+	managed = "in-band-status";
 };
 
 &cp0_eth2 {
@@ -334,6 +335,7 @@
 &cp1_eth0 {
 	status = "okay";
 	phy-mode = "10gbase-kr";
+	managed = "in-band-status";
 };
 
 &cp1_eth1 {
-- 
2.14.3
