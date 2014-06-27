From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Fri, 27 Jun 2014 15:25:08 +0200
Subject: [PATCH v2 11/14] drivers: clk: st: STiH407: Support for
 clockgenD0/D2/D3
In-Reply-To: <1403875511-7710-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1403875511-7710-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1403875511-7710-12-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch added support for ClockGenD0/D2/D3
It includes one 660 Quadfs.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
Signed-off-by: Olivier Bideau <olivier.bideau@st.com>
Acked-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/clk/st/clkgen-fsyn.c | 46 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
index 0e0d5f9..2b6cb1c 100644
--- a/drivers/clk/st/clkgen-fsyn.c
+++ b/drivers/clk/st/clkgen-fsyn.c
@@ -298,6 +298,48 @@ static const struct clkgen_quadfs_data st_fs660c32_C_407 = {
 	.get_rate	= clk_fs660c32_dig_get_rate,
 };
 
+static const struct clkgen_quadfs_data st_fs660c32_D_407 = {
+	.nrst_present = true,
+	.nrst	= { CLKGEN_FIELD(0x2a0, 0x1, 0),
+		    CLKGEN_FIELD(0x2a0, 0x1, 1),
+		    CLKGEN_FIELD(0x2a0, 0x1, 2),
+		    CLKGEN_FIELD(0x2a0, 0x1, 3) },
+	.ndiv	= CLKGEN_FIELD(0x2a4, 0x7, 16),
+	.pe	= { CLKGEN_FIELD(0x2b4, 0x7fff, 0),
+		    CLKGEN_FIELD(0x2b8, 0x7fff, 0),
+		    CLKGEN_FIELD(0x2bc, 0x7fff, 0),
+		    CLKGEN_FIELD(0x2c0, 0x7fff, 0) },
+	.sdiv	= { CLKGEN_FIELD(0x2b4, 0xf, 20),
+		    CLKGEN_FIELD(0x2b8, 0xf, 20),
+		    CLKGEN_FIELD(0x2bc, 0xf, 20),
+		    CLKGEN_FIELD(0x2c0, 0xf, 20) },
+	.npda	= CLKGEN_FIELD(0x2a0, 0x1, 12),
+	.nsb	= { CLKGEN_FIELD(0x2a0, 0x1, 8),
+		    CLKGEN_FIELD(0x2a0, 0x1, 9),
+		    CLKGEN_FIELD(0x2a0, 0x1, 10),
+		    CLKGEN_FIELD(0x2a0, 0x1, 11) },
+	.nsdiv_present = true,
+	.nsdiv	= { CLKGEN_FIELD(0x2b4, 0x1, 24),
+		    CLKGEN_FIELD(0x2b8, 0x1, 24),
+		    CLKGEN_FIELD(0x2bc, 0x1, 24),
+		    CLKGEN_FIELD(0x2c0, 0x1, 24) },
+	.mdiv	= { CLKGEN_FIELD(0x2b4, 0x1f, 15),
+		    CLKGEN_FIELD(0x2b8, 0x1f, 15),
+		    CLKGEN_FIELD(0x2bc, 0x1f, 15),
+		    CLKGEN_FIELD(0x2c0, 0x1f, 15) },
+	.en	= { CLKGEN_FIELD(0x2ac, 0x1, 0),
+		    CLKGEN_FIELD(0x2ac, 0x1, 1),
+		    CLKGEN_FIELD(0x2ac, 0x1, 2),
+		    CLKGEN_FIELD(0x2ac, 0x1, 3) },
+	.lockstatus_present = true,
+	.lock_status = CLKGEN_FIELD(0x2A0, 0x1, 24),
+	.powerup_polarity = 1,
+	.standby_polarity = 1,
+	.pll_ops	= &st_quadfs_pll_c32_ops,
+	.rtbl		= fs660c32_rtbl,
+	.rtbl_cnt	= ARRAY_SIZE(fs660c32_rtbl),
+	.get_rate	= clk_fs660c32_dig_get_rate,};
+
 /**
  * DOC: A Frequency Synthesizer that multiples its input clock by a fixed factor
  *
@@ -985,6 +1027,10 @@ static struct of_device_id quadfs_of_match[] = {
 		.compatible = "st,stih407-quadfs660-C",
 		.data = (void *)&st_fs660c32_C_407
 	},
+	{
+		.compatible = "st,stih407-quadfs660-D",
+		.data = (void *)&st_fs660c32_D_407
+	},
 	{}
 };
 
-- 
1.9.1
