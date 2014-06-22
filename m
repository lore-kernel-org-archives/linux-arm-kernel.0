From: b.galvani@gmail.com (Beniamino Galvani)
Date: Sun, 22 Jun 2014 17:31:45 +0200
Subject: [PATCH 5/5] regulator: act8865: add act8846 to DT binding
 documentation
In-Reply-To: <1403451105-31929-1-git-send-email-b.galvani@gmail.com>
References: <1403451105-31929-1-git-send-email-b.galvani@gmail.com>
Message-ID: <1403451105-31929-6-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a new "active-semi,act8846" compatible string and a
list of supported regulator names to the devicetree binding
documentation for Active-Semi PMUs.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 .../devicetree/bindings/regulator/act8865-regulator.txt         |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/act8865-regulator.txt b/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
index bef1fbb..865614b 100644
--- a/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
@@ -1,13 +1,16 @@
-ACT8865 regulator
+ACT88xx regulators
 -------------------
 
 Required properties:
-- compatible: "active-semi,act8865"
+- compatible: "active-semi,act8846" or "active-semi,act8865"
 - reg: I2C slave address
 
 Any standard regulator properties can be used to configure the single regulator.
 
 The valid names for regulators are:
+	- for act8846:
+	REG1, REG2, REG3, REG4, REG5, REG6, REG7, REG8, REG9, REG10, REG11, REG12
+	- for act8865:
 	DCDC_REG1, DCDC_REG2, DCDC_REG3, LDO_REG1, LDO_REG2, LDO_REG3, LDO_REG4.
 
 Example:
-- 
1.7.10.4
