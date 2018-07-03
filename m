From: dkos@cadence.com (Damian Kos)
Date: Tue, 3 Jul 2018 11:02:17 +0100
Subject: [PATCH 06/12] drm/dp: fix drm_dp_link_power_* for DP 1.2+
In-Reply-To: <1530612152-27555-1-git-send-email-dkos@cadence.com>
References: <1530612152-27555-1-git-send-email-dkos@cadence.com>
Message-ID: <1530612152-27555-7-git-send-email-dkos@cadence.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Quentin Schulz <quentin.schulz@free-electrons.com>

In DP 1.1, DP_SET_POWER had only two bits for the power state (D0 or D3
and two other reserved values), thus DP_SET_POWER_MASK being 0x3.

However, since DP 1.2, DP_SET_POWER has 3 bits (same values for D0 and
D3, a mixed D3 which leaves only AUX powered and five other reserved
values). Thus, we need to expand DP_SET_POWER_MASK to 3 bits (thus 0x7).

It is safe to expand DP_SET_POWER_MASK to 3 bits since bit 2 in DP 1.1
is reserved and read 0.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
---
 include/drm/drm_dp_helper.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index bd593df..a63a548 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -671,7 +671,7 @@
 #define DP_SET_POWER                        0x600
 # define DP_SET_POWER_D0                    0x1
 # define DP_SET_POWER_D3                    0x2
-# define DP_SET_POWER_MASK                  0x3
+# define DP_SET_POWER_MASK                  0x7
 # define DP_SET_POWER_D3_AUX_ON             0x5
 
 #define DP_EDP_DPCD_REV			    0x700    /* eDP 1.2 */
-- 
1.7.1
