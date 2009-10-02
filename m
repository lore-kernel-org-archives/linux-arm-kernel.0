From: tony@atomide.com (Tony Lindgren)
Date: Fri, 02 Oct 2009 15:45:37 -0700
Subject: [PATCH 7/8] omapfb: Blizzard: fix pointer to be const
In-Reply-To: <20091002223510.11962.21751.stgit@localhost>
References: <20091002223510.11962.21751.stgit@localhost>
Message-ID: <20091002224537.11962.13995.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tommi Rantala <tt.rantala@gmail.com>

Fixes a compiler warning:
warning: assignment discards qualifiers from pointer target type

Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Imre Deak <imre.deak@nokia.com>
Signed-off-by: Tommi Rantala <tt.rantala@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/video/omap/blizzard.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap/blizzard.c b/drivers/video/omap/blizzard.c
index d5e5955..ce28be6 100644
--- a/drivers/video/omap/blizzard.c
+++ b/drivers/video/omap/blizzard.c
@@ -191,7 +191,7 @@ struct blizzard_struct {
 
 	struct omapfb_device	*fbdev;
 	struct lcd_ctrl_extif	*extif;
-	struct lcd_ctrl		*int_ctrl;
+	const struct lcd_ctrl	*int_ctrl;
 
 	void			(*power_up)(struct device *dev);
 	void			(*power_down)(struct device *dev);
