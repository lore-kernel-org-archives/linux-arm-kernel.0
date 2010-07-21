From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 21 Jul 2010 20:33:54 +0300
Subject: [PATCH v2 20/20] wireless: wl1271: call SDIO claim/release power API
In-Reply-To: <1279733634-21974-1-git-send-email-ohad@wizery.com>
References: <1279733634-21974-1-git-send-email-ohad@wizery.com>
Message-ID: <1279733634-21974-21-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

call SDIO claim/release power API to turn the wl1271
power on and off

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/net/wireless/wl12xx/wl1271_sdio.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/net/wireless/wl12xx/wl1271_sdio.c b/drivers/net/wireless/wl12xx/wl1271_sdio.c
index 5967718..a7e9ace 100644
--- a/drivers/net/wireless/wl12xx/wl1271_sdio.c
+++ b/drivers/net/wireless/wl12xx/wl1271_sdio.c
@@ -152,11 +152,13 @@ static int wl1271_sdio_set_power(struct wl1271 *wl, bool enable)
 	 * alive.
 	 */
 	if (enable) {
+		sdio_claim_power(func);
 		sdio_claim_host(func);
 		sdio_enable_func(func);
 	} else {
 		sdio_disable_func(func);
 		sdio_release_host(func);
+		sdio_release_power(func);
 	}
 
 	return 0;
-- 
1.7.0.4
