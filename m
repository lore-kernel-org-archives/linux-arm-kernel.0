From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 19 May 2017 13:45:41 +0530
Subject: [PATCH 41/41] Documentation: ARM: Document new dependencies for MMC
 on DRA7
In-Reply-To: <20170519081541.26753-1-kishon@ti.com>
References: <20170519081541.26753-1-kishon@ti.com>
Message-ID: <20170519081541.26753-42-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MMC on DRA7 SoCs require different IO Delay values to be configured
depending on the MMC mode. In order to confgiure these IO Delay values
CONFIG_PINCTRL_TI_IODELAY must be enabled. Document this dependency
here so that it can be added by anyone using custom .config.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/arm/OMAP/README | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/arm/OMAP/README b/Documentation/arm/OMAP/README
index 75645c45d14a..df018c59e36a 100644
--- a/Documentation/arm/OMAP/README
+++ b/Documentation/arm/OMAP/README
@@ -5,3 +5,7 @@ KERNEL		NEW DEPENDENCIES
 v4.3+		Update is needed for custom .config files to make sure
 		CONFIG_REGULATOR_PBIAS is enabled for MMC1 to work
 		properly.
+
+v4.13+		Update is needed for custom .config files to make sure
+		CONFIG_PINCTRL_TI_IODELAY is enabled for all MMC instances
+		to work properly in DRA7 based boards.
-- 
2.11.0
