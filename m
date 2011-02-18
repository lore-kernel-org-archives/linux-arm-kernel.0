From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 18 Feb 2011 16:18:12 -0700
Subject: [PATCH 2/3] video: tegra: Fix CTS/N table for 25.2MHz pclk,
	44.1Hz audio
In-Reply-To: <1298071093-23865-1-git-send-email-swarren@nvidia.com>
References: <1298071093-23865-1-git-send-email-swarren@nvidia.com>
Message-ID: <1298071093-23865-3-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The existing values are for a 25.25MHz clock, not a 25.20MHz clock:

25250000 * 14112 / (128 * 63125) == 44100.000
25200000 * 5656  / (128 * 25250) == 44100.000

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/video/tegra/dc/hdmi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/tegra/dc/hdmi.c b/drivers/video/tegra/dc/hdmi.c
index 878cca5..9210737 100644
--- a/drivers/video/tegra/dc/hdmi.c
+++ b/drivers/video/tegra/dc/hdmi.c
@@ -152,7 +152,7 @@ const struct tegra_hdmi_audio_config tegra_hdmi_audio_32k[] = {
 };
 
 const struct tegra_hdmi_audio_config tegra_hdmi_audio_44_1k[] = {
-	{25200000,	14112,	63125},
+	{25200000,	5656,	25250},
 	{27000000,	6272,	30000},
 	{54000000,	6272,	60000},
 	{74250000,	6272,	82500},
-- 
1.7.1
