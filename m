From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 25 Aug 2016 14:21:55 +0800
Subject: [PATCH v3 1/6] clk: sunxi-ng: nkm: Correct mux clock macro name
In-Reply-To: <20160825062200.17206-1-wens@csie.org>
References: <20160825062200.17206-1-wens@csie.org>
Message-ID: <20160825062200.17206-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mux support for NKM style clocks was added in commit a36583595c17 ("clk:
sunxi-ng: nkm: Add mux to support multiple parents"). The macros for mux
clocks was later changed in commit ad4578dc4cfa ("clk: sunxi-ng: mux:
Rename mux macro to be consistent"), but the NKM style clock header was
missed.

Fix the macro name so NKM with mux compiles correctly.

Fixes: a36583595c17 ("clk: sunxi-ng: nkm: Add mux to support multiple
		      parents")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v2: new patch
---
 drivers/clk/sunxi-ng/ccu_nkm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu_nkm.h b/drivers/clk/sunxi-ng/ccu_nkm.h
index fcb152fc4eda..35493fddd8ab 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.h
+++ b/drivers/clk/sunxi-ng/ccu_nkm.h
@@ -49,7 +49,7 @@ struct ccu_nkm {
 		.k		= _SUNXI_CCU_MULT(_kshift, _kwidth),	\
 		.n		= _SUNXI_CCU_MULT(_nshift, _nwidth),	\
 		.m		= _SUNXI_CCU_DIV(_mshift, _mwidth),	\
-		.mux		= SUNXI_CLK_MUX(_muxshift, _muxwidth),	\
+		.mux		= _SUNXI_CCU_MUX(_muxshift, _muxwidth),	\
 		.common		= {					\
 			.reg		= _reg,				\
 			.hw.init	= CLK_HW_INIT_PARENTS(_name,	\
-- 
2.9.3
