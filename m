From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 13 Jan 2017 11:03:15 +0000
Subject: [PATCH RFC 1/5] pinctrl: mvebu: constify mvebu_mpp_ctrl structures
In-Reply-To: <20170113110240.GA29164@n2100.armlinux.org.uk>
References: <20170113110240.GA29164@n2100.armlinux.org.uk>
Message-ID: <E1cRzdb-0002YP-8q@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the mvebu_mpp_ctrl structures contain function pointers, it is
preferable for these to be made read-only to prevent the function
pointers being modified.  So make these const.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/pinctrl/mvebu/pinctrl-armada-370.c | 2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-375.c | 2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c | 2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-39x.c | 2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c  | 6 +++---
 drivers/pinctrl/mvebu/pinctrl-dove.c       | 2 +-
 drivers/pinctrl/mvebu/pinctrl-kirkwood.c   | 6 +++---
 drivers/pinctrl/mvebu/pinctrl-mvebu.c      | 6 +++---
 drivers/pinctrl/mvebu/pinctrl-mvebu.h      | 2 +-
 drivers/pinctrl/mvebu/pinctrl-orion.c      | 2 +-
 10 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-370.c b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
index 9cc1cc3f5c34..3cb6b4ea0118 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-370.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
@@ -384,7 +384,7 @@ static const struct of_device_id armada_370_pinctrl_of_match[] = {
 	{ },
 };
 
