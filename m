From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Mon, 12 May 2014 18:06:32 +0200
Subject: [PATCH 04/12] drivers: clk: st: STiH407: Support for A9 MUX Clocks
In-Reply-To: <1399910800-12847-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1399910800-12847-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1399910800-12847-5-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch supports the A9-mux clocks used by ClockGenA9

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
Signed-off-by: Olivier Bideau <olivier.bideau@st.com>
---
 drivers/clk/st/clkgen-mux.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/st/clkgen-mux.c b/drivers/clk/st/clkgen-mux.c
index a329906..9bdedc8 100644
--- a/drivers/clk/st/clkgen-mux.c
+++ b/drivers/clk/st/clkgen-mux.c
@@ -580,6 +580,11 @@ static struct clkgen_mux_data stih416_a9_mux_data = {
 	.shift = 0,
 	.width = 2,
 };
+static struct clkgen_mux_data stih407_a9_mux_data = {
+	.offset = 0x1a4,
+	.shift = 1,
+	.width = 2,
+};
 
 static struct of_device_id mux_of_match[] = {
 	{
@@ -610,6 +615,10 @@ static struct of_device_id mux_of_match[] = {
 		.compatible = "st,stih416-clkgen-a9-mux",
 		.data = &stih416_a9_mux_data,
 	},
+	{
+		.compatible = "st,stih407-clkgen-a9-mux",
+		.data = &stih407_a9_mux_data,
+	},
 	{}
 };
 
-- 
1.9.1
