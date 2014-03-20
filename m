From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 20 Mar 2014 13:55:22 +0900
Subject: [PATCH v3 1/4] clk: samsung: add new Kconfig for Samsung common clock
 option
In-Reply-To: <1395291325-4043-1-git-send-email-pankaj.dubey@samsung.com>
References: <1394598781-3848-1-git-send-email-pankaj.dubey@samsung.com>
 <1395291325-4043-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1395291325-4043-2-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds new Kconfig file for adding new COMMON_CLK_SAMSUNG option.
Samsung platforms can select this for using common clock infrastructure.

CC: Tomasz Figa <t.figa@samsung.com>
CC: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 drivers/clk/Kconfig         |    2 ++
 drivers/clk/samsung/Kconfig |    3 +++
 2 files changed, 5 insertions(+)
 create mode 100644 drivers/clk/samsung/Kconfig

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 7641965..f2b6179 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -112,3 +112,5 @@ source "drivers/clk/qcom/Kconfig"
 endmenu
 
 source "drivers/clk/mvebu/Kconfig"
+
+source "drivers/clk/samsung/Kconfig"
diff --git a/drivers/clk/samsung/Kconfig b/drivers/clk/samsung/Kconfig
new file mode 100644
index 0000000..fc8696b
--- /dev/null
+++ b/drivers/clk/samsung/Kconfig
@@ -0,0 +1,3 @@
+config COMMON_CLK_SAMSUNG
+	bool
+	select COMMON_CLK
-- 
1.7.10.4
