From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Jan 2011 19:25:25 +0000
Subject: [PATCH 13/14] ARM: v6k: allow swp emulation again when ARMv7 is
	enabled
In-Reply-To: <20110117192050.GE23331@n2100.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
Message-ID: <E1Peuhh-0003T5-2n@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we build a v6+v6k+v7 kernel with -march=armv6k for everything,
we don't need to disable swp emulation to work around the build problem
with OMAP.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index ca1238b..843bc8c 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -652,7 +652,7 @@ config ARM_THUMBEE
 
 config SWP_EMULATE
 	bool "Emulate SWP/SWPB instructions"
-	depends on CPU_V7 && !CPU_V6
+	depends on CPU_V7
 	select HAVE_PROC_CPU if PROC_FS
 	default y if SMP
 	help
-- 
1.6.2.5
