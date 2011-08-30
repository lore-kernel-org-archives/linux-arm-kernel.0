From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 30 Aug 2011 11:46:09 -0600
Subject: [PATCH REPOST 2/3] i2c: i2c-tegra: add I2C_FUNC_SMBUS_EMUL
In-Reply-To: <1314726370-8193-1-git-send-email-swarren@nvidia.com>
References: <1314726370-8193-1-git-send-email-swarren@nvidia.com>
Message-ID: <1314726370-8193-3-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mike Rapoport <mike@compulab.co.il>

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/i2c/busses/i2c-tegra.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index dd1f21b..8848a4b 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -532,7 +532,7 @@ static int tegra_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 
 static u32 tegra_i2c_func(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C;
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
 
 static const struct i2c_algorithm tegra_i2c_algo = {
-- 
1.7.0.4
