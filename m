From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 18 Feb 2014 14:46:31 +0800
Subject: [PATCH 5/5] ARM: prima2: staticize sirfsoc_init_late function
In-Reply-To: <1392705991-29967-1-git-send-email-21cnbao@gmail.com>
References: <1392705991-29967-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1392705991-29967-6-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

sirfsoc_init_late() is a local function not an extern interface to anyone.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
index 6926dbc..3b8865a 100644
--- a/arch/arm/mach-prima2/common.c
+++ b/arch/arm/mach-prima2/common.c
@@ -15,7 +15,7 @@
 #include <linux/of_platform.h>
 #include "common.h"
 
-void __init sirfsoc_init_late(void)
+static void __init sirfsoc_init_late(void)
 {
 	sirfsoc_pm_init();
 }
-- 
1.7.5.4
