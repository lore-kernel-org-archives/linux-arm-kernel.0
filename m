From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 03 Dec 2009 06:49:55 -0700
Subject: [PATCH 08/10] OMAP: hwmod: warn on missing clockdomain
In-Reply-To: <20091203134852.17146.81997.stgit@localhost.localdomain>
References: <20091203134852.17146.81997.stgit@localhost.localdomain>
Message-ID: <20091203134954.17146.50776.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Hilman <khilman@deeprootsystems.com>

WARN if a clock/hwmod is missing a clockdomain association since
resulting hwmod will not be able to correctly enable/disable clocks.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index cb5bf34..adc86e0 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -352,6 +352,9 @@ static int _init_main_clk(struct omap_hwmod *oh)
 		ret = -EINVAL;
 	oh->_clk = c;
 
+	WARN(!c->clkdm, "omap_hwmod: %s: missing clockdomain for %s.\n",
+	     oh->clkdev_con_id, c->name);
+
 	return ret;
 }
 
