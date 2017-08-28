From: mw@semihalf.com (Marcin Wojtas)
Date: Mon, 28 Aug 2017 23:14:14 +0200
Subject: [PATCH 2/2] arm64: dts: marvell: Force 3byte addressing mode for SPI
 on A7040 DB
In-Reply-To: <1503954854-30963-1-git-send-email-mw@semihalf.com>
References: <1503954854-30963-1-git-send-email-mw@semihalf.com>
Message-ID: <1503954854-30963-3-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Armada 7040 DB boards can be shipped with various models of
boot SPI flash devices. An issue can emerge, when their size
exceeds 16MB - in such case the kernel driver will switch automatically
to 4B addressing mode. Later, in case of soft reset, the Boot ROM
will fail to fetch the firmware during the board initialization.

In order to prevent such behavior, this patch forces 3B addressing
mode used on affected boards by adding newly introduced
'spi-3byte-addressing' property to the SPI flash nodes.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index 92c761c..d0bd296 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -116,6 +116,7 @@
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-max-frequency = <20000000>;
+		spi-3byte-addressing;
 
 		partitions {
 			compatible = "fixed-partitions";
-- 
1.8.3.1
