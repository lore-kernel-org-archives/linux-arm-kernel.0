From: olof@lixom.net (Olof Johansson)
Date: Fri,  7 Oct 2011 08:31:41 -0700
Subject: [PATCH v2] ARM: tegra: fix compilation error due to mach/hardware.h
	removal
Message-ID: <1318001501-14785-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Dietrich <marvin24@gmx.de>

This fixes a compilation error in cpu-tegra.c which was introduced in
dc8d966bc (ARM: convert PCI defines to variables) which removed the now
obsolete mach/hardware.h from the mach-tegra subtree.

Signed-off-by: Marc Dietrich <marvin24@gmx.de>
Signed-off-by: Olof Johansson <olof@lixom.net>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
---

v2: Added patch subject of introducing commit

Linus, last minute build fix. Not sure of Arnd is planning another merge
before release so sending directly.

 arch/arm/mach-tegra/cpu-tegra.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/cpu-tegra.c b/arch/arm/mach-tegra/cpu-tegra.c
index 0e1016a..0e0fd4d 100644
--- a/arch/arm/mach-tegra/cpu-tegra.c
+++ b/arch/arm/mach-tegra/cpu-tegra.c
@@ -32,7 +32,6 @@
 
 #include <asm/system.h>
 
-#include <mach/hardware.h>
 #include <mach/clk.h>
 
 /* Frequency table index must be sequential starting at 0 */
-- 
1.7.4.1
