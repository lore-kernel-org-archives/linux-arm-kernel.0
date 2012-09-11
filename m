From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Sep 2012 16:20:03 +0200
Subject: [PATCH 1/2] pinctrl: mvebu: mark internal functions as static
In-Reply-To: <1347373204-17883-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1347266386-16229-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347373204-17883-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1347373204-17883-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pinctrl/pinctrl-mvebu.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-mvebu.c b/drivers/pinctrl/pinctrl-mvebu.c
index 52b1da1..ed1fc3b 100644
--- a/drivers/pinctrl/pinctrl-mvebu.c
+++ b/drivers/pinctrl/pinctrl-mvebu.c
@@ -59,7 +59,7 @@ struct mvebu_pinctrl {
 	u8 variant;
 };
 
-struct mvebu_pinctrl_group *mvebu_pinctrl_find_group_by_pid(
+static struct mvebu_pinctrl_group *mvebu_pinctrl_find_group_by_pid(
 	struct mvebu_pinctrl *pctl, unsigned pid)
 {
 	unsigned n;
@@ -72,7 +72,7 @@ struct mvebu_pinctrl_group *mvebu_pinctrl_find_group_by_pid(
 	return NULL;
 }
 
-struct mvebu_pinctrl_group *mvebu_pinctrl_find_group_by_name(
+static struct mvebu_pinctrl_group *mvebu_pinctrl_find_group_by_name(
 	struct mvebu_pinctrl *pctl, const char *name)
 {
 	unsigned n;
@@ -83,7 +83,7 @@ struct mvebu_pinctrl_group *mvebu_pinctrl_find_group_by_name(
 	return NULL;
 }
 
-struct mvebu_mpp_ctrl_setting *mvebu_pinctrl_find_setting_by_val(
+static struct mvebu_mpp_ctrl_setting *mvebu_pinctrl_find_setting_by_val(
 	struct mvebu_pinctrl *pctl, struct mvebu_pinctrl_group *grp,
 	unsigned long config)
 {
@@ -98,7 +98,7 @@ struct mvebu_mpp_ctrl_setting *mvebu_pinctrl_find_setting_by_val(
 	return NULL;
 }
 
-struct mvebu_mpp_ctrl_setting *mvebu_pinctrl_find_setting_by_name(
+static struct mvebu_mpp_ctrl_setting *mvebu_pinctrl_find_setting_by_name(
 	struct mvebu_pinctrl *pctl, struct mvebu_pinctrl_group *grp,
 	const char *name)
 {
@@ -113,7 +113,7 @@ struct mvebu_mpp_ctrl_setting *mvebu_pinctrl_find_setting_by_name(
 	return NULL;
 }
 
-struct mvebu_mpp_ctrl_setting *mvebu_pinctrl_find_gpio_setting(
+static struct mvebu_mpp_ctrl_setting *mvebu_pinctrl_find_gpio_setting(
 	struct mvebu_pinctrl *pctl, struct mvebu_pinctrl_group *grp)
 {
 	unsigned n;
-- 
1.7.9.5
