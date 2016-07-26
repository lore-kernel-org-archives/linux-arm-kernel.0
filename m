From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Jul 2016 22:30:29 +0200
Subject: [PATCH 01/13] clk: sunxi-ng: mux: Rename mux macro to be consistent
In-Reply-To: <20160726203041.29366-1-maxime.ripard@free-electrons.com>
References: <20160726203041.29366-1-maxime.ripard@free-electrons.com>
Message-ID: <20160726203041.29366-2-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename the internal mux macro to be consistent with the other internal
structure macros.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/ccu_div.h | 2 +-
 drivers/clk/sunxi-ng/ccu_mp.h  | 2 +-
 drivers/clk/sunxi-ng/ccu_mux.h | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_div.h b/drivers/clk/sunxi-ng/ccu_div.h
index 653ade5769b3..5d98549e23a6 100644
--- a/drivers/clk/sunxi-ng/ccu_div.h
+++ b/drivers/clk/sunxi-ng/ccu_div.h
@@ -83,7 +83,7 @@ struct ccu_div {
 	struct ccu_div _struct = {					\
 		.enable	= _gate,					\
 		.div	= _SUNXI_CCU_DIV(_mshift, _mwidth),		\
-		.mux	= SUNXI_CLK_MUX(_muxshift, _muxwidth),		\
+		.mux	= _SUNXI_CCU_MUX(_muxshift, _muxwidth),		\
 		.common	= {						\
 			.reg		= _reg,				\
 			.hw.init	= CLK_HW_INIT_PARENTS(_name,	\
diff --git a/drivers/clk/sunxi-ng/ccu_mp.h b/drivers/clk/sunxi-ng/ccu_mp.h
index 3cf12bf95962..edf9215ea8cc 100644
--- a/drivers/clk/sunxi-ng/ccu_mp.h
+++ b/drivers/clk/sunxi-ng/ccu_mp.h
@@ -44,7 +44,7 @@ struct ccu_mp {
 		.enable	= _gate,					\
 		.m	= _SUNXI_CCU_DIV(_mshift, _mwidth),		\
 		.p	= _SUNXI_CCU_DIV(_pshift, _pwidth),		\
-		.mux	= SUNXI_CLK_MUX(_muxshift, _muxwidth),		\
+		.mux	= _SUNXI_CCU_MUX(_muxshift, _muxwidth),		\
 		.common	= {						\
 			.reg		= _reg,				\
 			.hw.init	= CLK_HW_INIT_PARENTS(_name,	\
diff --git a/drivers/clk/sunxi-ng/ccu_mux.h b/drivers/clk/sunxi-ng/ccu_mux.h
index 945082631e7d..95cfecec3c39 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.h
+++ b/drivers/clk/sunxi-ng/ccu_mux.h
@@ -21,7 +21,7 @@ struct ccu_mux_internal {
 	} variable_prediv;
 };
 
-#define SUNXI_CLK_MUX(_shift, _width)	\
+#define _SUNXI_CCU_MUX(_shift, _width)		\
 	{					\
 		.shift	= _shift,		\
 		.width	= _width,		\
@@ -37,7 +37,7 @@ struct ccu_mux {
 
 #define SUNXI_CCU_MUX(_struct, _name, _parents, _reg, _shift, _width, _flags) \
 	struct ccu_mux _struct = {					\
-		.mux	= SUNXI_CLK_MUX(_shift, _width),		\
+		.mux	= _SUNXI_CCU_MUX(_shift, _width),		\
 		.common	= {						\
 			.reg		= _reg,				\
 			.hw.init	= CLK_HW_INIT_PARENTS(_name,	\
@@ -51,7 +51,7 @@ struct ccu_mux {
 				_shift, _width, _gate, _flags)		\
 	struct ccu_mux _struct = {					\
 		.enable	= _gate,					\
-		.mux	= SUNXI_CLK_MUX(_shift, _width),		\
+		.mux	= _SUNXI_CCU_MUX(_shift, _width),		\
 		.common	= {						\
 			.reg		= _reg,				\
 			.hw.init	= CLK_HW_INIT_PARENTS(_name,	\
-- 
2.9.2
