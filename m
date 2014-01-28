From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 28 Jan 2014 09:47:29 +0100
Subject: [PATCH] clk: si5351: fix non-DT build breakage
In-Reply-To: <1390682911-9022-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1390682911-9022-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1390898849-761-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch ("clk: si5351: remove variant from platform_data") changed parameters
passed to si5351_dt_parse. While it builds fine with CONFIG_OF, the non-DT
stub of si5351_dt_parse has not been updated and fails to build there.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Reported-by: Kbuild Test Robot <fengguang.wu@intel.com>
---
Mike,

sorry for that one. Feel free to squash this one into the original patch.

Sebastian

Cc: Mike Turquette <mturquette@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/clk/clk-si5351.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
index b95aa09b7aed..e9ee2e12d9cc 100644
--- a/drivers/clk/clk-si5351.c
+++ b/drivers/clk/clk-si5351.c
@@ -1293,7 +1293,8 @@ static int si5351_dt_parse(struct i2c_client *client,
 	return 0;
 }
 #else
-static int si5351_dt_parse(struct i2c_client *client)
+static int si5351_dt_parse(struct i2c_client *client,
+			   enum si5351_variant variant)
 {
 	return 0;
 }
-- 
1.8.5.2
