From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 21 Jan 2014 12:56:42 +0200
Subject: [PATCHv3 10/41] OMAPDSS: Add DT support to DISPC
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1390301833-24944-11-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT support to DISPC. Only thing needed here is the of_match_table.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index f51646f15cf2..3ac51e125846 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3781,12 +3781,20 @@ static const struct dev_pm_ops dispc_pm_ops = {
 	.runtime_resume = dispc_runtime_resume,
 };
 
+static const struct of_device_id dispc_of_match[] = {
+	{ .compatible = "ti,omap2-dispc", },
+	{ .compatible = "ti,omap3-dispc", },
+	{ .compatible = "ti,omap4-dispc", },
+	{},
+};
+
 static struct platform_driver omap_dispchw_driver = {
 	.remove         = __exit_p(omap_dispchw_remove),
 	.driver         = {
 		.name   = "omapdss_dispc",
 		.owner  = THIS_MODULE,
 		.pm	= &dispc_pm_ops,
+		.of_match_table = dispc_of_match,
 	},
 };
 
-- 
1.8.3.2
