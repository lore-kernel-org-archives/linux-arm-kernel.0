From: dkos@cadence.com (Damian Kos)
Date: Tue, 3 Jul 2018 11:02:19 +0100
Subject: [PATCH 08/12] drm/dp: add max number of lanes supported
In-Reply-To: <1530612152-27555-1-git-send-email-dkos@cadence.com>
References: <1530612152-27555-1-git-send-email-dkos@cadence.com>
Message-ID: <1530612152-27555-9-git-send-email-dkos@cadence.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Quentin Schulz <quentin.schulz@free-electrons.com>

Currently, a maximum of 4 lanes is supported in DP.

It can be useful to add this maximum so that we can e.g. create arrays
in drivers that can store data for several lanes (e.g.
DP_TRAINING_LANEx_SET).

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
---
 include/drm/drm_dp_helper.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index a63a548..accefbb 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -69,6 +69,7 @@
 
 #define DP_MAX_LANE_COUNT                   0x002
 # define DP_MAX_LANE_COUNT_MASK		    0x1f
+# define DP_MAX_NUM_LANES		    4
 # define DP_TPS3_SUPPORTED		    (1 << 6) /* 1.2 */
 # define DP_ENHANCED_FRAME_CAP		    (1 << 7)
 
-- 
1.7.1
