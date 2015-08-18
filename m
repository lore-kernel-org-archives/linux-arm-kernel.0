From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 18 Aug 2015 10:08:57 +0200
Subject: [PATCH 06/10] ARM: marvell/dt: define crypto SRAM ranges in
 armada-375-db.dts
In-Reply-To: <1439885341-14644-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1439885341-14644-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1439885341-14644-7-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the crypto SRAM ranges so that the resources referenced by the
sa-sram node can be properly extracted from the DT.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/armada-375-db.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-375-db.dts b/arch/arm/boot/dts/armada-375-db.dts
index 5711b97..cded5f0 100644
--- a/arch/arm/boot/dts/armada-375-db.dts
+++ b/arch/arm/boot/dts/armada-375-db.dts
@@ -65,7 +65,9 @@
 
 	soc {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
-			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000>;
+			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000
+			  MBUS_ID(0x09, 0x09) 0 0xf1100000 0x10000
+			  MBUS_ID(0x09, 0x05) 0 0xf1110000 0x10000>;
 
 		internal-regs {
 			spi at 10600 {
-- 
1.9.1
