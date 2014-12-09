From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  9 Dec 2014 09:37:12 +0900
Subject: [PATCH] ARM: shmobile: koelsch: Fix QSPI mode of SPI-Flash into mode3
Message-ID: <1418085432-20374-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>

In order to change into mode3, CPOL and CPHA bit of SPCMD register
of QSPI is changed. Mode3 can avoid intermediate voltage.

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
[horms: Updated changelog and re-ordered properties]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

Based on the renesas-devel-20141208-v3.18 tag of my renesas tree

* Changes by Simon Horman as suggested by Geert Uytterhoeven
- Changed name from
  "ARM: shmobile: koelsch: Fix SPI mode of SPI-Flash into mode3" to
  "ARM: shmobile: koelsch: Fix QSPI mode of SPI-Flash into mode3"
- Updated changelog to refer to QSPI instead of MSIOF
- Grouped spi-* properties
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 6938377..a9a6e37 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -444,6 +444,8 @@
 		spi-max-frequency = <30000000>;
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
+		spi-cpha;
+		spi-cpol;
 		m25p,fast-read;
 
 		partition at 0 {
-- 
2.1.3
