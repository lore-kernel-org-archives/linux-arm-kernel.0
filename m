From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed,  2 Nov 2016 22:52:10 -0600
Subject: [PATCH v5 7/8] Documentation: bindings: Add support for Amlogic GXBB
 SCPI protocol
In-Reply-To: <1478148731-11712-1-git-send-email-sudeep.holla@arm.com>
References: <1478148731-11712-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1478148731-11712-8-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Neil Armstrong <narmstrong@baylibre.com>

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
(decoupled from the generic scpi binding)
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 .../devicetree/bindings/arm/amlogic,scpi.txt         | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic,scpi.txt

diff --git a/Documentation/devicetree/bindings/arm/amlogic,scpi.txt b/Documentation/devicetree/bindings/arm/amlogic,scpi.txt
new file mode 100644
index 000000000000..7b9a861e9306
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/amlogic,scpi.txt
@@ -0,0 +1,20 @@
+System Control and Power Interface (SCPI) Message Protocol
+(in addition to the standard binding in [0])
+----------------------------------------------------------
+Required properties
+
+- compatible : should be "amlogic,meson-gxbb-scpi"
+
+AMLOGIC SRAM and Shared Memory for SCPI
+------------------------------------
+
+Required properties:
+- compatible : should be "amlogic,meson-gxbb-sram"
+
+Each sub-node represents the reserved area for SCPI.
+
+Required sub-node properties:
+- compatible : should be "amlogic,meson-gxbb-scp-shmem" for SRAM based shared
+		memory on Amlogic GXBB SoC.
+
+[0] Documentation/devicetree/bindings/arm/arm,scpi.txt
-- 
1.9.1
