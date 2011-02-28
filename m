From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 28 Feb 2011 11:00:27 +0100
Subject: [PATCH 6/8] ARM i.MX5: Allow to increase max zone order
In-Reply-To: <1298887229-7987-1-git-send-email-s.hauer@pengutronix.de>
References: <1298887229-7987-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1298887229-7987-7-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

default setting of 11 allows us to allocate at maximum
2MB chunks of contiguous memory. For resolutions up to
1920x1080 32bpp we need much more memory, so make zone
order configurable

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 26d45e5..e25c04e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1451,8 +1451,8 @@ config HW_PERF_EVENTS
 source "mm/Kconfig"
 
 config FORCE_MAX_ZONEORDER
-	int "Maximum zone order" if ARCH_SHMOBILE
-	range 11 64 if ARCH_SHMOBILE
+	int "Maximum zone order" if ARCH_SHMOBILE || ARCH_MX5
+	range 11 64 if ARCH_SHMOBILE || ARCH_MX5
 	default "9" if SA1111
 	default "11"
 	help
-- 
1.7.2.3
