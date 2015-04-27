From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Mon, 27 Apr 2015 18:47:53 -0400
Subject: [PATCH 04/11] arm/mach-rockchip: remove legacy __cpuinit section that
 crept in
In-Reply-To: <1430174880-27958-1-git-send-email-paul.gortmaker@windriver.com>
References: <1430174880-27958-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <1430174880-27958-5-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We removed __cpuinit support (leaving no-op stubs) quite some time ago.
However this one crept back in as of commit a7a2b3118b410fb3cd3a8363b1
("ARM: rockchip: add smp bringup code").

Since we want to clobber the stubs soon, get this removed now.

Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/arm/mach-rockchip/platsmp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
index 5b4ca3c3c879..fd2f0dc81015 100644
--- a/arch/arm/mach-rockchip/platsmp.c
+++ b/arch/arm/mach-rockchip/platsmp.c
@@ -119,8 +119,7 @@ static int pmu_set_power_domain(int pd, bool on)
  * Handling of CPU cores
  */
 
-static int __cpuinit rockchip_boot_secondary(unsigned int cpu,
-					     struct task_struct *idle)
+static int rockchip_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	int ret;
 
-- 
2.2.1
