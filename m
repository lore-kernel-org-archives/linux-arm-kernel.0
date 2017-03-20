From: uwe@kleine-koenig.org (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 20 Mar 2017 09:21:11 +0100
Subject: [PATCH 2/2] ARM: dts: imx25-pinfunc: Move MX25_PAD_TDO__TDO to a more
 sensible place
In-Reply-To: <20170320082111.3249-1-uwe@kleine-koenig.org>
References: <20170320082111.3249-1-uwe@kleine-koenig.org>
Message-ID: <20170320082111.3249-2-uwe@kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pinfunc definitions are ordered by mux_reg and so automatically by
conf_reg, too. PAD_TDO is the only pad that has a conf_reg but no
mux_reg. Put it to the place where it its in the order of conf_regs
instead of the top.

Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
---
 arch/arm/boot/dts/imx25-pinfunc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx25-pinfunc.h b/arch/arm/boot/dts/imx25-pinfunc.h
index f987afce2f9d..6c63dca1b9b8 100644
--- a/arch/arm/boot/dts/imx25-pinfunc.h
+++ b/arch/arm/boot/dts/imx25-pinfunc.h
@@ -17,8 +17,6 @@
  * <mux_reg conf_reg input_reg mux_mode input_val>
  */
 
-#define MX25_PAD_TDO__TDO			0x000 0x3e8 0x000 0x00 0x000
-
 #define MX25_PAD_A10__A10			0x008 0x000 0x000 0x00 0x000
 #define MX25_PAD_A10__GPIO_4_0			0x008 0x000 0x000 0x05 0x000
 
@@ -541,6 +539,8 @@
 #define MX25_PAD_RTCK__OWIRE			0x1ec 0x3e4 0x000 0x01 0x000
 #define MX25_PAD_RTCK__GPIO_3_14		0x1ec 0x3e4 0x000 0x05 0x000
 
+#define MX25_PAD_TDO__TDO			0x000 0x3e8 0x000 0x00 0x000
+
 #define MX25_PAD_DE_B__DE_B			0x1f0 0x3ec 0x000 0x00 0x000
 #define MX25_PAD_DE_B__GPIO_2_20		0x1f0 0x3ec 0x000 0x05 0x000
 
-- 
2.11.0
