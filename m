From: rric@kernel.org (Robert Richter)
Date: Sun,  3 May 2015 22:49:32 +0200
Subject: [PATCH 4/4] arm64: gicv3: its: Increase FORCE_MAX_ZONEORDER for
 Cavium ThunderX
In-Reply-To: <1430686172-18222-1-git-send-email-rric@kernel.org>
References: <1430686172-18222-1-git-send-email-rric@kernel.org>
Message-ID: <1430686172-18222-5-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>

In case of ARCH_THUNDER, there is a need to allocate the GICv3 ITS table
which is bigger than the allowed max order. So we are forcing it only in
case of 4KB page size.

Signed-off-by: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b8e97331ffb..c519f3777453 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -542,6 +542,7 @@ config XEN
 config FORCE_MAX_ZONEORDER
 	int
 	default "14" if (ARM64_64K_PAGES && TRANSPARENT_HUGEPAGE)
+	default "13" if (ARCH_THUNDER && !ARM64_64K_PAGES)
 	default "11"
 
 menuconfig ARMV8_DEPRECATED
-- 
2.1.1
