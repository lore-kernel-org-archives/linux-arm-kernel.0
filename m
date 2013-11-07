From: acourbot@nvidia.com (Alexandre Courbot)
Date: Thu, 7 Nov 2013 19:11:42 +0900
Subject: [PATCH v10 3/7] of: add Trusted Foundations bindings
In-Reply-To: <1383819106-1400-1-git-send-email-acourbot@nvidia.com>
References: <1383819106-1400-1-git-send-email-acourbot@nvidia.com>
Message-ID: <1383819106-1400-4-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the Device Tree bindings for the Trusted Foundation secure monitor.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 .../arm/firmware/tlm,trusted-foundations.txt         | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.txt

diff --git a/Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.txt b/Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.txt
new file mode 100644
index 000000000000..adb471c3d2dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.txt
@@ -0,0 +1,20 @@
+Trusted Foundations
+-------------------
+
+Boards that use the Trusted Foundations secure monitor can signal its
+presence by declaring a node compatible with "tlm,trusted-foundations"
+under the /firmware/ node
+
+Required properties:
+- compatible : "tlm,trusted-foundations"
+- tlm,version-major : major version number of Trusted Foundations firmware
+- tlm,version-minor: minor version number of Trusted Foundations firmware
+
+Example:
+	firmware {
+		trusted-foundations {
+			compatible = "tlm,trusted-foundations";
+			tlm,version-major = <2>;
+			tlm,version-minor = <8>;
+		};
+	};
-- 
1.8.4.2
