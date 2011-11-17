From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 17 Nov 2011 22:27:22 +0800
Subject: [PATCH] ARM: CSR: PM: fix build error due to undeclared 'THIS_MODULE'
Message-ID: <1321540042-6670-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <baohua.song@csr.com>

In the new kernel, we will get the following compile error:
arch/arm/mach-prima2/pm.c:141: error: 'THIS_MODULE' undeclared
here (not in a function)
so include module.h head file explicitly

Signed-off-by: Barry Song <baohua.song@csr.com>
---
 arch/arm/mach-prima2/pm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-prima2/pm.c b/arch/arm/mach-prima2/pm.c
index cb53160..26ebb57 100644
--- a/arch/arm/mach-prima2/pm.c
+++ b/arch/arm/mach-prima2/pm.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/suspend.h>
 #include <linux/slab.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
-- 
1.7.0.4
