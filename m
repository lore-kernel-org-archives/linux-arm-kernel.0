From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 07 Nov 2014 14:53:57 +0100
Subject: [PATCH v2 0/2] DRM: Add runtime PM to Exynos DSI
Message-ID: <1415368439-23642-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Changes since v1
================
1. Replace patch 1 changing PM core with fix only for DRM exynos driver.

Description
===========
The goal of the patch 2 is to add runtime PM to the Exynos DSI driver.
This allows LCD power domain to be turned off.

However after adding this patch an interesing issue came in. The DSI
driver could not runtime resume during sustem resume because power
domain was not allowed to power on.

The issue is solved by patch 1.

Tested on Trats2 board.

Comments are welcomed.

Best regards,
Krzysztof


Krzysztof Kozlowski (2):
  drm/exynos: Fix DSI resuming fail because power domain being off
  drm/exynos/dsi: Add runtime PM so LCD power domain could be turned off

 drivers/gpu/drm/exynos/exynos_drm_drv.c | 2 --
 drivers/gpu/drm/exynos/exynos_drm_dsi.c | 9 +++++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

-- 
1.9.1
