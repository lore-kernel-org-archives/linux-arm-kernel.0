From: PeterHuewe@gmx.de (Peter Huewe)
Date: Thu, 7 Jan 2010 01:56:35 +0100
Subject: [PATCH] arch/arm: Fix build failure for lpd7a404_defconfig caused by
	missing includes
Message-ID: <201001070156.36221.PeterHuewe@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Huewe <peterhuewe@gmx.de>
Date: Thu, 7 Jan 2010 01:46:49 +0100

This patch fixes a build failure [1] due to missing includes
This should make the arm tree build again with lpd7a404_defconfig

References:
http://kisskb.ellerman.id.au/kisskb/buildresult/1983329/

Patch against Linus' tree.

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
 arch/arm/mach-lh7a40x/clocks.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-lh7a40x/clocks.c b/arch/arm/mach-lh7a40x/clocks.c
index fcaf876..0651f96 100644
--- a/arch/arm/mach-lh7a40x/clocks.c
+++ b/arch/arm/mach-lh7a40x/clocks.c
@@ -10,6 +10,8 @@
 #include <mach/hardware.h>
 #include <mach/clocks.h>
 #include <linux/err.h>
+#include <linux/device.h>
+#include <linux/string.h>
 
 struct module;
 
-- 
1.6.4.4
