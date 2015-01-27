From: andrew.jackson@arm.com (Andrew Jackson)
Date: Tue, 27 Jan 2015 20:38:28 +0000
Subject: [PATCH PING] ASoC: dwc: Remove unnecessary conditional compilation
Message-ID: <1422391108-9011-1-git-send-email-andrew.jackson@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Jackson <Andrew.Jackson@arm.com>

of_match_ptr is already conditionally compiled based on
CONFIG_OF so further conditional compilation is not
required.  Remove conditional compilation surrounding
of_match_ptr.

Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
---
 sound/soc/dwc/designware_i2s.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index 99cf64b..a3e97b4 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -624,9 +624,7 @@ static struct platform_driver dw_i2s_driver = {
 	.remove		= dw_i2s_remove,
 	.driver		= {
 		.name	= "designware-i2s",
-#ifdef CONFIG_OF
 		.of_match_table = of_match_ptr(dw_i2s_of_match),
-#endif
 	},
 };
 
-- 
1.7.1
