From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 15 Jun 2015 15:50:22 +0200
Subject: [PATCH 5/5] ARM: ep93xx: activate NO_HZ and high-res timers
In-Reply-To: <1434376222-4587-1-git-send-email-linus.walleij@linaro.org>
References: <1434376222-4587-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1434376222-4587-6-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's set the EP93xx to NO_HZ mode and activate the high-res
timers now that we have GENERIC_CLOCKEVENTS.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/ep93xx_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/ep93xx_defconfig b/arch/arm/configs/ep93xx_defconfig
index 72233b9c9d07..f3adf59fa315 100644
--- a/arch/arm/configs/ep93xx_defconfig
+++ b/arch/arm/configs/ep93xx_defconfig
@@ -1,4 +1,6 @@
 CONFIG_SYSVIPC=y
+CONFIG_NO_HZ_IDLE=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-- 
1.9.3
