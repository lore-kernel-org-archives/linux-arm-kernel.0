From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 23 Oct 2014 15:48:08 +0200
Subject: [RFC 0/2] PM and DRM: Add runtime PM to Exynos DSI
Message-ID: <1414072090-11293-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

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
  PM / Domains: Power on domain early during system resume
  drm/exynos/dsi: Add runtime PM so LCD power domain could be turned off

 drivers/base/power/domain.c             | 3 +--
 drivers/gpu/drm/exynos/exynos_drm_dsi.c | 9 +++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
1.9.1
