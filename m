From: john@metanate.com (John Keeping)
Date: Wed,  7 Sep 2016 17:53:29 +0100
Subject: [PATCH 1/2] clk: rockchip: add I2S internal clock IDs for rk3288
Message-ID: <20160907165330.14607-1-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To minimize jitter on the I2S clocks, it is important that the
denominator in the fractional divider is much greater than the
numerator.  Add identifiers for these internal clocks so that the
specific clock topology and rates can be specified in the device tree.

Signed-off-by: John Keeping <john@metanate.com>
---
 include/dt-bindings/clock/rk3288-cru.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/clock/rk3288-cru.h b/include/dt-bindings/clock/rk3288-cru.h
index 9a586e2d9c91..9526653383d9 100644
--- a/include/dt-bindings/clock/rk3288-cru.h
+++ b/include/dt-bindings/clock/rk3288-cru.h
@@ -88,6 +88,9 @@
 #define SCLK_PVTM_GPU		124
 #define SCLK_CRYPTO		125
 #define SCLK_MIPIDSI_24M	126
+#define SCLK_I2S_PRE		127
+#define SCLK_I2S_SRC		128
+#define SCLK_I2S_FRAC		129
 
 #define SCLK_MAC		151
 #define SCLK_MACREF_OUT		152
-- 
2.9.3.728.g30b24b4.dirty
