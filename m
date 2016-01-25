From: zhangqing@rock-chips.com (Zhang Qing)
Date: Mon, 25 Jan 2016 08:56:00 -0800
Subject: [PATCH v1 1/3] clk: rockchip: rk3368: fix edp_24m parent
In-Reply-To: <1453740962-8556-1-git-send-email-zhangqing@rock-chips.com>
References: <1453740962-8556-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1453740962-8556-2-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: zhangqing <zhangqing@rock-chips.com>

The edp_24m parent select bit define is:
1'b0:xin24m
1'b1:1'b0(dummy)
so adapt the parent sel bit to the currect one.

Signed-off-by: zhangqing <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-rk3368.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3368.c b/drivers/clk/rockchip/clk-rk3368.c
index be0ede5..4885e6b 100644
--- a/drivers/clk/rockchip/clk-rk3368.c
+++ b/drivers/clk/rockchip/clk-rk3368.c
@@ -121,7 +121,7 @@ PNAME(mux_i2s_2ch_p)		= { "i2s_2ch_src", "i2s_2ch_frac",
 				    "dummy", "xin12m" };
 PNAME(mux_spdif_8ch_p)		= { "spdif_8ch_pre", "spdif_8ch_frac",
 				    "ext_i2s", "xin12m" };
-PNAME(mux_edp_24m_p)		= { "dummy", "xin24m" };
+PNAME(mux_edp_24m_p)		= { "xin24m", "dummy" };
 PNAME(mux_vip_out_p)		= { "vip_src", "xin24m" };
 PNAME(mux_usbphy480m_p)		= { "usbotg_out", "xin24m" };
 PNAME(mux_hsic_usbphy480m_p)	= { "usbotg_out", "dummy" };
-- 
1.9.1
