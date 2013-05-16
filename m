From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 16 May 2013 17:49:16 +0200
Subject: [PATCH v2] clk: si5351: declare all device IDs for module loading
Message-ID: <20130516174916.2daa49b6@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the si5351 driver is a kernel module, it is loaded into memory
from its i2c device IDs, but not from its DT compatible properties.

This patch declares the i2c device IDs of all chip variants.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
v2: subject change - was "ARM: dove: ..."
--- 
 drivers/clk/clk-si5351.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
index 8927284..9ebdddd 100644
--- a/drivers/clk/clk-si5351.c
+++ b/drivers/clk/clk-si5351.c
@@ -1490,7 +1490,10 @@ static int si5351_i2c_probe(struct i2c_client *client,
 }
 
 static const struct i2c_device_id si5351_i2c_ids[] = {
-	{ "silabs,si5351", 0 },
+	{ "si5351a", 0 },
+	{ "si5351a-msop", 0 },
+	{ "si5351b", 0 },
+	{ "si5351c", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, si5351_i2c_ids);


-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
