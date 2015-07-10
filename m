From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 10 Jul 2015 19:37:31 +0900
Subject: [PATCH] Drop owner assignment from i2c_driver (and platform
 left-overs)
Message-ID: <1436524653-29132-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


The i2c drivers also do not have to set 'owner' field because
i2c_register_driver() will do it instead.

'owner' is removed from i2c drivers, which I was able to compile
with allyesconfig (arm, arm64, i386, x86_64, ppc64).
Only compile-tested.

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html


Best regards,
Krzysztof


Krzysztof Kozlowski (2):
  drm/bridge: Drop owner assignment from i2c_driver
  drm/rockchip: Drop owner assignment from platform_driver

 drivers/gpu/drm/bridge/ps8622.c             | 1 -
 drivers/gpu/drm/bridge/ptn3460.c            | 1 -
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 1 -
 3 files changed, 3 deletions(-)

-- 
1.9.1
