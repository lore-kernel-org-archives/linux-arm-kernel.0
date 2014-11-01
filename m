From: dianders@chromium.org (Doug Anderson)
Date: Fri, 31 Oct 2014 20:52:58 -0700
Subject: [PATCH 2/2] regulator: of: Add support for parsing microvolts for
 suspend state
In-Reply-To: <1414813978-32233-1-git-send-email-dianders@chromium.org>
References: <1414813978-32233-1-git-send-email-dianders@chromium.org>
Message-ID: <1414813978-32233-2-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Leverage all the work that was done in (40e20d6 regulator: of: Add
support for parsing regulator_state for suspend state) and throw in
the ability to set suspend microvolts from the device tree.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/regulator/of_regulator.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index f0d19fc..7fe93c5 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -107,6 +107,10 @@ static void of_get_regulation_constraints(struct device_node *np,
 					"regulator-off-in-suspend"))
 			suspend_state->disabled = true;
 
+		if (!of_property_read_u32(suspend_np,
+					"regulator-suspend-microvolt", &pval))
+			suspend_state->uV = pval;
+
 		of_node_put(suspend_np);
 		suspend_state = NULL;
 		suspend_np = NULL;
-- 
2.1.0.rc2.206.gedb03e5
