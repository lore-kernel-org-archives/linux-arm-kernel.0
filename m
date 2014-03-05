From: jg1.han@samsung.com (Jingoo Han)
Date: Wed, 05 Mar 2014 14:35:45 +0900
Subject: [PATCH 2/2] arm64: smp: make local symbol static
In-Reply-To: <000001cf3834$9667e5c0$c337b140$%han@samsung.com>
References: <000001cf3834$9667e5c0$c337b140$%han@samsung.com>
Message-ID: <000101cf3834$c1a5ff10$44f1fd30$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make smp_spin_table_cpu_postboot() static, because this function
is used only in this file.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 arch/arm64/kernel/smp_spin_table.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
index 44c2280..7a530d2 100644
--- a/arch/arm64/kernel/smp_spin_table.c
+++ b/arch/arm64/kernel/smp_spin_table.c
@@ -128,7 +128,7 @@ static int smp_spin_table_cpu_boot(unsigned int cpu)
 	return secondary_holding_pen_release != INVALID_HWID ? -ENOSYS : 0;
 }
 
-void smp_spin_table_cpu_postboot(void)
+static void smp_spin_table_cpu_postboot(void)
 {
 	/*
 	 * Let the primary processor know we're out of the pen.
-- 
1.7.10.4
