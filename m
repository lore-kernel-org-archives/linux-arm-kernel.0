From: ykk@rock-chips.com (Yakir Yang)
Date: Fri,  7 Aug 2015 05:54:04 -0500
Subject: [PATCH v2 8/8] drm: bridge/analogix_dp: expand the delay time for hpd
 detect
In-Reply-To: <1438943674-18191-1-git-send-email-ykk@rock-chips.com>
References: <1438943674-18191-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1438944844-19243-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some edp screen with no hpd signal would need some delay time
to ensure that screen would be ready for work, so we can expand
the delay time in hpd detect function, it works prefectly on my
rk3288 sdk board.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v2: None

 drivers/gpu/drm/bridge/analogix_dp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix_dp_core.c
index efd810c..3ba10fa2 100644
--- a/drivers/gpu/drm/bridge/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix_dp_core.c
@@ -71,7 +71,7 @@ static int analogix_dp_detect_hpd(struct analogix_dp_device *dp)
 			return 0;
 
 		timeout_loop++;
-		usleep_range(10, 11);
+		usleep_range(100, 110);
 	}
 
 	/*
-- 
1.9.1
