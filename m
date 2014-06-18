From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Wed, 18 Jun 2014 17:23:20 +0300
Subject: [PATCH v2 1/7] of: Add NVIDIA Tegra SATA controller binding
In-Reply-To: <1403101406-15439-1-git-send-email-mperttunen@nvidia.com>
References: <1403101406-15439-1-git-send-email-mperttunen@nvidia.com>
Message-ID: <1403101406-15439-2-git-send-email-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree binding documentation for the SATA
controller found on NVIDIA Tegra SoCs.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
v2:
- added target-5v-supply and target-12v-supply
- changed wording to be similar with other Tegra drivers

 .../devicetree/bindings/ata/tegra-sata.txt         | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/tegra-sata.txt

diff --git a/Documentation/devicetree/bindings/ata/tegra-sata.txt b/Documentation/devicetree/bindings/ata/tegra-sata.txt
new file mode 100644
index 0000000..946f207
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/tegra-sata.txt
@@ -0,0 +1,30 @@
+Tegra124 SoC SATA AHCI controller
+
+Required properties :
+- compatible : "nvidia,tegra124-ahci".
+- reg : Should contain 2 entries:
+  - AHCI register set (SATA BAR5)
+  - SATA register set
+- interrupts : Defines the interrupt used by SATA
+- clocks : Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
+- clock-names : Must include the following entries:
+  - sata
+  - sata-oob
+  - cml1
+  - pll_e
+- resets : Must contain an entry for each entry in reset-names.
+  See ../reset/reset.txt for details.
+- reset-names : Must include the following entries:
+  - sata
+  - sata-oob
+  - sata-cold
+- phys : Must contain an entry for each entry in phy-names.
+  See ../phy/phy-bindings.txt for details.
+- phy-names : Must include the following entries:
+  - sata-phy : XUSB PADCTL SATA PHY
+- hvdd-supply : Defines the SATA HVDD regulator
+- vddio-supply : Defines the SATA VDDIO regulator
+- avdd-supply : Defines the SATA AVDD regulator
+- target-5v-supply : Defines the SATA 5V power regulator
+- target-12v-supply : Defines the SATA 12V power regulator
-- 
1.8.1.5
