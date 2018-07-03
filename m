From: dkos@cadence.com (Damian Kos)
Date: Tue, 3 Jul 2018 11:02:20 +0100
Subject: [PATCH 09/12] drm/dp: add pixel encoding and colorimetry format
 indicator field in MISC1
In-Reply-To: <1530612152-27555-1-git-send-email-dkos@cadence.com>
References: <1530612152-27555-1-git-send-email-dkos@cadence.com>
Message-ID: <1530612152-27555-10-git-send-email-dkos@cadence.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Quentin Schulz <quentin.schulz@bootlin.com>

If DP_TEST_COLOR_FORMAT_RAW_Y_ONLY is set, if MISC0 color format is
DP_COLOR_FORMAT_RGB and all other bits are 0, then color format is
actually Y-Only.

If DP_TEST_COLOR_FORMAT_RAW_Y_ONLY is set, if MISC0 color format is
DP_COLOR_FORMAT_YCbCr422, DP_TEST_DYNAMIC_RANGE_CEA is not set and
chosen ITU is 601, then color format is actually RAW.

If DP_TEST_VSC_SDP is set, then DP_TEST_COLOR_FORMAT_RAW_Y_ONLY,
DP_TEST_COLOR_FORMAT, DP_TEST_DYNAMIC_RANGE_CEA,
DP_TEST_YCBCR_COEFFICIENTS and DP_TEST_BIT_DEPTH are ignored and we
should use VSC SDP for setting the colorimetry. This is used for Y420.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
---
 include/drm/drm_dp_helper.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index accefbb..22f6c3e 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -609,6 +609,8 @@
 #define DP_TEST_MISC1                       0x233
 # define DP_TEST_REFRESH_DENOMINATOR        (1 << 0)
 # define DP_TEST_INTERLACED                 (1 << 1)
+# define DP_TEST_VSC_SDP		    (1 << 6) /* 1.3+ */
+# define DP_TEST_COLOR_FORMAT_RAW_Y_ONLY    (1 << 7)
 
 #define DP_TEST_REFRESH_RATE_NUMERATOR      0x234
 
-- 
1.7.1
