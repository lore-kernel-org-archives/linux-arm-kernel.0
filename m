From: joe@perches.com (Joe Perches)
Date: Sun, 29 Mar 2015 18:25:12 -0700
Subject: [PATCH net-next] ethernet: Use bool function returns of true/false
 instead of 1/0
In-Reply-To: <20150329.121655.2092434262655191613.davem@davemloft.net>
References: <201503260524.AdqSbov9%fengguang.wu@intel.com>
 <20150325215525.GA26868@athens>
 <20150329.121655.2092434262655191613.davem@davemloft.net>
Message-ID: <1427678712.2715.52.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use bool constants as the return values instead of 1 and 0.

Signed-off-by: Joe Perches <joe@perches.com>
---
> To be honest I'd might rather get bunches of these, there has to be a ton
> of them, than a slow trickle of one every few weeks/days.

There aren't too many...

 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 4 ++--
 drivers/net/ethernet/xilinx/xilinx_emaclite.c    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 039b0c1..9980912 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -11610,7 +11610,7 @@ static bool bnx2x_get_dropless_info(struct bnx2x *bp)
 	u32 cfg;
 
 	if (IS_VF(bp))
-		return 0;
+		return false;
 
 	if (IS_MF(bp) && !CHIP_IS_E1x(bp)) {
 		/* Take function: tmp = func */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 02ffb30..ccaecb1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -1351,7 +1351,7 @@ static bool reg_pattern_test(struct ixgbe_adapter *adapter, u64 *data, int reg,
 
 	if (ixgbe_removed(adapter->hw.hw_addr)) {
 		*data = 1;
-		return 1;
+		return true;
 	}
 	for (pat = 0; pat < ARRAY_SIZE(test_pattern); pat++) {
 		before = ixgbe_read_reg(&adapter->hw, reg);
@@ -1376,7 +1376,7 @@ static bool reg_set_and_check(struct ixgbe_adapter *adapter, u64 *data, int reg,
 
 	if (ixgbe_removed(adapter->hw.hw_addr)) {
 		*data = 1;
-		return 1;
+		return true;
 	}
 	before = ixgbe_read_reg(&adapter->hw, reg);
 	ixgbe_write_reg(&adapter->hw, reg, write & mask);
diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 2111b91..6008eee 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -1062,7 +1062,7 @@ static bool get_bool(struct platform_device *ofdev, const char *s)
 	} else {
 		dev_warn(&ofdev->dev, "Parameter %s not found,"
 			"defaulting to false\n", s);
-		return 0;
+		return false;
 	}
 }
 
