From: chiau.ee.chew@intel.com (Chew Chiau Ee)
Date: Tue,  3 Jun 2014 03:46:19 +0800
Subject: [PATCH 2/2] clkdev: Export clk_register_clkdev
In-Reply-To: <1401738379-4107-1-git-send-email-chiau.ee.chew@intel.com>
References: <1401738379-4107-1-git-send-email-chiau.ee.chew@intel.com>
Message-ID: <1401738379-4107-3-git-send-email-chiau.ee.chew@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Darren Hart <dvhart@linux.intel.com>

Allow spi-pxa2xx-pci with common clock framework support to build as a
module by exporting clk_register_clkdev.

Signed-off-by: Darren Hart <dvhart@linux.intel.com>
Reviewed-by: Chew, Chiau Ee <chiau.ee.chew@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/clk/clkdev.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index a360b2e..bb48348 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -310,6 +310,7 @@ int clk_register_clkdev(struct clk *clk, const char *con_id,
 
 	return 0;
 }
+EXPORT_SYMBOL(clk_register_clkdev);
 
 /**
  * clk_register_clkdevs - register a set of clk_lookup for a struct clk
-- 
1.7.4.4
