From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Mon, 19 Jul 2010 14:31:17 +0900
Subject: [PATCH v3 1/7] ARM: S5PV210: Add a Kconfig entry
	"S5PC110_EVT0_WORKAROUND"
In-Reply-To: <1279517483-22751-1-git-send-email-myungjoo.ham@samsung.com>
References: <1279517483-22751-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1279517483-22751-2-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Early S5PC110 (EVT0) chip had some issues required workaround from a
kernel. We can add such workaround codes with this Kconfig entry.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 631019a..18802e7 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -101,4 +101,11 @@ config MACH_SMDKC110
 	  Machine support for Samsung SMDKC110
 	  S5PC110(MCP) is one of package option of S5PV210
 
+config S5PC110_EVT0_WORKAROUND
+	bool "S5PC110 Early Chip Workaround (EVT0)"
+	help
+	  Early S5PC110 (so called EVT0) has errata items that should be
+	  addressed; otherwise the kernel may panic or be locked up. Enable
+	  this option to execute workaround instructions.
+
 endif
-- 
1.6.3.3
