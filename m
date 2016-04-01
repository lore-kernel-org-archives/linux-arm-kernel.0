From: eric@anholt.net (Eric Anholt)
Date: Thu, 31 Mar 2016 17:30:41 -0700
Subject: [PATCH 2/4] ARM: bcm2835: Enable CONFIG_PM.
In-Reply-To: <1459470643-9070-1-git-send-email-eric@anholt.net>
References: <1459470643-9070-1-git-send-email-eric@anholt.net>
Message-ID: <1459470643-9070-2-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The power domain driver we've enabled doesn't actually do anything
without it, and we need it to do its job for VC4 to initialize
successfully.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/configs/bcm2835_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 1617fd2..1192a6f 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -38,6 +38,7 @@ CONFIG_CRASH_DUMP=y
 CONFIG_VFP=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 # CONFIG_SUSPEND is not set
+CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
-- 
2.7.0
