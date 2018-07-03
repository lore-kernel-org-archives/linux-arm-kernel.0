From: richard.gong@linux.intel.com (richard.gong at linux.intel.com)
Date: Tue,  3 Jul 2018 09:46:55 -0500
Subject: [PATCHv6 8/8] Documentation: driver-api: add stratix10 service layer
In-Reply-To: <1530629215-26990-1-git-send-email-richard.gong@linux.intel.com>
References: <1530629215-26990-1-git-send-email-richard.gong@linux.intel.com>
Message-ID: <1530629215-26990-9-git-send-email-richard.gong@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Gong <richard.gong@intel.com>

Add new file stratix10-svc.rst
Add stratix10-svc.rst to driver-api/index.rst

Signed-off-by: Richard Gong <richard.gong@intel.com>
Signed-off-by: Alan Tull <atull@kernel.org>
---
v5: this patch is added in patch set version 5
v6: no change
---
 Documentation/driver-api/index.rst         |  1 +
 Documentation/driver-api/stratix10-svc.rst | 32 ++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 Documentation/driver-api/stratix10-svc.rst

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 6d9f2f9..d4d2671 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -53,6 +53,7 @@ available subsections can be seen below.
    slimbus
    soundwire/index
    fpga/index
+   stratix10-svc
 
 .. only::  subproject and html
 
diff --git a/Documentation/driver-api/stratix10-svc.rst b/Documentation/driver-api/stratix10-svc.rst
new file mode 100644
index 0000000..ed361d8
--- /dev/null
+++ b/Documentation/driver-api/stratix10-svc.rst
@@ -0,0 +1,32 @@
+
+Intel Stratix10 SoC Service Layer
+=================================
+
+Some features of the Intel Stratix10 SoC require a level of privilege
+higher than the kernel is granted. Such secure features include
+FPGA programming. In terms of the ARMv8 architecture, the kernel runs
+at Exception Level 1 (EL1), access to the features requires
+Exception Level 3 (EL3).
+
+The Intel Stratix10 SoC service layer provides an in kernel API for
+drivers to request access to the secure features. The requests are queued
+and processed one by one. ARM?s SMCCC is used to pass the execution
+of the requests on to a secure monitor (EL3).
+
+.. kernel-doc:: include/linux/stratix10-svc-client.h
+   :functions: stratix10_svc_command_code
+
+.. kernel-doc:: include/linux/stratix10-svc-client.h
+   :functions: stratix10_svc_client_msg
+
+.. kernel-doc:: include/linux/stratix10-svc-client.h
+   :functions: stratix10_svc_command_reconfig_payload
+
+.. kernel-doc:: include/linux/stratix10-svc-client.h
+   :functions: stratix10_svc_cb_data
+
+.. kernel-doc:: include/linux/stratix10-svc-client.h
+   :functions: stratix10_svc_client
+
+.. kernel-doc:: drivers/misc/stratix10-svc.c
+   :export:
-- 
2.7.4
