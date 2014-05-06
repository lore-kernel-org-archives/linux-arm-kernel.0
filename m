From: elder@linaro.org (Alex Elder)
Date: Tue,  6 May 2014 17:18:29 -0500
Subject: [PATCH v3 1/5] devicetree: bindings: document Broadcom CPU enable
 method
In-Reply-To: <1399414713-19206-1-git-send-email-elder@linaro.org>
References: <1399414713-19206-1-git-send-email-elder@linaro.org>
Message-ID: <1399414713-19206-2-git-send-email-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Broadcom mobile SoCs use a ROM-implemented holding pen for
controlled boot of secondary cores.  A special register is
used to communicate to the ROM that a secondary core should
start executing kernel code.  This enable method is currently
used for members of the bcm281xx and bcm21664 SoC families.

The use of an enable method also allows the SMP operation vector to
be assigned as a result of device tree content for these SoCs.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 333f4ae..c6a2411 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -185,6 +185,7 @@ nodes to be present and contain the properties described below.
 			    "qcom,gcc-msm8660"
 			    "qcom,kpss-acc-v1"
 			    "qcom,kpss-acc-v2"
+			    "brcm,bcm11351-cpu-method"
 
 	- cpu-release-addr
 		Usage: required for systems that have an "enable-method"
@@ -209,6 +210,17 @@ nodes to be present and contain the properties described below.
 		Value type: <phandle>
 		Definition: Specifies the ACC[2] node associated with this CPU.
 
+	- secondary-boot-reg
+		Usage:
+			Required for systems that have an "enable-method"
+			property value of "brcm,bcm11351-cpu-method".
+		Value type: <u32>
+		Definition:
+			Specifies the physical address of the register used to
+			request the ROM holding pen code release a secondary
+			CPU.  The value written to the register is formed by
+			encoding the target CPU id into the low bits of the
+			physical start address it should jump to.
 
 Example 1 (dual-cluster big.LITTLE system 32-bit):
 
-- 
1.9.1