-static struct mvebu_mpp_ctrl mv88f6710_mpp_controls[] = {
+static const struct mvebu_mpp_ctrl mv88f6710_mpp_controls[] = {
 	MPP_FUNC_CTRL(0, 65, NULL, armada_370_mpp_ctrl),
 };
 
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-375.c b/drivers/pinctrl/mvebu/pinctrl-armada-375.c
index 070651431ca4..c9dba08780c5 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-375.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-375.c
@@ -402,7 +402,7 @@ static const struct of_device_id armada_375_pinctrl_of_match[] = {
 	{ },
 };
 
-static struct mvebu_mpp_ctrl mv88f6720_mpp_controls[] = {
+static const struct mvebu_mpp_ctrl mv88f6720_mpp_controls[] = {
 	MPP_FUNC_CTRL(0, 69, NULL, armada_375_mpp_ctrl),
 };
 
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
index 4e84c8e4938c..52f2ab82901a 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
@@ -409,7 +409,7 @@ static const struct of_device_id armada_38x_pinctrl_of_match[] = {
 	{ },
 };
 
-static struct mvebu_mpp_ctrl armada_38x_mpp_controls[] = {
+static const struct mvebu_mpp_ctrl armada_38x_mpp_controls[] = {
 	MPP_FUNC_CTRL(0, 59, NULL, armada_38x_mpp_ctrl),
 };
 
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
index e288f8ba0bf1..8ebc28ac289e 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
@@ -391,7 +391,7 @@ static const struct of_device_id armada_39x_pinctrl_of_match[] = {
 	{ },
 };
 
-static struct mvebu_mpp_ctrl armada_39x_mpp_controls[] = {
+static const struct mvebu_mpp_ctrl armada_39x_mpp_controls[] = {
 	MPP_FUNC_CTRL(0, 59, NULL, armada_39x_mpp_ctrl),
 };
 
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
index e4ea71a9d985..cec3fef6f77f 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
@@ -378,7 +378,7 @@ static const struct of_device_id armada_xp_pinctrl_of_match[] = {
 	{ },
 };
 
-static struct mvebu_mpp_ctrl mv78230_mpp_controls[] = {
+static const struct mvebu_mpp_ctrl mv78230_mpp_controls[] = {
 	MPP_FUNC_CTRL(0, 48, NULL, armada_xp_mpp_ctrl),
 };
 
@@ -387,7 +387,7 @@ static struct pinctrl_gpio_range mv78230_mpp_gpio_ranges[] = {
 	MPP_GPIO_RANGE(1,  32, 32, 17),
 };
 
-static struct mvebu_mpp_ctrl mv78260_mpp_controls[] = {
+static const struct mvebu_mpp_ctrl mv78260_mpp_controls[] = {
 	MPP_FUNC_CTRL(0, 66, NULL, armada_xp_mpp_ctrl),
 };
 
@@ -397,7 +397,7 @@ static struct pinctrl_gpio_range mv78260_mpp_gpio_ranges[] = {
 	MPP_GPIO_RANGE(2,  64, 64,  3),
 };
 
-static struct mvebu_mpp_ctrl mv78460_mpp_controls[] = {
+static const struct mvebu_mpp_ctrl mv78460_mpp_controls[] = {
 	MPP_FUNC_CTRL(0, 66, NULL, armada_xp_mpp_ctrl),
 };
 
diff --git a/drivers/pinctrl/mvebu/pinctrl-dove.c b/drivers/pinctrl/mvebu/pinctrl-dove.c
index f93ae0dcef9c..745421496f6b 100644
--- a/drivers/pinctrl/mvebu/pinctrl-dove.c
+++ b/drivers/pinctrl/mvebu/pinctrl-dove.c
@@ -354,7 +354,7 @@ static int dove_twsi_ctrl_set(unsigned pid, unsigned long config)
 	return 0;
 }
 
-static struct mvebu_mpp_ctrl dove_mpp_controls[] = {
+static const struct mvebu_mpp_ctrl dove_mpp_controls[] = {
 	MPP_FUNC_CTRL(0, 15, NULL, dove_pmu_mpp_ctrl),
 	MPP_FUNC_CTRL(16, 23, NULL, dove_mpp_ctrl),
 	MPP_FUNC_CTRL(24, 39, "mpp_camera", dove_mpp4_ctrl),
diff --git a/drivers/pinctrl/mvebu/pinctrl-kirkwood.c b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
index 5f89c26f3292..a331bb13a984 100644
--- a/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
+++ b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
@@ -370,7 +370,7 @@ static struct mvebu_mpp_mode mv88f6xxx_mpp_modes[] = {
 		MPP_VAR_FUNCTION(0xb, "lcd", "d17",      V(0, 0, 0, 0, 1, 0))),
 };
 
-static struct mvebu_mpp_ctrl mv88f6180_mpp_controls[] = {
+static const struct mvebu_mpp_ctrl mv88f6180_mpp_controls[] = {
 	MPP_FUNC_CTRL(0, 44, NULL, kirkwood_mpp_ctrl),
 };
 
@@ -379,7 +379,7 @@ static struct pinctrl_gpio_range mv88f6180_gpio_ranges[] = {
 	MPP_GPIO_RANGE(1, 35, 35, 10),
 };
 
-static struct mvebu_mpp_ctrl mv88f619x_mpp_controls[] = {
+static const struct mvebu_mpp_ctrl mv88f619x_mpp_controls[] = {
 	MPP_FUNC_CTRL(0, 35, NULL, kirkwood_mpp_ctrl),
 };
 
@@ -388,7 +388,7 @@ static struct pinctrl_gpio_range mv88f619x_gpio_ranges[] = {
 	MPP_GPIO_RANGE(1, 32, 32,  4),
 };
 
-static struct mvebu_mpp_ctrl mv88f628x_mpp_controls[] = {
+static const struct mvebu_mpp_ctrl mv88f628x_mpp_controls[] = {
 	MPP_FUNC_CTRL(0, 49, NULL, kirkwood_mpp_ctrl),
 };
 
diff --git a/drivers/pinctrl/mvebu/pinctrl-mvebu.c b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
index b6ec6db78351..a073d67f03e3 100644
--- a/drivers/pinctrl/mvebu/pinctrl-mvebu.c
+++ b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
@@ -38,7 +38,7 @@ struct mvebu_pinctrl_function {
 
 struct mvebu_pinctrl_group {
 	const char *name;
-	struct mvebu_mpp_ctrl *ctrl;
+	const struct mvebu_mpp_ctrl *ctrl;
 	struct mvebu_mpp_ctrl_setting *settings;
 	unsigned num_settings;
 	unsigned gid;
@@ -582,7 +582,7 @@ int mvebu_pinctrl_probe(struct platform_device *pdev)
 	pctl->num_groups = 0;
 	pctl->desc.npins = 0;
 	for (n = 0; n < soc->ncontrols; n++) {
-		struct mvebu_mpp_ctrl *ctrl = &soc->controls[n];
+		const struct mvebu_mpp_ctrl *ctrl = &soc->controls[n];
 
 		pctl->desc.npins += ctrl->npins;
 		/* initialize control's pins[] array */
@@ -628,7 +628,7 @@ int mvebu_pinctrl_probe(struct platform_device *pdev)
 	/* assign mpp controls to groups */
 	gid = 0;
 	for (n = 0; n < soc->ncontrols; n++) {
-		struct mvebu_mpp_ctrl *ctrl = &soc->controls[n];
+		const struct mvebu_mpp_ctrl *ctrl = &soc->controls[n];
 		pctl->groups[gid].gid = gid;
 		pctl->groups[gid].ctrl = ctrl;
 		pctl->groups[gid].name = ctrl->name;
diff --git a/drivers/pinctrl/mvebu/pinctrl-mvebu.h b/drivers/pinctrl/mvebu/pinctrl-mvebu.h
index b75a5f4adf3b..7f7c24ac49e3 100644
--- a/drivers/pinctrl/mvebu/pinctrl-mvebu.h
+++ b/drivers/pinctrl/mvebu/pinctrl-mvebu.h
@@ -105,7 +105,7 @@ struct mvebu_mpp_mode {
  */
 struct mvebu_pinctrl_soc_info {
 	u8 variant;
-	struct mvebu_mpp_ctrl *controls;
+	const struct mvebu_mpp_ctrl *controls;
 	int ncontrols;
 	struct mvebu_mpp_mode *modes;
 	int nmodes;
diff --git a/drivers/pinctrl/mvebu/pinctrl-orion.c b/drivers/pinctrl/mvebu/pinctrl-orion.c
index 84e144167b44..18c83b0a5a7c 100644
--- a/drivers/pinctrl/mvebu/pinctrl-orion.c
+++ b/drivers/pinctrl/mvebu/pinctrl-orion.c
@@ -161,7 +161,7 @@ static struct mvebu_mpp_mode orion_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0x5, "gpio", NULL,        V_5182)),
 };
 
-static struct mvebu_mpp_ctrl orion_mpp_controls[] = {
+static const struct mvebu_mpp_ctrl orion_mpp_controls[] = {
 	MPP_FUNC_CTRL(0, 19, NULL, orion_mpp_ctrl),
 };
 
-- 
2.7.4
