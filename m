From: taki@igel.co.jp (Takanari Hayama)
Date: Mon, 01 Jul 2013 16:38:53 +0900
Subject: [PATCH] ARM: shmobile: r8a73a4: Fix resources for SCIFB0
Message-ID: <51D1320D.4010709@igel.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takanari Hayama <taki@igel.co.jp>

Fix base address and IRQ resources associated with SCIFB0.

Signed-off-by: Takanari Hayama <taki@igel.co.jp>
---
 arch/arm/mach-shmobile/setup-r8a73a4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c
b/arch/arm/mach-shmobile/setup-r8a73a4.c
index c5a75a7..7f45c2e 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -62,7 +62,7 @@ enum { SCIFA0, SCIFA1, SCIFB0, SCIFB1, SCIFB2, SCIFB3 };
 static const struct plat_sci_port scif[] = {
 	SCIFA_DATA(SCIFA0, 0xe6c40000, gic_spi(144)), /* SCIFA0 */
 	SCIFA_DATA(SCIFA1, 0xe6c50000, gic_spi(145)), /* SCIFA1 */
-	SCIFB_DATA(SCIFB0, 0xe6c50000, gic_spi(145)), /* SCIFB0 */
+	SCIFB_DATA(SCIFB0, 0xe6c20000, gic_spi(148)), /* SCIFB0 */
 	SCIFB_DATA(SCIFB1, 0xe6c30000, gic_spi(149)), /* SCIFB1 */
 	SCIFB_DATA(SCIFB2, 0xe6ce0000, gic_spi(150)), /* SCIFB2 */
 	SCIFB_DATA(SCIFB3, 0xe6cf0000, gic_spi(151)), /* SCIFB3 */
-- 
1.8.0

-- 
Takanari Hayama, Ph.D. (taki at igel.co.jp)
IGEL Co.,Ltd.
http://www.igel.co.jp/
