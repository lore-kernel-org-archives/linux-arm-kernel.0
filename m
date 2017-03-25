From: leo.yan@linaro.org (Leo Yan)
Date: Sun, 26 Mar 2017 02:23:10 +0800
Subject: [PATCH v5 2/9] doc: Add documentation for Coresight CPU debug
In-Reply-To: <1490466197-29163-1-git-send-email-leo.yan@linaro.org>
References: <1490466197-29163-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1490466197-29163-3-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update kernel-parameters.txt to add two new parameters:

- coresight_cpu_debug.enable is a knob to enable debugging at boot time.
- coresight_cpu_debug.idle_constraint is used to constrain idle states
  to ensure Coresight CPU debug component can be accessible.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2ba45ca..6ed57d9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -650,6 +650,27 @@
 			/proc/<pid>/coredump_filter.
 			See also Documentation/filesystems/proc.txt.
 
+	coresight_cpu_debug.enable
+			[ARM,ARM64]
+			Format: <bool>
+			Enable/disable the CPU sampling based debugging.
+			0: default value, disable debugging
+			1: enable debugging at boot time
+
+	coresight_cpu_debug.idle_constraint
+			[ARM,ARM64]
+			Format: <int>
+			Some platforms have designed the idle states to disable
+			CPU power domain and need manually set constraint so
+			can access coresight CPU debug component safely. Setting
+			this parameter for latency requirement in
+			microseconds, finally we can constraint all or partial
+			idle states to ensure the CPU power domain is enabled.
+			Default is -1, which means no limiation to CPU idle
+			states; if set to 0, this means disabling all idle
+			states; user can choose other platform dependent values
+			so can disable specific idle states for the platform.
+
 	cpuidle.off=1	[CPU_IDLE]
 			disable the cpuidle sub-system
 
-- 
2.7.4
