From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri,  6 Mar 2015 16:05:24 +0100
Subject: [PATCH v2 06/10] pinctrl: berlin: use proper compatibles
In-Reply-To: <1425654328-26298-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1425654328-26298-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1425654328-26298-7-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Berlin pin-controller driver was sharing the chip and system
controller nodes with the clock and the reset drivers. They all shared
the same compatible. With the introduction of the Marvell Berlin MFD
controller, the Berlin pin-controller driver has now its own node.
Update its compatibles to not share anymore the ones of the chip and
system controllers.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/pinctrl/berlin/berlin-bg2.c   | 4 ++--
 drivers/pinctrl/berlin/berlin-bg2cd.c | 4 ++--
 drivers/pinctrl/berlin/berlin-bg2q.c  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/berlin/berlin-bg2.c b/drivers/pinctrl/berlin/berlin-bg2.c
index 368ec0b9b8ba..3769eaedf519 100644
--- a/drivers/pinctrl/berlin/berlin-bg2.c
+++ b/drivers/pinctrl/berlin/berlin-bg2.c
@@ -218,11 +218,11 @@ static const struct berlin_pinctrl_desc berlin2_sysmgr_pinctrl_data = {
 
 static const struct of_device_id berlin2_pinctrl_match[] = {
 	{
-		.compatible = "marvell,berlin2-chip-ctrl",
+		.compatible = "marvell,berlin2-soc-pinctrl",
 		.data = &berlin2_soc_pinctrl_data
 	},
 	{
-		.compatible = "marvell,berlin2-system-ctrl",
+		.compatible = "marvell,berlin2-system-pinctrl",
 		.data = &berlin2_sysmgr_pinctrl_data
 	},
 	{}
diff --git a/drivers/pinctrl/berlin/berlin-bg2cd.c b/drivers/pinctrl/berlin/berlin-bg2cd.c
index 6b9cae029ef7..9e11f191d643 100644
--- a/drivers/pinctrl/berlin/berlin-bg2cd.c
+++ b/drivers/pinctrl/berlin/berlin-bg2cd.c
@@ -161,11 +161,11 @@ static const struct berlin_pinctrl_desc berlin2cd_sysmgr_pinctrl_data = {
 
 static const struct of_device_id berlin2cd_pinctrl_match[] = {
 	{
-		.compatible = "marvell,berlin2cd-chip-ctrl",
+		.compatible = "marvell,berlin2cd-soc-pinctrl",
 		.data = &berlin2cd_soc_pinctrl_data
 	},
 	{
-		.compatible = "marvell,berlin2cd-system-ctrl",
+		.compatible = "marvell,berlin2cd-system-pinctrl",
 		.data = &berlin2cd_sysmgr_pinctrl_data
 	},
 	{}
diff --git a/drivers/pinctrl/berlin/berlin-bg2q.c b/drivers/pinctrl/berlin/berlin-bg2q.c
index 11aa10cc0e3e..ba7a8a8ad010 100644
--- a/drivers/pinctrl/berlin/berlin-bg2q.c
+++ b/drivers/pinctrl/berlin/berlin-bg2q.c
@@ -380,11 +380,11 @@ static const struct berlin_pinctrl_desc berlin2q_sysmgr_pinctrl_data = {
 
 static const struct of_device_id berlin2q_pinctrl_match[] = {
 	{
-		.compatible = "marvell,berlin2q-chip-ctrl",
+		.compatible = "marvell,berlin2q-soc-pinctrl",
 		.data = &berlin2q_soc_pinctrl_data,
 	},
 	{
-		.compatible = "marvell,berlin2q-system-ctrl",
+		.compatible = "marvell,berlin2q-system-pinctrl",
 		.data = &berlin2q_sysmgr_pinctrl_data,
 	},
 	{}
-- 
2.3.1
