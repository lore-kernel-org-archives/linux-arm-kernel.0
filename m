From: shannon.zhao@linaro.org (shannon.zhao at linaro.org)
Date: Tue, 17 Nov 2015 17:40:02 +0800
Subject: [PATCH v3 03/62] acpi/pmstat: Build pmstat for x86 only
In-Reply-To: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1447753261-7552-4-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Parth Dixit <parth.dixit@linaro.org>

Pmstat is currently not supported for ARM in Xen. Configure and build
pmstat for x86 architecture only.

Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 xen/common/sysctl.c       | 2 +-
 xen/drivers/acpi/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/xen/common/sysctl.c b/xen/common/sysctl.c
index 85e853f..8273ad4 100644
--- a/xen/common/sysctl.c
+++ b/xen/common/sysctl.c
@@ -171,7 +171,7 @@ long do_sysctl(XEN_GUEST_HANDLE_PARAM(xen_sysctl_t) u_sysctl)
         op->u.availheap.avail_bytes <<= PAGE_SHIFT;
         break;
 
-#ifdef HAS_ACPI
+#ifdef HAS_CPUFREQ
     case XEN_SYSCTL_get_pmstat:
         ret = do_get_pm_info(&op->u.get_pmstat);
         break;
diff --git a/xen/drivers/acpi/Makefile b/xen/drivers/acpi/Makefile
index 3bb626e..c7d006a 100644
--- a/xen/drivers/acpi/Makefile
+++ b/xen/drivers/acpi/Makefile
@@ -5,7 +5,7 @@ subdir-$(x86) += apei
 obj-bin-y += tables.init.o
 obj-$(HAS_NUMA) += numa.o
 obj-y += osl.o
-obj-y += pmstat.o
+obj-$(HAS_CPUFREQ) += pmstat.o
 
 obj-$(x86) += hwregs.o
 obj-$(x86) += reboot.o
-- 
2.1.0
