From: leo.yan@linaro.org (Leo Yan)
Date: Mon, 13 Feb 2017 14:11:36 +0800
Subject: [PATCH RFC 1/3] coresight: binding for coresight debug driver
In-Reply-To: <1486966298-16767-1-git-send-email-leo.yan@linaro.org>
References: <1486966298-16767-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1486966298-16767-2-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding compatible string for new coresight debug driver.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 Documentation/devicetree/bindings/arm/coresight.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index fcbae6a..3ff15fd 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -40,6 +40,9 @@ its hardware characteristcs.
 		- System Trace Macrocell:
 			"arm,coresight-stm", "arm,primecell"; [1]
 
+		- Debug Unit:
+			"arm,coresight-debug", "arm,primecell";
+
 	* reg: physical base address and length of the register
 	  set(s) of the component.
 
@@ -78,8 +81,10 @@ its hardware characteristcs.
 	* arm,cp14: must be present if the system accesses ETM/PTM management
 	  registers via co-processor 14.
 
-	* cpu: the cpu phandle this ETM/PTM is affined to. When omitted the
-	  source is considered to belong to CPU0.
+* Optional properties for ETM/PTM/Debugs:
+
+	* cpu: the cpu phandle this ETM/PTM/Debug is affined to. When omitted
+	  the source is considered to belong to CPU0.
 
 * Optional property for TMC:
 
-- 
2.7.4
