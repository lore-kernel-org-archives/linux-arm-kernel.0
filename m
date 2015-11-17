From: shannon.zhao@linaro.org (shannon.zhao at linaro.org)
Date: Tue, 17 Nov 2015 17:40:01 +0800
Subject: [PATCH v3 02/62] acpi/NUMA: Build NUMA for x86 only
In-Reply-To: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1447753261-7552-3-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Naresh Bhat <naresh.bhat@linaro.org>

NUMA is currently not supported for ARM in Xen. Add a new compilation
option HAS_NUMA for NUMA. Configure and build NUMA only for x86
architecture now.

Signed-off-by: Naresh Bhat <naresh.bhat@linaro.org>
Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 xen/arch/x86/Rules.mk     | 1 +
 xen/drivers/acpi/Makefile | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/xen/arch/x86/Rules.mk b/xen/arch/x86/Rules.mk
index 42de328..5b8eaed 100644
--- a/xen/arch/x86/Rules.mk
+++ b/xen/arch/x86/Rules.mk
@@ -3,6 +3,7 @@
 
 HAS_IOPORTS := y
 HAS_ACPI := y
+HAS_NUMA := y
 HAS_VGA  := y
 HAS_VIDEO  := y
 HAS_CPUFREQ := y
diff --git a/xen/drivers/acpi/Makefile b/xen/drivers/acpi/Makefile
index bbb06a7..3bb626e 100644
--- a/xen/drivers/acpi/Makefile
+++ b/xen/drivers/acpi/Makefile
@@ -3,7 +3,7 @@ subdir-y += utilities
 subdir-$(x86) += apei
 
 obj-bin-y += tables.init.o
-obj-y += numa.o
+obj-$(HAS_NUMA) += numa.o
 obj-y += osl.o
 obj-y += pmstat.o
 
-- 
2.1.0
